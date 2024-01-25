import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jdx/CustomWidgets/CustomElevetedButton.dart';
import 'package:jdx/Models/Acceptorder.dart';
import 'package:jdx/Models/order_history_response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:jdx/services/location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareQRCode extends StatefulWidget {
  const ShareQRCode({Key? key, this.parcel, this.qrimage}) : super(key: key);

  final ParcelDetails? parcel;
  final String? qrimage;

  @override
  State<ShareQRCode> createState() => _ShareQRCodeState();
}


class _ShareQRCodeState extends State<ShareQRCode> {
  @override
  ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController tfController = TextEditingController();

  String baseURL = 'https://developmentalphawizz.com/pickport/api/';
  Position? _position;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inIt();
  }

  inIt()async{
    _position = await getUserCurrentPosition();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              height: 23,
              width: 23,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )),
        ),
        backgroundColor: const Color(0xFF222443),
        title: const Text('Share Your Parcel QR'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
                 Screenshot(
                controller: screenshotController,
                child: widget.qrimage == null ? Image.asset('assets/images/jdx_logo.png') :Image.network('${baseURL}${widget.parcel?.barcodeLink ??''}') ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            /*ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(color: Colors.white,)
                ,),
              child: Text('Generate QR Code'),
              onPressed: () => setState(() {}),

            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomElevatedButton(
                text: 'Share QR Code',
                icon: Icons.qr_code,
                onPressed: () {

                    _shareQrCode();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _shareQrCode() async {
    PermissionStatus storagePermission = await Permission.storage.request();
    if (storagePermission == PermissionStatus.granted) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime.now().microsecondsSinceEpoch.toString();
            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path]).then((value) => onShareParcel());

            }
          } catch (error) {}
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });
    }else if (storagePermission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This Permission is recommended')));

    } else if (storagePermission == PermissionStatus.permanentlyDenied) {
      openAppSettings().then((value) {

      });
    }

  }

 Future<void> onShareParcel() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    var headers = {
      'Cookie': 'ci_session=2efafc8c9a9a64a5aeba794180de68f8a68329a0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/transfer_parcel'));
    request.fields.addAll({
      'sd_user_id': userId ?? '326',
      'order_id': widget.parcel?.orderId ?? '',
      'deliver_boy_latitude': _position?.latitude.toString() ?? '0.0',
      'deliver_boy_longitude': _position?.longitude.toString() ?? '75.898039'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


}

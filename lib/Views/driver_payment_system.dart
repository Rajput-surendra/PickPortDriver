import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jdx/services/api_services/request_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomWidgets/CustomElevetedButton.dart';
import '../Utils/CustomColor.dart';
import '../services/session.dart';

class DriverPaymentSystem extends StatefulWidget {
  const DriverPaymentSystem({Key? key}) : super(key: key);

  @override
  State<DriverPaymentSystem> createState() => _DriverPaymentSystemState();
}

class _DriverPaymentSystemState extends State<DriverPaymentSystem> {
  final ImagePicker _picker = ImagePicker();

  final amountController = TextEditingController();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF222443),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                height: 23,
                width: 23,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 55,
                    child: Image.asset('assets/images/cash.png',
                        fit: BoxFit.cover)),
                const SizedBox(
                  height: 30,
                ),
                /*const Text(
                  'Total Earning',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const Text('Rs. 0'),
                const SizedBox(
                  height: 30,
                ),*/
                Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: InkWell(
                        onTap: () {
                          showExitPopup1(context);
                        },
                        child: imageFile == null
                            ? Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: CustomColors.TransparentColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        getTranslated(context, "Upload Payment Photo"),
                                      //  'Upload Payment Photo'
                                    ),
                                    Icon(
                                      Icons.upload,
                                      color: Colors.red,
                                    ),
                                  ],
                                ))
                            : Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: CustomColors.TransparentColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.file(imageFile ?? File(''))))),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: CustomColors.TransparentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                          getTranslated(context, "Enter amount"),
                         // 'Enter amount',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: SizedBox(
                    width: 210,
                    height: 50,
                    child: CustomElevatedButton(
                      text:
                      getTranslated(context, "Send to Merchant"),
                      //'Send to Merchant',
                      icon: Icons.logout,
                      onPressed: () {
                        _sendToMerchant(context);
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _sendToMerchant(BuildContext context) async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please upload profile image");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      var headers = {
        'Cookie': 'ci_session=c7d48d7dcbb70c45bae12c8d08e77251655897e8'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/pickport/api/Authentication/driver_pay_amount_for_vendor'));
      request.fields.addAll({
        RequestKeys.deliveryBoyId: userId ?? '',
        RequestKeys.amount: amountController.text,
      });
      print("this isn ==========>${request.fields}");
      request.headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath(
          RequestKeys.attachment, imageFile?.path ?? ''));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('_________________success_______________-');
        final reslut = await response.stream.bytesToString();
        var finalResult = json.decode(reslut);
        print("this is a respoce${finalResult['status']}__________-");
        if (finalResult['status'] == true) {
          Fluttertoast.showToast(msg: "Sent successfully");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "Invalid Email & Password");
        }
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  Future<bool> showExitPopup1(BuildContext context) async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
              title: Text(
                  getTranslated(context, "Select Image"),
                 // 'Select Image'
              ),
              content: Row(
                // crossAxisAlignment: CrossAxisAlignment.s,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _getFromCamera1(context);
                    },
                    //return false when click on "NO"
                    child: Text(
                      getTranslated(context, "Camera"),
                      //    'Camera'
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getFromGallery1(context);
                      // Navigator.pop(context,true);
                      // Navigator.pop(context,true);
                    },
                    //return true when click on "Yes"
                    child: Text(
                        getTranslated(context, "Gallery"),
                       // 'Gallery'
                    ),
                  ),
                ],
              )),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  _getFromGallery1(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera1(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
}

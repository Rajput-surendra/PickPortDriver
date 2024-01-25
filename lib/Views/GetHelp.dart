import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/privacypolicymodel.dart';
import '../Utils/AppBar.dart';
import '../Utils/Color.dart';
import 'package:http/http.dart' as http;

import '../services/session.dart';

class GetHelp extends StatefulWidget {
  const GetHelp({Key? key}) : super(key: key);

  @override
  State<GetHelp> createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHelp();
  }

  String? description;
   String? url;
  PrivacypolicyModel? privacypolicy;

  getHelp() async {
    var headers = {
      'Cookie': 'ci_session=521e7894daca5e3189ecd3dd2cd31fd3c14d22c9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/pickport/api/Authentication/get_driver_help'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var result=jsonDecode(finalResponse);
      if(result['status']==true){

        setState(() {
          url = result['data']['url'].toString();
          description = result['data']['description'].toString();
       print('____Som______${url}_________');
        });
      }


    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: colors.whiteTemp,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: commonAppBar(context, text:
                // getTranslated(context, "Get Help"),
                getTranslated(context, "NEED_HELP"),
                //"Get Help"
                )),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: const BoxDecoration(

                ),
                child: url == null || url == ""
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(0)),
                      color: Colors.white),
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Html(data: "${privacyData}"),
                            Text("${description}"),
                            TextButton(
                              onPressed: (){
                                _launchUrl(Uri.parse('$url'));
                              },
                              child:Text('$url',),
                            )],
                    ),
                  ),
                ))));
  }
    _launchUrl(id) async {
    if (await launchUrl(id)) {
      throw Exception('Could not launch $id');
    }
  }
}

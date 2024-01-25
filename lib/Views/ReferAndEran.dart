import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/Views/SupportNewScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../../Utils/Color.dart';
import '../Models/GetProfileModel.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';
import 'NotificationScreen.dart';

class ReferAndEranScreen extends StatefulWidget {
  const ReferAndEranScreen({Key? key}) : super(key: key);

  @override
  State<ReferAndEranScreen> createState() => _ReferAndEranScreenState();
}

class _ReferAndEranScreenState extends State<ReferAndEranScreen> {


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }
    GetProfileModel? getProfileModel;
    String qrCodeResult = "Not Yet Scanned";

    getProfile() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("userId");
      print(" this is  User++++++++++++++>${userId}");
      var headers = {
        'Cookie': 'ci_session=6de5f73f50c4977cb7f3af6afe61f4b340359530'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Urls.baseUrl}User_Dashboard/getUserProfile'));
      request.fields.addAll({'user_id': userId.toString()});
      print(" this is  User++++++++++++++>${request.fields}");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final result = await response.stream.bytesToString();
        var finalResult = GetProfileModel.fromJson(jsonDecode(result));
        print("thisi is ============>${result}");
        setState(() {
          getProfileModel = finalResult;
          print('${getProfileModel!.data![0].userImage}_________________');
          Fluttertoast.showToast(msg: qrCodeResult);
        });
      } else {
        print(response.reasonPhrase);
      }
    }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: colors.primary,
          body: Column(
            children: [
              const SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: const Center(child: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Text(
                        getTranslated(context, "Refer and Earn"),
                        //"Refer and Earn"
                        style: TextStyle(color: colors.whiteTemp),),
                      Container(
                        height: 40,
                        width: 40,
                        decoration:  BoxDecoration(
                            color: colors.splashcolor,
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportNewScreen()));
                            },
                            child: Center(
                              child: Image.asset(
                                'assets/images/support.png',scale: 1.3,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Container(
                    decoration: const BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                    ),
                    child:  Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/OBJECTS.png"),
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Text(
                                  getTranslated(context, "Refer and Earn"),
                                 // "Refer and earn",
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: colors.backColor),
                                ),
                              ),
                                Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(context, "Invite your friends to join and get the reward as soon as your friend first order placed"),
                               //  "Invite your friends to join and get the reward as soon as your friend first order placed",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Text(
                                  getTranslated(context, "Your Referral Code"),
                                 // "Your Referral Code",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration:  BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: colors.secondary,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${getProfileModel?.data?.first.referralCode}",
                                      style: TextStyle(color: colors.backColor),
                                    ),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  decoration: const BoxDecoration(
                                      color: colors.primary,
                                      borderRadius:  BorderRadius.all(Radius.circular(4.0))),
                                  child: Text(
                                    getTranslated(context, "Tap to copy"),
                                   // "Tap to copy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: colors.whiteTemp),
                                  ),),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: "${getProfileModel?.data?.first.referralCode}"));
                                  // setSnackbar('Refercode Copied to clipboard');
                                  Fluttertoast.showToast(msg:
                                  getTranslated(context, "Refer code Copied to clipboard"),
                                 // "Refer code Copied to clipboard",
                                      backgroundColor: colors.primary
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                  onTap: () {
                                    share(referCode: "${getProfileModel?.data?.first.referralCode}");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width / 1.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.primary
                                    ),
                                    child:  Text(
                                      getTranslated(context, "Share"),
                                     // "Share",
                                      style: TextStyle(
                                      color: colors.whiteTemp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,),),
                                  ),
                              ),
                              // SimBtn(
                              //   size: 0.8,
                              //   title: "Share",
                              //   onBtnSelected: () {
                              //     var str =
                              //         "$appName\nRefer Code:$"REFER_CODE"\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
                              //     Share.share(str);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  GlobalKey keyList = GlobalKey() ;
  bool iconVisible = true;
  Future<void> share({String? referCode})  async {
     FlutterShare.share(
        title: 'Refer and Earn',
        text: '$referCode',
        linkUrl: 'Refer and Earn',
        chooserTitle: 'PickPort Driver'
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/AuthViews/ChangePassword.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/BottomNevBar.dart';
import '../Utils/ApiPath.dart';
import '../Utils/Color.dart';

import 'package:http/http.dart' as http;

import '../Utils/CustomColor.dart';
import '../services/session.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key? key, this.mobile, this.otp, this.fromForgetPassword})
      : super(key: key);
  String? mobile, otp;
  bool? fromForgetPassword;
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  var pinValue;

  bool isLoading = false;
  verifyOtpApi() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=1fae43cb24be06ee09e394b6be82b42f6d887269'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${Urls.baseUrl}Authentication/delivery_checkUserOtp'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString(),
      'firebaseToken': token.toString()
    });
    print('____Som______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = json.decode(result);
      if (finalResult['status'] == true) {
        print('____Status______${finalResult['status']}_________');
        String? userId = finalResult['data']['user_id'];
        String? userName = finalResult['data']['user_fullname'];
        String? userPhone = finalResult['data']['user_phone'];
        String? userEmail = finalResult['data']['user_email'];
        String? userImage = finalResult['data']['user_image'];
        print("User id+++++++++++++++++>${userId}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userId ?? '-id--');
        prefs.setString("userName", userName ?? '-username-');
        prefs.setString("userPhone", userPhone ?? '-userphone-');
        prefs.setString("userEmail", userEmail ?? '-useremail-');
        prefs.setString("userImage", userImage ?? '-userimage-');
        Fluttertoast.showToast(
          msg: '${finalResult['message']}',
        );

        if (widget.fromForgetPassword == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNav()));
        }

        setState(() {
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
          msg: "${finalResult['message']}",
        );
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyStatefulWidget()));
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  String? mobileOtp, mobileNo;
  // resendOtp() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var headers = {
  //     'Cookie': 'ci_session=c59791396657a1155df9f32cc7d7b547a40d648c'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/pickport/api/Authentication/DeliveryLogin'));
  //   request.fields.addAll({
  //     'mobile':widget.mobile.toString()
  //   });
  //   print('____Som______${request.fields}_________');
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result =   await response.stream.bytesToString();
  //     var finalResult =  jsonDecode(result);
  //   mobileOtp =  finalResult['data']['otp']['0'];
  //     widget.otp = mobileOtp;
  //         print('____Som______${widget.otp}____${finalResult['data']['otp']}_____');
  //     setState(() {
  //       isLoading = false;
  //     });
  //     setState(() {
  //       Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     });
  //     if(finalResult['status'] == false){
  //       Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     }else{
  //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerrifyScreen(mobile: mobileNo,otp: mobileOtp,)));
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //     // Navigator.push(context, MaterialPa
  //     // geRoute(builder: (context)=>))
  //
  //
  //   }
  //   else {
  //     setState(() {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     });
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  resendOtp() async {
    var headers = {
      'Cookie': 'ci_session=418394d486487780888e62b557385cca98626dde'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Urls.baseUrl}Authentication/DeliveryLogin'));
    request.fields.addAll({'user_phone': widget.mobile.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      widget.otp = mobileOtp = finalResult['data']['otp'];
      // mobileNo =  finalResult['data']['user_phone'];
      print('____Som______${mobileOtp}_________');
      setState(() {
        isLoading = false;
      });
      setState(() {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      });
      if (finalResult['status'] == false) {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      } else {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationPage(mobile: mobileNo,otp: mobileOtp,)));
        setState(() {
          isLoading = false;
        });
      }
      // Navigator.push(context, MaterialPa
      // geRoute(builder: (context)=>))
    } else {
      setState(() {
        setState(() {
          isLoading = false;
        });
      });
      print(response.reasonPhrase);
    }
  }

  String? newPin;
  String? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primary,
        appBar: AppBar(
          backgroundColor: colors.primary,
          elevation: 0,
          leadingWidth: 0,
          title: Row(
            children: [
              const SizedBox(
                width: 40,
              ),
              // Icon(
              //   Icons.arrow_back_ios,
              //   color: Colors.white,
              // ),
              Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    getTranslated(context, "Verification"),
                    //'Verification',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      getTranslated(context, "Code has sent to"),
                     // "Code has sent to",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "+91 ${widget.mobile.toString()}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "OTP: ${widget.otp.toString()}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    // controller.otp == "null" ?
                    // Text('OTP: ',style: const TextStyle(fontSize: 20,color: AppColors.whit),):
                    // Text('OTP: ${otp}',style: const TextStyle(fontSize: 20,color: Colors.white),),

                    const SizedBox(
                      height: 50,
                    ),
                    PinCodeTextField(
                      //errorBorderColor:Color(0xFF5ACBEF),
                      //defaultBorderColor: Color(0xFF5ACBEF),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        widget.otp = value.toString();
                        newPin = value.toString();
                      },
                      textStyle: const TextStyle(color: Colors.black),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        activeColor: colors.primary,
                        inactiveColor: colors.primary,
                        selectedColor: colors.primary,
                        fieldHeight: 60,
                        fieldWidth: 60,
                        selectedFillColor: colors.primary,
                        inactiveFillColor: colors.primary,
                        activeFillColor: colors.primary,
                      ),
                      //pinBoxRadius:20,
                      appContext: context, length: 4,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      getTranslated(context, "Haven't received the verification code?"),
                     // "Haven't received the verification code?",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    InkWell(
                        onTap: () {
                          resendOtp();
                        },
                        child: Text(
                          getTranslated(context, "Resend"),
                         // "Resend",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    // Obx(() => Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                    //
                    // )

                    Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          if (newPin != widget.otp) {
                            Fluttertoast.showToast(
                                msg:
                                getTranslated(context, "Please enter correct pin"));
                            setState(() {
                              isLoading = false;
                            });
                               // "Please enter correct pin");
                          } else if (newPin == null) {
                            Fluttertoast.showToast(msg:
                                getTranslated(context, "Please enter pin"));
                            setState(() {
                              isLoading = false;
                            });
                                //"Please enter pin");
                          } else {
                            setState(() {
                              isLoading = false;
                            });

                            verifyOtpApi();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.circular(15)),
                          child: isLoading
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : Center(
                            child: Text(
                                getTranslated(context, "Verify Code"),
                              //"Verify Code",
                              style: TextStyle(
                                color: CustomColors.White,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // CustomButton(
                    //   onTap: (){
                    //     setState((){
                    //       isLoading = true;
                    //     });
                    //     if(newPin != widget.otp){
                    //       Fluttertoast.showToast(msg: "Please enter correct pin");
                    //
                    //     } else if(newPin == null) {
                    //       Fluttertoast.showToast(msg: "Please enter pin");
                    //     }
                    //     else{
                    //       setState((){
                    //         isLoading = false;
                    //       });
                    //       verifyOtpApi();
                    //     }
                    //   },
                    //   buttonText: getTranslated(context, "Verify Code"),
                    // )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}

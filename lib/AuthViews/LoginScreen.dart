import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/AuthViews/verificationOtp.dart';
import 'package:jdx/Views/TermsAndConditions.dart';
import 'package:jdx/services/session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/BottomNevBar.dart';
import '../Models/login_model.dart';
import '../Utils/ApiPath.dart';
import '../Utils/Color.dart';
import '../Utils/CustomColor.dart';
import '../Views/GetHelp.dart';
import '../Views/PrivacyPolicy.dart';
import 'ForgetPasswordScreen.dart';
import 'SignUpScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isVisible = true;
  bool isTerm = false;
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int selected = 0;
  getLoginApi() async {
    isLoading = true;
    setState(() {});
    var headers = {
      'Cookie': 'ci_session=c7d48d7dcbb70c45bae12c8d08e77251655897e8'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Authentication/DeliveryLogin'));
    request.fields.addAll({
      'user_email': emailController.text,
      'user_password': passwordController.text,
      'firebaseToken': '4'
    });
    print("this isn ==========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final reslut = await response.stream.bytesToString();
      var finalResult = LoginModel.fromJson(json.decode(reslut));
      //var finalResult = json.decode(reslut);

      if (finalResult.status == true) {
        String? userId = finalResult.data?.userId;
        String? userName = finalResult.data?.userFullname;
        String? userImage = finalResult.data?.userImage;
        print("User id+++++++++++++++++>$userId");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userId ?? '-id--');
        prefs.setString("userName", userName ?? '-username-');
        prefs.setString("userImage", userImage ?? '-userimage-');
        isLoading = false;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNav()));
      } else {
        Fluttertoast.showToast(msg: "${finalResult.message}");
        isLoading = false;
      }
      setState(() {
        emailController.clear();
        passwordController.clear();
      });
    } else {
      print(response.reasonPhrase);
      isLoading = false;
      setState(() {});
    }
  }

  String? mobileOtp, mobileNo;

  loginWithMobileNumberApi() async {
    isLoading = true;
    setState(() {});
    var headers = {
      'Cookie': 'ci_session=418394d486487780888e62b557385cca98626dde'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Authentication/DeliveryLogin'));
    request.fields.addAll({'user_phone': mobileController.text});
    print('____Som______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      setState(() {
        isLoading = false;
      });
      if (finalResult['status'] == false) {
        // Fluttertoast.showToast(msg: "${finalResult['message']}");
        Fluttertoast.showToast(msg: "User is not registered");

      } else {
        mobileOtp = finalResult['data']['otp'];
        mobileNo = finalResult['data']['user_phone'];
        Fluttertoast.showToast(msg: "${finalResult['message']}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationPage(
                      mobile: mobileNo,
                      otp: mobileOtp,
                    )));
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

  // loginWithMobileNumberApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var headers = {
  //     'Cookie': 'ci_session=c59791396657a1155df9f32cc7d7b547a40d648c'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Authentication/DeliveryLogin'));
  //   request.fields.addAll({
  //     'mobile':mobileController.text
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result =   await response.stream.bytesToString();
  //     var finalResult =  jsonDecode(result);
  //     mobileOtp =  finalResult['data']['otp'];
  //     mobileNo =  finalResult['data']['user_phone'];
  //     print('____Som______${mobileOtp}_________');
  //     setState(() {
  //       isLoading = false;
  //     });
  //     setState(() {
  //       Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     });
  //     if(finalResult['status'] == false){
  //       Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     }else{
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationPage(mobile: mobileNo,otp: mobileOtp,)));
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title:  Text(
                    getTranslated(context, "Confirm Exit"),
                  //    "Confirm Exit"
                ),
                content:  Text(
                  getTranslated(context, "Are you sure you want to exit?"),
                  //  "Are you sure you want to exit?"
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: CustomColors.accentColor),
                    child:  Text(
                        getTranslated(context, "YES"),
                       // "YES"
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: CustomColors.accentColor),
                    child:  Text(
                      getTranslated(context, "NO"),
                      // "NO"
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        // if (_tabController.index != 0) {
        //   _tabController.animateTo(0);
        //   return false;
        // }
        return true;
      },
      child: Scaffold(
        backgroundColor: colors.primary,
        body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //  padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    // height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: colors.primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Log In"),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GetHelp()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  getTranslated(context, "NEED_HELP"),
                                  style: TextStyle(
                                      color: colors.primary, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                 Text(
                                  getTranslated(context, "Welcome to PickPort"),
                                 // 'Welcome to PickPort',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      width: MediaQuery.of(context).size.width,
                      //  height: MediaQuery.of(context).size.height * 1.0,
                      decoration: const BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: ListView(
                        //  physics: BouncingScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 0;
                                    FocusScope.of(context).unfocus();
                                    _formKey.currentState!.reset();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        selected == 0
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off_outlined,
                                        color: colors.secondary,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        getTranslated(context, "Email"),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 1;
                                    FocusScope.of(context).unfocus();
                                    _formKey.currentState!.reset();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        selected == 1
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off_outlined,
                                        color: colors.secondary,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        getTranslated(context, "Mobile"),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          selected == 0
                              ? Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: CustomColors.White),
                                    child: TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: const Icon(
                                            Icons.email,
                                            color: CustomColors.accentColor,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 20, left: 5),
                                        border: InputBorder.none,
                                        hintText:
                                            getTranslated(context, "email"),
                                      ),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return
                                            getTranslated(context, "Email id is required");
                                            //"Email is required";
                                        }
                                        if (!v.contains("@")) {
                                          return
                                            getTranslated(context, "Enter Valid Email Id");
                                            //"Enter Valid Email Id";
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Container(
                                    height: 60,
                                    //   width: MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: CustomColors.White),
                                    child: TextFormField(
                                      controller: mobileController,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        //    counter: Container(),
                                        prefixIcon: Container(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: const Icon(
                                            Icons.call,
                                            color: CustomColors.accentColor,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 24, left: 5),
                                        border: InputBorder.none,
                                        hintText: getTranslated(
                                            context, "ENTER_MOBILE"),
                                      ),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return
                                            getTranslated(context, "Mobile is required");
                                          //  "Mobile is required";
                                        }
                                        if (v.length != 10) {
                                          return  getTranslated(context, "Enter Valid Mobile Number");

                                            //"Enter Valid Mobile Number";
                                        }
                                      },
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          selected == 0
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: CustomColors.White),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: isVisible,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          child: Icon(
                                            Icons.lock,
                                            color: CustomColors.accentColor, size: 28,
                                          ),
                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isVisible = !isVisible;
                                                });
                                              },
                                              icon: Icon(
                                                isVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: colors.secondary,
                                              )),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 22, left: 5),
                                        border: InputBorder.none,
                                        hintText:
                                            getTranslated(context, "Password"),
                                      ),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return
                                            getTranslated(context, "Password is required");
                                           // "Password is required";
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          selected == 0
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TermsConditionsWidget()),
                                    );
                                  },
                                  child: Container(
                                    child: Row(children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isTerm = !isTerm;
                                          });
                                        },
                                        child: Icon(
                                          isTerm
                                              ? Icons.check_box_outlined
                                              : Icons.check_box_outline_blank,
                                          color: colors.secondary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        getTranslated(
                                            context, "I argree to all"),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        getTranslated(context, "T&C"),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: colors.primary,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsConditionsWidget()));
                                        },
                                        child: const Text(
                                          ' &',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      privacy_policy()));
                                        },
                                        child: Text(
                                          getTranslated(
                                              context, "Privacy Policy"),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: colors.primary,
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                )
                              : Container(),
                          selected == 0
                              ? Container(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Forget()));
                                      },
                                      child: Text(
                                        getTranslated(context, "Forgot_pass?"),
                                        style:
                                            TextStyle(color: Color(0xFF66CC00)),
                                      )),
                                )
                              : Container(),
                          const SizedBox(
                            height: 40,
                          ),
                          selected == 0 ?  InkWell(
                            onTap: () {
                              if(emailController.text == ""){
                                Fluttertoast.showToast(msg: getTranslated(context, "Email id is required"));
                                return;
                              }if(passwordController.text == ""){
                                Fluttertoast.showToast(msg:  getTranslated(context, "Password is required"));
                                return;
                              }
                              else{
                                getLoginApi();
                              }

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: colors.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child:  isLoading
                                  ? Center(child: Text("Please Wait..",style: const TextStyle(
                                color: CustomColors.White,
                                fontSize: 18,
                              ),))
                                  : Center(
                                      child: Text(
                                       getTranslated(context, "Log In"),
                                        style: const TextStyle(
                                          color: CustomColors.White,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                            ),
                          )
                          :
                          InkWell(
                            onTap: () {
                              if(mobileController.text == ""){
                                Fluttertoast.showToast(msg: getTranslated(context, "Mobile is required"));
                                return;
                              }if(mobileController.text.length <10){
                                Fluttertoast.showToast(msg:  getTranslated(context, "Enter Valid Mobile Number"));
                                return;
                              }
                              else{
                                loginWithMobileNumberApi();
                              }

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                              const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: colors.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: isLoading
                                  ? Center(child: Text("Please Wait..",style: const TextStyle(
                                color: CustomColors.White,
                                fontSize: 18,
                              ),))
                                  : Center(
                                child: Text(
                                  getTranslated(context, "Send OTP"),
                                  style: const TextStyle(
                                    color: CustomColors.White,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslated(context, "Don't have an account?")),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUpScreen()));
                                },
                                child:  Text(
                                  getTranslated(context, "Sign Up"),
                                  style: TextStyle(color: colors.secondary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        // bottomSheet:
      ),
    );
  }
}

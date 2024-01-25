// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextField.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/passwordTextField.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
// import 'package:get/get.dart';
// import 'package:job_dekho_app/Views/Recruiter/appliedjobs_Screens.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Model/ChangepasswordModel.dart';
// import '../Utils/color.dart';
// import 'MyProfile.dart';
// import 'package:http/http.dart' as http;
// import 'notification_Screen.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//
//   TextEditingController oldpswController = TextEditingController();
//   TextEditingController newpswController = TextEditingController();
//
//   changePassword() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString('userid');
//     var headers = {
//       'Cookie': 'ci_session=b3b229754d182b6e4d05901374d052785b664b07'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/pickport/Api/change_password'));
//     request.fields.addAll({
//       'user_id': '${userid}',
//       'current_password': '${oldpswController.text}',
//       'new_password': '${newpswController.text}'
//     });
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("truuuuuuuuuuuuuu");
//       print(await response.stream.bytesToString());
//
//       Get.to(DrawerScreen());
//
//       // final jsonResponse = ChangepasswordModel.fromJson(json.decode(finalResponse));
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(child: Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: (){
//             Get.to(DrawerScreen());
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         elevation: 0,
//         backgroundColor: primaryColor,
//         title: Text('Change Password',style: TextStyle(fontFamily: 'Lora'),),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding:  EdgeInsets.only(right: 10),
//             child: InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
//                 },
//                 child: Icon(Icons.notifications,color: Colors.white,)),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height/1.1,
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           width: size.width,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(topRight: Radius.circular(0))
//           ),
//           //padding: EdgeInsets.symmetric(vertical: 30),
//           child: Column(
//             children: [
//               SizedBox(height: 70,),
//               Material(
//                 elevation: 10,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 1.2,
//                   height: 50,
//                   child: TextField(
//                     controller: oldpswController,
//                     decoration: InputDecoration(
//                       border: const OutlineInputBorder(
//                           borderSide: BorderSide.none
//                       ),
//                       hintText: "Old Password",
//                       prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40,),
//               Material(
//                 elevation: 10,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 1.2,
//                   height: 50,
//                   child: TextField(
//                     controller: newpswController,
//                     decoration: InputDecoration(
//                       border: const OutlineInputBorder(
//                           borderSide: BorderSide.none
//                       ),
//                       hintText: "New Password",
//                       prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40,),
//               CustomTextButton(buttonText: "save", onTap: (){
//                 changePassword();
//                 // Get.to(DrawerScreen());
//                 },)
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jdx/AuthViews/LoginScreen.dart';
import 'package:jdx/CustomWidgets/CustomElevetedButton.dart';
import 'package:jdx/Models/chnage_pasword_response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:jdx/Views/SupportNewScreen.dart';
import 'package:jdx/services/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ChangePasswordModel.drt.dart';
import '../Utils/Color.dart';

import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newpswController = TextEditingController();
  TextEditingController cnfrmpswController = TextEditingController();

  SnackBar snackBar =  SnackBar(
    content: Text(
     // getTranslated(context, "Password Change Successfully"),
     'Password Change Successfully',
    ),
  );

  ChangepasswordModel? changepasswordModel;
  changePassword() async {
    print("Change Password");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=2642df063cc1a98b4a32209e7aa3505d7f4932a1'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Authentication/changePassword'));
    request.fields.addAll({
      'user_id': '$userid',
      'password': newpswController.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var finalResult = await response.stream.bytesToString();

      final jsonResponse =
          ChangepasswordModel.fromJson(json.decode(finalResult));
      print("final change passsowrd result>>>>>>> ${finalResult.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      prefs.setString('userId', "");
      Get.to(LoginScreen());
      setState(() {
        changepasswordModel = jsonResponse;
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
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.only(left: 20, right: 20),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(child: Icon(Icons.arrow_back)),
                  ),
                ),
                Text(
                  getTranslated(context, "Change Password"),
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: colors.splashcolor,
                      borderRadius: BorderRadius.circular(100)),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SupportNewScreen()));
                      },
                      child: Center(
                        child: Image.asset(
                          'assets/images/support.png',
                          scale: 1.3,
                        ),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 11,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: newpswController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: getTranslated(context, "New Password"),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: colors.primary,
                                )
                                // prefixIcon: Image.asset(
                                //   'assets/AuthAssets/Icon ionic-ios-lock.png',
                                //   scale: 2.1,
                                //   color: colors.primary,
                                // ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            controller: cnfrmpswController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: getTranslated(context, "Confirm Password"),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: colors.primary,
                                )
                                // prefixIcon: Image.asset(
                                //   'assets/AuthAssets/Icon ionic-ios-lock.png',
                                //   scale: 2.1,
                                //   color: colors.primary,
                                // ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: SizedBox(
                            height: 45,
                            width: 270,
                            child: CustomElevatedButton(
                              text:
                               getTranslated(context, "Save"),
                              icon: Icons.save,
                              onPressed: () {
                                if (newpswController.text.length > 0 &&
                                    cnfrmpswController.text.length > 0 &&
                                    cnfrmpswController.text == newpswController.text
                                ) {
                                  changePassword();
                                }
                                else if(cnfrmpswController.text != newpswController.text){
                                  Fluttertoast.showToast(
                                    msg:
                                    getTranslated(context, "Passwords do not match"),
                                    // "Please Enter Password"
                                  );
                                }
                                else {
                                  Fluttertoast.showToast(
                                      msg:
                                      getTranslated(context, "Please Enter Password"),
                                     // "Please Enter Password"
                                  );
                                }
                                //  if(_formKey.currentState!.validate()){

                                //  }

                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),

      // SingleChildScrollView(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height/1.1,
      //     padding: EdgeInsets.symmetric(horizontal: 12),
      //     width: size.width,
      //     decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(topRight: Radius.circular(0))
      //     ),
      //     //padding: EdgeInsets.symmetric(vertical: 30),
      //     child: Column(
      //       children: [
      //         SizedBox(height: 70,),
      //         Material(
      //           elevation: 10,
      //           borderRadius: BorderRadius.circular(10),
      //           child: Container(
      //             width: MediaQuery.of(context).size.width / 1.2,
      //             height: 50,
      //             child: TextField(
      //               controller: oldpswController,
      //               decoration: InputDecoration(
      //                 border: const OutlineInputBorder(
      //                     borderSide: BorderSide.none
      //                 ),
      //                 hintText: "Old Password",
      //                 prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 40,),
      //         Material(
      //           elevation: 10,
      //           borderRadius: BorderRadius.circular(10),
      //           child: Container(
      //             width: MediaQuery.of(context).size.width / 1.2,
      //             height: 50,
      //             child: TextField(
      //               controller: newpswController,
      //               decoration: InputDecoration(
      //                 border: const OutlineInputBorder(
      //                     borderSide: BorderSide.none
      //                 ),
      //                 hintText: "New Password",
      //                 prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 2.1, color: primaryColor,),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 40,),
      //         CustomTextButton(buttonText: "save", onTap: (){
      //           changePassword();
      //           // Get.to(DrawerScreen());
      //         },),
      //       ],
      //     ),
      //   ),
      // ),
    ));
  }
}

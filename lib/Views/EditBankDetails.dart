import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/AuthViews/LoginScreen.dart';
import 'package:jdx/Utils/CustomColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/GetProfileModel.dart';
import '../Utils/ApiPath.dart';
import '../Utils/Color.dart';
import 'package:http/http.dart'as http;

import '../services/session.dart';

class EditBankDetails extends StatefulWidget {
  const EditBankDetails({Key? key}) : super(key: key);

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  int selected = 0;
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

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(request.url);
    print(request.fields);
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalResult = GetProfileModel.fromJson(jsonDecode(result));
      print("thisi is ============>${result}");
      setState(() {
        getProfileModel = finalResult;
        bankName.text = "${getProfileModel?.data?[0].bankName.toString()}";
        accountHolderName.text = "${getProfileModel?.data?[0].accountHolderName.toString()}";
        accountNumber.text = "${getProfileModel?.data?[0].accountNumber.toString()}";
        ifscCode.text = "${getProfileModel?.data?[0].ifscCode.toString()}";


      });
    } else {
      print(response.reasonPhrase);
    }
  }
  bool? isLoading =  false;
  updateBankDetailsApi() async {
    setState(() {
      isLoading =  true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Cookie': 'ci_session=212cd59e07c6a3b4b952031517ec3ffe518a1ea9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}User_Dashboard/updateBank_data'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'bank_name':bankName.text,
      'holder_name':accountHolderName.text,
      'account_number':accountNumber.text,
      'ifsc_code':ifscCode.text,
      'account_type':selected.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setState(() {
      isLoading =  false;
    });
    if (response.statusCode == 200) {
       var result  = await response.stream.bytesToString();
       var finalResult = jsonDecode(result);
       if(finalResult['status'] == true){
         Fluttertoast.showToast(msg: "${finalResult['message']}");
         Navigator.pop(context);
       }else{
         setState(() {
           Fluttertoast.showToast(msg: "${finalResult['message']}");
         });
       }

    }
    else {
      setState(() {
        isLoading =  false;
      });
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      body:getProfileModel==null? Center(child: CircularProgressIndicator()): Container(
        child: ListView(
          children: [
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: colors.primary),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                   Expanded(
                     child: Container(
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.only(right: 20),
                           child: Text(
                              getTranslated(context, "Bank Details"),
                             // 'Bank Details',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                         ),
                       ),
                     ),
                   ),
                  ],
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.TransparentColor),
                      child: TextFormField(
                        readOnly: true,
                        controller: bankName,
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Image.asset(
                              'assets/images/BANK NAME.png',
                              scale: 1.1,
                              color: colors.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 22, left: 5),
                          border: InputBorder.none,
                          hintText:
                          getTranslated(context, "Bank Name"),
                         // "Bank Name",
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return
                              getTranslated(context, "Bank Name is required");
                             // "Bank Name is required";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.TransparentColor),
                      child: TextFormField(
                        readOnly: true,
                        controller: accountHolderName,
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Image.asset(
                              'assets/images/ACCOUNT HOLDER NAME.png',
                              scale: 1.1,
                              color: colors.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 22, left: 5),
                          border: InputBorder.none,
                          hintText:
                          getTranslated(context, "Account Holder Name")
                        //  "Account Holder Name",
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return
                              getTranslated(context, "Account Holder Name is required");
                             // "Account Holder Name is required";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.TransparentColor),
                      child: TextFormField(
                        readOnly: true,
                        controller: accountNumber,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child:  Image.asset(
                              'assets/images/ACCOUNT  NUMBER.png',
                              scale: 1.1,
                              color: colors.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 22, left: 5),
                          border: InputBorder.none,
                          hintText:
                          getTranslated(context, "Account Number")
                        //  "Account Number",
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return
                              getTranslated(context, "Account Number is required");
                             // "Account Number is required";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.TransparentColor),
                      child: TextFormField(
                        readOnly: true,
                        controller: ifscCode,
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child:  Image.asset(
                              'assets/images/IFSC CODE.png',
                              scale: 1.1,
                              color: colors.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 22, left: 5),
                          border: InputBorder.none,
                          hintText:
                          getTranslated(context, "IFSC Code")
                        //  "IFSC Code",
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return
                              getTranslated(context, "IFSC Code is required");
                            //  "IFSC Code is required";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.TransparentColor),
                      child: Image.network("${getProfileModel!.data![0].userImage}",fit: BoxFit.fill,),
                    )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    getTranslated(context, "Account Type"),
                   // 'Account Type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selected = 0;
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
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            const Text( "Saving Account",
                               // getTranslated(context, "Saving Account"),
                              //  'Saving Account',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selected = 1;
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
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            const Text( "Current Account",
                               // getTranslated(context, "Current Account"),
                               // 'Current Account',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 40,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 70.0),
                  //   child: InkWell(
                  //     onTap: (){
                  //       updateBankDetailsApi();
                  //     },
                  //     child: Container(
                  //         decoration: BoxDecoration(
                  //             color: colors.primary,
                  //             borderRadius: BorderRadius.circular(15)),
                  //         height: 50,
                  //         width: MediaQuery.of(context).size.width * 0.7,
                  //         child:  Center(
                  //           child:isLoading == true ?const Center(child: CircularProgressIndicator()) : Text(
                  //             'Save',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

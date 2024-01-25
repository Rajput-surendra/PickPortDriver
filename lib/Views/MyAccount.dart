import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jdx/AuthViews/ChangePassword.dart';
import 'package:jdx/AuthViews/LoginScreen.dart';
import 'package:jdx/CustomWidgets/CustomElevetedButton.dart';
import 'package:jdx/Models/order_accept_response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:jdx/Views/Feedback.dart';
import 'package:jdx/Views/MyProfile.dart';
import 'package:jdx/Views/PaymentScreen.dart';
import 'package:jdx/Views/driver_payment_system.dart';
import 'package:jdx/Views/past_parcel_history.dart';
import 'package:jdx/Views/share_qr/scan_qr.dart';
import 'package:jdx/Views/withdrawal_view.dart';
import 'package:jdx/services/api_services/request_key.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/GetProfileModel.dart';
import '../Utils/Color.dart';
import '../services/session.dart';
import 'AboutUs.dart';
import 'CommissionCharge.dart';
import 'EditBankDetails.dart';
import 'Mywallet.dart';
import 'Parcel HistoryPage.dart';
import 'PrivacyPolicy.dart';
import 'ReferAndEran.dart';
import 'SupportNewScreen.dart';
import 'TermsAndConditions.dart';
import 'faq_Screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  openLogoutDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title:Text(
                getTranslated(context, "Are you sure want to logout app ?"),
                //"Are you sure want to logout app ?",
                style: const TextStyle(
                    fontFamily: 'Serif',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      prefs.setString('userId', "");
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.green,
                      ),
                      child: Text(
                        getTranslated(context, "Confirm"),
                      //  "Confirm",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Serif'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red,
                      ),
                      child:Text(
                        getTranslated(context, "Cancel"),
                      //  "Cancel",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Serif'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      return getProfile();
    });
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
    print(request.fields);
    print(request.url);
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      print(result);
      var finalResult = GetProfileModel.fromJson(jsonDecode(result));
      print("thisi is ============>${result}");
      setState(() {
        getProfileModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primary,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(15, 54, 140, 1),
          elevation: 0,
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          title: Container(
              padding: const EdgeInsets.all(2),
              child:  Text(
                getTranslated(context, "My Account"),
               // 'My Account',
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 28.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getProfileModel == null
                            ? const Center(child: CircularProgressIndicator())
                            : Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    height: 70,
                                    width: 70,
                                    child:
                                        getProfileModel!.data![0].userImage ==
                                                    null ||
                                                getProfileModel!
                                                        .data![0].userImage ==
                                                    ""
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(
                                                  "assets/images/profileImage.jpg",
                                                  fit: BoxFit.fill,
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  "${getProfileModel!.data![0].userImage}",
                                                  fit: BoxFit.fill,
                                                )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     Text(
                                        getTranslated(context, "Hello"),
                                       // "Hello",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${getProfileModel!.data![0].userFullname}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${getProfileModel!.data![0].userEmail}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        Row(
                          children: [
                            InkWell(
                              onTap: getProfileModel == null
                                  ? null
                                  : () async {
                                      var value = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Myprofile(
                                                  getProfileModel:
                                                      getProfileModel)));

                                      if (value == 'true') {
                                        getProfile();
                                      }
                                    },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBankDetails(),
                            ));
                      },
                      child: SizedBox(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Bank Details"),
                                     // 'Bank Details',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyWallet(),
                            ));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    const Icon(
                                      Icons.wallet,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Pickport Wallet"),
                                     //   'Pickport Wallet',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WithdrawalScreen()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                   Image.asset("assets/images/Withdraw Money.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Withdraw Money"),
                                     // 'Withdraw Money',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(Icons.arrow_forward_ios, size: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParcelHistory()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Image.asset("assets/images/Parcel History.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Parcel History"),
                                     // 'Parcel History',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommissionCharge()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Image.asset("assets/images/termscondition.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                    getTranslated(context, "Commission Charge"),
                                  //  'Commission Charge',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                        BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReferAndEranScreen()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Image.asset("assets/images/Refer and earn.png", height: 15, width: 15, color: Colors.green,),

                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Refer and earn"),
                                     // 'Refer And Earn',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PaymentScreen(),
                                    //     ));
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const SupportNewScreen(),
                            ));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Icon(Icons.support_agent, color: Colors.green,size: 18,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Support"),
                                     // 'Support',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => privacy_policy()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Image.asset("assets/images/Privacy Policy.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Privacy Policy"),
                                     // 'Privacy Policy',
                                      style: const  TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsConditionsWidget()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Image.asset("assets/images/termscondition.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Terms & Conditions"),
                                      //'Terms and Conditions',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FaqScreen()));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/FAQs.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "FAQS"),
                                      //'FAQs',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const AboutUs(),
                            ));
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/Withdraw Money.png", height: 15, width: 15, color: Colors.green,),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "About Us"),
                                     // 'About Us',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                        BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        deleteAccountDailog();
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 20,),
                                    Text(
                                      getTranslated(context, "Delete Account"),
                                     // 'Delete Account',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  //   child: Container(
                  //     height: 80,
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(11)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: const [
                  //                 Icon(Icons.more_time_sharp),
                  //                 Padding(
                  //                   padding: EdgeInsets.only(left: 28.0),
                  //                   child: Text(
                  //                     'COD Payment Submit',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             DriverPaymentSystem()));
                  //               },
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(left: 70.0),
                  //                 child: Container(
                  //                     height: 40,
                  //                     width: 40,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.redAccent
                  //                             .withOpacity(0.10),
                  //                         borderRadius:
                  //                             BorderRadius.circular(50)),
                  //                     child: const Icon(
                  //                       Icons.arrow_forward_ios,
                  //                     )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  //   child: Container(
                  //     height: 80,
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(11)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: const [
                  //                 Icon(Icons.more_time_sharp),
                  //                 Padding(
                  //                   padding: EdgeInsets.only(left: 28.0),
                  //                   child: Text(
                  //                     'Get Feedback',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const UserFeedback()));
                  //               },
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(left: 128.0),
                  //                 child: Container(
                  //                     height: 40,
                  //                     width: 40,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.redAccent
                  //                             .withOpacity(0.10),
                  //                         borderRadius:
                  //                             BorderRadius.circular(50)),
                  //                     child: Icon(
                  //                       Icons.arrow_forward_ios,
                  //                     )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  //   child: Container(
                  //     height: 80,
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(11)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Icon(Icons.more_time_sharp),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 28.0),
                  //                   child: Text(
                  //                     'Support',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const PastParcelHistory()));
                  //               },
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(left: 128.0),
                  //                 child: Container(
                  //                     height: 40,
                  //                     width: 40,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.redAccent
                  //                             .withOpacity(0.10),
                  //                         borderRadius:
                  //                             BorderRadius.circular(50)),
                  //                     child: Icon(
                  //                       Icons.arrow_forward_ios,
                  //                     )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  //   child: Container(
                  //     height: 80,
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(11)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Icon(Icons.qr_code_scanner_outlined),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 28.0),
                  //                   child: Text(
                  //                     'Scan QR Code',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 scanQR();
                  //               },
                  //               child: Container(
                  //                   height: 40,
                  //                   width: 40,
                  //                   decoration: BoxDecoration(
                  //                       color:
                  //                           Colors.redAccent.withOpacity(0.10),
                  //                       borderRadius:
                  //                           BorderRadius.circular(50)),
                  //                   child: Icon(
                  //                     Icons.arrow_forward_ios,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  //   child: Container(
                  //     height: 80,
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(11)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Icon(Icons.lock),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 28.0),
                  //                   child: Text(
                  //                     'Change Password',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) => ChangePass()));
                  //               },
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(left: 105.0),
                  //                 child: Container(
                  //                     height: 40,
                  //                     width: 40,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.redAccent
                  //                             .withOpacity(0.10),
                  //                         borderRadius:
                  //                             BorderRadius.circular(50)),
                  //                     child: Icon(
                  //                       Icons.arrow_forward_ios,
                  //                     )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(top: 58.0, bottom: 60),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: CustomElevatedButton(
                        text: 'Log Out',
                        icon: Icons.logout,
                        onPressed: () {
                          openLogoutDialog();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ))
          ]),
        ));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      qrCodeResult = barcodeScanRes;

      if (qrCodeResult == '-1') {
      } else {
        // acceptTransferredParcel();

        acceptParcelByQrScan();
      }

      print('${barcodeScanRes}________________');
    });
  }

  /* void acceptTransferredParcel() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=679a0bf637c0c326b677ea0476d380fe3d31b1bf'
    };

    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/JDX/api/Payment/accept_order_request'));
    print('${request}');
    request.body = json.encode({
      "user_id": userId ?? '',
      "order_id": qrCodeResult,
      "status":  '2'
    });
    print('${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    http.Response.fromStream(response)
        .then((response) {
      if(response.statusCode == 200){
        log(response.body);
        var res =  OrderAcceptApiResponse.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(msg: res.message ?? '');


      }
    });



  }*/

  void acceptParcelByQrScan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=c5fe2882c92758dfc2798f81f1010ec073030369'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Payment/scan_parcel_received'));
    request.fields
        .addAll({'rd_user_id': userId ?? '315', 'order_id': qrCodeResult});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: finalResult['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  deleteAccountDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Text(
              getTranslated(context, "Are you sure you want to delete account ?"),
             // "Are you sure you want to delete account ?",
              style: TextStyle(color: Color(0xFF0F368C))),
          actions: <Widget>[
            TextButton(
                child:  Text(
                  getTranslated(context, "NO"),
                 // "NO",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
            TextButton(
                child:  Text(
                  getTranslated(context, "YES"),
                  //"YES",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  deleteAccount();
                  Navigator.pop(context);

                  // SettingProvider settingProvider =
                  // Provider.of<SettingProvider>(context, listen: false);
                  // settingProvider.clearUserSession(context);
                  // //favList.clear();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/home', (Route<dynamic> route) => false);
                })
          ],
        );
      });
    }));
  }

  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
        );
  }

  deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Cookie': 'ci_session=96944ca78b243ab8f0408ccfec94c5f2d8ca05fc'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Authentication/delete_account'));
    request.fields.addAll({'user_id': userId.toString()});
    print('____Som______${request.fields}_________');
    print(request.fields);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['error'] == false){
        Fluttertoast.showToast(msg: "${finalResult['message']}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }else{
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }

    } else {
      print(response.reasonPhrase);
    }
  }
}

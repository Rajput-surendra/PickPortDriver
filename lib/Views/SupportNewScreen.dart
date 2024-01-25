// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:jdx/Utils/ApiPath.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../Utils/Color.dart';
// import '../Models/NewContactModel.dart';
// import '../Models/contactus.dart';
// import '../services/session.dart';
//
// class SupportNewScreen extends StatefulWidget {
//
//   const SupportNewScreen({Key? key}) : super(key: key);
//
//
//   @override
//   State<SupportNewScreen> createState() => _SupportNewScreenState();
// }
//
// class _SupportNewScreenState extends State<SupportNewScreen> {
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//
//
//   Contactus? Contact;
//
//   contactus() async {
//     var headers = {
//       'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
//     };
//     var request = http.MultipartRequest('GET', Uri.parse('${Urls.baseUrl}Users/ContactUs'));
//     request.fields.addAll({
//       'name': '${nameController.text}',
//       'email': '${emailcontroller.text}',
//       'subject': '4',
//       'message': '56'
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("bbbbbbbbbbbbbbbbbbbb${response}");
//
//       final result = await response.stream.bytesToString();
//       var resultcontactus = Contactus.fromJson(jsonDecode(result));
//
//       setState(() {
//         Contact = resultcontactus;
//       });
//
//     }
//
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get();
//     Future.delayed(Duration(milliseconds: 30),(){
//       return contactus();
//     });
//   }
//   NewContectModel? newContectModel;
//
//
//   get() async {
//     var headers = {
//       'Cookie': 'ci_session=f9248f94280271245402dd0f5f7a337996575439'
//     };
//     var request = http.MultipartRequest('GET', Uri.parse('https://developmentalphawizz.com/pickport/api/payment/contact_setting'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result  = await response.stream.bytesToString();
//       var finalREsult  = NewContectModel.fromJson(json.decode(result));
//       setState(() {
//         newContectModel =  finalREsult;
//         emailAddress = newContectModel?.data?.email.toString();
//         phoneNumber = newContectModel?.data?.phoneNo.toString();
//       });
//       print('____Som______${phoneNumber}_________');
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: colors.primary,
//           body:  Column(
//             children: [
//               SizedBox(height: 10,),
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20,right: 20),
//                   child: Container(
//                     color: colors.primary,
//                     child: Row(
//
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                                 color:colors.whiteTemp,
//                                 borderRadius: BorderRadius.circular(100)
//                             ),
//                             child: Center(child: Icon(Icons.arrow_back)),
//                           ),
//                         ),
//                         SizedBox(width: 100,),
//                         Text(getTranslated(context, "Support"),style: TextStyle(color:colors.whiteTemp,fontSize: 18),),
//                         // Container(
//                         //   height: 40,
//                         //   width: 40,
//                         //   decoration:  BoxDecoration(
//                         //       color: splashcolor,
//                         //       borderRadius:
//                         //       BorderRadius.circular(100)),
//                         //   child: InkWell(
//                         //       onTap: () {
//                         //         Navigator.push(
//                         //             context,
//                         //             MaterialPageRoute(
//                         //                 builder: (context) =>
//                         //                 const NotificationScreen()));
//                         //       },
//                         //       child: Center(
//                         //         child: Image.asset(
//                         //           'assets/ProfileAssets/support.png',scale: 1.3,
//                         //         ),
//                         //       )),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 11,
//                 child: Container(
//                     decoration: BoxDecoration(
//                         color: colors.primary,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(50))
//                     ),
//                     child: Contact ==  null || Contact == "" ? Center(child: CircularProgressIndicator(),) :
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView(
//                         //crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           InkWell(
//                               onTap: (){
//                                 _launchEmail();
//                               },
//                               child: Text("Email Us->: ${newContectModel?.data?.email}")),
//                           InkWell(
//                               onTap: (){
//                                 _launchPhoneDialer();
//                               },
//                               child: Text("Call Us->: ${newContectModel?.data?.phoneNo}")),
//                         ],
//                       ),
//                     )
//
//                 ),
//               )
//
//             ],
//           ),
//
//
//
//           // body: Column(
//           //   children: [
//           //     Row(
//           //       children: [
//           //         Text("${Contact!.data!.pgDescri}"),
//           //       ],
//           //     ),
//           //
//           //     // Image.asset("assets/ContactUsAssets/contactusIcon.png",scale: 1.2,),
//           //     // SizedBox(height: 30,),
//           //     // Text("Incase of any queries or assistance\nKindly what's app us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lora'),textAlign: TextAlign.center,),
//           //     // SizedBox(height: 30,),
//           //     // Padding(padding: EdgeInsets.symmetric(horizontal: 30),
//           //     // child: Column(
//           //     //   children: [
//           //     //     // Html(data: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,));
//           //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,)),
//           //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/whatsapp.png', scale: 1.9,),),
//           //     //
//           //     //     // LogoWithText(labelText: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/email.png', scale: 1.2,)),
//           //     //     // LogoWithText(labelText: "@jdxconnectofficial", imageIcon: Image.asset('assets/ContactUsAssets/instagram.png', scale: 1.2,)),
//           //     //     // LogoWithText(labelText: "@jdxconnct_official", imageIcon: Image.asset('assets/ContactUsAssets/facebook.png', scale: 1.2,))
//           //     //   ],
//           //     // ),)
//           //   ],
//           //
//           // )
//         ));
//   }
//   String? emailAddress;
//
//   void _launchEmail() async {
//     final Uri _emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: emailAddress,
//     );
//
//     if (await canLaunch(_emailLaunchUri.toString())) {
//       await launch(_emailLaunchUri.toString());
//     } else {
//       throw 'Could not launch email';
//     }
//   }
//
//   String? phoneNumber ;
//
//   void _launchPhoneDialer() async {
//     if (phoneNumber != null && await canLaunch("tel:$phoneNumber")) {
//       await launch("tel:$phoneNumber");
//     } else {
//       throw 'Could not launch phone dialer';
//     }
//   }
//
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/Color.dart';
import '../Models/NewContactModel.dart';
import '../Models/contactus.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';

class SupportNewScreen extends StatefulWidget {

  const SupportNewScreen({Key? key}) : super(key: key);


  @override
  State<SupportNewScreen> createState() => _SupportNewScreenState();
}

class _SupportNewScreenState extends State<SupportNewScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();


  Contactus? Contact;

  contactus() async {
    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${Urls.baseUrl}Users/ContactUs'));
    request.fields.addAll({
      'name': nameController.text,
      'email': emailcontroller.text,
      'subject': '4',
      'message': '56'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("bbbbbbbbbbbbbbbbbbbb${response}");

      final result = await response.stream.bytesToString();
      var resultcontactus = Contactus.fromJson(jsonDecode(result));

      setState(() {
        Contact = resultcontactus;
      });

    }

    else {
      print(response.reasonPhrase);
    }

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    Future.delayed(Duration(milliseconds: 30),(){
      return contactus();
    });
  }
  NewContectModel? newContectModel;


  get() async {
    var headers = {
      'Cookie': 'ci_session=f9248f94280271245402dd0f5f7a337996575439'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://developmentalphawizz.com/pickport/api/payment/contact_setting'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalREsult  = NewContectModel.fromJson(json.decode(result));
      setState(() {
        newContectModel =  finalREsult;
        emailAddress = newContectModel?.data?.email.toString();
        phoneNumber = newContectModel?.data?.phoneNo.toString();
      });
      print('____Som______${phoneNumber}_________');
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: colors.primary,
          body:  Column(
            children: [
              SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    color: colors.primary,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(child: Icon(Icons.arrow_back)),
                          ),
                        ),
                        SizedBox(width: 100,),
                        Text(getTranslated(context, "Support"),style: TextStyle(color: Colors.white,fontSize: 18),),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration:  BoxDecoration(
                        //       color: splashcolor,
                        //       borderRadius:
                        //       BorderRadius.circular(100)),
                        //   child: InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                 const NotificationScreen()));
                        //       },
                        //       child: Center(
                        //         child: Image.asset(
                        //           'assets/ProfileAssets/support.png',scale: 1.3,
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFDDEDFA),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Contact ==  null || Contact == "" ? Center(child: CircularProgressIndicator(),) :
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: (){
                                                _launchEmail();
                                              },
                                              child:
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getTranslated(context, "Email Us"),
                                                  //  "Email Us"
                                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.email_outlined,size: 20,),
                                                      SizedBox(width: 2,),
                                                      Text("${newContectModel?.data?.email}")
                                                    ],
                                                  )
                                                ],
                                              )
                                          )

                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: (){
                                              _launchPhoneDialer();
                                            },
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getTranslated(context, "Call Us"),
                                                //  "Call Us"
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                Row(
                                                  children: [
                                                    Icon(Icons.call,size: 20,),
                                                    SizedBox(width: 2,),
                                                    Text("${newContectModel?.data?.phoneNo}")
                                                  ],
                                                )

                                              ],
                                            )
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    )

                ),
              )

            ],
          ),



          // body: Column(
          //   children: [
          //     Row(
          //       children: [
          //         Text("${Contact!.data!.pgDescri}"),
          //       ],
          //     ),
          //
          //     // Image.asset("assets/ContactUsAssets/contactusIcon.png",scale: 1.2,),
          //     // SizedBox(height: 30,),
          //     // Text("Incase of any queries or assistance\nKindly what's app us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lora'),textAlign: TextAlign.center,),
          //     // SizedBox(height: 30,),
          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 30),
          //     // child: Column(
          //     //   children: [
          //     //     // Html(data: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,));
          //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.9,)),
          //     //     LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/whatsapp.png', scale: 1.9,),),
          //     //
          //     //     // LogoWithText(labelText: "${Contact!.data!.pgDescri}", imageIcon: Image.asset('assets/ContactUsAssets/email.png', scale: 1.2,)),
          //     //     // LogoWithText(labelText: "@jdxconnectofficial", imageIcon: Image.asset('assets/ContactUsAssets/instagram.png', scale: 1.2,)),
          //     //     // LogoWithText(labelText: "@jdxconnct_official", imageIcon: Image.asset('assets/ContactUsAssets/facebook.png', scale: 1.2,))
          //     //   ],
          //     // ),)
          //   ],
          //
          // )
        ));
  }
  String? emailAddress;

  void _launchEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  String? phoneNumber ;

  void _launchPhoneDialer() async {
    if (phoneNumber != null && await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch phone dialer';
    }
  }
}

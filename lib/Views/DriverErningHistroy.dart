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
import 'package:jdx/Views/withdrawal_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/Color.dart';
import '../Models/Get_online_offline_Model.dart';
import '../Models/NewContactModel.dart';
import '../Models/contactus.dart';
import '../Models/driver_earn_model.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';

class DriverErningHistroy extends StatefulWidget {

  const DriverErningHistroy({Key? key}) : super(key: key);


  @override
  State<DriverErningHistroy> createState() => _DriverErningHistroyState();
}

class _DriverErningHistroyState extends State<DriverErningHistroy> {


  void initState() {
    // TODO: implement initState
    super.initState();
    onlineOfflineHistoryApi();

  }

  DriverEarnModel ? getOnlineOfflineModel;
  onlineOfflineHistoryApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Cookie': 'ci_session=ccd29ed97897179805eae4af31f61c9124290627'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/delivery_parcel_history'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    print('____Som______${request.fields}_________');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  = DriverEarnModel.fromJson(json.decode(result));
      setState(() {
       getOnlineOfflineModel =  finalResult;
      // driverEraningAmount = finalResult.total.toString();
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.primary,
      body:  Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            flex: 2,
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
                    Expanded(
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Center(child: Text(getTranslated(context, "DRIVER_EARNING"),style: TextStyle(color: Colors.white,fontSize: 18),)),
                          )),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 18,
            child:
            SingleChildScrollView(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFDDEDFA),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: getOnlineOfflineModel ==  null || getOnlineOfflineModel == "" ? Center(child: CircularProgressIndicator()) : getOnlineOfflineModel?.data?.isEmpty ?? false ?
                  Center(child: Text("No data available")) :
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0,left:10 ,right: 10),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>WithdrawalScreen()));
                              },
                              child: Card(

                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.account_balance_wallet,
                                            color: colors.primary,
                                          ),
                                          Text(
                                            " " + 'Available Balance',
                                            style: TextStyle(color: colors.blackTemp,
                                                fontWeight: FontWeight.bold,fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      getOnlineOfflineModel?.total == null ? Text("No Balance") :Text("₹${getOnlineOfflineModel?.total}" ,style: TextStyle(color: colors.blackTemp,fontSize: 20,fontFamily: "lora",fontWeight: FontWeight.bold),),
                                      SizedBox(height: 0,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                              //  shrinkWrap: true,
                                 // physics: ScrollPhysics(),
                                  itemCount:getOnlineOfflineModel?.data?.length?? 0 ,
                                  itemBuilder: (context,i){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      getTranslated(context, "Parcel Id")),
                                                  Text("${getOnlineOfflineModel?.data?[i].orderId}")
                                                ],
                                              ),

                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(getTranslated(context, "Amount")),
                                                  Text("₹ ${getOnlineOfflineModel?.data?[i].driverAmount}",style: TextStyle(fontFamily: "lora"),)
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(getTranslated(context, "Commission Charge")),
                                                  Text("₹ ${getOnlineOfflineModel?.data?[i].adminCommission}",style: TextStyle(fontFamily: "lora"),)
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      )


              ),
            ),
          )

        ],
      ),

    );
  }

}

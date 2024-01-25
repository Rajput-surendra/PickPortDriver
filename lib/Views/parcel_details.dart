import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jdx/Controller/BottomNevBar.dart';
import 'package:jdx/CustomWidgets/CustomElevetedButton.dart';
import 'package:jdx/Models/Acceptorder.dart';
import 'package:jdx/Models/order_history_response.dart';
import 'package:jdx/Utils/CustomColor.dart';
import 'package:jdx/Views/share_qr/share_qr.dart';
import 'package:jdx/services/api_services/request_key.dart';
import 'package:jdx/services/location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Utils/Color.dart';
import '../services/api_services/api.dart';
import '../services/session.dart';

class ParcelDetailsView extends StatefulWidget {
  ParcelDetailsView({Key? key, this.parcelFullDetail}) : super(key: key);
  List<ParcelDetails>? parcelFullDetail;

  @override
  State<ParcelDetailsView> createState() => _ParcelDetailsViewState();
}

class _ParcelDetailsViewState extends State<ParcelDetailsView> {
  Position? _position;

  Api api = Api();
 final _otpController =  TextEditingController();

  inIt() async {
    _position = await getUserCurrentPosition();
    print("${_position!.longitude}______________");
  }

  List<Widget> dropDownitem = [
    item(title: 'Pending', color: Colors.blueAccent),
    item(title: 'Confirm', color: Colors.orange),
    item(title: 'Received', color: Colors.yellowAccent),
    item(title: 'Picked', color: Colors.red),
    item(title: 'Out Of Delivery', color: Colors.green),
    item(title: 'Delivered', color: Colors.green),
    item(title: 'Order Complete', color: Colors.green),
  ];
  var dropdownvalue;
  String qrCodeResult = "Not Yet Scanned";

  @override
  void initState() {
    // TODO: implement initState
    inIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              height: 23,
              width: 23,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )),
        ),
        backgroundColor: colors.primary,
        title: Text(
            getTranslated(context, "Parcel Details"),
          //  'Parcel Details'
        ),
      ),
      body:
      Container(
        decoration: BoxDecoration(color: colors.splashcolor, borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: ListView.builder(
                      itemCount: widget.parcelFullDetail?.length,
                      itemBuilder: (context, index) {
                        var item = widget.parcelFullDetail?[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                          getTranslated(context, "Order Id"),
                                        //"Order Id",
                                          style: TextStyle(fontSize: 14, color: CustomColors.primary2, fontWeight: FontWeight.bold)),
                                    ),
                                    Text(item?.orderId ?? '-',style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                          getTranslated(context, "Parcel Id            "),
                                        //  "Parcel Id            ",
                                          style: TextStyle(fontSize: 13, color: Color(0xFFBF2331))),
                                    ),
                                    Text(item?.orderId ?? '-'),
                                  ],
                                )
                              ],
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 2,
                              color: Colors.white,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                    getTranslated(context, "Sender Name"),
                                                   // "Sender Name",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Color(0xFFBF2331))),
                                              ),
                                              Text(item?.senderName ?? '-'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                    getTranslated(context, "Receiver Name"),
                                                   // "Receiver Name",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Color(0xFFBF2331))),
                                              ),
                                              Text(item?.receiverName ?? ''),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getTranslated(context, "Sender Address"),
                                               // "Sender Address",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(item?.senderAddress ?? '-',
                                                    overflow: TextOverflow.clip),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                 getTranslated(context, "Receiver Address"),
                                               // "Receiver Address",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(item?.receiverAddress ?? '-',
                                                    overflow: TextOverflow.fade, maxLines: 3),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getTranslated(context, "Date"),
                                                //"Date",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              Text(item?.onDate.toString() ??
                                                  '-'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               SizedBox(
                                                width: 100,
                                                child: Text(
                                                  getTranslated(context, "Amount"),
                                                 // "Amount",
                                                  style: TextStyle(
                                                      fontSize: 14, color: CustomColors.primary2, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Text('₹ ${item?.totalAmount ??  "-"}',style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     item?.status == '4' ? const SizedBox() : Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const Text(
                                      //           "Transfer Parcel",
                                      //           style: TextStyle(
                                      //               fontSize: 13, color: Color(0xFFBF2331)),
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Icon(
                                      //               Icons.qr_code,
                                      //               size: 40,
                                      //             ),
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 Navigator.push(
                                      //                     context,
                                      //                     MaterialPageRoute(
                                      //                       builder: (context) => ShareQRCode(
                                      //                           qrimage: item?.barcodeLink, parcel: item),
                                      //                     ));
                                      //               },
                                      //               child: Container(
                                      //                 padding: const EdgeInsets.only(
                                      //                     left: 5, right: 10, top: 5, bottom: 5),
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius: BorderRadius.circular(15),
                                      //                     color: const Color(0xFF222443)),
                                      //                 child: Row(
                                      //                   mainAxisSize: MainAxisSize.min,
                                      //                   children: const [
                                      //                     Icon(
                                      //                       Icons.arrow_back,
                                      //                       color: Colors.white,
                                      //                     ),
                                      //                     SizedBox(
                                      //                       width: 5,
                                      //                     ),
                                      //                     Text(
                                      //                       'Share',
                                      //                       style: TextStyle(
                                      //                           fontSize: 12,
                                      //                           color: Colors.white),
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         /*const Text(
                                      //         "Transfer Parcel",
                                      //         style: TextStyle(
                                      //             fontSize: 13,
                                      //             color: Color(0xFFBF2331)),
                                      //       ),*/
                                      //         item?.status == '2' ?  Row(
                                      //           children: [
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 showAlert();
                                      //               },
                                      //               child: Container(
                                      //                 padding: const EdgeInsets.only(
                                      //                     left: 5, right: 10, top: 5, bottom: 5),
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius: BorderRadius.circular(15),
                                      //                     color: Colors.red),
                                      //                 child: Row(
                                      //                   mainAxisSize: MainAxisSize.min,
                                      //                   children: const [
                                      //                     Icon(
                                      //                       Icons.cancel_outlined,
                                      //                       color: Colors.white,
                                      //                     ),
                                      //                     SizedBox(
                                      //                       width: 5,
                                      //                     ),
                                      //                     Text(
                                      //                       'Cancel',
                                      //                       style: TextStyle(
                                      //                           fontSize: 12,
                                      //                           color: Colors.white),
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ) : const SizedBox.shrink(),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      item?.status == '4' ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              getTranslated(context, "Order Status"),
                                             // "Order Status",
                                              style: TextStyle(
                                                  fontSize: 13, color: Color(0xFFBF2331)),
                                            ),
                                            Text(
                                                getTranslated(context, "Delivered"),
                                              //  'Delivered'
                                            )

                                          ],),
                                      ) : const SizedBox(),
                                      item?.status == '4' ? const SizedBox(height: 10,) : SizedBox(),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const Text(
                                      //           "Track Sender",
                                      //           style: TextStyle(
                                      //               fontSize: 13, color: Color(0xFFBF2331)),
                                      //         ),
                                      //         InkWell(
                                      //           onTap: () {
                                      //             String lat = item?.senderLatitude.toString() ??
                                      //                 ''; //'22.7177'; //
                                      //             String lon = item?.senderLongitude.toString() ??
                                      //                 ''; //'75.8545'; //
                                      //             String CURENT_LAT =
                                      //                 _position?.latitude.toString() ?? '';
                                      //             String CURENT_LONG =
                                      //                 _position?.longitude.toString() ?? '';
                                      //
                                      //             final Uri url = Uri.parse(
                                      //                 'https://www.google.com/maps/dir/?api=1&origin=' +
                                      //                     CURENT_LAT +
                                      //                     ',' +
                                      //                     CURENT_LONG +
                                      //                     ' &destination=' +
                                      //                     lat.toString() +
                                      //                     ',' +
                                      //                     lon.toString() +
                                      //                     '&travelmode=driving&dir_action=navigate');
                                      //
                                      //             _launchURL(url);
                                      //           },
                                      //           child: Container(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 5, right: 10, top: 5, bottom: 5),
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius: BorderRadius.circular(15),
                                      //                 color: const Color(0xFF222443)),
                                      //             child: Row(
                                      //               mainAxisSize: MainAxisSize.min,
                                      //               children: const [
                                      //                 Icon(
                                      //                   Icons.location_on_outlined,
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: 5,
                                      //                 ),
                                      //                 Text(
                                      //                   'Track',
                                      //                   style: TextStyle(
                                      //                       fontSize: 12, color: Colors.white),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     const SizedBox(
                                      //       height: 5,
                                      //     ),
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const SizedBox(
                                      //           width: 100,
                                      //           child: Text(
                                      //             "Track Receiver",
                                      //             style: TextStyle(
                                      //                 fontSize: 13, color: Color(0xFFBF2331)),
                                      //           ),
                                      //         ),
                                      //         InkWell(
                                      //           onTap: () {
                                      //             String lat =
                                      //                 item?.receiverLatitude.toString() ??
                                      //                     ''; //'22.7177';
                                      //             String lon =
                                      //                 item?.receiverLongitude.toString() ??
                                      //                     ''; //'75.8545';
                                      //             String CURENT_LAT =
                                      //                 _position?.latitude.toString() ?? '';
                                      //             String CURENT_LONG =
                                      //                 _position?.longitude.toString() ?? '';
                                      //
                                      //             final Uri url = Uri.parse(
                                      //                 'https://www.google.com/maps/dir/?api=1&origin=' +
                                      //                     CURENT_LAT +
                                      //                     ',' +
                                      //                     CURENT_LONG +
                                      //                     ' &destination=' +
                                      //                     lat.toString() +
                                      //                     ',' +
                                      //                     lon.toString() +
                                      //                     '&travelmode=driving&dir_action=navigate');
                                      //
                                      //             _launchURL(url);
                                      //             //orderRejectedOrAccept(index, context, isRejected:  true);
                                      //           },
                                      //           child: Container(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 5, right: 10, top: 5, bottom: 5),
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius: BorderRadius.circular(15),
                                      //                 color: const Color(0xFF222443)),
                                      //             child: Row(
                                      //               mainAxisSize: MainAxisSize.min,
                                      //               children: const [
                                      //                 Icon(
                                      //                   Icons.location_on_outlined,
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: 5,
                                      //                 ),
                                      //                 Text(
                                      //                   'Track',
                                      //                   style: TextStyle(
                                      //                       fontSize: 12, color: Colors.white),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      item?.status == '2' ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getTranslated(context, "Enter OTP To Pick Parcel"),
                                               // "Enter OTP To Pick Parcel",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                            ],
                                          ),
                                          OTPField(controller: _otpController, onTap: () {orderPickedOrCompleteByOtp(_otpController.text,'3'); },),
                                          CircleAvatar(
                                              backgroundColor: CustomColors.primary2,
                                              child: IconButton(onPressed: (){
                                                orderPickedOrCompleteByOtp(_otpController.text,'3');
                                              }, color: CustomColors.White, icon: const Icon(Icons.check),)),
                                          /*ElevatedButton(

                                onPressed: (){}, child:Text('Pick'), style: ElevatedButton.styleFrom(backgroundColor: CustomColors.primary2,padding: EdgeInsets.zero),)*/
                                          //FourDigitOtpFormField(onSaved: (String ) {  },),
                                          //dropDown(index),
                                        ],
                                      ) : item?.status == '4' ? SizedBox() : Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getTranslated(context, "Enter OTP to Complete Order"),
                                              //  "Enter OTP to Complete Order",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                            ],
                                          ),
                                          OTPField(controller: _otpController, onTap: () { orderPickedOrCompleteByOtp(_otpController.text,'4'); },),
                                          CircleAvatar(
                                              backgroundColor: CustomColors.primary2,
                                              child: IconButton(onPressed: (){
                                                orderPickedOrCompleteByOtp(_otpController.text,'4');
                                              }, color: CustomColors.White, icon: const Icon(Icons.check),)),
                                          //FourDigitOtpFormField(onSaved: (String ) {  },),
                                          //dropDown(index),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      item?.status == '2' ? SizedBox.shrink() :  item?.status == '4' ? SizedBox()  :  Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: CustomElevatedButton(
                                            text:  getTranslated(context, "Scan QR to Complete Order"),

                                            //'Scan QR to Complete Order',
                                            icon: Icons.qr_code,
                                            onPressed: () {
                                              scanQR();
                                            },
                                          ),
                                        ),
                                      )

                                      /* Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Payment Method",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Color(0xFFBF2331)),
                                                      ),
                                                      Text(parcelDataList[index]
                                                          .paymentMethod
                                                          .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),*/
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )

                        ;
                      },
                    )),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: ListView.builder(
                      itemCount: widget.parcelFullDetail?.length,
                      itemBuilder: (context, index) {
                        var item = widget.parcelFullDetail?[index];
                        return Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                          getTranslated(context, "Order Id"),
                                         // "Order Id",
                                          style: TextStyle(
                                              fontSize: 14, color: CustomColors.primary2, fontWeight: FontWeight.bold)),
                                    ),
                                    Text(item?.orderId ?? '-',style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                          getTranslated(context, "Parcel Id            "),
                                         // "Parcel Id            ",
                                          style: TextStyle(
                                              fontSize: 13, color: Color(0xFFBF2331))),
                                    ),
                                    Text(item?.orderId ?? '-'),
                                  ],
                                )
                              ],
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 2,
                              color: Colors.white,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               Padding(
                                                padding: EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                    getTranslated(context, "Sender Name"),
                                                   // "Sender Name",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Color(0xFFBF2331))),
                                              ),
                                              Text(item?.senderName ?? '-'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             Padding(
                                                padding: EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                    getTranslated(context, "Receiver Name"),
                                                   // "Receiver Name",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Color(0xFFBF2331))),
                                              ),
                                              Text(item?.receiverName ?? ''),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                 getTranslated(context, "Sender Address"),
                                              //  "Sender Address",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(item?.senderAddress ?? '-',
                                                    overflow: TextOverflow.clip),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             Text(
                                               getTranslated(context, "Receiver Address"),
                                              //  "Receiver Address",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(item?.receiverAddress ?? '-',
                                                    overflow: TextOverflow.fade, maxLines: 3),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getTranslated(context, "Date"),
                                              //  "Date",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                              Text(item?.onDate.toString() ??
                                                  '-'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             SizedBox(
                                                width: 100,
                                                child: Text(
                                                  getTranslated(context, "Amount"),
                                                  //"Amount",
                                                  style: TextStyle(
                                                      fontSize: 14, color: CustomColors.primary2, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Text('₹ ${item?.totalAmount ??  "-"}',style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     item?.status == '4' ? const SizedBox() : Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const Text(
                                      //           "Transfer Parcel",
                                      //           style: TextStyle(
                                      //               fontSize: 13, color: Color(0xFFBF2331)),
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Icon(
                                      //               Icons.qr_code,
                                      //               size: 40,
                                      //             ),
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 Navigator.push(
                                      //                     context,
                                      //                     MaterialPageRoute(
                                      //                       builder: (context) => ShareQRCode(
                                      //                           qrimage: item?.barcodeLink, parcel: item),
                                      //                     ));
                                      //               },
                                      //               child: Container(
                                      //                 padding: const EdgeInsets.only(
                                      //                     left: 5, right: 10, top: 5, bottom: 5),
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius: BorderRadius.circular(15),
                                      //                     color: const Color(0xFF222443)),
                                      //                 child: Row(
                                      //                   mainAxisSize: MainAxisSize.min,
                                      //                   children: const [
                                      //                     Icon(
                                      //                       Icons.arrow_back,
                                      //                       color: Colors.white,
                                      //                     ),
                                      //                     SizedBox(
                                      //                       width: 5,
                                      //                     ),
                                      //                     Text(
                                      //                       'Share',
                                      //                       style: TextStyle(
                                      //                           fontSize: 12,
                                      //                           color: Colors.white),
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         /*const Text(
                                      //         "Transfer Parcel",
                                      //         style: TextStyle(
                                      //             fontSize: 13,
                                      //             color: Color(0xFFBF2331)),
                                      //       ),*/
                                      //         item?.status == '2' ?  Row(
                                      //           children: [
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 showAlert();
                                      //               },
                                      //               child: Container(
                                      //                 padding: const EdgeInsets.only(
                                      //                     left: 5, right: 10, top: 5, bottom: 5),
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius: BorderRadius.circular(15),
                                      //                     color: Colors.red),
                                      //                 child: Row(
                                      //                   mainAxisSize: MainAxisSize.min,
                                      //                   children: const [
                                      //                     Icon(
                                      //                       Icons.cancel_outlined,
                                      //                       color: Colors.white,
                                      //                     ),
                                      //                     SizedBox(
                                      //                       width: 5,
                                      //                     ),
                                      //                     Text(
                                      //                       'Cancel',
                                      //                       style: TextStyle(
                                      //                           fontSize: 12,
                                      //                           color: Colors.white),
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ) : const SizedBox.shrink(),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      item?.status == '4' ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children:[
                                            Text(
                                              getTranslated(context, "Order Status"),
                                            //  "Order Status",
                                              style: TextStyle(
                                                  fontSize: 13, color: Color(0xFFBF2331)),
                                            ),
                                            Text(
                                                getTranslated(context, "Delivered"),
                                               // 'Delivered'
                                            )

                                          ],),
                                      ) : const SizedBox(),
                                      item?.status == '4' ? const SizedBox(height: 10,) : SizedBox(),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const Text(
                                      //           "Track Sender",
                                      //           style: TextStyle(
                                      //               fontSize: 13, color: Color(0xFFBF2331)),
                                      //         ),
                                      //         InkWell(
                                      //           onTap: () {
                                      //             String lat = item?.senderLatitude.toString() ??
                                      //                 ''; //'22.7177'; //
                                      //             String lon = item?.senderLongitude.toString() ??
                                      //                 ''; //'75.8545'; //
                                      //             String CURENT_LAT =
                                      //                 _position?.latitude.toString() ?? '';
                                      //             String CURENT_LONG =
                                      //                 _position?.longitude.toString() ?? '';
                                      //
                                      //             final Uri url = Uri.parse(
                                      //                 'https://www.google.com/maps/dir/?api=1&origin=' +
                                      //                     CURENT_LAT +
                                      //                     ',' +
                                      //                     CURENT_LONG +
                                      //                     ' &destination=' +
                                      //                     lat.toString() +
                                      //                     ',' +
                                      //                     lon.toString() +
                                      //                     '&travelmode=driving&dir_action=navigate');
                                      //
                                      //             _launchURL(url);
                                      //           },
                                      //           child: Container(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 5, right: 10, top: 5, bottom: 5),
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius: BorderRadius.circular(15),
                                      //                 color: const Color(0xFF222443)),
                                      //             child: Row(
                                      //               mainAxisSize: MainAxisSize.min,
                                      //               children: const [
                                      //                 Icon(
                                      //                   Icons.location_on_outlined,
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: 5,
                                      //                 ),
                                      //                 Text(
                                      //                   'Track',
                                      //                   style: TextStyle(
                                      //                       fontSize: 12, color: Colors.white),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     const SizedBox(
                                      //       height: 5,
                                      //     ),
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         const SizedBox(
                                      //           width: 100,
                                      //           child: Text(
                                      //             "Track Receiver",
                                      //             style: TextStyle(
                                      //                 fontSize: 13, color: Color(0xFFBF2331)),
                                      //           ),
                                      //         ),
                                      //         InkWell(
                                      //           onTap: () {
                                      //             String lat =
                                      //                 item?.receiverLatitude.toString() ??
                                      //                     ''; //'22.7177';
                                      //             String lon =
                                      //                 item?.receiverLongitude.toString() ??
                                      //                     ''; //'75.8545';
                                      //             String CURENT_LAT =
                                      //                 _position?.latitude.toString() ?? '';
                                      //             String CURENT_LONG =
                                      //                 _position?.longitude.toString() ?? '';
                                      //
                                      //             final Uri url = Uri.parse(
                                      //                 'https://www.google.com/maps/dir/?api=1&origin=' +
                                      //                     CURENT_LAT +
                                      //                     ',' +
                                      //                     CURENT_LONG +
                                      //                     ' &destination=' +
                                      //                     lat.toString() +
                                      //                     ',' +
                                      //                     lon.toString() +
                                      //                     '&travelmode=driving&dir_action=navigate');
                                      //
                                      //             _launchURL(url);
                                      //             //orderRejectedOrAccept(index, context, isRejected:  true);
                                      //           },
                                      //           child: Container(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 5, right: 10, top: 5, bottom: 5),
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius: BorderRadius.circular(15),
                                      //                 color: const Color(0xFF222443)),
                                      //             child: Row(
                                      //               mainAxisSize: MainAxisSize.min,
                                      //               children: const [
                                      //                 Icon(
                                      //                   Icons.location_on_outlined,
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: 5,
                                      //                 ),
                                      //                 Text(
                                      //                   'Track',
                                      //                   style: TextStyle(
                                      //                       fontSize: 12, color: Colors.white),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      item?.status == '2' ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(
                                                getTranslated(context, "Enter OTP To Pick Parcel"),
                                               // "Enter OTP To Pick Parcel",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                            ],
                                          ),
                                          OTPField(controller: _otpController, onTap: () {orderPickedOrCompleteByOtp(_otpController.text,'3'); },),
                                          CircleAvatar(
                                              backgroundColor: CustomColors.primary2,
                                              child: IconButton(onPressed: (){
                                                orderPickedOrCompleteByOtp(_otpController.text,'3');
                                              }, color: CustomColors.White, icon: const Icon(Icons.check),)),
                                          /*ElevatedButton(

                                onPressed: (){}, child:Text('Pick'), style: ElevatedButton.styleFrom(backgroundColor: CustomColors.primary2,padding: EdgeInsets.zero),)*/
                                          //FourDigitOtpFormField(onSaved: (String ) {  },),
                                          //dropDown(index),
                                        ],
                                      ) : item?.status == '4' ? SizedBox() : Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(
                                                getTranslated(context, "Enter OTP to Complete Order"),
                                               // "Enter OTP to Complete Order",
                                                style: TextStyle(
                                                    fontSize: 13, color: Color(0xFFBF2331)),
                                              ),
                                            ],
                                          ),
                                          OTPField(controller: _otpController, onTap: () { orderPickedOrCompleteByOtp(_otpController.text,'4'); },),
                                          CircleAvatar(
                                              backgroundColor: CustomColors.primary2,
                                              child: IconButton(onPressed: (){
                                                orderPickedOrCompleteByOtp(_otpController.text,'4');
                                              }, color: CustomColors.White, icon: const Icon(Icons.check),)),
                                          //FourDigitOtpFormField(onSaved: (String ) {  },),
                                          //dropDown(index),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      item?.status == '2' ? SizedBox.shrink() :  item?.status == '4' ? SizedBox()  :  Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: CustomElevatedButton(
                                            text:
                                            getTranslated(context, "Scan QR to Complete Order"),
                                           // 'Scan QR to Complete Order',
                                            icon: Icons.qr_code,
                                            onPressed: () {
                                              scanQR();
                                            },
                                          ),
                                        ),
                                      )

                                      /* Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Payment Method",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Color(0xFFBF2331)),
                                                      ),
                                                      Text(parcelDataList[index]
                                                          .paymentMethod
                                                          .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),*/
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )

                        ;
                      },
                    )),
              ),
            ),
          ],
        )

        
      ),
    );
  }

  Widget dropDown(int i) {
    return Padding(
      padding: EdgeInsets.only(right: 7),
      child: DropdownButton<Widget>(
        // Initial Value
        value: dropdownvalue,
        hint: Text(
          getTranslated(context, "select status"),
          //    'select status',
          style: TextStyle(color: Colors.black26),
        ),

        borderRadius: BorderRadius.circular(10),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: dropDownitem.map((Widget items) {
          return DropdownMenuItem(
            value: items,
            child: items,
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (Widget? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            int index = dropDownitem.indexOf(dropdownvalue) + 1;

            updateOrderStatus(index, i);
          });
        },
      ),
    );
  }

  void _launchURL(Uri url) async {
    if (await launchUrl(url)) {
      //await launch(url);
    } else {
      Fluttertoast.showToast(msg:
      getTranslated(context, "Could not launch "),
        //  'Could not launch '
      );
      throw 'Could not launch $url';
    }
  }

  void updateOrderStatus(int index, int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = userId ?? '';
      body[RequestKeys.saleId] = widget.parcelFullDetail?[i].saleId ?? '';
      body[RequestKeys.deliveryBoyOrderStatus] = index.toString();
      body[RequestKeys.deliveryTime] = DateTime.now().toString();
      var res = await api.updateOrderStatusDriver(body);
      if (res.status ?? false) {
        print('_____success____');
        // responseData = res.data?.userid.toString();
        //orderHistoryList = res.data ?? [];
        Fluttertoast.showToast(msg: '${res.meassge}');
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: '${res.meassge}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg:
      getTranslated(context, "Invalid Email & Password"),
   //   "Invalid Email & Password"
      );
    } finally {}
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes =
          getTranslated(context, "Failed to get platform version.");
      //'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      qrCodeResult = barcodeScanRes;


      print('__________${qrCodeResult}_____qrCodeResult________');

      if(qrCodeResult == '-1'){

      }else{
        completeOrder();
      }


    });
  }

  void completeOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = userId ?? '';
      body[RequestKeys.scanId] = qrCodeResult;
      body[RequestKeys.deliveryBoyOrderStatus] = '4';
      body[RequestKeys.deliveryTime] = DateTime.now().toString();
      var res = await api.completeOrderDriver(body);
      if (res.status ?? false) {
        print('_____success____');
        // responseData = res.data?.userid.toString();
        //orderHistoryList = res.data ?? [];
        Fluttertoast.showToast(msg: '${res.meassge}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(),
            ));
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: '${res.meassge}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    } finally {}
  }

  void orderPickedOrCompleteByOtp(String otp , String status) async {
     if(otp.isEmpty){
       Fluttertoast.showToast(msg:
       getTranslated(context, "please enter otp")
    //   'please enter otp'
       );
     }else if(otp.length < 4){
       Fluttertoast.showToast(msg:
       getTranslated(context, "please enter right otp")
      // 'please enter right otp'
       );
     }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      var headers = {
        'Cookie': 'ci_session=27190b0a94b885f1a7656c45b1492a2c7a91a862'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/pickport/api/Authentication/otp_order_complete'));
      request.fields.addAll({
        'user_id': userId ?? '300',
        'otp': otp,
        'deliveryboy_order_status': status
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        _otpController.clear();
        var result = await response.stream.bytesToString();
        var finalResult = jsonDecode(result);
        if(finalResult['status']) {
          if (status == '3') {
            Fluttertoast.showToast(msg:
            getTranslated(context, "Order Picked Successfully")
          //  'Order Picked Successfully'
            );
            Navigator.pop(context);

          } else if (status == '4') {
            Fluttertoast.showToast(
                msg:
                getTranslated(context, "Order has been delivered successfully")
               // 'Order has been delivered successfully'
            );
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          }
        }else{
          Fluttertoast.showToast(msg: '${finalResult['data']}');
        }
      } else {
        _otpController.clear();
        print(response.reasonPhrase);
      }
    }
  }

  showAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 6,
            child: AlertDialog(
              alignment: Alignment.center,
              title:  Text(
                getTranslated(context, "Are you sure you want to Cencel this parcel?"),
              //  "Are you sure you want to Cencel this parcel?",
                textAlign: TextAlign.center,
              ),
              content:  Text(
                getTranslated(context, "If yes, then you will be charged a penalty"),
              //  "If yes, then you will be charged a penalty",
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF222443)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              getTranslated(context, "Yes"),
                             // 'Yes',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF222443)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              getTranslated(context, "No"),
                            //  'No',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

Widget item({String? title, Color? color}) {
  return Container(
    color: Colors.transparent,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? Colors.orange,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title ?? ''),
      ],
    ),
  );
}

/*class FourDigitOtpFormField extends StatefulWidget {
  final Function(String) onSaved;

  FourDigitOtpFormField({required this.onSaved});

  @override
  _FourDigitOtpFormFieldState createState() => _FourDigitOtpFormFieldState();
}

class _FourDigitOtpFormFieldState extends State<FourDigitOtpFormField> {
  late TextEditingController _controller;
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 30,
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: _controller,
          autofocus: true,
          focusNode: _focusNode1,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              _focusNode1.unfocus();
              FocusScope.of(context).requestFocus(_focusNode2);
            }
          },
        ),
      ),
      SizedBox(width: 10),
      Container(
        width: 30,
        child: TextFormField(
          textAlign: TextAlign.center,
          autofocus: false,
          focusNode: _focusNode2,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              _focusNode2.unfocus();
              FocusScope.of(context).requestFocus(_focusNode3);
            }
          },
        ),
      ),
      SizedBox(width: 10),
      Container(
        width: 30,
        child: TextFormField(
          textAlign: TextAlign.center,
          autofocus: false,
          focusNode: _focusNode3,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              _focusNode3.unfocus();
              FocusScope.of(context).requestFocus(_focusNode4);
            }
          },
        ),
      ),
      SizedBox(width: 10),
      Container(

        width: 30,
        child: TextFormField(
          textAlign: TextAlign.center,
          autofocus: false,
          focusNode: _focusNode4,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              _focusNode3.unfocus();
              FocusScope.of(context).requestFocus(_focusNode4);
            }
          },
        ),
      ),
    ]);
  }
}*/

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  OTPField({required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: TextFormField(
        onEditingComplete:onTap,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
          _OTPInputFormatter(),
        ],
        decoration:  InputDecoration(
          border: OutlineInputBorder(),
          labelText:
          getTranslated(context, "Enter OTP"),
         // 'Enter OTP',
        ),
      ),
    );
  }
}

class _OTPInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      final int selectionIndex = newValue.selection.end;

      String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
      if (newText.length > 6) {
        newText = newText.substring(0, 6);
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selectionIndex,
        ),
      );
    }
    return newValue;
  }
}

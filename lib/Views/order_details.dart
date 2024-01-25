import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jdx/Views/share_qr/share_qr.dart';
import 'package:jdx/widgets/custom_cliper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/order_history_response.dart';
import '../services/location/location.dart';
import '../services/session.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({Key? key, this.orderDetail}) : super(key: key);
  final OrderHistoryData? orderDetail;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  Position? _position;

  @override
  void initState() {
    // TODO: implement initState
    inIt();
    super.initState();
  }

  inIt() async {
    _position = await getUserCurrentPosition();
    print("${_position!.longitude}______________");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: const Color(0xFF222443),
        title: Text(
            getTranslated(context, "Order Details"),
           // 'Order Details'
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF222443), Color(0xFF222443)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.75, 1]),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(2, 3))
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.orderDetail?.orderId ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ClipPath(
                    clipper: CustomClip(),
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                     Text(
                                        getTranslated(context, "Order Date"),
                                       // 'Order Date',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          widget.orderDetail?.onDate.toString().substring(0,11) ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      const SizedBox(height: 10),
                                     Text(
                                        getTranslated(context, "Sender"),
                                       // 'Sender',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.orderDetail?.senderName
                                            .toString() ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                      const SizedBox(height:5 ),
                                      Text(
                                        getTranslated(context, "Track sender"),
                                       // 'Track sender',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(


                                        onTap: () {
                                          String lat =
                                              widget.orderDetail?.senderLatitude.toString() ?? '';//'22.7177'; //
                                          String lon =
                                              widget.orderDetail?.senderLongitude.toString() ?? '';//'75.8545'; //
                                          String CURENT_LAT =
                                              _position?.latitude.toString() ?? '';
                                          String CURENT_LONG =
                                              _position?.longitude.toString() ?? '';

                                          final Uri url = Uri.parse(
                                              'https://www.google.com/maps/dir/?api=1&origin=' +
                                                  CURENT_LAT +
                                                  ',' +
                                                  CURENT_LONG +
                                                  ' &destination=' +
                                                  lat.toString() +
                                                  ',' +
                                                  lon.toString() +
                                                  '&travelmode=driving&dir_action=navigate');
                                          /*String url = 'https://www.google.com';'https://www.google.com/maps/dir/?api=1&origin=' +
                          CURENT_LAT+
                          ','+
                          CURENT_LONG+
                          ' &destination='+
                          lat.toString()+
                          ','+
                          lon.toString()+
                          '&travelmode=driving&dir_action=navigate';*/

                                          _launchURL(url);
                                          //orderRejectedOrAccept(index, context, isRejected:  true);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: const Color(0xFF222443)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:  [
                                              Icon(Icons.location_on_outlined, color: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text(
                                                getTranslated(context, "Track"),
                                               // 'Track',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const DottedLine(
                                  dashColor: Colors.grey,
                                  direction: Axis.vertical,
                                  lineThickness: 1.2,
                                  lineLength: 80.0,
                                  dashGapLength: 5.0,
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        getTranslated(context, "Sender Address"),
                                       // 'senderAddress',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.orderDetail?.senderAddress ?? '',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        textAlign: TextAlign.end,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        getTranslated(context, "Amount"),
                                      //  'Amount',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\u{20B9}${widget.orderDetail?.orderAmount ?? 'N/A'}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.orderDetail?.parcelDetails.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: productCard(
                          index) /*Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        child: SizedBox(
                          width:
                          MediaQuery.of(context).size.width / 1.1,

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.0),
                                          child: Text("Recipient Name",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(
                                                      0xFFBF2331))),
                                        ),
                                        Text(widget.orderDetail?.parcelDetails[index].accountName ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Mobile No",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFBF2331)),
                                        ),
                                        Text(widget.orderDetail?.parcelDetails[index].phoneNo ?? ''),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Sender Name",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFBF2331)),
                                        ),
                                        Text(widget.orderDetail?.parcelDetails[index].senderName ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Delivery Address",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFBF2331)),
                                        ),
                                        Text(widget.orderDetail?.parcelDetails[index].deliveryAddress ?? ''),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color:
                                                Color(0xFFBF2331)),
                                          ),
                                          Text(widget.orderDetail?.parcelDetails[index].onDate.toString() ?? ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Receiver Address",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFBF2331)),
                                        ),
                                        Text(widget.orderDetail?.parcelDetails[index].receiverAddress ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          ),
                        ),
                      )*/
                      ,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard(int index) {
    var item = widget.orderDetail?.parcelDetails[index];
    print('${item.runtimeType}___________');
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 3))
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              height: 50,
              width: 50,
              child: Image.network(item?.parcelPhoto ?? '')),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.accountName ?? '',
                  style: const TextStyle(color: Colors.red),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textColumn(
                        getTranslated(context, "IsPaid"),
                        //'IsPaid'
                         item?.isPaid ?? '-'),
                    textColumn(
                        getTranslated(context, "Status"),
                        //Status'
                         item?.status ?? '-'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Text(
                          getTranslated(context, "City"),
                        //  'City',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: Text(
                            '${item?.city ?? '-'}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    // textColumn('Rate', '\u{20B9}${item.rate.toString()}'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Text(
                          getTranslated(context, "Total Amount"),
                          //'Total Amount',
                          style:
                          TextStyle(fontSize: 12, color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: Text(
                            '\u{20B9} ${item?.totalAmount ?? '-'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    //textColumn('Amount', '\u{20B9}${item.amount.toString()}'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getTranslated(context, "Track receiver : "),
                    //  'Track receiver : ',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        String lat =
                            item?.receiverLatitude.toString() ?? '';//'22.7177';
                        String lon =
                            item?.receiverLongitude.toString() ?? '';//'75.8545';
                        String CURENT_LAT =
                            _position?.latitude.toString() ?? '';
                        String CURENT_LONG =
                            _position?.longitude.toString() ?? '';

                        final Uri url = Uri.parse(
                            'https://www.google.com/maps/dir/?api=1&origin=' +
                                CURENT_LAT +
                                ',' +
                                CURENT_LONG +
                                ' &destination=' +
                                lat.toString() +
                                ',' +
                                lon.toString() +
                                '&travelmode=driving&dir_action=navigate');
                        /*String url = 'https://www.google.com';'https://www.google.com/maps/dir/?api=1&origin=' +
                        CURENT_LAT+
                        ','+
                        CURENT_LONG+
                        ' &destination='+
                        lat.toString()+
                        ','+
                        lon.toString()+
                        '&travelmode=driving&dir_action=navigate';*/

                        _launchURL(url);
                        //orderRejectedOrAccept(index, context, isRejected:  true);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF222443)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Icon(Icons.location_on_outlined, color: Colors.white,),
                            SizedBox(width: 5,),
                            Text(
                              getTranslated(context, "Track"),
                            //  'Track',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          ],),
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text(
                      getTranslated(context, "Share QR Code : "),
                     // 'Share QR Code : ',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => ShareQRCode(parcel: item ),));

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
                            Icon(Icons.qr_code, color: Colors.white,),
                            SizedBox(width: 5,),
                            Text(
                              getTranslated(context, "Share"),
                             // 'Share',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          ],),
                      ),
                    ),


                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textColumn(String title, String subTitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.red),
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        )
      ],
    );
  }

  void _launchURL(Uri url) async {
    if (await launchUrl(url)) {
      //await launch(url);
    } else {
      Fluttertoast.showToast(msg:
      getTranslated(context, "Could not launch"),
     // 'Could not launch '
      );
      throw 'Could not launch $url';
    }
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jdx/Models/Acceptorder.dart';
import 'package:jdx/Models/accepted_order_response.dart';
import 'package:jdx/Models/parcel_history_response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:jdx/Views/parcel_details.dart';
import 'package:jdx/Views/share_qr/share_qr.dart';
import 'package:jdx/services/location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Models/Acceptorder.dart';
import '../Models/parcel_list_model.dart';
import '../Utils/Color.dart';
import '../services/api_services/api.dart';
import '../services/api_services/request_key.dart';
import '../services/session.dart';
import 'ParcelDetails.dart';


class ParcelHistory extends StatefulWidget {
  const ParcelHistory({Key? key}) : super(key: key);

  @override
  State<ParcelHistory> createState() => _ParcelHistoryState();
}
class _ParcelHistoryState extends State<ParcelHistory> {
 // Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getParcelListApi();
  }
  //List<AccepetedOrderList> parcelDataList = [];
  // Acceptorder? parcelDataList;
  bool isLoading = false;

  ParcelListModel? parcelDataList;
  getParcelListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    var headers = {
      'Cookie': 'ci_session=c4370beef33ee79f901e567ecda93c42af5e89d7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/get_order_request'));
    request.fields.addAll({
      'user_id': userId ?? "323",
      'status':"4"
    });
    print("get parcel history ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalRsult = ParcelListModel.fromJson(json.decode(result));
      setState(() {
        parcelDataList  = finalRsult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   getAcceptedOrder();
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       /*leading: Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Container(
  //             height: 23,
  //             width: 23,
  //             decoration: BoxDecoration(
  //                 color: Colors.white, borderRadius: BorderRadius.circular(30)),
  //             child: const Icon(
  //               Icons.arrow_back,
  //               color: Colors.black,
  //             )),
  //       ),*/
  //       backgroundColor: const Color(0xFF222443),
  //       title: const Text('Parcel History'),
  //       centerTitle: true,
  //     ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(15, 54, 140, 1),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
            padding: const EdgeInsets.all(2),
            child: Text(
              getTranslated(context, "Parcel History"),
            //  'Parcel History',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
                height: MediaQuery.of(context).size.height/1.0,
                decoration: BoxDecoration(
                    color: colors.splashcolor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: parcelDataList?.status == 0  ? Center(child: Text("Parcel Not Found", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,),)):
                  Container(
                    child: parcelDataList == null ? Center(child: CircularProgressIndicator()): ListView.builder(
                        // scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: false,
                        itemCount: parcelDataList?.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PercelDetails(pId:parcelDataList?.data?[index].orderId ,isCheck: true,)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 1,
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
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                    getTranslated(context, "Parcel Id"),
                                                   // "Parcel ID",
                                                    style: TextStyle(
                                                        fontSize: 16,fontWeight: FontWeight.bold,
                                                        color:Color(0xFF0F368C))),
                                              ),
                                              Text("#${parcelDataList?.data?[index].orderId ?? '-'}"),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              parcelDataList?.data?[index].parcelDetails?.first.status == "4" ? Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Text(
                                                  getTranslated(context, "Delivered"),
                                                 // "Delivered",
                                                  style: TextStyle(color: Colors.green,fontSize: 18),),
                                              ):Text(
                                                getTranslated(context, "cancel"),
                                              //    "Cancel"
                                              )
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
                                               Text(
                                                 getTranslated(context, "Receiver's Name :"),
                                               // "Receiver's Name :",
                                                style: TextStyle(
                                                    fontSize: 16,fontWeight: FontWeight.bold,
                                                    color: Color(0xFF0F368C)),
                                              ),
                                               SizedBox(
                                                width: 100,
                                                child: Text(parcelDataList?.data?[index].parcelDetails?.first.receiverName ?? '-',
                                                    overflow:
                                                        TextOverflow.clip),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                getTranslated(context, "Order Date :"),
                                               // "Order Date :",
                                                style: TextStyle(
                                                    fontSize: 16,fontWeight: FontWeight.bold,
                                                    color: Color(0xff000000)),
                                              ),
                                               SizedBox(
                                                width: 100,
                                                child: Text(
                                                    parcelDataList?.data?[index].parcelDetails?.first.onDate ?? '-',
                                                    overflow:
                                                        TextOverflow.fade,
                                                    maxLines: 3),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      InkWell(
                                          onTap: (){
                                           // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ParcelDetailsView(parcelFullDetail: parcelDataList!.data![index].parcelDetails))).then((value) => getAcceptedOrder());
                                          },
                                          child: const Align(
                                            alignment: Alignment.bottomCenter,
                                            // child: Text('See full details', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red),)),
                                          ))

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
                            ),
                          );
                        }),
                  ),
                ),

                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   width: double.maxFinite,
                //   child: isLoading
                //       ? const Center(child: CircularProgressIndicator())
                //       : parcelDataList?.data?.isEmpty ?? false
                //       ? const Center(child: Text('Data Not Available'))
                //       :
                // ),
            ),

          ],
        ),
      ),
    );
  }



  /*void getAcceptedOrder() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = userId ?? '';
      var res = await api.getAcceptedOrderData(body);
      if (res.status == 1) {
        print('_____success____');
        // responseData = res.data?.userid.toString();
        parcelDataList = res.data ?? [];
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: '');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
    } finally {
      isLoading = false;
    }
  }*/
  // getAcceptedOrder() async {
  //   isLoading = true;
  //   setState(() {
  //
  //   });
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString("userId");
  //   print(" this is  User++++++++++++++>${userId}");
  //   var headers = {
  //   'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=2c1b56459e9faa5d8a7a5d04455cd0c8f6cee0f0'
  //   };
  //   var request = http.Request(
  //       'POST', Uri.parse('${Urls.baseUrl}payment/get_order_request'));
  //   request.body = json.encode({'user_id': userId.toString()});
  //   print(" this is  User++++++++++++++>${request.body}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final result = await response.stream.bytesToString();
  //     var finalResult = Acceptorder.fromJson(jsonDecode(result));
  //     isLoading = false;
  //     print("thisi is ============>${finalResult}");
  //     setState(() {
  //       parcelDataList = finalResult;
  //     });
  //   } else {
  //     isLoading = false;
  //     print(response.reasonPhrase);
  //   }
  // }
}

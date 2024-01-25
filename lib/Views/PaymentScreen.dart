import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jdx/Models/driver_to_recieve_payment_response.dart';
import 'package:jdx/Models/payment_history_response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:jdx/Utils/CustomColor.dart';
import 'package:jdx/services/api_services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_services/request_key.dart';
import 'package:http/http.dart' as http;

import '../services/session.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Api api = Api();

  List<PaymentHistoryDataList> paymentHistoryList = [];
  bool isLoading = false ;
  int selectedSegmentVal = 0 ;

  @override
  void initState() {
    // TODO: implement initState
    //getPaymentHistory();
    //toReceivePayment();
    getDriverDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text(
              getTranslated(context, "Payment"),
           //   'Payment'
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF222443),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ),
          )),
      body: isLoading ? Center(child: CircularProgressIndicator(color: Colors.grey,)) : SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 55,
                    child: Image.asset('assets/images/cash.png', fit: BoxFit.cover),
                  ),
                ),
                 Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, "Cash On Delivery Amount"),
                    //  'Cash On Delivery Amount ',
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    )),
                const SizedBox(
                  height: 30,
                ),
                /*const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Total Earning',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text('Rs. ${driverToReceivePaymentResponse?.data?.totalAmount}')),*/

                /*const Text(
                  'Payment History',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),*/

                const SizedBox(height: 10,),
                _segmentButton(),

               isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.grey,)) : selectedSegmentVal==0 ?  toReceiveWidget() : toPayWidget()
                /*SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: driverToReceivePaymentResponse?.data?.orderData?.length ?? 0,
                    itemBuilder: (context, index) {
                      return   isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.grey,)) : selectedSegmentVal==0 ?  toReceiveWidget(index) : toPayWidget(index);  //productCard(index);
                    },
                  ),
                )*/
              ],


            ),
          )),
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

 /* Widget productCard(int index) {
    var item = paymentHistoryList[index];
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
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
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
              child: Image.network(item.attachment ?? '--')),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.id ?? '',
                  style: const TextStyle(color: Colors.red),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textColumn('Id', item.id ?? '-'),
                    textColumn('Status', item.status ?? '-'),
                    textColumn('City', item.status ?? '-'),
                    textColumn('Date', item.createDt ?? '-'),
                    // textColumn('Rate', '\u{20B9}${item.rate.toString()}'),
                    Column(
                      children: [
                        const Text(
                          'Amount',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: Text(
                            '\u{20B9} ${item.amount ?? '-'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    //textColumn('Amount', '\u{20B9}${item.amount.toString()}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

/*  void getPaymentHistory() async {
    isLoading =true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = userId ?? '';
      var res = await api.getPaymentHistoryData(body);
      if (res.status ?? false) {
        print('_____success____');
        Fluttertoast.showToast(msg: res.message ?? '');
        // responseData = res.data?.userid.toString();
        paymentHistoryList = res.data ?? [];
        setState(() {
          isLoading =false;
        });
      } else {
        Fluttertoast.showToast(msg: res.message ?? '');
        isLoading =false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid Password");
    } finally {
      isLoading =false;
    }
  }*/

  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
     // parcelHistory(2);
    } else if (i == 1) {
      //parcelHistory(1);
    }
    setState(() {

    });
    // getOrderList(status: status);

  }

  Widget _segmentButton() => Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: Colors.white,
    ),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 0
                        ? [CustomColors.darkBlueColor, CustomColors.darkBlueColor]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Text(
                getTranslated(context, "To Receive"),
               // 'To Receive',
                style:  TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,
                    color: selectedSegmentVal == 0
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 30,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [CustomColors.darkBlueColor, CustomColors.darkBlueColor  ]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: FittedBox(
                child: Text(
                  getTranslated(context, "To Pay"),
                //  'To Pay',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,
                      color: selectedSegmentVal == 1
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  DriverToReceivePaymentResponse? driverToReceivePaymentResponse;


/* Future <void> toReceivePayment() async{

   setState(() {
     isLoading =true;
   });
   SharedPreferences prefs = await SharedPreferences.getInstance();
   final userId = prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=88167424081073f013b15a7d0f5d3ea52c0437b8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/get_driver_cod_list'));
    request.fields.addAll({
      'user_id': userId ?? '328'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var data =  await response.stream.bytesToString();
     var finalResult = jsonDecode(data);
     if(finalResult['status']){
       driverToReceivePaymentResponse = DriverToReceivePaymentResponse.fromJson(finalResult) ;
       setState(() {
         isLoading =false;
       });
     }else{
       Fluttertoast.showToast(msg: finalResult['message']);
       setState(() {
         isLoading =false;
       });
     }
    }
    else {
    print(response.reasonPhrase);
    setState(() {
      isLoading =false;
    });
    }
  }*/



  toReceiveWidget({int? index})  {

   var item = driverToReceivePaymentResponse?.data?.orderData?[index ?? 1];
   return Center(
     child: Padding(
       padding: EdgeInsets.all(16.0),
       child: Container(
         decoration: BoxDecoration(
           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.2),
               blurRadius: 4.0,
               spreadRadius: 2.0,
               offset: Offset(0, 2),
             ),
           ],
         ),
         child: Padding(
           padding: EdgeInsets.all(16.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 'Amount: ₹ ${toReceive}',
                 style: TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               /*SizedBox(height: 20),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Sender:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('${item?.senderName}'),
                         SizedBox(height: 10),
                         Text(
                           'Sender Address:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text(item?.senderAddress ?? 'N/A'),
                         SizedBox(height: 10),
                         *//*Text(
                           'Receiver:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('Me'),
                         SizedBox(height: 10),
                         Text(
                           'Receiver Phone:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('9635222478'),
                         SizedBox(height: 10),*//*
                         Text(
                           'Receiver Address:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text(item?.receiverAddress ?? 'N/A'),
                       ],
                     ),
                   ),
                   SizedBox(width: 20),
                   Expanded(
                     flex: 1,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Total Amount',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text(item?.totalAmount ??'N/A'),
                         SizedBox(height: 10),
                         Text(
                           'Date',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text(item?.onDate ?? 'N/A'),
                         SizedBox(height: 10),
                         Text(
                           'Distance:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('0.89 km'),
                         SizedBox(height: 10),
                         Text(
                           'Amount:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Row(
                           children: [
                             Text('Driver: '),
                             Text(
                               '\$${item?.driverAmont}',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         *//*SizedBox(height: 5),
                         Row(
                           children: [
                             Text('Admin: '),
                             Text(
                               '\$7',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),*//*
                       ],
                     ),
                   ),
                 ],
               ),*/
             ],
           ),
         ),
       ),
     ),
   );
  }

  toPayWidget({int? index})  {

    var item = driverToReceivePaymentResponse?.data?.orderData?[index ?? 1];
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.primary2,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount: ₹ ${toPay}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.White
                  ),
                ),
                /*SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sender:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('${item?.senderName}'),
                          SizedBox(height: 10),
                          Text(
                            'Sender Address:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(item?.senderAddress ?? 'N/A'),
                          SizedBox(height: 10),
                          *//*Text(
                           'Receiver:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('Me'),
                         SizedBox(height: 10),
                         Text(
                           'Receiver Phone:',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5),
                         Text('9635222478'),
                         SizedBox(height: 10),*//*
                          Text(
                            'Receiver Address:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(item?.receiverAddress ?? 'N/A'),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(item?.totalAmount ??'N/A'),
                          SizedBox(height: 10),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(item?.onDate ?? 'N/A'),
                          SizedBox(height: 10),
                          Text(
                            'Distance:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('0.89 km'),
                          SizedBox(height: 10),
                          Text(
                            'Amount:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          *//*SizedBox(height: 5),
                          Row(
                            children: [
                              Text('Driver: '),
                              Text(
                                '\$${item?.driverAmont}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )*//*
                          SizedBox(height: 5),
                         Row(
                           children: [
                             Text('Admin: '),
                             Text(
                               '\$7',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                        ],
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? toPay;
  String? toReceive;

  Future<void> getDriverDetail() async {
    setState(() {
      isLoading = true ;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=ea86425602d6ef78ad0a04f606d792bba4b58299'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Authentication/driver_details'));
    request.fields.addAll({
      'user_id': userId ?? '326'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult = jsonDecode(result) ;
      toPay = finalResult['data'][0]['cash_collection'];
      toReceive = finalResult['data'][0]['to_pay'];
      setState(() {
        isLoading = false ;
      });
    }
    else {
      setState(() {
        isLoading = false ;
      });
      print(response.reasonPhrase);
    }

  }





}

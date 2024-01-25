import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/Utils/Color.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/AddMoneyModel.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';
import 'Mywallet.dart';

import 'package:http/http.dart'as http;

class AddAmount extends StatefulWidget {
  const AddAmount({Key? key, this.walletBalance}) : super(key: key);
 final String? walletBalance;
  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  TextEditingController amountCtr = TextEditingController();
  late Razorpay _razorpay;
  AddMoneyModel? Addwallet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  onSuccessAddMoney() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=a73a943cc72f7a14a48f171f18226dddd0e6a0ec'
    };
    var request = http.Request('POST', Uri.parse('${Urls.baseUrl}Payment/driver_add_money_to_wallet'));
    request.body = json.encode({
      "user_id": userId.toString(),
      "amount": amountCtr.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    print('_____sssss_____${request.body}_____________');
    print('__________${response.statusCode}_____________');

    if (response.statusCode == 200) {
      print('User Id Is Here>>>>>>>>>${userId}');
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = AddMoneyModel.fromJson(json.decode(finalResult));
      setState((){
        Addwallet = jsonResponse;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyWallet()));
      // Fluttertoast.showToast(msg: '${jsonResponse['message']}');
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: primaryColor,
      //   leading: GestureDetector(
      //     onTap: (){
      //       Navigator.pop(context);
      //     },
      //     child: Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
      //     //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
      //   ),
      //   title:  Text('Add Amount', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),),
      //   // actions: [
      //   //   Padding(
      //   //     padding:  EdgeInsets.only(right: 10),
      //   //     child: InkWell(
      //   //         onTap: (){
      //   //           Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
      //   //         },
      //   //         child: Icon(Icons.notifications,color: Colors.white,)),
      //   //   )
      //   // ],
      // ),
      body:   Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: colors.whiteTemp,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Center(child: Icon(Icons.arrow_back)),
                    ),
                  ),
                 Text(
                    getTranslated(context, "Add Amount")
                   // "Add Amount"
                    ,style: TextStyle(color: colors.whiteTemp),),
                  Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                        color: colors.splashcolor,
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //         const SupportNewScreen()));
                        },
                        child: Center(
                          child: Image.asset(
                            'assets/ProfileAssets/support.png',scale: 1.3,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Container(
                decoration: const BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                ),
                child:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(child: Text(
                          getTranslated(context, "Add money to wallet"),
                         // "Add money to wallet",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                        Text(
                          getTranslated(context, "Available Balance"),
                        //  "Available Balance",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Text(widget.walletBalance??'---',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        const SizedBox(height: 20,),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextField(
                              controller: amountCtr,
                              keyboardType: TextInputType.number,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText:
                                getTranslated(context, "Amount"),
                               // "Amount",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              openCheckout();
                              // Get.to(ParceldetailsScreen());
                            }
                            // Get.to(AddAmount());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.primary,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width/2.5,
                            child:Center(child: Text(
                              getTranslated(context, "Proceed"),
                             // "Proceed",
                              style: TextStyle(color: colors.whiteTemp,fontSize: 15),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }



  void openCheckout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('userPhone');
     String? email = prefs.getString('userEmail');

    // String? phone = '9074305952';
    int amt = int.parse(amountCtr.text);


    print('${email}______dddd_________');
    print('${phone}_______________');
    print('${amt}_______________');

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amt*100,
      'name': 'PICKPORT Driver',
      'description': 'PICKPORT Driver',
      "currency": "INR",
     'prefill': {'contact': '$phone', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    onSuccessAddMoney();
    Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);

    print('${response.error}________error_________');
    print('${response.code}________code_________');
    Fluttertoast.showToast(
        msg: "Payment cancelled by user",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}



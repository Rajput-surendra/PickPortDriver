
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jdx/Utils/Color.dart';
import 'package:jdx/Views/SupportNewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/GetBalanceModel.dart';
import '../Models/GetProfileModel.dart';
import '../Models/WalletHistoryModel.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';
import 'AddAmountwallet.dart';
import 'NotificationScreen.dart';
import 'package:http/http.dart'as http;

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {

  TextEditingController amountController = TextEditingController();

  WalletHistoryModel? walletHistorymodel;
  walletHistroy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=fa798ca5ff74e60a6d79d768d0be8efac030321a'
    };
    var request = http.Request('POST', Uri.parse('${Urls.baseUrl}Payment/wallet_history'));
    request.body = json.encode({
      "user_id": userId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(request.body);
    print(request.url);
    if (response.statusCode == 200) {
      print('Userr Id@@@@@@@${userId}');
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = WalletHistoryModel.fromJson(json.decode(finalResult));
      setState((){
        walletHistorymodel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  GetProfileModel? getProfileModel;
  String qrCodeResult = "Not Yet Scanned";

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print(" this is  User++++++++++++++>$userId");
    var headers = {
      'Cookie': 'ci_session=6de5f73f50c4977cb7f3af6afe61f4b340359530'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}User_Dashboard/getUserProfile'));
    request.fields.addAll({'user_id': userId.toString()});
    print(" this is  User++++++++++++++>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalResult = GetProfileModel.fromJson(jsonDecode(result));
      print("thisi is============>$result");
      setState(() {
        getProfileModel = finalResult;
        wallet = "${getProfileModel!.data![0].wallet}";
        //Fluttertoast.showToast(msg: qrCodeResult);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String ? wallet;
  String ? minimumBalance;
  @override
  void initState() {
    // TODO: implement initState
    getWalletBalance();
    walletHistroy();
    getProfile();
    super.initState();
  }


  GetBalanceModel? getBalanceModel;
  getWalletBalance() async {
    var headers = {
      'Cookie': 'ci_session=c3663036678f59c6e1598643dc7b12f9ed509821'
    };
    var request = http.Request('POST', Uri.parse('${Urls.baseUrl}Authentication/driver_min_wallet'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalResult = GetBalanceModel.fromJson(jsonDecode(result));
      print("thisi is============>$result");
      setState(() {
        getBalanceModel = finalResult;
        minimumBalance = "${getBalanceModel!.data!.amt}";
        print("===============$minimumBalance===========");
        //Fluttertoast.showToast(msg: qrCodeResult);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
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
                    getTranslated(context, "Pickport Wallet"),
                    //"Pickport Wallet",
                    style: TextStyle(color: colors.whiteTemp,fontSize: 18),),
                  Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                        color: colors.splashcolor,
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SupportNewScreen()));
                        },
                        child: const Icon(
                          Icons.headset_rounded,
                          color: Colors.black,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 17,
            child: Container(
                decoration: const BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35))
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                         Center(child: Text(
                          getTranslated(context, "Available Balance"),
                       //   "Available Balance",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                         const SizedBox(height: 5,),
                         Text("Minimum Wallet Amount is ₹ $minimumBalance", style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5,),
                        // wallet == null || wallet == "" ? Text("₹ ${minimumBalance?? '0'}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),):
                        Text("₹ ${wallet?? '0'}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              //walletHistroy();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       AddAmount(walletBalance: wallet??'--',))).then((value) =>  walletHistroy());
                            //  Get.to(AddAmount(walletBalance: wallet??'--',))?.then((value) => walletHistroy() );
                            }
                            // addMoney();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.primary,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width/2.5,
                            child: Center(
                              child: Text(
                                getTranslated(context, "Add Money"),
                               // "Add Money",
                                style: TextStyle(color: colors.whiteTemp,fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Icon(Icons.account_balance_wallet, color: colors.primary,),
                            SizedBox(width: 10,),
                            Text(
                              getTranslated(context, "Wallet History"),
                             // "WalletHistory",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          ],),),
                        walletHistorymodel?.data == null ? Center(child: CircularProgressIndicator(color: colors.splashcolor,),) : walletHistorymodel?.data?.isEmpty ?? true ?
                       Text(
                          getTranslated(context, "Not Available"),
                          //"Not Available",
                        ): ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: walletHistorymodel?.data?.length,
                          itemBuilder: (context, index) {
                            var item = walletHistorymodel?.data?[index];
                            return Card(
                              elevation: 2.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount: ${item?.amount}',
                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      'Payment Type: ${item?.paymentType}',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      'Status: ${item?.paymentMethod == "0"? "Success": "Failed"}',
                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date : ${item?.createDt}',
                                          style: const TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },)
                      ],
                    ),
                  ),
                ),

            ),
          )

        ],
      ),


    );
  }
}

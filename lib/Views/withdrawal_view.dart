import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart'as http;
import 'package:jdx/Utils/Color.dart';
import 'package:jdx/Views/SupportNewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/GetProfileModel.dart';
import '../Models/Get_transaction_model.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';

class WithdrawalScreen extends StatefulWidget {
  WithdrawalScreen({Key? key, this.isFrom,this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {

  @override
  void initState() {
    super.initState();
    getProfile();
    balanceUser();
  }
  String? userBalance,userId;
  balanceUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    setState(() {

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
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalResult = GetProfileModel.fromJson(jsonDecode(result));
      print("thisi is ============>${result}");
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



  TextEditingController amountController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          backgroundColor: colors.primary,
          body: ListView(
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),

                  // height: MediaQuery.of(context).size.height * 0.12,
                  // width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: colors.primary),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
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
                          Text(
                            getTranslated(context, "Withdraw Money"),
                            //   'Withdraw Money',
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportNewScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration:
                              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                              child: const Icon(
                                Icons.headset_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                ),
              ),
              Padding(
                // padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.1),
                padding: EdgeInsets.only(
                  top:20,
                ),
                child:

                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        // Top-left corner radius
                        topRight: Radius.circular(30),
                        // Top-right corner radius
                      ),
                    ),
                    child:SingleChildScrollView(
                      child:Column(
                        children: [
                          tabTop(),
                          _currentIndex == 1 ? withdrawal():withdrawalRequest()

                        ],
                      ),

                    )
                ),
              )
            ],
          )




      ),
    ) ;

  }
  int _currentIndex = 1 ;
  tabTop(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 1;
                  // getNewListApi(1);


                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1 ?
                    colors.primary
                        :  colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 45,
                child: Center(
                  child: Text(
                      getTranslated(context, "Withdrawal"),
                      //  "Withdrawal"
                      style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp,fontSize: 18)),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),

          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 2;
                  getTransactionApi();
                  // getNewListApi(3);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2 ?
                    colors.primary
                        :  colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 45,
                child: Center(
                  child: Text(""
                      "Withdrawal List",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp,fontSize: 18),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  withdrawal(){
    return  Form(
      key: _formKey,
      child: Column(
        children: [
          showContent(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.whiteTemp,
                      ),

                      child: TextFormField(

                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 8,top: 5),
                          border: InputBorder.none,
                          hintText:
                          getTranslated(context, "Enter Amount"),
                          //  'Enter Amount'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || int.parse(value) <= 0) {
                            return
                              getTranslated(context, "Please enter amount");
                            //  'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.whiteTemp,
                      ),

                      child: TextFormField(

                        keyboardType: TextInputType.name,
                        controller: messageController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,top: 5),
                            border: InputBorder.none,
                            hintText:
                            getTranslated(context, "Enter message")
                          //'Enter message'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return
                              getTranslated(context, "Please enter message");
                            // 'Please enter message';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          getWithdrawApi();}
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                            ,color: colors.primary
                        ),
                        child: Center(child:isLodding == true ? Center(child: CircularProgressIndicator()): Text("Withdrawal Amount",style: TextStyle(color: colors.whiteTemp),)),
                      ),
                    ),
                  )
                ]
            ),
          ),

        ],
      ),
    );
  }


  withdrawalRequest(){
    return  getTransactionModel == null? Center(child: CircularProgressIndicator()) : getTransactionModel?.data?.length==0 ?  Center(child: Text("No Withdrawal List Found!!")):Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:  MediaQuery.of(context).size.height/1.3,
        child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: getTransactionModel?.data?.length,
            itemBuilder: (context,i){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3,),
                        Text("₹ ${getTransactionModel?.data?[i].amount}"),
                        const SizedBox(height: 3,),
                        Text("${getTransactionModel?.data?[i].date}"),
                        const SizedBox(height: 3,),
                        Text("${getTransactionModel?.data?[i].notes}"),
                        const SizedBox(height: 3,),
                        Text("${getTransactionModel?.data?[i].paymentStatus}"),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }


  bool isLodding =  false;

  getWithdrawApi() async {
    setState(() {
      isLodding =  true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Cookie': 'ci_session=84167892b4c1be830d2a6845f3443f5df00291c5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/api_requestToWithdrawal'));
    request.fields.addAll({
      "user_id":userId.toString(),
      "amount":amountController.text,
      "notes":messageController.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        isLodding = false;
      });
      var result = await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      if(finalResult['status'] == true){
        Navigator.pop(context);
      }
    }
    else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }
  }

  //LotteryListModel? lotteryDetailsModel;

  StateSetter? dialogState;
  TextEditingController  amtC = TextEditingController();
    TextEditingController  msgC = TextEditingController();
  ScrollController controller = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  showContent() {
    return SingleChildScrollView(
      controller: controller,
      child:   Column(
          mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.only(top: 5.0,left:5 ,right: 5),
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
                  wallet == null ? Text("No Balance") :Text("₹${wallet}" ,style: TextStyle(color: colors.blackTemp,fontSize: 15),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),

      ]),
    );
  }
  GetTransactionModel? getTransactionModel;

  getTransactionApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    var headers = {
      'Cookie': 'ci_session=84167892b4c1be830d2a6845f3443f5df00291c5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/api_wallet_history'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    print('____Som______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('____Som______${request.fields}_________');
      var result  = await response.stream.bytesToString();
      var finalResult = GetTransactionModel.fromJson(json.decode(result));
      Fluttertoast.showToast(msg: "${finalResult.message}");
      setState(() {
        getTransactionModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

}

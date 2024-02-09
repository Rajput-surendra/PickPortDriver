

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/Color.dart';
import '../Models/Get_online_offline_Model.dart';
import '../Models/NewContactModel.dart';
import '../Models/contactus.dart';
import '../Utils/ApiPath.dart';
import '../services/session.dart';

class OnlineOfflineHistoryScreen extends StatefulWidget {

  const OnlineOfflineHistoryScreen({Key? key}) : super(key: key);


  @override
  State<OnlineOfflineHistoryScreen> createState() => _OnlineOfflineHistoryScreenState();
}

class _OnlineOfflineHistoryScreenState extends State<OnlineOfflineHistoryScreen> {


  void initState() {
    // TODO: implement initState
    super.initState();
    onlineOfflineHistoryApi();

  }

  GetOnlineOfflineModel ? getOnlineOfflineModel;
  onlineOfflineHistoryApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    var headers = {
      'Cookie': 'ci_session=ccd29ed97897179805eae4af31f61c9124290627'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Urls.baseUrl}Payment/login_logout_hrs'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  = GetOnlineOfflineModel.fromJson(json.decode(result));
      setState(() {
       getOnlineOfflineModel =  finalResult;
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
          const SizedBox(height: 20,),
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
                        child: const Center(child: Icon(Icons.arrow_back)),
                      ),
                    ),
                    const SizedBox(width: 45,),
                    Text(getTranslated(context, "OnlineOffline"),style: const TextStyle(color: Colors.white,fontSize: 18),),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 18,
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFDDEDFA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: getOnlineOfflineModel ==  null || getOnlineOfflineModel == "" ? const Center(child: CircularProgressIndicator()) : getOnlineOfflineModel?.data?.isEmpty ?? false ?
                const Center(child: Text("No data available")) :
              ListView.builder(
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
                              const Text("LogIn Time:"),
                              Text("${getOnlineOfflineModel?.data?[i].onlineTime}")
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("LogOut Time:"),
                              Text("${getOnlineOfflineModel?.data?[i].oflineTime}")
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Date:"),
                              Text("${getOnlineOfflineModel?.data?[i].createdAt?.substring(0,10)}")
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Time:"),
                              Text("${getOnlineOfflineModel?.data?[i].totalTime}")
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              })

            ),
          )

        ],
      ),

    );
  }

}

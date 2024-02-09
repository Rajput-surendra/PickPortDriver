import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jdx/Models/GetTmc.dart';

import '../Utils/ApiPath.dart';
import '../Utils/AppBar.dart';
import '../Utils/Color.dart';
import 'package:http/http.dart'as http;

import '../services/session.dart';


class TermsConditionsWidget extends StatefulWidget {
  @override
  State<TermsConditionsWidget> createState() => _TermsConditionsWidgetState();
}

class _TermsConditionsWidgetState extends State<TermsConditionsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTermCondition();
  }
  GetTmc? gettmc;
  getTermCondition() async {
    var headers = {
      'Cookie': 'ci_session=c6e9b8fa5907fd26fe43fffdfc36c4433f340576'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${Urls.baseUrl}Users/TermsCondition?type=3'));
    request.fields.addAll({
      'type': '3'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var ResultTMC = GetTmc.fromJson(jsonDecode(result));
      print(" this is tmccccccccccccccccc${ResultTMC}");
      setState(() {
        gettmc = ResultTMC;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      body:  Column(
        children: [
          const SizedBox(height: 25,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 20),
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
                    Expanded(
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Center(child: Text(getTranslated(context, "Terms & Conditions"),style: const TextStyle(color: Colors.white,fontSize: 18),)),
                          )),
                    ),

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
              child:
              gettmc == null? Center(child: CircularProgressIndicator()):   ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(data: "${gettmc!.data!.pgDescri}"),
                ],
              ),

            ),
          )

        ],
      ),

    );


      SafeArea(
        child: Scaffold(
            backgroundColor: colors.whiteTemp,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: commonAppBar(context, text:
                getTranslated(context, "Terms & Conditions"),
              //  "Terms & Conditions"
                )),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: const BoxDecoration(
                  // const BorderRadius.all(Radius.Radius),
                  // border: Border(
                  //   top: BorderSide(
                  //     //  BorderRadius.all(Radius.Radius),
                  //     color: colors.primary,
                  //     width: 1,
                  //   ),
                  // ),
                ),
                child:   gettmc ==  null || gettmc == "" ? Center(child: CircularProgressIndicator(),) : ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(data: "${gettmc!.data!.pgDescri}"),
                  ],
                ),
            )));
  }
}


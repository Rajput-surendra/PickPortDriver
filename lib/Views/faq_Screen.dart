import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:jdx/Models/faq_model.dart';

import 'package:http/http.dart' as http;
import 'package:jdx/services/session.dart';

import '../../Utils/Color.dart';
import '../Utils/ApiPath.dart';
import 'SupportNewScreen.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFaqApi();
  }

  String? title, dec;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Column(
    children: [
      SizedBox(
        height: 25,
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: colors.whiteTemp,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(child: Icon(Icons.arrow_back)),
                ),
              ),
              Text(
                getTranslated(context, "FAQS"),
                style: TextStyle(color: colors.whiteTemp, fontSize: 18),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: colors.splashcolor,
                    borderRadius: BorderRadius.circular(100)),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SupportNewScreen()));
                    },
                    child: Center(
                      child: Image.asset(
                        'assets/images/support.png',
                        scale: 1.3,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 18,
        child: faqModel == null
            ? Center(child: CircularProgressIndicator())
            : faqModel?.data?.length == 0
                ? Text("No Faq Found!!!")
                : Container(
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: faqModel?.data?.length ?? 0,
                          itemBuilder: (context, i) {
                            // title  = faqModel?.data?[i];
                            //   dec = faqModel?.data?[i];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: colors.primary)),
                                child: ExpansionTile(
                                  title: Text(
                                      "${faqModel?.data?[i].question}"),
                                  children: [
                                    ListTile(
                                      title: Html(
                                        data: faqModel?.data?[i].answer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
      )
    ],
      ),
    );
  }

  String? quetion;
  FaqModel? faqModel;

  getFaqApi() async {
    var headers = {
      'Cookie': 'ci_session=521e7894daca5e3189ecd3dd2cd31fd3c14d22c9'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.baseUrl}Authentication/api_faq'));
    request.fields.addAll({'type': '3'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = FaqModel.fromJson(json.decode(result));
      setState(() {
        faqModel = finalResult;
      });

      print('____Som__gggg____${quetion}_________');
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
}

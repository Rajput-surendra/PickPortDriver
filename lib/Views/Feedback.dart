import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jdx/Models/user_feedback_Response.dart';
import 'package:jdx/Utils/ApiPath.dart';
import 'package:http/http.dart' as http;
import 'package:jdx/Utils/CustomColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/session.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({Key? key}) : super(key: key);

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF222443),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
              getTranslated(context, "User Feedback")
             // 'User Feedback'
          ),
        ),
        body: isLoading
            ?const Center(child: CircularProgressIndicator(),) :  ratingsList.isEmpty
                ?  Center(
                    child: Text(
                        getTranslated(context, "Rating not available")
                       // 'Rating not available'
                    ),
                  )
                : ListView.builder(
                    itemCount: ratingsList.length,
                    itemBuilder: (context, index) {
                      var item = ratingsList[index];
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(context, "Parcel Id:"),
                                      //'Parcel Id:',
                                      style:
                                          TextStyle(color: CustomColors.primary2),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      getTranslated(context, "User Name:"),
                                     // 'User Name:',
                                      style:
                                          TextStyle(color: CustomColors.primary2),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      getTranslated(context, "Ratings:"),
                                     // 'Ratings:',
                                      style:
                                          TextStyle(color: CustomColors.primary2),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.parcelId ?? '--',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      item.userFullname ?? '--',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          itemSize: 18,
                                          ignoreGestures: true,
                                          initialRating:
                                              double.parse(item.rating ?? ''),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.zero,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text.rich(TextSpan(children: [
                                          TextSpan(
                                              text: '${item.rating}',
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                          const TextSpan(
                                              text: '/5.0',
                                              style: TextStyle(color: Colors.grey)),
                                        ]))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
            );
  }

  UserFeedbackResponseResponse? userFeedbackResponseResponse;

  List<Rating> ratingsList = [];
bool isLoading = false ;
  Future<void> feedback() async {
    setState(() {
      isLoading = true ;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=e01a6c92851a23778c738ee9ec011791b3180455'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${Urls.baseUrl}Authentication/get_delivery_boy_rating'));
    request.fields.addAll({'delivery_boy_id': userId ?? '326'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print('___________${result}__________');
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        userFeedbackResponseResponse =
            UserFeedbackResponseResponse.fromJson(finalResult);
        ratingsList = userFeedbackResponseResponse?.rating ?? [];
        setState(() {
          isLoading = false ;
        });
      }else {
        setState(() {
          isLoading = false ;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}

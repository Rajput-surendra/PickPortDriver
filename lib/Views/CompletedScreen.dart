import 'package:flutter/material.dart';
import '../Utils/Color.dart';
import '../Utils/btn.dart';
import '../services/session.dart';

class paymentSuccessful extends StatefulWidget {

  @override
  State<paymentSuccessful> createState() => _paymentSuccessfulState();
}

class _paymentSuccessfulState extends State<paymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            //   Navigator.pop(context, false);
          },
          //child: Container(
          //   margin: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     gradient: LinearGradient(
          //         begin: Alignment.bottomLeft,
          //         end: Alignment.topRight,
          //         colors: [colors.primary, colors.secondary, colors.secondary]),
          //   ),
          // padding: EdgeInsets.all(5),
          // child: Icon(Icons.arrow_back),
          //  ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage('assets/images/Group75302.png')),
              ),
              //  SizedBox(
              //    height: 5,
              //  ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.25,
              //   width: MediaQuery.of(context).size.width,
              //   child: Image(image: AssetImage('assets/images/Group75302.png')),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   "Payment Successful",
              //   style: TextStyle(
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //       color: colors.primary),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                getTranslated(context, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since"),
               // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color:Color(0xff000000),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.13),
                child: FilledBtn(
                  title:
                  getTranslated(context, "Completed"),
                 // 'Completed',
                  onPress: () {
                    // Navigator.push(
                    //                  context,
                    //                  MaterialPageRoute(
                    //                      builder: (context) => const personal_information()),
                    //                );
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}
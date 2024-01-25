import 'package:flutter/material.dart';

import '../Utils/AppBar.dart';
import '../Utils/Color.dart';

class FaqPage extends StatefulWidget {


  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<String> quList = [
    "How Can I Update My Profile?",
    "How Can I Change My Password?",
    "How Can I Cancel My Order?",
    "How Can I Return The Order?"
  ];
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: colors.whiteTemp,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: commonAppBar(context, text: "FAQ")),
          // preferredSize: Size(MediaQuery.of(context).size.width, 80)),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colors.primary,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'FAQ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return faqTileDetails(
                        question: quList[index], answer: 'answer', index: index);
                  },
                  itemCount: quList.length,
                )
              ],
            ),
          ),
        )
    );
  }

  Widget faqTileDetails(
      {required String question, required String answer, required int index}) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            onTap: () {
              setState(() {
                if (selected == index) {
                  selected = -1;
                } else {
                  selected = index;
                }
              });
            },
            title: Text(
              question,
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
            ),
            trailing: Icon(selected == index
                ? Icons.arrow_drop_down
                : Icons.arrow_drop_down),
          ),
        ),
        selected == index
            ? Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.grey.shade300,
          child: Text(
            'Lorem Ipsum is simply dummy text of the and typesetting industry. Lorem Ipsum industry\'s standard dummy since the 1500s, when an unknown printer took a galley of type and scrambled it Lorem Ipsum is simply dummy text and typesetting industry.',
            style: TextStyle(fontSize: 10, color: Colors.black),
          ),
        )
            : Container(),
      ],
    );
  }
}
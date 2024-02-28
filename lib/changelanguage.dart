import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/Utils/Color.dart';
import 'package:jdx/services/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'AuthViews/LoginScreen.dart';

class ChangeLanguage extends StatefulWidget {
  bool? back;
  ChangeLanguage({this.back});

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  int? selectLan = 2;

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'KANADA_LAN'),
        getTranslated(context, 'HINDI_LAN'),
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'TAMIL_LAN'),
        getTranslated(context, 'TELUGU_LAN'),
        getTranslated(context, 'MARATHI_LAN'),
      ];
      setState(() {});
    });

    super.initState();
  }

  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();
  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3700b3)),
                                child: const Icon(Icons.arrow_forward))),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget getHeading(String title) {
    print("here is title value ${title}");
    return Text(
      getTranslated(context, title).toString(),
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 20),
        child: getHeading(
          labelName,
        ),
      );
  List<String> langCode = ["kn","hi","en","ta","te","mr"];
  List<String?> languageList = [];
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
              index,
              InkWell(
                onTap: () async {
                  print('____Som______setthdhdjdjdjdj}_________');
                  if (mounted)
                    setState(() {
                      selectLan = index;
                      _changeLan(langCode[index], ctx);
                    });


                  setModalState(() {});
                },
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colors.whiteTemp,
                            borderRadius: BorderRadius.circular(15),
                            border: selectLan == index
                                ? Border.all(color: colors.primary)
                                : Border.all(color: Colors.transparent),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                            leading: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10.0,
                                ),
                                child: Text(
                                  languageList[index].toString() == getTranslated(context, 'KANADA_LAN')
                                      ? getTranslated(context, 'KANADA_LAN'):
                                  languageList[index].toString() ==
                                      getTranslated(context, 'HINDI_LAN')
                                      ? getTranslated(context, 'HINDI_LAN'):
                                  languageList[index].toString() == getTranslated(context, 'ENGLISH_LAN')
                                      ? getTranslated(context, 'ENGLISH_LAN'):
                                  languageList[index].toString() == getTranslated(context, 'TAMIL_LAN')
                                      ? getTranslated(context, 'TAMIL_LAN'):
                                  languageList[index].toString() == getTranslated(context, 'TELUGU_LAN')
                                      ? getTranslated(context, 'TELUGU_LAN')

                                          : getTranslated(
                                              context, 'MARATHI_LAN'),
                                  //     languageList[index].toString(),
                                  style: Theme.of(this.context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.black),
                                )),
                            trailing: Container(
                              height: 25.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectLan == index
                                      ? Colors.transparent
                                      : Colors.white,
                                  border: Border.all(color: colors.secondary)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: selectLan == index
                                    ? Icon(
                                        Icons.check,
                                        size: 17.0,
                                        color: selectLan == index
                                            ? colors.primary
                                            : Colors.white,
                                      )
                                    : const Icon(Icons.check_box_outline_blank,
                                        size: 15.0, color: colors.whiteTemp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // index == languageList.length - 1
                    //     ? Container(
                    //         margin: EdgeInsetsDirectional.only(
                    //           bottom: 10,
                    //         ),
                    //       )
                    //     : Divider(
                    //         color: Theme.of(context).colorScheme.lightBlack,
                    //       ),
                  ],
                ),
              )),
        )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {

    Locale _locale = await setLocale(language);
    print('__________${_locale}_________');
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLanguage',true);

    MyApp.setLocale(ctx, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        backgroundColor: colors.primary,
        toolbarHeight: 60,
        centerTitle: true,
        title: bottomsheetLabel(
          "CHOOSE_LANGUAGE_LBL",
        ),
        elevation: 0,
      ),
      body: SafeArea(
          top: true,
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80)),
                  color: colors.background),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: _changePwdKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setModalState) {
                                return SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children:
                                            getLngList(context, setModalState)),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (selectLan != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        } else {
                          Fluttertoast.showToast(msg: "Please Select Language");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          child: Card(
                              color: selectLan == null
                                  ? Colors.white
                                  : colors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    getTranslated(context, 'Next'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: selectLan == null
                                                ? colors.primary
                                                : Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

// _createLanguageDropDown() {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: Colors.black),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: DropdownButton<LanguageModel>(
//         iconSize: 30,
//         underline: SizedBox(),
//         hint: Text(getTranslated(context, 'CHOOSE_LANGUAGE_LBL')),
//         onChanged: (LanguageModel? language) {
//           changeLanguage(context, language!.languageCode);
//         },
//         items: LanguageModel.languageList()
//             .map<DropdownMenuItem<LanguageModel>>(
//               (e) => DropdownMenuItem<LanguageModel>(
//             value: e,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(
//                   e.flag,
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 Text(e.name)
//               ],
//             ),
//           ),
//         )
//             .toList(),
//       ),
//     ),
//   );
// }
}

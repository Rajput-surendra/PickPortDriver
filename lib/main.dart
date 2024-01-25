// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jdx/services/notification_service.dart';
//
// import 'AuthViews/AddBankDetails.dart';
// import 'Views/CompletedScreen.dart';
// import 'Views/EditBankDetails.dart';
// import 'Views/Faq.dart';
// import 'Views/MyAccount.dart';
// import 'Views/NotificationScreen.dart';
// import 'Views/Parcel HistoryPage.dart';
// import 'Views/TermsAndConditions.dart';
// import 'Views/parcel_details.dart';
// import 'Views/splash.dart';
//
// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   LocalNotificationService.initialize();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   try{
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("-----------token:-----${token}");
//   } on FirebaseException{
//     print('__________FirebaseException_____________');
//   }
//
//
//
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'PICKPORT Driver',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:SplashScreen()
//     );
//   }
// }
//
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jdx/services/demo_localization.dart';
import 'package:jdx/services/notification_service.dart';
import 'package:jdx/services/session.dart';
import 'package:flutter_localizations/flutter_localizations.dart' ;

import 'Views/splash.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  LocalNotificationService.initialize();

  try{
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("-----------token:-----${token}");
  } on FirebaseException{
    debugPrint('__________FirebaseException_____________');
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
    debugPrint('__________${state}_________');
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted)
      setState(() {
        _locale = locale;
      });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      if (mounted)
        setState(() {
          this._locale = locale;
        });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PICKPORT Driver',
      locale: _locale,
      supportedLocales: [
        Locale("kn", "IN"),
        Locale("hi", "IN"),
        Locale("en", "US"),
        Locale("ta", "IN"),
        Locale("te", "IN"),
        Locale("mr", "IN"),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      theme: ThemeData(
       // fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
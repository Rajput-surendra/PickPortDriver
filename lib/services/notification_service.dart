// /*
// import 'dart:math';
// */
//
// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// class LocalNotificationService {
//   BuildContext? context;
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static void initialize() async {
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: AndroidInitializationSettings(
//             "@mipmap/ic_launcher"),
//         iOS: DarwinInitializationSettings());
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     NotificationSettings settings =
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//           print('${message.notification!.body}_________body1____');
//           print("message.data12 ${message.data}");
//           // if (message.data['_id'] != null) {
//           //   Navigator.of(context).push(
//           //     MaterialPageRoute(
//           //       builder: (context) => DemoScreen(
//           //         id: message.data['_id'],
//           //       ),
//           //     ),
//           //   );
//           // }
//         }
//       },
//     );
//
//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         print("FirebaseMessaging.onMessage______________");
//         if (message.notification != null) {
//           print('${message.notification}_________________');
//           print('${message.notification!.body}_________body____');
//           print("message.data11 ${message.data}");
//
//          display(message);
//          // Get.to(const FeedbackScreen());
//           //handleNotification(message.data);
//
//         }
//       },
//     );
//
//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) {
//         print("FirebaseMessaging.onMessageOpenedApp___________");
//         if (message.notification != null) {
//           print('_____________${message.notification}_______________');
//           print('_____________${message.notification?.title}_______________');
//           print(message.notification!.body);
//           print("message.data22 ${message.data}");
//
//           // Get.to(FeedbackScreen());
//           //handleNotification(message.data);
//
//          // HomeScreenState().setSegmentValue(2) ;
//
//
//
//
//         }
//       },
//     );
//
//
//   }
//   static  Future<void> handleNotification(Map<String, dynamic> message) async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//     await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//
//     if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//       // App was opened from a notification
//       // TODO: handle the notification
//
//     } else {
//       // App was opened normally
//     }
//   }
//
//
//   static void display(RemoteMessage message) async {
//     try {
//       print("In Notification method");
//       // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
//       Random random = Random();
//       int id = random.nextInt(1000);
//       const NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//             "JdxApp",
//             "JdxApp",
//             importance: Importance.max,
//             priority: Priority.high,
//           ));
//       //print("my id is ${id.toString()}");
//       await _flutterLocalNotificationsPlugin.show(
//           id,
//           message.notification!.title,
//           message.notification!.body,
//           notificationDetails,
//           payload: message.data['_id']);
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }
//
//
//
// }

/*
import 'dart:math';
*/


import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationClass{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  initNotification() async {

    await _firebaseMessaging.requestPermission();
    try{
      String fcmToken=await  _firebaseMessaging.getToken()??"";
      print("=============FCM Token=============${fcmToken.toString()}");

    } on FirebaseException{
    }
// FirebaseMessaging.onBackgroundMessage(handleBackgroundMessageing);

    initPushNotification();
  }
  Future<void> handleBackgroundMessageing(RemoteMessage msg)async {

    print("title :${msg.notification?.title}");
    print("title :${msg.notification?.body}");
    print("title :${msg.data}");

  }
//user ka code background and terminate mode ke liye hai,


// neche ka code notification screen me navigate hone ke liye hai
  initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,


    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage)  ;
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage)  ;
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessageing)  ;

    FirebaseMessaging.onMessage.listen((msgg){

      final notificationnn=msgg.notification;
      if(notificationnn==null)
      {
        return;
      }
      else{

        _localNotificationplugin.show(notificationnn.hashCode, notificationnn.title, notificationnn.body,
          NotificationDetails(

              android: AndroidNotificationDetails(

                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/notiicon',
                  // sound:RawResourceAndroidNotificationSound('soundnotification'),
                  // priority: Priority.high,
                  playSound: true,

                  importance: Importance.max



              )
          ),
          payload: jsonEncode(notificationnn.toMap()),





        );

      }



    });

  }

  void handleMessage(RemoteMessage ?msg){

    if(msg==null){

      return;
    }
    else{
      // navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => Notifinationn(),));

    }
  }




// for for ground msg not enough firebase messaging we need flutter local notification


  final _androidChannel = const AndroidNotificationChannel(
    'default_notification_channel_id 2', 'high Notification',
    description: 'this is channel use for notification',
    importance: Importance.defaultImportance,

  );

  final _localNotificationplugin = FlutterLocalNotificationsPlugin();

}





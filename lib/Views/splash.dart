import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jdx/AuthViews/LoginScreen.dart';
import 'package:jdx/Controller/BottomNevBar.dart';
import 'package:jdx/changelanguage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _visible = false;
  @override

  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      return checkLogin();
    });
    // _controller = VideoPlayerController.asset("assets/images/splash.gif");
    // _controller.initialize().then((_) {
    //   _controller.setLooping(true);
    //   Timer(Duration(seconds: 3), () {
    //     setState(() {
    //       // _controller.play();
    //       _visible = true;
    //     });
    //   });
    // });
    Future.delayed(Duration(seconds: 5),(){
      print('____Som______${isLan}_________');
      if(userid == null || userid == ""||isLan==false){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChangeLanguage()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
      }
    });
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  bool?isLan;
  String? userid;
  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLan  = await pref.getBool('isLanguage') ?? false;
    userid = pref.getString('userId');
    print("this is iser============> $userid");
    print("this is iser============> $isLan");
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash.gif"),
      ),
    );
  }
}

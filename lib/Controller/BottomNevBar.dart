// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jdx/Views/HomeScreen.dart';
// import 'package:jdx/Views/MyAccount.dart';
// import 'package:jdx/Views/NotificationScreen.dart';
// import 'package:jdx/Views/Parcel%20HistoryPage.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   final items=const[
//
//     Icon(Icons.home,color: Color(0xff06b5df0)),
//     Icon(Icons.event_note_sharp,color:Color(0xff06b5df0)),
//     Icon(Icons.notifications_active,color:Color(0xff06b5df0)),
//     Icon(Icons.person,color:Color(0xff06b5df0)),
//   ];
//   int index=0;
//   void CurvedNavigationar;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar:CurvedNavigationBar(
//
//         items:items,
//         index: index,
//         onTap: (selectedIndex){
//           setState(() {
//             index=selectedIndex;
//           });
//         },
//         backgroundColor: Colors.transparent,
//       ),
//       body: Container(
//         child: getSelectedWidget(index:index),
//       ),
//     );
//   }
//   Widget getSelectedWidget({required int index}){
//     Widget widget;
//     switch(index){
//       case 0:
//         widget=const HomeScreen();
//         break;
//       case 1:
//         widget=const ParcelHistory();
//         break;
//       case 2:
//         widget= NotificationScreen();
//         break;
//       case 3:
//         widget=const MyAccount();
//         break;
//       default:
//         widget= HomeScreen();
//     }
//     return widget;
//   }
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdx/Utils/CustomColor.dart';
import 'package:jdx/Views/HomeScreen.dart';
import 'package:jdx/Views/MyAccount.dart';
import 'package:jdx/Views/NotificationScreen.dart';
import 'package:jdx/Views/Parcel%20HistoryPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({Key,key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    //ParcelHistory(),
    NotificationScreen(),
    MyAccount()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:CustomColors.accentColor
                    ),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:CustomColors.accentColor
                    ),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
        // if (_tabController.index != 0) {
        //   _tabController.animateTo(0);
        //   return false;
        // }
        return true;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home,color: Colors.grey,),
        //       label: 'Home',
        //       backgroundColor: Colors.white,
        //     ),
        //     /*BottomNavigationBarItem(
        //       icon: Icon(Icons.more_time_rounded,color: Colors.grey,),
        //       label: 'Parcel',
        //      // backgroundColor: Colors.green,
        //     ),*/
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.notifications,color: Colors.grey,),
        //       label: 'Notification',
        //       //backgroundColor: Colors.purple,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person,color: Colors.grey,),
        //       label: 'Account',
        //       //backgroundColor: Colors.pink,
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}


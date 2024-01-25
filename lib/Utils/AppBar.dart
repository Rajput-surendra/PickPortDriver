import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdx/Views/SupportNewScreen.dart';
import 'CustomColor.dart';


class getAppbar extends StatelessWidget {
  final VoidCallback? onTaped;
  final SizedBox? sizedBox;
  String? text;
  bool? istrue;

  getAppbar({this.onTaped, this.text, this.sizedBox, this.istrue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [
                Color(0xFF0F368C),
                Color(0xFF0F368C),
                ],
                stops: [
                  0,
                  1,
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: istrue ?? false
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF0F368C).withOpacity(0.4)),
                      child: const Icon(
                        Icons.arrow_back,
                        color:Color(0xFF0F368C),
                      ),
                    ),
                  )
                      : const SizedBox()),

              Text(
                '${text}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),

              // Icon(Icons.chat_rounded,color: Colors.white,),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF0F368C).withOpacity(0.4)),
                    child: const Icon(
                      Icons.notifications_none,
                      color:Color(0xFF0F368C),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Padding(
          //     padding: const EdgeInsets.only(left: 0, right: 0),
          //     child: AppBar(
          //         flexibleSpace: Container(
          //             decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //               begin: Alignment.bottomLeft,
          //               end: Alignment.bottomRight,
          //               colors: [
          //                 CustomColors.grade1,
          //                 CustomColors.grade,
          //               ],
          //
          //             ),
          //           ),
          //         ),
          //       centerTitle: true,
          //         leading: Icon(
          //           Icons.add,color:CustomColors.grade1,
          //         ),
          //         title: Text(
          //           '${text}',
          //           style: TextStyle(color: Colors.white, fontSize: 20),
          //         ),
          //         actions: [
          //           InkWell(
          //             onTap: () {
          //               Navigator.pop(context);
          //             },
          //             child: Padding(
          //               padding: const EdgeInsets.all(8),
          //               child: Container(
          //                 height: 45,
          //                 width: 45,
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(10),
          //                     color:
          //                         CustomColors.AppbarColor1.withOpacity(0.4)),
          //                 child: Icon(
          //                   Icons.notifications_none,
          //                   color: CustomColors.AppbarColor1,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ])
          //
          //
          //     ),
        ),
      ],
    );
  }
}

Widget customAppBar(
    {required BuildContext context,
      VoidCallback? onTaped,
      required String text,
      required bool isTrue,
      bool? isActionIcon}) {
  return Container(
    padding: const EdgeInsets.only(top: 10),
    color: const Color(0xFF0F368C),
    child: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0F368C),
      centerTitle: true,
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(1),bottomLeft: Radius.circular(1)),
      //     gradient: LinearGradient(
      //         begin: Alignment.bottomLeft,
      //         end: Alignment.bottomRight,
      //         colors: [
      //         colors.appbarColor
      //         ],
      //         stops: [
      //           0,
      //           1,
      //         ]),
      //   ),
      // ),
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: isTrue
              ? const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF0F368C),
            ),
          )
              : const SizedBox()),
      title: Text(
        '${text}',
        style: const TextStyle(color: Color(0xFF0F368C), fontSize: 20),
      ),
      actions: isActionIcon == true
          ? [
        const Icon(CupertinoIcons.heart, color: Color(0xFF0F368C),),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.shopping_cart_outlined,
          color: Color(0xFF0F368C),
        ),
        const SizedBox(
          width: 10,
        )
        // InkWell(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: InkWell(
        //         onTap: (){
        //          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
        //         },
        //         child: Icon(Icons.search,color: colors.whiteTemp,)),
        //   ),
        // ),
      ]
          : [],
    ),
  );
}

Widget homeAppBar(BuildContext context,
    {required String text, required VoidCallback ontap}) {
  return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      //padding: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0F368C), Color(0xFF0F368C)]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.menu,
                color:Color(0xFF0F368C),
              ),
            ),
          ),
          Container(
            child: const Text(
              'Home',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const NotificationPage()),
              // );
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.notifications_active_rounded,
                color: CustomColors.primaryColor,
              ),
            ),
          ),
        ],
      ));
}

Widget commonAppBar(BuildContext context,
    {required String text, bool? isActionButton}) {
  return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      //padding: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color:  CustomColors.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
                Navigator.pop(context);
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.arrow_back,
                color: CustomColors.primaryColor,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          isActionButton == false
              ? Container(
            width: 40,
          )
              : InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupportNewScreen()));
            },
                child: Container(
            // margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
            child: const Icon(
                Icons.headset_rounded,
                color: CustomColors.primaryColor,
            ),
          ),
              ),
        ],
      ));
}

// class CustomAppbar extends StatefulWidget {
//   const CustomAppbar({super.key});

//   @override
//   State<CustomAppbar> createState() => _CustomAppbarState();
// }

// class _CustomAppbarState extends State<CustomAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
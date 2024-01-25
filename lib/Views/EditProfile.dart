// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jdx/Utils/ApiPath.dart';
// import 'package:jdx/Views/HomeScreen.dart';
// import 'package:jdx/services/api_services/api.dart';
// import 'package:jdx/services/api_services/request_key.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../CustomWidgets/CustomElevetedButton.dart';
// import '../Models/GetProfileModel.dart';
// import '../Utils/CustomColor.dart';
// import 'package:http/http.dart' as http;
//
// class EditProfile extends StatefulWidget {
//   GetProfileModel? getProfileModel;
//
//   EditProfile({this.getProfileModel});
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     nameController.text =
//         widget.getProfileModel!.data![0].userFullname.toString();
//     emailController.text =
//         widget.getProfileModel!.data![0].userEmail.toString();
//     mobController.text = widget.getProfileModel!.data![0].userPhone.toString();
//     passController.text =
//         widget.getProfileModel!.data![0].userPassword.toString();
//     vehicleNumController.text =
//         widget.getProfileModel!.data![0].vehicleNo.toString();
//     vehicleTypeController.text =
//         widget.getProfileModel!.data![0].vehicleType.toString();
//     licenceController.text =
//         widget.getProfileModel!.data![0].drivingLicenceNo.toString();
//     aadharController.text =
//         widget.getProfileModel!.data![0].aadhaarCardNo.toString();
//   }
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//   TextEditingController vehicleNumController = TextEditingController();
//   TextEditingController vehicleTypeController = TextEditingController();
//   TextEditingController licenceController = TextEditingController();
//   TextEditingController aadharController = TextEditingController();
//
//   final ImagePicker _picker = ImagePicker();
//   File? license, profileImage;
//   var filesPath;
//   String? fileName;
//   String? resumeData;
//
//   Future<bool> showExitPopup1() async {
//     return await showDialog(
//           //show confirm dialogue
//           //the return value will be from "Yes" or "No" options
//           context: context,
//           builder: (context) => AlertDialog(
//               title: Text('Select Image'),
//               content: Row(
//                 // crossAxisAlignment: CrossAxisAlignment.s,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       _getFromCamera();
//                     },
//                     //return false when click on "NO"
//                     child: Text('Camera'),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _getFromGallery();
//                       // Navigator.pop(context,true);
//                       // Navigator.pop(context,true);
//                     },
//                     //return true when click on "Yes"
//                     child: Text('Gallery'),
//                   ),
//                 ],
//               )),
//         ) ??
//         false; //if showDialouge had returned null, then return false
//   }
//
//   _getFromGallery() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
//     /* PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );*/
//     if (pickedFile != null) {
//       setState(() {
//         license = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   _getFromCamera() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
//     /*  PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );*/
//     if (pickedFile != null) {
//       setState(() {
//         license = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   ////////////////////////////
//   Future<bool> showExitPopup() async {
//     return await showDialog(
//           //show confirm dialogue
//           //the return value will be from "Yes" or "No" options
//           context: context,
//           builder: (context) => AlertDialog(
//               title: Text('Select Image'),
//               content: Row(
//                 // crossAxisAlignment: CrossAxisAlignment.s,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       _getFromCamera1();
//                     },
//                     //return false when click on "NO"
//                     child: Text('Camera'),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _getFromGallery1();
//                       // Navigator.pop(context,true);
//                       // Navigator.pop(context,true);
//                     },
//                     //return true when click on "Yes"
//                     child: Text('Gallery'),
//                   ),
//                 ],
//               )),
//         ) ??
//         false; //if showDialouge had returned null, then return false
//   }
//
//   _getFromGallery1() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
//     /* PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );*/
//     if (pickedFile != null) {
//       setState(() {
//         profileImage = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   _getFromCamera1() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
//     /* PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );*/
//     if (pickedFile != null) {
//       setState(() {
//         profileImage = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: 200,
//                     width: 400,
//                     decoration:  BoxDecoration(
//                         gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                           CustomColors.accentColor,
//                           CustomColors.DarkBrownColor,
//                           CustomColors.DarkYellowColor,
//                           CustomColors.darkBlueColor
//                         ],
//                             stops: [
//                           0,
//                           1,
//                           2,
//                           3
//                         ])),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0, top: 210),
//                     child: Container(
//                       height: 760,
//                       width: 370,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 130.0, left: 30),
//                     child: Column(
//                       children: [
//                         InkWell(
//                           onTap: () => showExitPopup(),
//                           child: profileImage == null
//                               ? CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       "${widget.getProfileModel!
//                                           .data![0].userImage}"),
//                                   backgroundColor: Colors.redAccent,
//                                   maxRadius: 65,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 90.0, left: 70),
//                                     child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.deepOrangeAccent,
//                                             borderRadius:
//                                                 BorderRadius.circular(30)),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           color: Colors.white,
//                                           size: 20,
//                                         )),
//                                   ),
//                                 )
//                               : CircleAvatar(
//                                   backgroundImage:
//                                       FileImage(profileImage ?? File('')),
//                                   backgroundColor: Colors.redAccent,
//                                   maxRadius: 65,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 90.0, left: 70),
//                                     child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.deepOrangeAccent,
//                                             borderRadius:
//                                                 BorderRadius.circular(30)),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           color: Colors.white,
//                                           size: 20,
//                                         )),
//                                   ),
//                                 ),
//                         ),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: nameController,
//                                   keyboardType: TextInputType.name,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.person,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "User Name",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Name is required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: emailController,
//                                   keyboardType: TextInputType.name,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.email,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "Email id",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Email is required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: mobController,
//                                     keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.phone,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "Mobile No.",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Mobile no. is required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: vehicleNumController,
//                                   keyboardType: TextInputType.name,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.car_repair,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "Vehicle Number",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Vehicle Number is required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: vehicleTypeController,
//                                   keyboardType: TextInputType.name,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.car_repair,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "Vehicle Type",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Vehicle type required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: 70,
//                                 width: MediaQuery.of(context).size.width / 1.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: CustomColors.TransparentColor),
//                                 child: TextFormField(
//                                   controller: licenceController,
//                                   keyboardType: TextInputType.name,
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Icon(
//                                         Icons.lock,
//                                         color: CustomColors.accentColor,
//                                       ),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 22, left: 5),
//                                     border: InputBorder.none,
//                                     hintText: "Driving Licence no.",
//                                   ),
//                                   validator: (v) {
//                                     if (v!.isEmpty) {
//                                       return "Driving Licence is required";
//                                     }
//                                   },
//                                 ),
//                               ),
//                             )),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         InkWell(
//                           onTap: () => showExitPopup1(),
//                           child: Container(
//                               height: 115,
//                               width: 290,
//                               decoration: BoxDecoration(
//                                   color: CustomColors.TransparentColor,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: license == null
//                                   ? Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.file_copy,
//                                           color: CustomColors.accentColor,
//                                         ),
//                                         Text(
//                                           'Upload(Driving Licence ID)*',
//                                           style: TextStyle(color: Colors.red),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         // Container(
//                                         //   height: 60,
//                                         //   width: 200,
//                                         //   child: ClipRRect(
//                                         //       borderRadius: BorderRadius.circular(10),
//                                         //       child:Image.file(imageFile!,
//                                         //         fit: BoxFit.fill,
//                                         //       )),
//                                         // ),
//                                       ],
//                                     )
//                                   : ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.file(
//                                         license ?? File(''),
//                                         fit: BoxFit.fill,
//                                       ))),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 80.0),
//                           child: SizedBox(
//                               height: 45,
//                               width: 270,
//                               child: CustomElevatedButton(
//                                 text: 'Save',
//                                 icon: Icons.send,
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     _updateProfile();
//                                   } else {
//                                     print("Enter right credential");
//                                   }
//                                 },
//                               )),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _updateProfile() async {
//     if (profileImage == null) {
//       Fluttertoast.showToast(msg: "Please upload profile image");
//     } else if (license == null) {
//       Fluttertoast.showToast(msg: "Please upload Licence photo");
//     } else {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getString('userId');
//       var headers = {
//         'Cookie': 'ci_session=c7d48d7dcbb70c45bae12c8d08e77251655897e8'
//       };
//       var request = http.MultipartRequest(
//           'POST',
//           Uri.parse(
//               '${Urls.baseUrl}Authentication/editDeliveryProfile'));
//       request.fields.addAll({
//
//         RequestKeys.userFullName: nameController.text,
//         RequestKeys.userEmail: emailController.text,
//         RequestKeys.userPhone: mobController.text,
//         RequestKeys.vehicleType: vehicleTypeController.text,
//         RequestKeys.vehicleNo: vehicleNumController.text,
//         RequestKeys.drivingLicenceNo: licenceController.text,
//         RequestKeys.userId: userId ?? '',
//
//         'user_id':userId: userId ?? '',
//         'user_fullname': 'satish',
//         'user_phone': '182973192454',
//         'user_email': 'sas11@gmail.com',
//         'vehicle_no': '7218318',
//         'pan_card': 'ASHK54FG',
//         'driving_licence_no': '21893',
//         'aadhaar_card_no': '213`12',
//         'rc_number': '21324',
//         'address': 'ujjian',
//         'state_id': '9',
//         'city_id': '17',
//         'user_password': '12345678',
//         'vehicle_type': '4',
//         'vehicle_insurance': '1',
//         'pollution_emission': '1'
//       });
//
//       request.files.add(await http.MultipartFile.fromPath('user_image', profileImage?.path ?? ''));
//       request.files.add(await http.MultipartFile.fromPath('driving_licence_photo', license?.path ?? ''));
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//
//       if (response.statusCode == 200) {
//         final reslut = await response.stream.bytesToString();
//         print('___________${reslut}__________');
//         var finalResult = json.decode(reslut);
//         if (finalResult['status'] == true) {
//           Navigator.pop(context, 'true');
//           Fluttertoast.showToast(msg: "Profile update successfully");
//
//         } else {
//           Fluttertoast.showToast(msg: "Invalid Email & Password");
//         }
//       } else {
//         print(response.reasonPhrase);
//       }
//     }
//   }
// }

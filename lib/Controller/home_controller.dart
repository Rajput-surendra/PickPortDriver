import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdx/Controller/base_Controller/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_services/request_key.dart';

class HomeController extends AppBaseController {
  bool isSwitched = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  /*void getUserStatusOnlineOrOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = userId ?? '';
      body[RequestKeys.status] = '';
      var res = await api.userOfflineOnlineApi(body);
      if (res.status == 200) {
        // responseData = res.data?.userid.toString();
      } else {
        Fluttertoast.showToast(msg: '');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid Email & Password");
    } finally {}
  }*/
}

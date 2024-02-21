class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String driverOnlineOffline = 'Payment/driver_online_offline';
    String orderHistory = 'Authentication/deliverBoyOrderHistory';
  String editDeliveryProfile = 'Authentication/editDeliveryProfile';
  String driverPayAmountForVendor =
      'Authentication/driver_pay_amount_for_vendor';
  String acceptOrderRequest = 'Payment/accept_order_request';
  String changePassword = 'Authentication/changePassword';
  String getDriverCodEarning = 'Authentication/get_driver_cod_earning';
  String driverParcelHistory = 'Payment/driver_parcel_history';
  String deliverBoyOrderHistory = 'Authentication/deliverBoyOrderHistory';
  String getNotificationList = 'Payment/GetNotificationList';
  String resetPassword = 'Authentication/ResetPassword';
  String deliverBoyOrderStatus = 'Authentication/deliverBoyOrderStatus';
  String scanOrderComplete = 'Authentication/scan_order_complete';
  String getOrderRequest = 'payment/get_order_request';
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:jdx/Models/accepted_order_response.dart';
import 'package:jdx/Models/chnage_pasword_response.dart';
import 'package:jdx/Models/driver_online_offline_response.dart';
import 'package:jdx/Models/forgot_password_response.dart';
import 'package:jdx/Models/notification_response.dart';
import 'package:jdx/Models/order_history_response.dart';
import 'package:jdx/Models/order_status_response.dart';
import 'package:jdx/Models/payment_history_response.dart';
import 'package:jdx/Models/update_profile_respoonse.dart';

import '../../Models/parcel_history_response.dart';
import 'api_client.dart';
import 'api_methods.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();

  final Connectivity connectivity = Connectivity();
  //final Connectivity? connectivity;

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> getHeader() {
    return {'Cookie': 'ci_session=c7d48d7dcbb70c45bae12c8d08e77251655897e8'};
    // return {'Content-Type': 'application/json'};
  }

  Future<DriverOnlineOfflineResponse> userOfflineOnlineApi(
      Map<String, String> body) async {
    String res = await _apiClient.postMethod(
        method: _apiMethods.driverOnlineOffline, body: body);
    if (res.isNotEmpty) {
      try {
        return driverOnlineOfflineResponseFromJson(res);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return DriverOnlineOfflineResponse(
            status: false, message: e.toString());
      }
    } else {
      return DriverOnlineOfflineResponse(
          status: false, message: 'Something went wrong');
    }
  }

  Future<UpdateProfileResponse> updateProfile(Map<String, String> body) async {
    String res = await _apiClient.postMethod(
        method: _apiMethods.editDeliveryProfile, body: body);
    if (res.isNotEmpty) {
      try {
        return updateProfileResponseFromJson(res);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return UpdateProfileResponse(status: false, message: e.toString());
      }
    } else {
      return UpdateProfileResponse(
          status: false, message: 'Something went wrong');
    }
  }

  Future<OrderHistoryResponse> getOrderHistoryData(
      Map<String, String> body) async {
    String res = await _apiClient.postMethod(
        method: _apiMethods.orderHistory, body: body);
    if (res.isNotEmpty) {
      try {
        return orderHistoryResponseFromJson(res);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return OrderHistoryResponse(status: false, message: e.toString(), data: []);
      }
    } else {
      return OrderHistoryResponse(
          status: false, message: 'Something went wrong', data: []);
    }
  }

  Future<ChangePasswordResponse> changePassword(
      Map<String, String> body) async {
    String res = await _apiClient.postMethod(
        method: _apiMethods.changePassword, body: body);

    if (res.isNotEmpty) {
      try {
        return chnagePasswordResponseFromJson(res);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return ChangePasswordResponse(status: false, message: e.toString());
      }
    } else {
      return ChangePasswordResponse(
          status: false, message: 'Something went wrong');
    }
  }

  Future<PaymentHistoryResponse> getPaymentHistoryData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getDriverCodEarning, body: body);
      if (res.isNotEmpty) {
        try {
          return paymentHistoryResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PaymentHistoryResponse(status: false, message: e.toString());
        }
      } else {
        return PaymentHistoryResponse(status: false, message: 'Something went wrong');
      }
    } else {
      return PaymentHistoryResponse(status: false, message: 'No Internet');
    }
  }

  Future<ParcelHistoryResponse> getParcelHistoryData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.driverParcelHistory, body: body);
      if (res.isNotEmpty) {
        try {
          return parcelHistoryResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ParcelHistoryResponse(status: 400, message: e.toString(),);
        }
      } else {
        return ParcelHistoryResponse(status: 400, message: 'Something went wrong');
      }
    } else {
      return ParcelHistoryResponse(status: 500, message: 'No Internet');
    }
  }

  Future<NotificationResponse> getNotificationData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getNotificationList, body: body);
      if (res.isNotEmpty) {
        try {
          return notificationResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return NotificationResponse(status: false, );
        }
      } else {
        return NotificationResponse(status: false, );
      }
    } else {
      return NotificationResponse(status: false, );
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.resetPassword, body: body);
      if (res.isNotEmpty) {
        try {
          return forgotPasswordResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ForgotPasswordResponse(status: false, );
        }
      } else {
        return ForgotPasswordResponse(status: false, );
      }
    } else {
      return ForgotPasswordResponse(status: false, );
    }
  }

  Future<OrderStatusUpdate> updateOrderStatusDriver(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.deliverBoyOrderStatus, body: body);
      if (res.isNotEmpty) {
        try {
          return orderStatusUpdateFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderStatusUpdate(status: false, );
        }
      } else {
        return OrderStatusUpdate(status: false, );
      }
    } else {
      return OrderStatusUpdate(status: false, );
    }
  }

  Future<OrderStatusUpdate> completeOrderDriver(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.deliverBoyOrderStatus, body: body);
      if (res.isNotEmpty) {
        try {
          return orderStatusUpdateFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderStatusUpdate(status: false, );
        }
      } else {
        return OrderStatusUpdate(status: false, );
      }
    } else {
      return OrderStatusUpdate(status: false, );
    }
  }

  Future<AcceptedOrderResponse> getAcceptedOrderData(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getOrderRequest, body: body);
      if (res.isNotEmpty) {
        try {
          return acceptedOrderResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AcceptedOrderResponse(status: 400,message: '',errorCode: 400,errorLine: 5 );
        }
      } else {
        return AcceptedOrderResponse(status: 400,message: '',errorCode: 400,errorLine: 5 );
      }
    } else {
      return AcceptedOrderResponse(status: 400,message: '',errorCode: 400,errorLine: 5 );
    }
  }




}



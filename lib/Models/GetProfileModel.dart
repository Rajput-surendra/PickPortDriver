class GetProfileModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetProfileModel({this.status, this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userType;
  String? userPhone;
  String? firstname;
  String? lastname;
  String? userFullname;
  String? userEmail;
  String? userBdate;
  String? userPassword;
  String? userCity;
  String? userState;
  String? varificationCode;
  String? userImage;
  String? pincode;
  String? socityId;
  String? houseNo;
  String? mobileVerified;
  String? userGcmCode;
  String? userIosToken;
  String? varifiedToken;
  String? address;
  String? status;
  String? regCode;
  String? wallet;
  String? rewards;
  String? created;
  String? modified;
  String? otp;
  String? otpStatus;
  String? social;
  String? facebookID;
  String? isEmailVerified;
  String? vehicleType;
  String? vehicleTypeString;
  String? vehicleNo;
  String? drivingLicenceNo;
  String? drivingLicencePhotof;
  String? drivingLicencePhotob;
  String? loginStatus;
  String? isAvaible;
  String? latitude;
  String? longitude;
  String? referralCode;
  String? referralBy;
  String? aadhaarCardNo;
  String? aadhaarCardPhotob;
  String? aadhaarCardPhotof;
  String? qrCode;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? accountType;
  String? panCard;
  String? rcImageb;
  String? rcImagef;
  String? serviceBill;
  String? cashCollection;
  String? toPay;
  String? cheque;
  String? gstType;
  String? gstNumber;
  String? gstAddress;
  String? pollutionEmission;
  String? vehicleInsurance;
  String? insertDate;
  Null? refAmount;
  String? drivingLicencePhoto;

  Data(
      {this.userId,
        this.userType,
        this.userPhone,
        this.firstname,
        this.lastname,
        this.userFullname,
        this.userEmail,
        this.userBdate,
        this.userPassword,
        this.userCity,
        this.userState,
        this.varificationCode,
        this.userImage,
        this.pincode,
        this.socityId,
        this.houseNo,
        this.mobileVerified,
        this.userGcmCode,
        this.userIosToken,
        this.varifiedToken,
        this.address,
        this.status,
        this.regCode,
        this.wallet,
        this.rewards,
        this.created,
        this.modified,
        this.otp,
        this.otpStatus,
        this.social,
        this.facebookID,
        this.isEmailVerified,
        this.vehicleType,
        this.vehicleTypeString,
        this.vehicleNo,
        this.drivingLicenceNo,
        this.drivingLicencePhotof,
        this.drivingLicencePhotob,
        this.loginStatus,
        this.isAvaible,
        this.latitude,
        this.longitude,
        this.referralCode,
        this.referralBy,
        this.aadhaarCardNo,
        this.aadhaarCardPhotob,
        this.aadhaarCardPhotof,
        this.qrCode,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.bankName,
        this.accountType,
        this.panCard,
        this.rcImageb,
        this.rcImagef,
        this.serviceBill,
        this.cashCollection,
        this.toPay,
        this.cheque,
        this.gstType,
        this.gstNumber,
        this.gstAddress,
        this.pollutionEmission,
        this.vehicleInsurance,
        this.insertDate,
        this.refAmount,
        this.drivingLicencePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    userPhone = json['user_phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userBdate = json['user_bdate'];
    userPassword = json['user_password'];
    userCity = json['city_name'];
    userState = json['state_name'];
    varificationCode = json['varification_code'];
    userImage = json['user_image'];
    pincode = json['pincode'];
    socityId = json['socity_id'];
    houseNo = json['house_no'];
    mobileVerified = json['mobile_verified'];
    userGcmCode = json['user_gcm_code'];
    userIosToken = json['user_ios_token'];
    varifiedToken = json['varified_token'];
    address = json['address'];
    status = json['status'];
    regCode = json['reg_code'];
    wallet = json['wallet'];
    rewards = json['rewards'];
    created = json['created'];
    modified = json['modified'];
    otp = json['otp'];
    otpStatus = json['otp_status'];
    social = json['social'];
    facebookID = json['facebookID'];
    isEmailVerified = json['is_email_verified'];
    vehicleType = json['vehicle_type'];
    vehicleTypeString = json['vehicle_type_string'];
    vehicleNo = json['vehicle_no'];
    drivingLicenceNo = json['driving_licence_no'];
    drivingLicencePhotof = json['driving_licence_photo'];
    drivingLicencePhotob = json['driving_licence_photo_back'];
    loginStatus = json['login_status'];
    isAvaible = json['is_avaible'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    referralCode = json['referral_code'];
    referralBy = json['referral_by'];
    aadhaarCardNo = json['aadhaar_card_no'];
    aadhaarCardPhotob = json['aadhaar_card_photo_back'];
    aadhaarCardPhotof = json['aadhaar_card_photo'];
    qrCode = json['qr_code'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountType = json['account_type'];
    panCard = json['pan_card'];
    rcImageb = json['rc_card_photo_back'];
    rcImagef = json['rc_card_photo'];
    serviceBill = json['service_bill'];
    cashCollection = json['cash_collection'];
    toPay = json['to_pay'];
    cheque = json['cheque'];
    gstType = json['gst_type'];
    gstNumber = json['gst_number'];
    gstAddress = json['gst_address'];
    pollutionEmission = json['pollution_emission'];
    vehicleInsurance = json['vehicle_insurance'];
    insertDate = json['insert_date'];
    refAmount = json['ref_amount'];
    drivingLicencePhoto = json['driving_licence_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['user_phone'] = this.userPhone;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['user_fullname'] = this.userFullname;
    data['user_email'] = this.userEmail;
    data['user_bdate'] = this.userBdate;
    data['user_password'] = this.userPassword;
    data['user_city'] = this.userCity;
    data['user_state'] = this.userState;
    data['varification_code'] = this.varificationCode;
    data['user_image'] = this.userImage;
    data['pincode'] = this.pincode;
    data['socity_id'] = this.socityId;
    data['house_no'] = this.houseNo;
    data['mobile_verified'] = this.mobileVerified;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_ios_token'] = this.userIosToken;
    data['varified_token'] = this.varifiedToken;
    data['address'] = this.address;
    data['status'] = this.status;
    data['reg_code'] = this.regCode;
    data['wallet'] = this.wallet;
    data['rewards'] = this.rewards;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['otp'] = this.otp;
    data['otp_status'] = this.otpStatus;
    data['social'] = this.social;
    data['facebookID'] = this.facebookID;
    data['is_email_verified'] = this.isEmailVerified;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_type_string'] = this.vehicleTypeString;
    data['vehicle_no'] = this.vehicleNo;
    data['driving_licence_no'] = this.drivingLicenceNo;
    data['driving_licence_photof'] = this.drivingLicencePhotof;
    data['driving_licence_photob'] = this.drivingLicencePhotob;
    data['login_status'] = this.loginStatus;
    data['is_avaible'] = this.isAvaible;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['referral_code'] = this.referralCode;
    data['referral_by'] = this.referralBy;
    data['aadhaar_card_no'] = this.aadhaarCardNo;
    data['aadhaar_card_photob'] = this.aadhaarCardPhotob;
    data['aadhaar_card_photof'] = this.aadhaarCardPhotof;
    data['qr_code'] = this.qrCode;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['account_type'] = this.accountType;
    data['pan_card'] = this.panCard;
    data['rc_imageb'] = this.rcImageb;
    data['rc_imagef'] = this.rcImagef;
    data['service_bill'] = this.serviceBill;
    data['cash_collection'] = this.cashCollection;
    data['to_pay'] = this.toPay;
    data['cheque'] = this.cheque;
    data['gst_type'] = this.gstType;
    data['gst_number'] = this.gstNumber;
    data['gst_address'] = this.gstAddress;
    data['pollution_emission'] = this.pollutionEmission;
    data['vehicle_insurance'] = this.vehicleInsurance;
    data['insert_date'] = this.insertDate;
    data['ref_amount'] = this.refAmount;
    data['driving_licence_photo'] = this.drivingLicencePhoto;
    return data;
  }
}

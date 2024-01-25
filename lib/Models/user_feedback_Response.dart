class UserFeedbackResponseResponse {
  bool? status;
  String? message;
  List<Rating>? rating;

  UserFeedbackResponseResponse({this.status, this.message, this.rating});

  UserFeedbackResponseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(new Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  String? id;
  String? parcelId;
  String? deliveryBoyId;
  String? userId;
  String? rating;
  String? feedback;
  String? createdDate;
  String? userType;
  String? userPhone;
  String? firstname;
  String? lastname;
  String? userFullname;
  String? userEmail;
  String? userBdate;
  String? userPassword;
  String? userCity;
  String? varificationCode;
  String? userImage;
  String? pincode;
  String? socityId;
  String? houseNo;
  String? mobileVerified;
  String? userGcmCode;
  String? userIosToken;
  String? varifiedToken;
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
  String? vehicleNo;
  String? drivingLicenceNo;
  String? drivingLicencePhoto;
  String? loginStatus;
  String? isAvaible;
  String? latitude;
  String? longitude;
  String? referralCode;
  String? aadhaarCardNo;
  String? aadhaarCardPhoto;
  String? qrCode;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? panCard;
  String? serviceBill;
  String? cashCollection;
  String? toPay;

  Rating(
      {this.id,
        this.parcelId,
        this.deliveryBoyId,
        this.userId,
        this.rating,
        this.feedback,
        this.createdDate,
        this.userType,
        this.userPhone,
        this.firstname,
        this.lastname,
        this.userFullname,
        this.userEmail,
        this.userBdate,
        this.userPassword,
        this.userCity,
        this.varificationCode,
        this.userImage,
        this.pincode,
        this.socityId,
        this.houseNo,
        this.mobileVerified,
        this.userGcmCode,
        this.userIosToken,
        this.varifiedToken,
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
        this.vehicleNo,
        this.drivingLicenceNo,
        this.drivingLicencePhoto,
        this.loginStatus,
        this.isAvaible,
        this.latitude,
        this.longitude,
        this.referralCode,
        this.aadhaarCardNo,
        this.aadhaarCardPhoto,
        this.qrCode,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.bankName,
        this.panCard,
        this.serviceBill,
        this.cashCollection,
        this.toPay});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parcelId = json['parcel_id'];
    deliveryBoyId = json['delivery_boy_id'];
    userId = json['user_id'];
    rating = json['rating'];
    feedback = json['feedback'];
    createdDate = json['created_date'];
    userType = json['user_type'];
    userPhone = json['user_phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userBdate = json['user_bdate'];
    userPassword = json['user_password'];
    userCity = json['user_city'];
    varificationCode = json['varification_code'];
    userImage = json['user_image'];
    pincode = json['pincode'];
    socityId = json['socity_id'];
    houseNo = json['house_no'];
    mobileVerified = json['mobile_verified'];
    userGcmCode = json['user_gcm_code'];
    userIosToken = json['user_ios_token'];
    varifiedToken = json['varified_token'];
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
    vehicleNo = json['vehicle_no'];
    drivingLicenceNo = json['driving_licence_no'];
    drivingLicencePhoto = json['driving_licence_photo'];
    loginStatus = json['login_status'];
    isAvaible = json['is_avaible'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    referralCode = json['referral_code'];
    aadhaarCardNo = json['aadhaar_card_no'];
    aadhaarCardPhoto = json['aadhaar_card_photo'];
    qrCode = json['qr_code'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    panCard = json['pan_card'];
    serviceBill = json['service_bill'];
    cashCollection = json['cash_collection'];
    toPay = json['to_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parcel_id'] = this.parcelId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['created_date'] = this.createdDate;
    data['user_type'] = this.userType;
    data['user_phone'] = this.userPhone;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['user_fullname'] = this.userFullname;
    data['user_email'] = this.userEmail;
    data['user_bdate'] = this.userBdate;
    data['user_password'] = this.userPassword;
    data['user_city'] = this.userCity;
    data['varification_code'] = this.varificationCode;
    data['user_image'] = this.userImage;
    data['pincode'] = this.pincode;
    data['socity_id'] = this.socityId;
    data['house_no'] = this.houseNo;
    data['mobile_verified'] = this.mobileVerified;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_ios_token'] = this.userIosToken;
    data['varified_token'] = this.varifiedToken;
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
    data['vehicle_no'] = this.vehicleNo;
    data['driving_licence_no'] = this.drivingLicenceNo;
    data['driving_licence_photo'] = this.drivingLicencePhoto;
    data['login_status'] = this.loginStatus;
    data['is_avaible'] = this.isAvaible;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['referral_code'] = this.referralCode;
    data['aadhaar_card_no'] = this.aadhaarCardNo;
    data['aadhaar_card_photo'] = this.aadhaarCardPhoto;
    data['qr_code'] = this.qrCode;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['pan_card'] = this.panCard;
    data['service_bill'] = this.serviceBill;
    data['cash_collection'] = this.cashCollection;
    data['to_pay'] = this.toPay;
    return data;
  }
}

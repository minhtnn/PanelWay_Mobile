import 'dart:io';

class ServerConstant{
  static String serverURL =
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';
}

class ApiEndpoints {
  //Base URL
  static String localhost = ServerConstant.serverURL;
  static const String _rootEndPoint = "/api";
  static const String _apiVersion = "/v1";
  static const String _apiEndpoint = _rootEndPoint + _apiVersion;
  static String baseUrl = localhost + _apiEndpoint;

  //Authentication
  static String authenticationEndpoint = "$baseUrl/auth";
  static String login = "$authenticationEndpoint/login";
  static String signUp = "$authenticationEndpoint/sign-up";
  static String refreshToken = "$authenticationEndpoint/refresh-token";

  //Account
  static const String _accountEndpoint = "/accounts";
  static String accountApiEndpoint = baseUrl + _accountEndpoint;
  static String findAccountByIdApiEndpoint = "$accountApiEndpoint/{id}";
  static String findAccountByUserIdApiEndpoint = "$accountApiEndpoint/user/{id}";

  //AdContent
  static const String _adContentEndpoint = "/ad-contents";
  static String adContentApiEndpoint = baseUrl + _adContentEndpoint;
  static String findAdContentByIdApiEndpoint = "$adContentApiEndpoint/{id}";
  static String findAdContentByAdvertisingClientIdApiEndpoint = "$adContentApiEndpoint/accounts/{id}";

  //Appointment
  static const String _appointmentEndpoint = "/appointments";
  static String appointmentApiEndpoint = baseUrl + _appointmentEndpoint;
  static String findAppointmentByIdApiEndpoint = "$appointmentApiEndpoint/{id}";
  static String findAppointmentByRentalLocationIdApiEndpoint = "$appointmentApiEndpoint/rental-location/{id}";

  //AppointmentHistory
  static const String _appointmentHistoryEndpoint = "/appointment-histories";
  static String appointmentHistoryApiEndpoint = baseUrl + _appointmentHistoryEndpoint;
  static String findAppointmentHistoryByIdApiEndpoint = "$appointmentHistoryApiEndpoint/{id}";
  static String findAppointmentHistoryByAppointmentIdApiEndpoint = "$appointmentHistoryApiEndpoint/appointment/{id}";

  //Firebase
  static const String _firebaseEndpoint = "/firebase";
  static String firebaseUploadApiEndpoint = "$baseUrl$_firebaseEndpoint/upload";
  static String firebaseDownload = "$baseUrl$_firebaseEndpoint/download";
  static String firebaseVerifyToken = "$baseUrl$_firebaseEndpoint/verify-token";
  static String firebaseSaveUser = "$baseUrl$_firebaseEndpoint/save-user";
  static String firebaseGetUser = "$baseUrl$_firebaseEndpoint/user/{id}";

  //PanelType
  static const String _panelTypeEndpoint = "/panel-types";
  static String panelTypeApiEndpoint = baseUrl + _panelTypeEndpoint;
  static String findPanelTypeByIdApiEndpoint = "$panelTypeApiEndpoint/{id}";

  //Payment
  static const String _paymentEndpoint = "/payments";
  static String _paymentApiEndpoint = baseUrl + _paymentEndpoint;
  static String findPaymentByIdApiEndpoint = "$_paymentApiEndpoint/{id}";

  //PayOS
  static const String _payOsEndPoint = "/payos";
  static String payOsApiEndpoint = baseUrl + _payOsEndPoint;
  static String createQrApiEndpoint = "$payOsApiEndpoint/create-qr";
  static String findPayOSByOrderIdApiEndpoint = "$payOsApiEndpoint/{orderId}";
  static String cancelPayOSByOrderIdApiEndpoint = "$payOsApiEndpoint/{orderId}/cancel";

  //PaymentType
  static const String _paymentTypeEndpoint = "/payment-types";
  static String paymentTypeApiEndpoint = baseUrl + _paymentTypeEndpoint;
  static String findPaymentTypeByIdApiEndpoint = "$paymentTypeApiEndpoint/{id}";

  //RegulatoryApproval
  static const String _regulatoryApprovalEndpoint = "/regulatory-approvals";
  static String regulatoryApprovalApiEndpoint = baseUrl + _regulatoryApprovalEndpoint;
  static String findRegulatoryApprovalByIdApiEndpoint = "$regulatoryApprovalApiEndpoint/{id}";
  static String findRegulatoryApprovalByRentalLocationIdApiEndpoint = "$regulatoryApprovalApiEndpoint/rental-location/{id}";

  //RegulatoryLicense
  static const String _regulatoryLicenseEndpoint = "/regulatory-licenses";
  static String regulatoryLicenseApiEndpoint = baseUrl + _regulatoryLicenseEndpoint;
  static String findRegulatoryLicenseByIdApiEndpoint = "$regulatoryLicenseApiEndpoint/{id}";
  static String findRegulatoryLicenseByRegulatoryApproveIdApiEndpoint = "$regulatoryLicenseApiEndpoint/regulatory-approve/{id}";

  //RentalLocation
  static const String _rentalLocationEndpoint = "/rental-locations";
  static String rentalLocationApiEndpoint = baseUrl + _rentalLocationEndpoint;
  static String findRentalLocationByIdApiEndpoint = "$rentalLocationApiEndpoint/{id}";

  //RentalLocationPanelType
  static const String _rentalLocationPanelTypeEndpoint = "/rental-location-panel-types";
  static String rentalLocationPanelTypeApiEndpoint = baseUrl + _rentalLocationPanelTypeEndpoint;
  static String findRentalLocationPanelTypeByRentalLocationIdApiEndpoint = "$rentalLocationPanelTypeApiEndpoint/rental-location/{id}";

  //Subscription
  static const String _subscriptionEndpoint = "/subscriptions";
  static String subscriptionApiEndpoint = baseUrl + _subscriptionEndpoint;
  static String findSubscriptionByIdApiEndpoint = "$subscriptionApiEndpoint/{id}";

  //Transaction
  static const String _transactionEndpoint = "/transactions";
  static String transactionApiEndpoint = baseUrl + _transactionEndpoint;
  static String findTransactionByIdApiEndpoint = "$transactionApiEndpoint/{id}";
  static String findTransactionByAccountIdApiEndpoint = "$transactionApiEndpoint/account/{id}";
  static String findTransactionByUserSubscriptionIdAndPaymentIdApiEndpoint = "$transactionApiEndpoint/user-subscription/{userSubscriptionId}/payment/{paymentId}";

  //User
  static const String _userEndpoint = "/users";
  static String userApiEndpoint = baseUrl + _userEndpoint;
  static String findUserByIdApiEndpoint = "$userApiEndpoint/{id}";

  //UserSubscription
  static const String _userSubscriptionEndpoint = "/user-subscriptions";
  static String userSubscriptionApiEndpoint = baseUrl + _userSubscriptionEndpoint;
  static String findUserSubscriptionByIdApiEndpoint = "$userSubscriptionApiEndpoint/{id}";
  static String findUserSubscriptionByAccountIdApiEndpoint = "$userSubscriptionApiEndpoint/account/{id}";
}
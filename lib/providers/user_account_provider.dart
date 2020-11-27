import 'package:flutter/material.dart';
import 'package:loadoperator/model/user_model.dart';

class UserAccountProvider with ChangeNotifier {
  UserModel _userModel = UserModel();

  /*ServiceModel _serviceModel  = ServiceModel();
  WalletModel _walletModel= WalletModel();
  String tempEmail= '';
  KonveyoUserModel _konveyoUserModel = KonveyoUserModel();
  List<ScheduleModel> _list = List<ScheduleModel>();
  RouteModel _routeModel = RouteModel(
      starting: Places(name: 'N/A', latitude: 0.0, longitude: 0.0),
      destination: Places(name: 'N/A', latitude: 0.0, longitude: 0.0));*/

  bool isAvailable = false;
  bool isAKonveyo = false;
  String temPhone='';
  String temJson='';
  String temToken='';

  void setUserDetails(UserModel model) {
    _userModel = model;
    notifyListeners();
  }
  void appendUserDetails(String name,String id, String logo) {
    _userModel.storeName = name;
    _userModel.storeId = id;
    _userModel.storeLogo = logo;
    print(_userModel.storeLogo);
    notifyListeners();
  }

  void setTempToken(String s) {
    temToken = s;
    notifyListeners();
  }

  void setTempPhone(String s){
    temPhone=s;
    print(s);
    notifyListeners();
  }
  void setTempJson(String s){
    temJson=s;
    print(s);
    notifyListeners();
  }

  String get getFullName {
    return _userModel.name;
  }

  String get getEmail {
    return _userModel.email;
  }

  String get getId {
    return _userModel.id.toString();
  }

  /*String get getLanguage {
    return _userModel.language;
  }

  Places get getStarting {
    return _routeModel.starting;
  }

  Places get getDestination {
    return _routeModel.destination;
  }

  String get getCountry {
    return _userModel.country;
  }*/

  String get getPhone {
    return _userModel.phone;
  }

  String get getEmailVerifiedAt {
    return _userModel.emailVerifiedAt;
  }

  String get getAccessToken {
    return _userModel.apiToken;
  }

  String get getStatus {
    return _userModel.status;
  }

  String get getRole {
    return _userModel.role;
  }

  String get getUserOf {
    return _userModel.userOf;
  }

  String get getTempPhone {
    return temPhone;
  }

  String get getTempToken {
    return temToken;
  }

  String get getJson{
    return temJson;
  }
  String get getLogo {
    return _userModel.storeLogo;
  }

  String get getStoreId{
    return _userModel.storeId;
  }
  UserModel get getUserModel{
    return _userModel;
  }
}

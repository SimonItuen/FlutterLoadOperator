import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadoperator/helper/session_manager_util.dart';
import 'package:loadoperator/model/user_model.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Main_screen/main_screen.dart';
import 'package:loadoperator/screens/login_screen/login.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  static String routeName = '/splash-screen';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      checkLogin();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  checkLogin() async {
    await SessionManagerUtil.getInstance();
    if (SessionManagerUtil.getString('apiToken') == null ||
        SessionManagerUtil
            .getString('apiToken')
            .trim()
            .isEmpty) {
      Navigator.of(context).pushReplacementNamed(Login.routeName);
      print('null');
    } else {
      print('yes');
      UserModel model = UserModel(
        apiToken: SessionManagerUtil.getString('apiToken'),
        email: SessionManagerUtil.getString('email'),
        status: SessionManagerUtil.getString('status'),
        id: SessionManagerUtil.getInt('id'),
        name: SessionManagerUtil.getString('name'),
        role: SessionManagerUtil.getString('role'),
        userOf: SessionManagerUtil.getString('userOf'),
        phone: SessionManagerUtil.getString('phone'),
        emailVerifiedAt: SessionManagerUtil.getString('emailVerifiedAt'),
      );

      model.storeName =SessionManagerUtil.getString('storeName');
      model.storeId =SessionManagerUtil.getString('storeId');
      model.storeLogo =SessionManagerUtil.getString('storeLogo');

      Provider.of<UserAccountProvider>(context, listen: false)
          .setUserDetails(model);
      Navigator.of(context).pushReplacementNamed(Mainscreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}

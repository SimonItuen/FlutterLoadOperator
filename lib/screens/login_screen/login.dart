import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:loadoperator/helper/base_url.dart';
import 'package:loadoperator/helper/screensize.dart';
import 'package:loadoperator/helper/session_manager_util.dart';
import 'package:loadoperator/model/user_model.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Main_screen/main_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:loadoperator/widgets/smart_button.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  static String routeName = '/login-screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var visability = false;
  bool isLoading = false;
  bool emailValid = false;
  bool passwordValid = false;
  bool active = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                color: Mycolors.white,
                //image: DecorationImage(image: AssetImage('assets/Path 1908.png'),fit: BoxFit.cover)
              ),
              child: SingleChildScrollView(
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/load.svg',
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        padding:
                            EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
                        width: SizeConfig.screenHeight,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  primaryColor: Mycolors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      emailValid =
                                              value.trim().isNotEmpty;
                                      setState(() {
                                        active =
                                            emailValid && passwordValid;
                                      });
                                    },
                                    controller: emailController,
                                    decoration: new InputDecoration(
                                      labelText: "Operator Id",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans-Regular',
                                          color: Mycolors.red),
                                      fillColor: Colors.white,

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Mycolors.red)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        new BorderRadius.circular(14.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      ),

                                      border: new OutlineInputBorder(
                                        borderRadius:
                                        new BorderRadius.circular(14.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val.length == 0) {
                                        return "Operator Id cannot be empty";
                                      } else {
                                          return null;
                                      }
                                    },
                                    keyboardType:
                                    TextInputType.emailAddress,
                                    style: new TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans-Regular',
                                        color: Mycolors.dark2),
                                  ),
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Mycolors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (value.length > 5) {
                                        passwordValid = true;
                                      } else {
                                        passwordValid = false;
                                      }
                                      setState(() {
                                        active =
                                            emailValid && passwordValid;
                                      });
                                    },
                                    controller: passwordController,
                                    obscureText: visability ? false : true,
                                    decoration: new InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans-Regular',
                                          color: Mycolors.red),
                                      fillColor: Colors.white,

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Mycolors.red)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        new BorderRadius.circular(14.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      ),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              visability = !visability;
                                            });
                                          },
                                          child: !visability
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility)),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                        new BorderRadius.circular(14.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val.length < 6) {
                                        return "Password must contain at least 6 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType:
                                    TextInputType.emailAddress,
                                    style: new TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans-Regular',
                                        color: Mycolors.dark2),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: SmartButton(
                                  active: active,
                                  isLoading: isLoading,
                                  text: 'Login',
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    postLogin(context);
                                  },
                                  inactiveOnpressed: () {
                                    _formKey.currentState.validate();
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                  color: Color(0x99000000),
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  postLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      print('${emailController.text}    ${passwordController.text}');
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/operator/operator-login';
      print(url);
      var map = convert.jsonEncode(<String, String>{
        'operator_id': emailController.text,
        'password': passwordController.text,
      });
      print(map);
      try {
        http.Response response = await http.post(url,
            headers: {"Content-Type": "application/json", "X-Requested-With" :  "XMLHttpRequest"}, body: map);

        print(response.body);
        if (response.statusCode == 200) {
          print('eien');
          print('eien');
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse['success'].toString() == 'true') {
            Map<String, dynamic> map = jsonResponse['data'];
            UserModel model = UserModel.fromJson(map);
            print(model.apiToken);
            UserAccountProvider _accountProvider =
            Provider.of<UserAccountProvider>(context, listen: false);
            _accountProvider.setUserDetails(model);
            SessionManagerUtil.putString('apiToken', '${model.apiToken}');
            SessionManagerUtil.putString('status', '${model.status}');
            SessionManagerUtil.putInt('id', model.id);
            SessionManagerUtil.putString('name', '${model.name}');
            SessionManagerUtil.putString('email', '${model.email}');
            SessionManagerUtil.putString('emailVerifiedAt', '${model.emailVerifiedAt}');
            SessionManagerUtil.putString('role', '${model.role}');
            SessionManagerUtil.putString('phone', '${model.phone}');
            SessionManagerUtil.putString('userOf', '${model.userOf}');
          await getProfile(model);
            setState(() {
              isLoading = false;
            });
          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['message']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', '')),
                duration: Duration(seconds: 4),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              setState(() {
                isLoading = false;
              });
            }
          }
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 4),
            );
            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              isLoading = false;
            });
          } else {
            final snackBar = SnackBar(
              content: Text('Couldn\'t Connect, please try again'),
              duration: Duration(seconds: 4),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
          setState(() {
            isLoading = false;
          });
        }
      } on TimeoutException catch (e) {
        final snackBar = SnackBar(
          content: Text('Timeout Error: ${e.message}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on SocketException catch (e) {
        final snackBar = SnackBar(
          content: Text('Socket Error: ${e.message}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on Error catch (e) {
        final snackBar = SnackBar(
          content: Text('General Error: ${e}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getProfile(UserModel model) async {
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/operator-details';
    print(url);
    var map = convert.jsonEncode(
        <String, String>{'api_token': _accountProvider.getAccessToken});
    print(map);
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
          body: map);

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          Map<String, dynamic> map = jsonResponse['data'];
          print(jsonResponse['data']['store_name'].toString());
          print(jsonResponse['data']['store_logo']);
          print(jsonResponse['data']['id']);
          model.storeName = jsonResponse['data']['store_name'].toString();
          model.storeId = jsonResponse['data']['id'].toString();
          model.storeLogo =  jsonResponse['data']['store_logo'].toString();
          UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
          _accountProvider.setUserDetails(model);
          SessionManagerUtil.putString('storeId', jsonResponse['data']['id'].toString());
          SessionManagerUtil.putString('storeName', jsonResponse['data']['store_name'].toString());
          SessionManagerUtil.putString('storeLogo', jsonResponse['data']['store_logo'].toString());

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mainscreen()));
          /*UserModel model = UserModel.fromJson(map);
          model.points = _accountProvider.getPoints;
          _accountProvider.setUserDetails(model);
          print('This is ${_accountProvider.getAccessToken}');
          SessionManagerUtil.putString('apiToken', '${model.apiToken}');
          SessionManagerUtil.putString('status', '${model.status}');
          SessionManagerUtil.putInt('id', model.id);
          SessionManagerUtil.putString('name', '${model.name}');
          SessionManagerUtil.putString('email', '${model.email}');
          SessionManagerUtil.putString('role', '${model.role}');
          SessionManagerUtil.putString('phone', '${model.phone}');
          SessionManagerUtil.putString('profilePhoto', '${model.profileImg}');*/
          /*getPoints();*/
        } else {
          if (jsonResponse
              .toString()
              .isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 4),
            );
            /*Scaffold.of(context).showSnackBar(snackBar);*/

          }
        }
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse
            .toString()
            .isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 4),
          );
          /*Scaffold.of(context).showSnackBar(snackBar);*/

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          /*Scaffold.of(context).showSnackBar(snackBar);*/
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    }
  }
}

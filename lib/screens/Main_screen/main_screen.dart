import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadoperator/helper/base_url.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:loadoperator/helper/screensize.dart';
import 'package:loadoperator/helper/session_manager_util.dart';
import 'package:loadoperator/model/user_model.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Add_points_screen/Add_points.dart';
import 'package:loadoperator/screens/login_screen/login.dart';
import 'package:loadoperator/screens/mobile_number_screen/mobile.dart';
import 'package:loadoperator/screens/scanned_reward/scanned.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:transparent_image/transparent_image.dart';

class Mainscreen extends StatefulWidget {
  static String routeName = '/main-screen';

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  String barcode = "";
  bool isLoading=false;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var block_vert = SizeConfig.blockSizeVertical;
    var block_horz = SizeConfig.blockSizeHorizontal;
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolors.red,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.white,
                        title: Text(
                          "Are you sure you want to Log out?",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'OpenSans-Semibold',
                              color: Mycolors.dark),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "NO",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'OpenSans-Semibold',
                                  color: Mycolors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              logout();
                            },
                            child: Text(
                              "YES",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'OpenSans-Semibold',
                                  color: Mycolors.red),
                            ),
                          ),
                        ],
                      );
                    });
              })
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Path 1908.png'),
                      fit: BoxFit.cover)),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: block_vert * 6,
                      ),
                      Container(
                          width: block_vert * 14,
                          height: block_vert * 14,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:_accountProvider.getUserModel.storeLogo.toString().startsWith('http')
                                ? Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                SpinKitFadingCircle(
                                  color: Mycolors.textfield,
                                ),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: _accountProvider.getUserModel.storeLogo.toString(),
                                  width: width,
                                  fit:BoxFit.cover,
                                  alignment: AlignmentDirectional.topCenter,
                                  height: width * 0.67230,
                                  imageScale: 0.8,
                                )
                              ],
                            )
                                : Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.fill,
                          ),
                            /*child: Image.network(
                              _accountProvider.getUserModel.storeLogo,
                              scale: 0.8,
                            ),*/
                          )),
                      SizedBox(
                        height: block_vert * 2,
                      ),
                      Text(
                        _accountProvider.getUserModel.storeName.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'OpenSans-Semibold',
                            color: Colors.white),
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Addpoints()));

                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    // set to false
                                    pageBuilder: (_, __, ___) => Mobilenumber(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                width: block_horz * 46,
                                height: block_vert * 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      size: block_vert * 8,
                                      color: Mycolors.dark4,
                                    ),
                                    SizedBox(
                                      height: block_vert,
                                    ),
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'OpenSans-Semibold',
                                          color: Mycolors.dark),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                scan(context);
                                /* Navigator.push(context, MaterialPageRoute(builder: (context)=>Scannedreward()));*/
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                width: block_horz * 46,
                                height: block_vert * 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset:
                                        Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/qr.png',
                                      height: block_vert * 8,
                                    ),
                                    SizedBox(
                                      height: block_vert,
                                    ),
                                    Text(
                                      "Scan QR",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'OpenSans-Semibold',
                                          color: Mycolors.dark),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
            );
          }),
    );
  }

  scan(BuildContext context) async {
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);

    try {
      String cameraString = await FlutterBarcodeScanner.scanBarcode(
          '#FFEE4036',
          'Exit',
          true,
          ScanMode.QR);
      final key = encrypt.Key.fromUtf8('my 32 length key................');
      final iv = encrypt.IV.fromUtf8('my 16 length iv8');
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final String cameraScanResult = encrypter.decrypt(encrypt.Encrypted.fromBase64(cameraString), iv: iv);

      setState(() {
        isLoading=true;
      });
      if (cameraScanResult.startsWith('{\"type\"')) {
        _accountProvider.setTempJson(cameraScanResult);
        var jsonData = convert.jsonDecode(_accountProvider.getJson);
        if (jsonData['type'] == 'userDetails') {
          Navigator.of(context).pushNamed(Addpoints.routeName);
        } else if (jsonData['type'] == 'singleReward') {
          if(jsonData['stores_id'].toString()==_accountProvider.getUserModel.storeId) {
            Navigator.of(context).pushNamed(Scannedreward.routeName);
          }else{
            _accountProvider.setTempJson('');
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Incorrect Store'),));
          }
        }
      } else {
        if (cameraScanResult == '-1') {

        } else {
          print('This $cameraScanResult');
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Incorrect Qr code'),));
        }

        /*Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('No Results'),));*/
      }
      setState(() {
        isLoading=false;
      });
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Unknown Error'),));
    } on FormatException {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('No Results'),));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('No Results'),));
    }
  }

  logout() {
    SessionManagerUtil.clearAll();
    Navigator.of(context).pushReplacementNamed(Login.routeName);
  }

  Future<void> getProfile() async {
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
          print(jsonResponse['data']['store_logo'].toString());
          print(jsonResponse['data']['id'].toString());
          UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
          _accountProvider.appendUserDetails(jsonResponse['data']['store_name'].toString(), jsonResponse['data']['id'].toString(), jsonResponse['data']['store_logo'].toString());
          SessionManagerUtil.putString('storeId', jsonResponse['data']['id'].toString());
          SessionManagerUtil.putString('storeName', jsonResponse['data']['store_name'].toString());
          SessionManagerUtil.putString('storeLogo', jsonResponse['data']['store_logo'].toString());

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

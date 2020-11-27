import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:loadoperator/helper/screensize.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Available_rewards/available.dart';
import 'package:loadoperator/widgets/available_reward_tile.dart';
import 'package:loadoperator/widgets/backdrop_bg.dart';
import 'package:loadoperator/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:loadoperator/helper/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class Scannedreward extends StatefulWidget {
  static String routeName = '/scanned-reward';

  @override
  _ScannedrewardState createState() => _ScannedrewardState();
}

class _ScannedrewardState extends State<Scannedreward> {
  Map jsonResponse;
  bool isRedeemLoading = false;

  @override
  Widget build(BuildContext context) {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    jsonResponse = convert.jsonDecode(_accountProvider.getJson);
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var block_vert = SizeConfig.blockSizeVertical;
    var block_horz = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Scanned Reward',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans-Semibold',
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body: Builder(
          builder: (context) => Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    BackdropBg(),
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: <Widget>[
                            Container(
                              width: width,
                              height: height / 50,
                              color: Mycolors.red,
                            ),
                            Container(
                              width: width,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: block_vert * 7,
                                  ),
                                  Container(
                                    width: width,
                                    padding: EdgeInsets.only(
                                      top: (block_vert * 4)+16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: block_vert * 5,
                                            ),
                                            Text(
                                              jsonResponse['name'].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'OpenSans-Semibold',
                                                  color: Mycolors.dark),
                                            ),
                                            SizedBox(
                                              height: block_vert,
                                            ),

                                            Text(
                                              jsonResponse['mobile_number']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans-Regular',
                                                  color: Mycolors.dark),
                                            ),
                                            SizedBox(
                                              height: block_vert * 3,
                                            ),

                                            AvailableRewardTile(
                                              coverUrl: jsonResponse['image'],
                                              points: jsonResponse[
                                              'required_load_point'],
                                              name: jsonResponse['title'],
                                              isLocked: false,
                                              isSelected: false,
                                            ),

                                            SizedBox(height:20,),

                                          ],
                                        ),

                                        SmartButton(
                                          active: true,
                                          text: 'REDEEM',
                                          hasFullBorder: false,
                                          onPressed: () {
                                            redeemReward(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: block_vert * 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              width * 0.22222 * 0.5)),
                                      color: Colors.white,
                                    ),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: width * 0.22222 * 0.5,
                                        backgroundImage: NetworkImage(
                                            jsonResponse['profile_photo']
                                                .toString())),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isRedeemLoading,
                          child: Container(
                              color: Color(0x99000000),
                              child: Center(
                                child: CircularProgressIndicator(),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )),
    );
  }

  redeemReward(BuildContext context) async {
    setState(() {
      isRedeemLoading = true;
    });
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/collect-redeem-point';
    print(url);
    var map = convert.jsonEncode(<String, String>{
      'api_token': _accountProvider.getAccessToken,
      'customer_id': jsonResponse['id'].toString(),
      'store_offer_id': jsonResponse['rewards_id'].toString()
    });
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
        print('eien');
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {

          final snackBar = SnackBar(
            content: Text(jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 2),
          );
          setState(() {
            isRedeemLoading = false;
          });
          await Scaffold.of(context).showSnackBar(snackBar).closed;
          Navigator.of(context).pop();
        } else {
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 2),
            );
            setState(() {
              isRedeemLoading = false;
            });
            Scaffold.of(context).showSnackBar(snackBar);
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
            isRedeemLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            isRedeemLoading = false;
          });
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      print('General Error: ${e}');
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}

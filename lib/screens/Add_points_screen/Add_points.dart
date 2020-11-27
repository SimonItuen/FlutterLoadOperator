import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadoperator/helper/base_url.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:loadoperator/helper/screensize.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/widgets/backdrop_bg.dart';
import 'package:loadoperator/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'package:loadoperator/helper/base_url.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Addpoints extends StatefulWidget {
  static String routeName = '/add-points';

  @override
  _AddpointsState createState() => _AddpointsState();
}

class _AddpointsState extends State<Addpoints> {
  TextEditingController amountController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  var visability = false;
  bool isLoading = false;
  bool amountValid = false;
  bool invoiceValid = false;
  bool active = false;
  final _formKey = GlobalKey<FormState>();
  Map jsonResponse;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    jsonResponse = convert.jsonDecode(_accountProvider.getJson);
    /*phoneNumber = _accountProvider.getTempPhone;*/
    print(jsonResponse);
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
          'Add Points',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans-Semibold',
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              SingleChildScrollView(
                child: Container(
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
                                height: height / 1.5,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: block_vert * 7,
                                    ),
                                    Container(
                                      width: width,
                                      padding: EdgeInsets.only(top:(block_vert * 4)+16),
                                      height: block_vert * 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: block_vert * 5,
                                            ),
                                            Text(
                                              (jsonResponse['name']).toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'OpenSans-Semibold',
                                                  color: Mycolors.dark),
                                            ),
                                            SizedBox(
                                              height: block_vert,
                                            ),
                                            Text(
                                              (jsonResponse['mobile_number']).toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans-Regular',
                                                  color: Mycolors.dark),
                                            ),
                                            SizedBox(
                                              height: block_vert * 3,
                                            ),
                                            Theme(
                                              data: ThemeData(
                                                primaryColor: Mycolors.red,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: Container(
                                                  color: Mycolors.textfield1,
                                                  child: TextFormField(
                                                    controller: amountController,
                                                    onChanged: (value) {
                                                      amountValid =
                                                          value.trim().isNotEmpty;
                                                      setState(() {
                                                        active =
                                                            amountValid;
                                                      });
                                                    },
                                                    autofocus: true,
                                                    decoration: new InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          right: 15,
                                                          left: 15),

                                                      labelText: "Amount (KD)",
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
                                                        new BorderRadius.circular(
                                                            14.0),
                                                        borderSide: new BorderSide(
                                                            color: Colors.red),
                                                      ),

                                                      border: new OutlineInputBorder(
                                                        borderRadius:
                                                        new BorderRadius.circular(
                                                            14.0),
                                                        borderSide: new BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                      //fillColor: Colors.green
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    style: new TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'OpenSans-Semibold',
                                                        color: Mycolors.dark),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: block_vert * 2,
                                            ),
                                            Theme(
                                              data: ThemeData(
                                                primaryColor: Mycolors.red,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: Container(
                                                  color: Mycolors.textfield1,
                                                  child: TextFormField(
                                                    controller: invoiceController,
                                                    decoration: new InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          right: 15,
                                                          left: 15),
                                                      labelText: "Invoice # (Optional)",
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
                                                        new BorderRadius.circular(
                                                            14.0),
                                                        borderSide: new BorderSide(
                                                            color: Colors.red),
                                                      ),

                                                      border: new OutlineInputBorder(
                                                        borderRadius:
                                                        new BorderRadius.circular(
                                                            14.0),
                                                        borderSide: new BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                      //fillColor: Colors.green
                                                    ),
                                                    keyboardType:
                                                    TextInputType.emailAddress,
                                                    style: new TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'OpenSans-Semibold',
                                                        color: Mycolors.dark2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            SmartButton(
                                              text: 'COMPLETE',
                                              isLoading: isLoading,
                                              active: active,
                                              hasFullBorder: false,
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                postPoint(context);
                                              },
                                              inactiveOnpressed: () {
                                                _formKey.currentState.validate();
                                              },
                                            )
                                          ],
                                        ),
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
                                            Radius.circular(width * 0.22222 * 0.5)),
                                        color: Colors.white,
                                      ),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: width * 0.22222 * 0.5,
                                          backgroundImage:
                                          NetworkImage(jsonResponse['profile_photo'].toString())),
                                    ),
                                  ),
                                ),
                              ),
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
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )),
    );
  }

  void postPoint(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/add-user-point';
      print(url);
      var map = convert.jsonEncode(<String, String>{
        'phone_number': jsonResponse['mobile_number'],
        'invoice_number': invoiceController.text,
        'amount': amountController.text,
        'api_token': _accountProvider.getAccessToken,
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
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse['success'].toString() == 'true') {
            setState(() {
              isLoading = false;
            });
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 1),
            );
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
}

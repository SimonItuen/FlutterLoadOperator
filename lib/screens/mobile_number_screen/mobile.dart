import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadoperator/helper/base_url.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:loadoperator/helper/screensize.dart';
import 'package:loadoperator/model/user_model.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Add_points_screen/Add_points.dart';
import 'package:loadoperator/screens/Available_rewards/available.dart';
import 'package:loadoperator/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class Mobilenumber extends StatefulWidget {
  @override
  _MobilenumberState createState() => _MobilenumberState();
}

class _MobilenumberState extends State<Mobilenumber> {
  var add = false;
  var redeem = false;
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool active = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      add = true;
      redeem = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var block_vert = SizeConfig.blockSizeVertical;
    var block_horz = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              Container(
                width: width,
                height: height,
                alignment: Alignment.bottomCenter,
                color: Colors.black.withOpacity(0.5),
                child: SingleChildScrollView(
                  child: AbsorbPointer(
                    absorbing: isLoading,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Column(
                          children: [
                            // IconButton(icon: Icon(Icons.cancel,color: Colors.white,size: 25,), onPressed: (){}),
                            //SizedBox(height: block_vert*55,),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: width,
                                height: block_vert * 46,
                                //color: Colors.red,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              width: width,
                              height: block_vert * 46,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 2,
                                      color: Mycolors.red,
                                    ),
                                    SizedBox(
                                      height: block_vert * 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              add = true;
                                              redeem = false;
                                            });
                                          },
                                          child: Container(
                                            width: block_horz * 40,
                                            height: block_vert * 6,
                                            decoration: BoxDecoration(
                                                color: add
                                                    ? Mycolors.red_dark
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    bottomLeft:
                                                        Radius.circular(50))),
                                            child: Center(
                                              child: Text(
                                                "Add Points",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'OpenSans-Semibold',
                                                    color: add
                                                        ? Colors.white
                                                        : Mycolors.dark4),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              add = false;
                                              redeem = true;
                                            });
                                          },
                                          child: Container(
                                            width: block_horz * 40,
                                            height: block_vert * 6,
                                            decoration: BoxDecoration(
                                                color: redeem
                                                    ? Mycolors.red_dark
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(50),
                                                    bottomRight:
                                                        Radius.circular(50))),
                                            child: Center(
                                              child: Text(
                                                "Redeem",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'OpenSans-Semibold',
                                                    color: redeem
                                                        ? Colors.white
                                                        : Mycolors.dark4),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: block_vert * 6,
                                    ),
                                    Text(
                                      "Enter mobile number",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'OpenSans-Semibold',
                                          color: Mycolors.dark),
                                    ),
                                    SizedBox(
                                      height: block_vert * 2,
                                    ),
                                    Theme(
                                      data: ThemeData(
                                        primaryColor: Mycolors.red,
                                      ),
                                      child: Container(
                                        color: Mycolors.textfield,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              active =
                                                  value.trim().isNotEmpty &&
                                                      phoneController.text
                                                              .trim()
                                                              .length ==
                                                          8;
                                            });
                                          },
                                          autofocus: true,
                                          textAlign: TextAlign.center,
                                          validator: (val) {
                                            if (val.trim().isEmpty) {
                                              return "Phone Number cannot be empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: phoneController,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(8),
                                          ],
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 10, bottom: 10),

                                            // hintText: '94445411',
                                            // hintStyle:  TextStyle(fontSize: 23,fontFamily: 'BAHNSCHRIFT-regular',color: Mycolors.dark),
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
                                          keyboardType: TextInputType.phone,
                                          style: new TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'BAHNSCHRIFT-regular',
                                            color: Mycolors.dark,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: block_vert * 4,
                                    ),

                                    /*Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.blockSizeVertical*7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Mycolors.red_dark
                              ),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Addpoints()));
                              }, child: Text("NEXT",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),),),
                            )*/

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      child: SmartButton(
                                        active: active,
                                        isLoading: isLoading,
                                        borderRadius: 40,
                                        text: 'Next',
                                        onPressed: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          checkNumber(context);
                                        },
                                        inactiveOnpressed: () {
                                          _formKey.currentState.validate();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                          child: Visibility(
                            visible: isLoading,
                            child: Container(
                                color: Color(0x99000000),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  void checkNumber(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/operator/customer-details';
      print(url);
      var map = convert.jsonEncode(<String, String>{
        'phone_number': phoneController.text.toString(),
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
            var params = {
              "id": jsonResponse['data']['id'].toString(),
              "name": jsonResponse['data']['name'].toString(),
              "profile_photo": jsonResponse['data']['profile_photo'].toString(),
              "email": jsonResponse['data']['email'].toString(),
              "mobile_number": jsonResponse['data']['mobile_number'].toString(),
              "role": jsonResponse['data']['role'].toString(),
              "api_token": jsonResponse['data']['api_token'].toString(),
              "status": jsonResponse['data']['status'].toString(),
            };
            String json = convert.jsonEncode(params);
            _accountProvider.setTempJson(json);
            Navigator.of(context).pop();
            if (add) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addpoints()));
            }
            if (redeem) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Availablereward()));
            }
            setState(() {
              isLoading = false;
            });
            /*final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 1),
            );
            await Scaffold.of(context).showSnackBar(snackBar).closed;*/

          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['data']
                        .toString()
                        .replaceAll('{', '')
                        .replaceAll('}', '')
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .trim()
                        .isEmpty
                    ? 'Number not Registered'
                    : jsonResponse['data']
                        .toString()
                        .replaceAll('{', '')
                        .replaceAll('}', '')
                        .replaceAll('[', '')
                        .replaceAll(']', '').toString()),
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

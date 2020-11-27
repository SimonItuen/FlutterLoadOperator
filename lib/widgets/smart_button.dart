import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SmartButton extends StatelessWidget {
  final bool active;
  final Function() onPressed;
  Function() inactiveOnpressed;
  final bool isLoading;
  final String text;
  Color activeColor;
  Color inactiveColor;
  final hasFullBorder;
  final double borderRadius;

  SmartButton({
    this.active = true,
    this.onPressed,
    this.borderRadius=12,
    this.hasFullBorder=true,
    this.inactiveOnpressed,
    this.isLoading = false,
    this.text,
    this.activeColor,
    this.inactiveColor,
  }) {
    activeColor ??= Mycolors.red_dark;
    inactiveColor ??= Mycolors.red_light;
    inactiveOnpressed ??= () {};
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: InkWell(
        onTap: active ? onPressed : inactiveOnpressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: active ? activeColor : inactiveColor,
              borderRadius: hasFullBorder?BorderRadius.all(
                   Radius.circular(borderRadius)):BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius))),
          child: Column(

            children: <Widget>[
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*isLoading
                        ? Container(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : SizedBox.fromSize(
                            size: Size.square(20),
                          ),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:6.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Colors.white),
                      ),
                    ),
                    /*SizedBox.fromSize(
                      size: Size.square(20),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

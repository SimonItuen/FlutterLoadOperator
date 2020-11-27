import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loadoperator/helper/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AvailableRewardTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  final String points;
  final String coverUrl;
  final bool isSelected;
  final bool isLocked;

  AvailableRewardTile(
      {this.onPressed,
      this.name,
      this.isSelected,
      this.points,
      this.coverUrl,
      this.isLocked=true});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.82222;
    double height = width * 0.64189;
    return Center(
      child: InkWell(
        onTap: isLocked ? () {} : onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.04054))),
          child: Container(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Container(
                      height: width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: (Radius.circular(width * 0.04054)),
                        topRight: (Radius.circular(width * 0.04054)),
                      )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: (Radius.circular(width * 0.04054)),
                          topRight: (Radius.circular(width * 0.04054)),
                        ),
                        child: coverUrl.startsWith('http')
                            ? Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  SpinKitFadingCircle(
                                    color: Mycolors.textfield,
                                  ),
                                  FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: coverUrl,
                                    width: width,
                                    height: width * 0.67230,
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                  )
                                ],
                              )
                            : Image.asset(
                                'assets/placeholder.png',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Visibility(
                      visible: isSelected,
                      child: Container(
                        height: width * 0.49948,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: (Radius.circular(width * 0.04054)),
                              topRight: (Radius.circular(width * 0.04054)),
                            ),
                            color: Color(0x80707070)),
                        child: Center(
                            child: SvgPicture.asset(
                          'assets/selected.svg',
                          width: width * 0.20608,
                          height: width * 0.20608,
                          fit: BoxFit.contain,
                        )),
                      ),
                    ),
                    Visibility(
                      visible: isLocked,
                      child: Container(
                        height: width * 0.49948,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: (Radius.circular(width * 0.04054)),
                              topRight: (Radius.circular(width * 0.04054)),
                            ),
                            color: Color(0x80707070)),
                        child: Center(
                            child: SvgPicture.asset(
                          'assets/lock.svg',
                          width: width * 0.20608,
                          height: width * 0.20608,
                          fit: BoxFit.contain,
                        )),
                      ),
                    ),
                    Positioned(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.only(left: 1, top: 1, bottom: 1),
                          decoration: BoxDecoration(
                              color: Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x80000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Text(
                                  points.toString() != '1'
                                      ? '$points points'
                                      : '$points point',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'BAHNSCHRIFT-regular',
                                      color: Mycolors.textfield)),
                            ),
                          )),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans-Semibold',
                                color: Mycolors.dark),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

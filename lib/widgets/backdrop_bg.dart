import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:loadoperator/helper/colors.dart';

class BackdropBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _pathHeight = (MediaQuery.of(context).size.width * 0.54293)-AppBar().preferredSize.height;
    var _pathStartHeight = _pathHeight * 0.91919;
    var _pathTopHandleHeight = _pathHeight * 0.84397;
    var _pathWidth = MediaQuery.of(context).size.width *1.00278;
    return CustomPaint(
      painter: MyPainter(_pathStartHeight, _pathTopHandleHeight, _pathHeight),
      size: Size(_pathWidth, _pathHeight),
    );
  }
}

class MyPainter extends CustomPainter {
  final double pathTopHandleHeight;
  final double pathStartHeight;

  final double pathHeight;
  /*final double pathWidth;*/
  MyPainter(this.pathStartHeight, this.pathTopHandleHeight, this.pathHeight);

  final Paint _paint = Paint()..color = Mycolors.red;

  @override
  void paint(Canvas canvas, Size size) {
    Path path =Path();
    /*path
      ..lineTo(0, pathStartHeight)
      ..cubicTo(size.width / 3, this.pathStartHeight, 2 * size.width/3,
          this.pathTopHandleHeight, size.width, pathStartHeight)
      ..lineTo(size.width, 0);*/
   /* path.lineTo(0, pathStartHeight); //vertical line
    path.cubicTo(size.width/3, pathTopHandleHeight, 2*size.width/3, pathStartHeight, size.width, pathStartHeight); //cubic curve
    path.lineTo(size.width, 0);*/
    /*path.lineTo(0, size.height*0.92018); //vertical line
    path.cubicTo(size.width/3, size.height *0.92018*0.84507, 2*size.width/3, size.height*1.08, size.width, size.height*0.92018); //cubic curve
    path.lineTo(size.width, 0);*/
    path.moveTo(0, 0);
    path.lineTo(0, size.height); //vertical line
    path.cubicTo(size.width/3, size.height *0.7, 2*size.width/3, size.height*1.3, size.width, size.height); //cubic curve
    path.lineTo(size.width, 0);
    canvas.drawPath(path,_paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

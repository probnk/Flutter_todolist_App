import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    Path path = Path();
    path.lineTo(0, h-20);
    path.quadraticBezierTo(0, h, 20, h);
    path.lineTo(w * .5, h);
    path.quadraticBezierTo(w*.57, h,w*.6 , h-20);
    path.lineTo(w, 0);
    path.quadraticBezierTo(w,h-250, w-20, 0);
    path.lineTo(0, 0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    Path path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(w*.5,h-20,w,h);
    path.lineTo(w, 0);
    path.quadraticBezierTo(0,h*.1,0,h*.2);
    path.lineTo(0, 0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
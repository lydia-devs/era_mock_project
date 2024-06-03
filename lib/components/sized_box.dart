import 'package:flutter/material.dart';

class HBox extends StatelessWidget {
  final double height;

  HBox(this.height, {Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class WBox extends StatelessWidget {
  final double width;

  WBox(this.width, {Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

import 'package:flutter/material.dart';

class GlobalSizedBox extends StatelessWidget {
  const GlobalSizedBox({Key? key, this.height = 0, this.width = 0})
      : super(key: key);

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) => SizedBox(height: height, width: width);
}


import 'package:flutter/material.dart';
import 'package:flutter_codigo_movieapp/ui/general/colors.dart';

class LineWidget extends StatelessWidget {

  double width;

  LineWidget({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3.2,
      decoration: BoxDecoration(
        color: kBrandSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

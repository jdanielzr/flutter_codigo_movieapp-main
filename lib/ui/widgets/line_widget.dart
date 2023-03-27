import 'package:flutter/material.dart';
import 'package:flutter_codigo_movieapp/ui/general/colors.dart';

//ignore: must_be_immutable
class LineWidget extends StatelessWidget {
  double width;

  // ignore: use_key_in_widget_constructors
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

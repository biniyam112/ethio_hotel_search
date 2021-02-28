import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

BoxDecoration homePageBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: textLightColor.withOpacity(.1),
      offset: Offset(2, 2),
      blurRadius: 2,
    ),
    BoxShadow(
      color: textLightColor.withOpacity(.1),
      offset: Offset(-2, -2),
      blurRadius: 2,
    ),
  ],
  borderRadius: BorderRadius.circular(
    getProportionateScreenWidth(10),
  ),
  color: Colors.white,
);

import 'package:flutter/material.dart';
import '../../../size_config.dart';

import 'components/body.dart';

class AllHotelsScreen extends StatelessWidget {
  const AllHotelsScreen({Key key}) : super(key: key);
  static String route = '/all_hotel';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}

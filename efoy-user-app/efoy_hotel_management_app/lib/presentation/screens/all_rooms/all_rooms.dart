import 'package:flutter/material.dart';
import '../../../size_config.dart';

import 'components/body.dart';

class AllRoomsScreen extends StatelessWidget {
  const AllRoomsScreen({Key key}) : super(key: key);
  static String route = '/all_rooms';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}

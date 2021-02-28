import 'package:flutter/material.dart';

import 'components/body.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({Key key}) : super(key: key);
  static String route = '/all_events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

import 'components/body.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({Key key, this.event}) : super(key: key);
  static String route = '/event_details';
  final Event event;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(event: event),
    );
  }
}

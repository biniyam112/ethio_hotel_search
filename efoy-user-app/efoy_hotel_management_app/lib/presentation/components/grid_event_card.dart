import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';

import '../screens/event_details/event_details.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.event,
  }) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Image.network(
                'http://10.0.2.2:3000/${event.images[0]}',
                height: getProportionateScreenHeight(100),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                event.name,
                style: TextStyle(
                  color: textDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            verticalSpacing(of: 4),
          ],
        ),
      ),
    );
  }
}

import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';

import 'package:flutter/material.dart';
import '../../event_details/event_details.dart';
import 'constants.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.event,
  }) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
              event: event,
            ),
          ),
        ),
        child: Container(
          height: getProportionateScreenWidth(250),
          decoration: homePageBoxDecoration,
          child: AspectRatio(
            aspectRatio: .7,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'http://10.0.2.2:3000/${event.images[0]}',
                      height: getProportionateScreenWidth(100),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: TextStyle(
                            color: textDarkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        verticalSpacing(of: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryColor,
                            ),
                            SizedBox(width: 8),
                            Row(
                              children: [
                                Text(
                                  'Addis ababa ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Sheraten',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpacing(of: 8),
                        Text(
                          event.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: textLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

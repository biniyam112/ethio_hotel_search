import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';

import '../screens/room_details/room_details.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key key,
    @required this.room,
  }) : super(key: key);
  final Room room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsScreen(room: room),
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
              child: Image.asset(
                // room.imagePath[0],
                'assets/images/bed_room_1.jpg',
                height: getProportionateScreenHeight(100),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                // room.title,
                'this is the title',
                style: TextStyle(
                  color: textDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            verticalSpacing(of: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '\$${room.price}',
                    style: TextStyle(
                      decoration: room.discount != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: textLightColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  if (room.discount != null)
                    Text(
                      '\$${room.discount}',
                      style: TextStyle(
                        color: Color(0xFF986621),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

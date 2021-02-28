import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

import '../../../constants.dart';
import 'components/body.dart';
import 'components/book_button.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({Key key, this.room}) : super(key: key);
  final Room room;
  static String route = '/room_details';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(room: room),
      bottomNavigationBar: Container(
        width: SizeConfig.screenWidth,
        height: getProportionateScreenHeight(70),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (room.discount != null)
                          Text(
                            '${room.discount} % off',
                            style: TextStyle(
                              color: Color(0xFF986621),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 2,
                            ),
                          ),
                        SizedBox(width: 6),
                        Text(
                          '\$${room.price}',
                          style: TextStyle(
                            decoration: room.discount != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: textLightColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (room.discount != null)
                      Text(
                        'with discount',
                        maxLines: 1,
                        style: TextStyle(
                          color: textLightColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: BookButton(
                room: room,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

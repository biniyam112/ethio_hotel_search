import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import '../../room_details/room_details.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key key,
    @required this.room,
    this.hotel,
  }) : super(key: key);
  final Room room;
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsScreen(
              room: room,
            ),
          ),
        ),
        child: Container(
          height: getProportionateScreenHeight(170),
          width: SizeConfig.screenWidth / 1.5,
          decoration: homePageBoxDecoration,
          child: Stack(
            children: [
              Container(
                height: getProportionateScreenHeight(100),
                width: SizeConfig.screenWidth / 1.5,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(6),
                    ),
                    child: Image.asset(
                      // room.imagePath[0],
                      'assets/images/bed_room_1.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: getProportionateScreenWidth(75),
                left: getProportionateScreenWidth(24),
                child: Container(
                  height: getProportionateScreenHeight(30),
                  width: getProportionateScreenWidth(80),
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(8),
                    ),
                    // color: Colors.green[room.rating.ceil() * 100],
                    color: Colors.green[4 * 100],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(flex: 2),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                      Spacer(),
                      Text(
                        // '${room.rating}',
                        '4',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(flex: 8),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: getProportionateScreenHeight(10),
                left: getProportionateScreenWidth(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          // room.title,
                          'the room',
                          style: TextStyle(
                            color: textDarkColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(6)),
                        Text(
                          '\$${room.price}',
                          style: TextStyle(
                            color: textLightColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: SizeConfig.screenWidth / 1.5,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'location',
                            // hotel.location,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(30),
                            ),
                            child: Text(
                              'thisis new',
                              // '@${hotel.name}',
                              style: TextStyle(
                                color: textLightColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

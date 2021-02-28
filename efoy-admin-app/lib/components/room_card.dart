import 'package:flutter/material.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/Room/screens/room_detail.dart';
import '../constants.dart';
import '../size_config.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.room,
  }) : super(key: key);

  final double width, aspectRetio;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(RoomDetail.routeName, arguments: room),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset('assets/images/room.jpg',fit: BoxFit.fill,),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${room.numberOfBedrooms} Bed Room',
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              
              Text(
                "Available ${room.count}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),
              ),
              Text(
                "For Price of ${room.pricePerNight}ETB",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

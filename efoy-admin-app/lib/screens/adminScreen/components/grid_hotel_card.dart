import 'package:flutter/material.dart';
import 'package:hotels/constants.dart';
import 'package:hotels/hotel/models/hotel.dart';

import '../../../size_config.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    Key key,
    @required this.hotel,
  }) : super(key: key);
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        // context,
        // MaterialPageRoute(
        // builder: (context) => HotelDetailsScreen(hotel: hotel),
        // ),
        // );
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
                'http://10.0.2.2:3000/${hotel.images[0].toString()}',
                height: getProportionateScreenHeight(100),
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: TextStyle(
                          color: textDarkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            hotel.location,
                            style:
                                TextStyle(fontSize: 16, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${hotel.stars}',
                        style: TextStyle(
                          color: textLightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(4))
          ],
        ),
      ),
    );
  }
}

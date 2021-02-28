import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import '../../hotel_details/hotel_details.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    Key key,
    @required this.hotel,
  }) : super(key: key);
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    print(hotel.images);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsScreen(
              hotel: hotel,
            ),
          ),
        ),
        child: Container(
          height: getProportionateScreenHeight(220),
          decoration: homePageBoxDecoration,
          child: AspectRatio(
            aspectRatio: .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(6),
                      ),
                      child: Image.network(
                        'http://10.0.2.2:3000/${hotel.images[0]}',
                        height: getProportionateScreenHeight(120),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(22),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                hotel.location,
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
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10),
                          ),
                          color: Colors.green[hotel.rating.ceil() * 100],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${hotel.rating}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

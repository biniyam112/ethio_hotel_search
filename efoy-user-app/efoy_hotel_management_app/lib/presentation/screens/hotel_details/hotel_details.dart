import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({
    Key key,
    this.hotel,
  }) : super(key: key);
  static String route = '/hotel_details';
  final Hotel hotel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        hotel: hotel,
      ),
    );
  }
}

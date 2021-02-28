import 'package:hotels/hotel/models/hotel.dart';
import 'package:hotels/hotel/screens/hotel_detail.dart';
import 'package:hotels/hotel/screens/hotel_list.dart';
import 'package:hotels/hotel/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotelAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => HotelList());
    }
    if (settings.name == AddUpdateHotel.routeName) {
      HotelArgument args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateHotel(args: args),
      );
    }
    if (settings.name == HotelDetail.routeName) {
      Hotel hotel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => HotelDetail(
                hotel: hotel,
              ));
    }

    return MaterialPageRoute(builder: (context) => HotelList());
  }
}

class HotelArgument {
  final Hotel hotel;
  final bool edit;
  HotelArgument({this.hotel, this.edit});
}

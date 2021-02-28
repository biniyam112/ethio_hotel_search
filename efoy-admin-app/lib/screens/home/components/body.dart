import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/Room/bloc/bloc.dart';
import 'package:hotels/Room/data_provider/data_provider.dart';
import 'package:hotels/Room/repository/repository.dart';
import 'package:hotels/event/screens/screen.dart';
import 'package:hotels/hotel/bloc/hotel_bloc.dart';
import 'package:hotels/hotel/bloc/hotel_event.dart';
import 'package:hotels/hotel/data_provider/hotel_data.dart';
import 'package:hotels/hotel/repository/hotel_repository.dart';

import '../../../size_config.dart';
import 'hotelProfile.dart';
import 'room_bar.dart';
import 'special_offers.dart';
import 'package:http/http.dart' as http;
class Body extends StatelessWidget {
  // final RoomRepository roomRepository=RoomRepository(
  //   roomProvider: RoomDataProvider(httpClient: http.Client()));
  //   final HotelRepository hotelRepository=HotelRepository(
  //   hotelProvider: HotelDataProvider(httpClient: http.Client()));
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: SingleChildScrollView(
          child: Column(
            children: [
      SizedBox(height: getProportionateScreenHeight(20)),
      HotelProfile(),
      EventList(),
      SizedBox(height: getProportionateScreenWidth(30)),
      RoomBar(),
      SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'presentation/screens/all_events/all_events.dart';
import 'presentation/screens/all_hotels/all_hotels.dart';
import 'presentation/screens/all_rooms/all_rooms.dart';
import 'presentation/screens/event_details/event_details.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/hotel_details/hotel_details.dart';
import 'presentation/screens/otp/otp_screen.dart';
import 'presentation/screens/room_details/room_details.dart';
import 'presentation/screens/signup/signup_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  SplashScreen.route: (context) => SplashScreen(),
  SignUpScreen.route: (context) => SignUpScreen(),
  OTPScreen.route: (context) => OTPScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  RoomDetailsScreen.route: (context) => RoomDetailsScreen(),
  EventDetailsScreen.route: (context) => EventDetailsScreen(),
  HotelDetailsScreen.route: (context) => HotelDetailsScreen(),
  AllHotelsScreen.route: (context) => AllHotelsScreen(),
  AllRoomsScreen.route: (context) => AllRoomsScreen(),
  AllEventsScreen.route: (context) => AllEventsScreen(),
};

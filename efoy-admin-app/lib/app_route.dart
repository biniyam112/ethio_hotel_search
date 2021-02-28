import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/Room/screens/room_detail.dart';
import 'package:hotels/Room/screens/screens.dart';
import 'package:hotels/auth/sign_in/sign_in_page.dart';
import 'package:hotels/event/event.dart';
import 'package:hotels/event/screens/event_detail.dart';
import 'package:hotels/hotel/screens/hotel_add_update.dart';
import 'package:hotels/screens/forgot_password/forgot_password_screen.dart';
import 'package:hotels/screens/home/home_screen.dart';
import 'package:hotels/screens/otp/otp_screen.dart';
import 'package:hotels/screens/sign_in/sign_in_screen.dart';
import 'package:hotels/screens/splash/splash_screen.dart';

import 'hotel/screens/hotel_route.dart';

class RoomAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == SplashScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SplashScreen());
    }
    if (settings.name == '/login') {
      return MaterialPageRoute(builder: (context) => SignInPage());
    }
    if (settings.name == SignInScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SignInScreen());
    }
    if (settings.name == ForgotPasswordScreen.routeName) {
      return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
    }
    if (settings.name == OtpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => OtpScreen());
    }
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    // if (settings.name==DetailsScreen.routeName) {
    //   return MaterialPageRoute(builder: (context) => DetailsScreen());
    // }
    // if (settings.name == RoomList.routeName) {
    //   return MaterialPageRoute(builder: (context) => RoomList());
    // }
    if (settings.name == AddUpdateRoom.routeName) {
      RoomArgument args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateRoom(args: args),
      );
    }
    if (settings.name == AddUpdateHotel.routeName) {
      HotelArgument args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateHotel(args: args),
      );
    }
    if (settings.name == RoomDetail.routeName) {
      Room room = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => RoomDetail(
          room: room,
        ),
      );
    }
    if (settings.name == AddEventUpdate.routeName) {
      EventArgument event = settings.arguments;

      return MaterialPageRoute(
        builder: (context) => AddEventUpdate(args: event),
      );
    }
    if (settings.name == EventDetail.routeName) {
      Event event = settings.arguments;

      return MaterialPageRoute(
          builder: (context) => EventDetail(
                event: event,
              ));
    }
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}

class RoomArgument {
  final Room room;
  final bool edit;
  RoomArgument({this.room, this.edit});
}

class EventArgument {
  final Event event;
  final bool edit;
  EventArgument({this.event, this.edit});
}

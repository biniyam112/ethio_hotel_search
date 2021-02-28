// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hotels/auth/bloc/auth_bloc.dart';
// import 'package:hotels/auth/data_provider/auth_provider.dart';
// import 'package:hotels/auth/models/auth.dart';
// import 'package:hotels/auth/repository/auth_repository.dart';
// import 'package:hotels/auth/sign_in/sign_in_page.dart';
// import 'package:http/http.dart' as http;
//
// // import 'HomePage.dart';
//
// void main() async {
//   try {
//     await GetStorage.init();
//   } catch (err) {
//     print(err);
//   }
//   runApp(
//     MyApp(),
//   );
// }
//
// //the get storage way
// class MyApp extends StatelessWidget {
//   AuthRepository authRepository = AuthRepository(
//       dataProvider: AuthDataProvider(
//     httpClient: http.Client(),
//   ));
//   AuthData a = AuthData(email: "hotel@gmail.com", password: 'password');
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AuthBloc(repository: authRepository),
//       child: MaterialApp(
//         theme: ThemeData(
//           primaryColor: Colors.purple,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: SignInPage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotels/Room/bloc/room_bloc.dart';
import 'package:hotels/Room/repository/repository.dart';
import 'package:hotels/app_route.dart';
import 'package:hotels/auth/bloc/auth_bloc.dart';
import 'package:hotels/auth/data_provider/auth_provider.dart';
import 'package:hotels/auth/repository/auth_repository.dart';
import 'package:hotels/bloc_observer.dart';
import 'package:hotels/hotel/bloc/hotel_bloc.dart';
import 'package:hotels/hotel/bloc/hotel_event.dart';
import 'package:hotels/hotel/data_provider/hotel_data.dart';
import 'package:hotels/hotel/repository/hotel_repository.dart';
import 'package:hotels/screens/splash/splash_screen.dart';
import 'package:hotels/theme.dart';
import 'package:http/http.dart' as http;

import 'Room/bloc/room_event.dart';
import 'Room/data_provider/room_data.dart';
import 'event/event.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final EventRepository eventRepository = EventRepository(
        eventDataProvider: EventDataProvider(httpClient: http.Client()));
    final AuthRepository authRepository = AuthRepository(
        dataProvider: AuthDataProvider(httpClient: http.Client()));
    final RoomRepository roomRepository = RoomRepository(
        roomProvider: RoomDataProvider(httpClient: http.Client()));
    final HotelRepository hotelRepository = HotelRepository(
        hotelProvider: HotelDataProvider(httpClient: http.Client()));
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
            create: (context) =>
                RoomBloc(roomRepository: roomRepository)..add(RoomLoad())),
        BlocProvider<HotelBloc>(
            create: (context) =>
                HotelBloc(hotelRepository: hotelRepository)..add(HotelLoad())),
        BlocProvider<EventBloc>(
            create: (context) =>
                EventBloc(eventRepository: eventRepository)..add(FetchEvent())),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(repository: authRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'e-foy hotel Search',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: RoomAppRoute.generateRoute,
      ),
    );
  }
}

import 'package:efoy_hotel_management_app/feature/book/bloc/book_bloc.dart';
import 'package:efoy_hotel_management_app/feature/book/data/dataprovider/book_dataprovider.dart';
import 'package:efoy_hotel_management_app/feature/book/data/repository/book_repository.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_bloc.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_event.dart';
import 'package:efoy_hotel_management_app/feature/event/data/dataprovider/event_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/event/data/repository/event_repository.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_bloc.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_event.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/dataprovider/hotel_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/repository/hotel_repository.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_bloc.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_event.dart';
import 'package:efoy_hotel_management_app/feature/room/data/dataprovider/room_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/room/data/repository/room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  final HotelRepository hotelRepository = HotelRepository(
    hotelDataProvider: HotelDataProvider(
      client: http.Client(),
    ),
  );
  final RoomRepository roomRepository = RoomRepository(
    roomDataProvider: RoomDataProvider(
      client: http.Client(),
    ),
  );
  final EventRepository eventRepository = EventRepository(
    eventDataProvider: EventDataProvider(
      httpClient: http.Client(),
    ),
  );
  final BookRepository bookRepository = BookRepository(
    roomBookDataProvider: BookDataProvider(
      client: http.Client(),
    ),
  );
  runApp(
    MyApp(
        eventRepository: eventRepository,
        hotelRepository: hotelRepository,
        roomRepository: roomRepository,
        bookRepository: bookRepository),
  );
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({
    Key key,
    @required this.eventRepository,
    @required this.hotelRepository,
    @required this.roomRepository,
    @required this.bookRepository,
  }) : assert(eventRepository != null &&
            hotelRepository != null &&
            bookRepository != null &&
            roomRepository != null);

  final EventRepository eventRepository;
  final HotelRepository hotelRepository;
  final RoomRepository roomRepository;
  final BookRepository bookRepository;
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = true;

  _MyAppState();
  @override
  void initState() {
    super.initState();
    checkFirstStart();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBlock(
            bookRepository: widget.bookRepository,
          ),
        ),
        BlocProvider(
          create: (context) => EventBloc(
            eventRepository: widget.eventRepository,
          )..add(FetchEvent()),
        ),
        BlocProvider(
          create: (context) => HotelBloc(
            hotelRepository: widget.hotelRepository,
          )..add(FetchHotels()),
        ),
        BlocProvider(
          create: (context) => RoomBloc(
            roomRepository: widget.roomRepository,
          )..add(FetchRoom()),
        ),
      ],
      child: MaterialApp(
        title: 'AME',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          scaffoldBackgroundColor: Color(0xffF1F2ED),
          inputDecorationTheme: inputDecorationTheme(),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 22,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          fontFamily: GoogleFonts.muli().fontFamily,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        initialRoute: firstTime ? SplashScreen.route : HomeScreen.route,
        // initialRoute: HomeScreen.route,
      ),
    );
  }

  Future<bool> checkFirstStart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('firstTime') == null) {
      preferences.setBool('firstTime', false);
      firstTime = true;
      return true;
    }
    firstTime = preferences.getBool('firstTime');
    return false;
  }
}

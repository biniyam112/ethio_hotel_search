import 'package:efoy_hotel_management_app/feature/event/bloc/events_bloc.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_state.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_bloc.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_state.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/dataprovider/hotel_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/repository/hotel_repository.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_bloc.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_app_bar.dart';
import '../../all_events/all_events.dart';
import '../../all_hotels/all_hotels.dart';
import '../../all_rooms/all_rooms.dart';
import 'event_card.dart';
import 'hotel_card.dart';
import 'room_card.dart';

import '../../../../size_config.dart';
import 'title_with_see_all.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithSeeallButton(
                  title: 'Hotels',
                  onPress: () =>
                      Navigator.pushNamed(context, AllHotelsScreen.route),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  child: BlocBuilder<HotelBloc, HotelState>(
                      builder: (_, hotelState) {
                    if (hotelState is HotelFetchingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (hotelState is HotelFetchFailedState) {
                      return Center(
                        child: Text('failed to fetch rooms'),
                      );
                    } else if (hotelState is HotelFetchedState) {
                      print(hotelState.hotels);
                      return Row(
                        children: [
                          ...List.generate(
                            hotelState.hotels.length,
                            (index) =>
                                HotelCard(hotel: hotelState.hotels[index]),
                          ),
                        ],
                      );
                    } else {
                      return null;
                    }
                  }),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithSeeallButton(
                  title: 'Rooms',
                  onPress: () =>
                      Navigator.pushNamed(context, AllRoomsScreen.route),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  child:
                      BlocBuilder<RoomBloc, RoomState>(builder: (_, roomState) {
                    if (roomState is RoomFetchingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (roomState is RoomFetchFailedState) {
                      return Center(
                        child: Text('failed to fetch rooms'),
                      );
                    } else if (roomState is RoomFetchedState) {
                      return Row(
                        children: [
                          ...List.generate(
                            roomState.rooms.length,
                            (index) {
                              return RoomCard(
                                room: roomState.rooms[index],
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return null;
                    }
                  }),
                ),
              ],
            ),
            Column(
              children: [
                TitleWithSeeallButton(
                  title: 'Events',
                  onPress: () =>
                      Navigator.pushNamed(context, AllEventsScreen.route),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  child: BlocBuilder<EventBloc, EventState>(
                    builder: (_, eventState) {
                      if (eventState is FetchEventingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (eventState is FetchEventFailedState) {
                        return Center(
                          child: Text('Unable to fetch data at the moment'),
                        );
                      } else if (eventState is FetchEventedState) {
                        print(
                            'the event title is : ${eventState.events[0].name}');
                        return Row(
                          children: [
                            ...List.generate(
                              eventState.events.length,
                              (index) =>
                                  EventCard(event: eventState.events[index]),
                            ),
                          ],
                        );
                      } else
                        return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

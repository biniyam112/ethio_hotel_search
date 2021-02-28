import 'package:efoy_hotel_management_app/feature/event/bloc/events_bloc.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/grid_event_card.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
        verticalSpacing(of: 20),
        BlocBuilder<EventBloc, EventState>(builder: (context, eventState) {
          if (eventState is FetchEventedState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20),
                horizontal: getProportionateScreenHeight(12),
              ),
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: eventState.events.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: getProportionateScreenWidth(10),
                  crossAxisSpacing: getProportionateScreenWidth(10),
                ),
                itemBuilder: (context, index) {
                  return EventCard(
                    event: eventState.events[index],
                  );
                },
              ),
            );
          }
          return null;
        }),
      ],
    );
  }
}

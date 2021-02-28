import 'package:efoy_hotel_management_app/feature/room/bloc/room_bloc.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/grid_room_card.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
        verticalSpacing(of: 20),
        BlocBuilder<RoomBloc, RoomState>(
          builder: (context, roomState) {
            if (roomState is RoomFetchedState) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenHeight(12),
                ),
                child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: roomState.rooms.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: getProportionateScreenWidth(10),
                    crossAxisSpacing: getProportionateScreenWidth(10),
                  ),
                  itemBuilder: (context, index) {
                    return RoomCard(
                      room: roomState.rooms[index],
                    );
                  },
                ),
              );
            }
            return null;
          },
        ),
      ],
    );
  }
}

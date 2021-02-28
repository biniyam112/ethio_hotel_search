import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/Room/bloc/room_bloc.dart';
import 'package:hotels/Room/bloc/room_state.dart';
import 'package:hotels/components/room_card.dart';
import 'package:hotels/models/Product.dart';
import 'package:hotels/screens/home/components/section_title1.dart';

import '../../../size_config.dart';


class RoomBar extends StatelessWidget {
  // List<Roo>
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle1(title: "Our Rooms"),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        
        SingleChildScrollView(
        child:BlocBuilder<RoomBloc, RoomState>(
        builder: (_, state) {
          if (state is RoomOperationFailure) {
            return Text('Could not do Room operation');
          }
          if (state is RoomLoadSuccess) {
            final rooms = state.rooms;
            return 
                Row(
                  children: [
                    ...List.generate(rooms.length, (index) {
                      if (rooms[index].description!=null)
                        return RoomCard(room: rooms[index]);
                        
                        return SizedBox
                      .shrink();
                    })
                  ],
                );
          }
          return CircularProgressIndicator();
        },
      ),
          scrollDirection: Axis.horizontal,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/Room/screens/room_add_update.dart';
import 'package:hotels/app_route.dart';

import '../../../app_route.dart';
import '../../../size_config.dart';

class SectionTitle1 extends StatelessWidget {
  const SectionTitle1({
    Key key,
    @required this.title,
    // @required this.press,
  }) : super(key: key);

  final String title;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap:() {
            print('Adding Room');
             Navigator.pushNamed(context,
            AddUpdateRoom.routeName,
            arguments: RoomArgument(edit: false, room: Room()));
          },
          child: Text(
            "Add Room",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}

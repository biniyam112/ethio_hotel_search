import 'package:flutter/material.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/Room/screens/room_add_update.dart';
import 'package:hotels/app_route.dart';
import 'package:hotels/event/event.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

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
           Navigator.of(context).pushNamed(AddEventUpdate.routeName,
                arguments: EventArgument(edit: false, event: Event()));
          },
          child: Text(
            "Add Event",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotels/screens/home/home_screen.dart';
import 'package:hotels/size_config.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SizedBox(
          // top: false,
          height: getProportionateScreenHeight(78),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              Column(
                
                children: [
                  IconButton(
                    icon: Icon(Icons.home_outlined,color: kPrimaryColor,),
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
                  Text("Home")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.roofing,color: kPrimaryColor,),
                    onPressed: () {
                      // Navigator.pushNamed(context, RoomList.routeName);
                    },
                  ),
                  Text("Rooms")
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.event,color: kPrimaryColor,),
                    onPressed: () {
                      // Navigator.pushNamed(context, EventList.routeName);
                    },
                  ),
                        Text("Events")

                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.person_outline,color: kPrimaryColor,),
                    onPressed: null,
                    // onPressed: () =>
                    //     Navigator.pushNamed(context, ProfileScreen.routeName),
                  ),
                                    Text("Profile")

                ],
              ),
            ],
          )),
    );
  }
}

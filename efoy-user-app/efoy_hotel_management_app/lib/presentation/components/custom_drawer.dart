import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../size_config.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: SizeConfig.screenWidth * .8,
        decoration: BoxDecoration(
          color: Color(0xffF5F6FD),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                ),
                child: DrawerTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/images/dj_ebo.jpg',
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  title: 'User details',
                  subtitle: FirebaseAuth.instance.currentUser.phoneNumber ??
                      'no logged in user',
                ),
              ),
              DrawerTile(
                title: 'Hotels',
                subtitle: 'choose form hotels',
                leading: Icon(
                  Icons.room,
                  color: textLightColor.withOpacity(.6),
                ),
              ),
              DrawerTile(
                title: 'Rooms',
                subtitle: 'book here and now',
                leading: Icon(
                  Icons.hotel,
                  color: textLightColor.withOpacity(.6),
                ),
              ),
              DrawerTile(
                title: 'Events',
                subtitle: 'find out about events',
                leading: Icon(
                  Icons.event,
                  color: textLightColor.withOpacity(.6),
                ),
              ),
              DrawerTile(
                title: 'Favorite',
                subtitle: 'see your favorite places',
                leading: Icon(
                  Icons.favorite_outline,
                  color: textLightColor.withOpacity(.6),
                ),
              ),
              DrawerTile(
                title: 'Discount',
                subtitle: 'huge discounts of today',
                leading: Icon(
                  Icons.money_off,
                  color: textLightColor.withOpacity(.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key key,
      @required this.title,
      this.subtitle,
      this.onpress,
      this.leading})
      : super(key: key);
  final String title, subtitle;
  final GestureTapCallback onpress;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Ink(
          child: InkWell(
            onTap: onpress,
            splashColor: textLightColor.withOpacity(.4),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: leading,
                    ),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: textDarkColor.withOpacity(.8),
                            fontSize: getProportionateScreenWidth(16),
                            fontFamily: GoogleFonts.raleway().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpacing(of: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: textLightColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(12)),
                Divider(
                  color: textLightColor.withOpacity(.1),
                  thickness: .8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

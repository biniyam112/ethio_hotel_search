import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotels/screens/adminScreen/delete_hotels/delete_hotel.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'addHotel/add_hotel.dart';
import 'components/body.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key key}) : super(key: key);
  static String routeName = '/admin_screen';

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 28,
            color: Colors.white,
          ),
        ),
        title: Text(
          'EFOY admin',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      drawer: AdminAppDrawer(),
      body: Body(),
    );
  }
}

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({
    Key key,
    this.title,
    this.subtitle,
    this.onPress,
  }) : super(key: key);
  final String title, subtitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth / 1.4,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerTile(
                title: 'Add hotels',
                subtitle: 'Click here to add more hotels',
                icon: Icons.add_location_alt_rounded,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddHotelsScreen();
                      },
                    ),
                  );
                },
              ),
              DrawerTile(
                title: 'Delete hotels',
                subtitle: 'Click here to delete hotels',
                icon: Icons.delete,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DeleteHotelScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.onPress,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final GestureTapCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: textLightColor.withOpacity(.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 30,
              color: kPrimaryColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(8),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textDarkColor.withOpacity(.8),
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(8),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textLightColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

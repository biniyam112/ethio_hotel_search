import 'package:efoy_hotel_management_app/feature/room/bloc/room_bloc.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_state.dart';
import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/grid_room_card.dart';
import '../../../../size_config.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  Body({Key key, this.room}) : super(key: key);
  final Room room;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight / 2.4,
              width: SizeConfig.screenWidth,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: 4,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        // 'http://10.0.2.2:3000/${widget.room.imagePath[index]}',
                        'assets/images/bed_room_${index + 1}.jpg',
                        height: SizeConfig.screenHeight * (3 / 7),
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.all(3.0),
                                child: AnimatedContainer(
                                  duration: animationDuration * 2,
                                  height: 8,
                                  width: currentPage == index ? 22 : 8,
                                  decoration: BoxDecoration(
                                    color: currentPage == index
                                        ? primaryColor
                                        : Colors.white60,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(of: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 30,
                      ),
                      Text(
                        // widget.room.hotel.location,
                        'Addis Ababa',
                        style: TextStyle(
                          color: textLightColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFFffb300),
                        size: 30,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${widget.room.rating ?? 4}',
                        style: TextStyle(
                          fontSize: 18,
                          color: textLightColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpacing(of: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      color: textDarkColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  verticalSpacing(of: 10),
                  Text(
                    widget.room.description,
                    style: TextStyle(
                      color: textLightColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(of: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wifi, color: textDarkColor),
                      Text('wi-fi'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.bathtub, color: textDarkColor),
                      Text('hot bath'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.tv, color: textDarkColor),
                      Text('TV'),
                    ],
                  ),
                ],
              ),
            ),
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
        ),
      ),
    );
  }
}

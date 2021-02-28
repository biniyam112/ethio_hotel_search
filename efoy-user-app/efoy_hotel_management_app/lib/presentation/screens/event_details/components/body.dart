import 'package:efoy_hotel_management_app/feature/event/bloc/events_bloc.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_state.dart';
import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../components/grid_event_card.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.event}) : super(key: key);
  final Event event;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  bool isfavorite = false;
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
                      return Image.network(
                        'http://10.0.2.2:3000/${widget.event.images[0]}',
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * (3 / 7),
                        fit: BoxFit.fill,
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
                            isfavorite
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              isfavorite = !isfavorite;
                            });
                          },
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Addis ababa',
                        style: TextStyle(
                          color: textLightColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'party',
                    style: TextStyle(
                      color: textLightColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(of: 16),
            Container(
              width: SizeConfig.screenWidth,
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
                    widget.event.description,
                    style: TextStyle(
                      color: textLightColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(of: 12),
            BlocBuilder<EventBloc, EventState>(
              builder: (context, eventState) {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/event/event.dart';
import 'package:hotels/event/screens/event_detail.dart';
import 'package:hotels/screens/home/components/section_title.dart';
import 'package:hotels/size_config.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, eventState) {
        if (eventState is EventFetchFailure) {
          return Text('Could not do Hotel operation');
        }
        // if (eventState is EventFetchedSuccess) {
        //   print(eventState.events);
        // }
        if (eventState is EventFetchedSuccess) {
          print("******success on fetching");
          print(eventState.events);
          final events = eventState.events;
          return Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                title: "Events in our Hotel",
                press: () {},
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(events.length, (index) {
                    if (events[index].name != null)
                      // return ProductCard(product: demoProducts[index]);
                      return EventListCard(
                        name: events[index].name,
                        description: events[index].description,
                        image: events[index].imagepath[0].path,
                        press: () {
                          Navigator.of(context).pushNamed(EventDetail.routeName,
                              arguments: events[index]);
                        },
                      );

                    return SizedBox.shrink();
                  }),
                ],
              ),
            )
          ]);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class EventListCard extends StatelessWidget {
  const EventListCard({
    Key key,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.press,
  }) : super(key: key);

  final String name, image;
  final String description;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  'http://10.0.2.2:3000/$image',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$name\n",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700]),
                        ),
                        TextSpan(
                            text: "$description ",
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

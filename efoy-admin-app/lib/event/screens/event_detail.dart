import 'package:hotels/app_route.dart';
import 'package:hotels/event/event.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/models.dart';
import 'package:hotels/hotel/screens/hotel_list.dart';
import 'package:hotels/hotel/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/screens/home/home_screen.dart';
import 'package:hotels/size_config.dart';

class EventDetail extends StatelessWidget {
  static const routeName = "eventDetail";
  final Event event;

  EventDetail({@required this.event}) : assert(event != null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${this.event.name}",
          style: TextStyle(fontSize: 25, color: Colors.orange[700]),
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            "${this.event.name}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
          Image.network(
            "http://localhost:3000${this.event.imagepath[0].path}",
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${this.event.description}",
                style: TextStyle(fontSize: 25),
              ),
              // Row(
              //   children: [
              //     Text("${this.event.stars}"),
              //     Icon(Icons.star_outlined)
              //   ],
              // )
            ],
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<EventBloc>(context)
                        .add(DeleteEvent(event: this.event));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                  child: Text('Delete'),
                  color: Colors.red,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddEventUpdate.routeName,
                        arguments:
                            EventArgument(event: this.event, edit: true));
                  },
                  child: Text('Edit'),
                  color: Colors.grey,
                )
              ]))
        ],
      ),
    );
  }
}

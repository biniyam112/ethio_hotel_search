import 'package:hotels/Room/bloc/bloc.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/Room/screens/room_add_update.dart';
import 'package:hotels/app_route.dart';
import 'package:hotels/components/default_button.dart';
import 'package:hotels/constants.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/models.dart';
import 'package:hotels/hotel/screens/hotel_list.dart';
import 'package:hotels/hotel/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/size_config.dart';

class RoomDetail extends StatelessWidget {
  static const routeName = "/roomDetail";
  final Room room;

  RoomDetail({@required this.room});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Detail"),
        actions: [
          Row(
            children: [
              Text("Edit"),
               IconButton(
              icon: Icon(Icons.edit),
              onPressed: null,
              // onPressed: () => Navigator.of(context).pushNamed(
              //     AddUpdateRoom.routeName,
              //     arguments: RoomArgument(room: this.room, edit: true),
              //     ),
                  ),
            ],
          ),
          SizedBox(width: 32),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<RoomBloc>(context).add(RoomDelete(this.room));
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HotelList.routeName, (route) => false);
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/room.jpg'),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "This room is ${this.room.description}",
                  style: TextStyle(fontSize: 30),
                ),
                Text("Number of bed room : ${this.room.numberOfBedrooms}",
                            style: TextStyle(fontSize: 24, color: kPrimaryColor),),
                Text("Price Per Night ${this.room.pricePerNight} ETB",
                      style: TextStyle(fontSize: 24,color: Colors.purple),)
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(145),
          ),
           Center(
             child: DefaultButton(
                        text: "Home",
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
           ),
        ],
      ),
    );
  }
}

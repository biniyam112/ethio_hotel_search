import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/models.dart';
import 'package:hotels/hotel/screens/hotel_list.dart';
import 'package:hotels/hotel/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelDetail extends StatelessWidget {
  static const routeName = "hotelDetail";
  final Hotel hotel;

  HotelDetail({@required this.hotel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.hotel.name}"),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pushNamed(
                  AddUpdateHotel.routeName,
                  arguments: HotelArgument(hotel: this.hotel, edit: true))),
          SizedBox(width: 32),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<HotelBloc>(context).add(HotelDelete(this.hotel));
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HotelList.routeName, (route) => false);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            "${this.hotel.name}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
          Image.network(
            "http://localhost:3000/${hotel.imagePath}",
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${this.hotel.description}"),
              Row(
                children: [
                  Text("${this.hotel.stars}"),
                  Icon(Icons.star_outlined)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

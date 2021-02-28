import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/models.dart';
import 'package:hotels/hotel/screens/hotel_add_update.dart';
import 'package:hotels/hotel/screens/hotel_detail.dart';
import 'package:hotels/hotel/screens/hotel_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Hotels"),
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (_, state) {
          if (state is HotelOperationFailure) {
            return Text('Could not do Hotel operation');
          }
          if (state is HotelLoadSuccess) {
            final hotels = state.hotels;

            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (_, index) => ListTile(
                leading: Image.network(
                    "http://localhost:3000/${hotels[index].imagePath}"),
                title: Text("${hotels[index].name}"),
                subtitle: Text("${hotels[index].location}"),
                onTap: () => Navigator.of(context)
                    .pushNamed(HotelDetail.routeName, arguments: hotels[index]),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
            AddUpdateHotel.routeName,
            arguments: HotelArgument(edit: false, hotel: Hotel())),
      ),
    );
  }
}

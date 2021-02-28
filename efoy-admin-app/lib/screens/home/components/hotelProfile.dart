import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/hotel.dart';
import 'package:hotels/hotel/screens/hotel_add_update.dart';
import 'package:hotels/hotel/screens/hotel_route.dart';

import '../../../size_config.dart';

class HotelProfile extends StatelessWidget {
  
  const HotelProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
        builder: (_, state) {
          if (state is HotelOperationFailure) {
            return Text('Could not do Room operation');
          }
          if (state is SingleHotelLoadSuccess) {
            final hotel = state.hotel;
            return GestureDetector(
      onTap: () {
            print('Hotel Edit profile');
             Navigator.pushNamed(context,
            AddUpdateHotel.routeName,
            arguments: HotelArgument(edit: true, hotel: hotel),);
          },
          child: Container(
        // height: 90,
        width: double.infinity,
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(15),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text.rich(
          TextSpan(
            style: TextStyle(color: Colors.white),
            children: [
              TextSpan(text: "${hotel.name} \n"),
              TextSpan(
                text: "${hotel.description}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );      
          }
          return CircularProgressIndicator();
        },
      );
  }
}

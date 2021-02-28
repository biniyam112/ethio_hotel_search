import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/constants.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/bloc/hotel_bloc.dart';
import 'package:hotels/hotel/bloc/hotel_state.dart';

import '../../../size_config.dart';
import 'grid_hotel_card.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              Container(
                height: getProportionateScreenHeight(120),
                width: SizeConfig.screenWidth - getProportionateScreenWidth(20),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(16)),
                    Text(
                      'Welcome to efoy admin screen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'here you can add hotels ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HotelBloc, HotelState>(
                builder: (context, hotelstate) {
                  print(hotelstate.runtimeType.toString());
                  if (hotelstate is HotelLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (hotelstate is HotelLoadSuccess) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20),
                        horizontal: getProportionateScreenHeight(12),
                      ),
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: hotelstate.hotels.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: getProportionateScreenWidth(10),
                          crossAxisSpacing: getProportionateScreenWidth(10),
                        ),
                        itemBuilder: (context, index) {
                          return HotelCard(
                            hotel: hotelstate.hotels[index],
                          );
                        },
                      ),
                    );
                  }
                  if (hotelstate is HotelOperationFailure) {
                    return Center(
                      child: Text('Failed to fetch hotel data'),
                    );
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

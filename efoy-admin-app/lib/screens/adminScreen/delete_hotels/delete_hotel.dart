import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/bloc/hotel_bloc.dart';
import 'package:hotels/hotel/bloc/hotel_state.dart';
import 'package:hotels/screens/adminScreen/components/grid_hotel_card.dart';

import '../../../size_config.dart';

class DeleteHotelScreen extends StatelessWidget {
  const DeleteHotelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: getProportionateScreenWidth(10),
                            crossAxisSpacing: getProportionateScreenWidth(10),
                          ),
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(hotelstate.hotels[index].id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                BlocProvider.of<HotelBloc>(context)
                                    .add(HotelDelete(hotelstate.hotels[index]));
                                BlocProvider.of<HotelBloc>(context)
                                    .add(HotelLoad());
                              },
                              child: HotelCard(
                                hotel: hotelstate.hotels[index],
                              ),
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
      ),
    );
  }
}

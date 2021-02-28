import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_bloc.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/grid_hotel_card.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
        verticalSpacing(of: 20),
        BlocBuilder<HotelBloc, HotelState>(
          builder: (context, hotelState) {
            if (hotelState is HotelFetchedState) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenHeight(12),
                ),
                child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: hotelState.hotels.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: getProportionateScreenWidth(10),
                    crossAxisSpacing: getProportionateScreenWidth(10),
                  ),
                  itemBuilder: (context, index) {
                    return HotelCard(
                      hotel: hotelState.hotels[index],
                    );
                  },
                ),
              );
            }
            if (hotelState is HotelFetchingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return null;
          },
        ),
      ],
    );
  }
}

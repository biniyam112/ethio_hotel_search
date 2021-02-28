import 'package:efoy_hotel_management_app/feature/book/bloc/book_bloc.dart';
import 'package:efoy_hotel_management_app/feature/book/bloc/book_event.dart';
import 'package:efoy_hotel_management_app/feature/book/bloc/book_state.dart';
import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:efoy_hotel_management_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookButton extends StatelessWidget {
  const BookButton({
    Key key,
    @required this.room,
  }) : super(key: key);
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Ink(
        decoration: BoxDecoration(
          color: Color(0xF200C853),
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          splashColor: Color(0xFF01A343),
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            BlocProvider.of<BookBlock>(context).add(
              BookRoomEvent(
                room: room,
                phone: FirebaseAuth.instance.currentUser.phoneNumber,
              ),
            );
            print('out side the book bloc builder');
            _showMyDialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xF200C853),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                'Book Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight / 3.5,
              horizontal: SizeConfig.screenWidth / 6),
          child: AlertDialog(
            elevation: 4,
            title: Center(child: Text('Booking progress')),
            content: BlocBuilder<BookBlock, BookState>(
              builder: (context, bookstate) {
                if (bookstate is BookingProcessingState) {
                  print('booking in progress time to show dialogue');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (bookstate is BookingFailedState) {
                  print('booking failed time to show dialogue');
                  return Center(
                    child: Text('Booking failed'),
                  );
                }
                if (bookstate is BookingSuccessState) {
                  print('booking worked time to show dialogue');
                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        Text('Booking Completed'),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
            buttonPadding: EdgeInsets.all(10),
            actions: <Widget>[
              TextButton(
                child: Text('dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

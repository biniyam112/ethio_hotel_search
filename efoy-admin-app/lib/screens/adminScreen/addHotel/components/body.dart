import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/models.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);

  final Map<String, dynamic> _hotel = {};
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _hotel['images'] = [File(pickedFile.path)];
    } else {
      print('No image selected.');
    }
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
            content: BlocBuilder<HotelBloc, HotelState>(
              builder: (context, hotelstate) {
                if (hotelstate is HotelAddingState) {
                  print('booking in progress time to show dialogue');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (hotelstate is HotelAddFailedState) {
                  print('booking failed time to show dialogue');
                  return Center(
                    child: Text('Booking failed'),
                  );
                }
                if (hotelstate is HotelAddedState) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(30)),
                child: Text(
                  'ADD FEILDS TO ADD HOTEL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textLightColor,
                  ),
                ),
              ),
              TextInputField(
                fieldLabel: 'name',
                textchanged: (input) {
                  _hotel['name'] = input;
                },
              ),
              verticalSpacing(of: 20),
              TextInputField(
                fieldLabel: 'location',
                textchanged: (input) {
                  _hotel['location'] = input;
                },
              ),
              verticalSpacing(of: 20),
              TextInputField(
                fieldLabel: 'rating',
                textchanged: (input) {
                  _hotel['rating'] = input;
                },
              ),
              verticalSpacing(of: 20),
              TextInputField(
                fieldLabel: 'description',
                textchanged: (input) {
                  _hotel['description'] = input;
                },
              ),
              verticalSpacing(of: 20),
              TextInputField(
                fieldLabel: 'email',
                textchanged: (input) {
                  _hotel['email'] = input;
                },
              ),
              verticalSpacing(of: 20),
              TextInputField(
                fieldLabel: 'password',
                textchanged: (input) {
                  _hotel['password'] = input;
                },
              ),
              verticalSpacing(of: 20),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.file_copy),
                      SizedBox(width: 10),
                      Text(
                        "get image",
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpacing(of: 20),
              _hotel['images'] == null
                  ? Center(
                      child: Text(
                        'select image',
                        style: TextStyle(
                          color: textLightColor,
                          fontSize: 20,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    )
                  : Image.file(
                      _hotel['images'][0],
                    ),
              verticalSpacing(of: 20),
              GestureDetector(
                onTap: () {
                  _showMyDialog(context);
                  print(_hotel);
                  BlocProvider.of<HotelBloc>(context).add(
                    HotelCreate(
                      hotel: Hotel(
                        name: _hotel['name'],
                        description: _hotel['description'],
                        location: _hotel['location'],
                        stars: _hotel['rating'],
                        images: _hotel['images'],
                      ),
                      email: _hotel['email'],
                      password: _hotel['password'],
                    ),
                  );
                },
                child: Container(
                  width:
                      SizeConfig.screenWidth - getProportionateScreenWidth(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(20),
                    ),
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(40),
                        vertical: getProportionateScreenHeight(24),
                      ),
                      child: Text(
                        'Add hotel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpacing(of: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key key, @required this.fieldLabel, @required this.textchanged})
      : super(key: key);
  final String fieldLabel;

  final Function(String text) textchanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      width: SizeConfig.screenWidth - getProportionateScreenWidth(100),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => textchanged(value),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: fieldLabel,
          labelStyle: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

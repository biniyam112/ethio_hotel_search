import 'dart:io';

import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/models/hotel.dart';
import 'package:hotels/hotel/screens/hotel_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateHotel extends StatefulWidget {
  final HotelArgument args;
  static const routeName = 'hotelAddUpdate';
  AddUpdateHotel({this.args});

  @override
  _AddUpdateHotelState createState() => _AddUpdateHotelState();
}

class _AddUpdateHotelState extends State<AddUpdateHotel> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _hotels = {};
  File _imageFile;

  _onImageButtonPressed() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    print(image);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Hotel" : "Add Hotel"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.hotel.name : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Hotel name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Hotel Name'),
                    onSaved: (value) {
                      setState(() {
                        this._hotels["name"] = value;
                      });
                    }),
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.hotel.description : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter hotel description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Hotel description'),
                    onSaved: (value) {
                      this._hotels["description"] = value;
                    }),
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.hotel.location : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter hotel location';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Hotel Location'),
                    onSaved: (value) {
                      setState(() {
                        this._hotels["location"] = value;
                      });
                    }),
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.hotel.stars : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter hotel stars';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Hotel Stars'),
                    onSaved: (value) {
                      setState(() {
                        this._hotels["stars"] = value;
                      });
                    }),
                RaisedButton(
                    onPressed: () async {
                      await _onImageButtonPressed();
                      // Navigator.of(context).pop();
                      print("======printing image file");
                      print(_imageFile);
                      this._hotels["images"] = [_imageFile];
                    },
                    child: Text("Choose image")),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        final HotelEvent hotelEvent = widget.args.edit
                            ? HotelUpdate(Hotel(
                                id: widget.args.hotel.id,
                                imagePath: "",
                                name: _hotels["name"],
                                location: _hotels["location"],
                                description: _hotels["description"],
                                stars: _hotels["stars"],
                                images: _hotels["images"],
                              ))
                            : HotelCreate(
                                hotel: Hotel(
                                id: widget.args.hotel.id,
                                imagePath: "",
                                name: _hotels["name"],
                                location: _hotels["location"],
                                description: _hotels["description"],
                                stars: _hotels["stars"],
                                images: _hotels["images"],
                              ));
                        BlocProvider.of<HotelBloc>(context).add(hotelEvent);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save"),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

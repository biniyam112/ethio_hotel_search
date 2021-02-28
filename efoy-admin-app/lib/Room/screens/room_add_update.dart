import 'dart:io';

import 'package:hotels/Room/bloc/bloc.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:hotels/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/size_config.dart';

class AddUpdateRoom extends StatefulWidget {
  final RoomArgument args;
   static const routeName = '/roomAddUpdate';
  AddUpdateRoom({this.args});

  @override
  _AddUpdateRoomState createState() => _AddUpdateRoomState();
}   

class _AddUpdateRoomState extends State<AddUpdateRoom> {
 
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _rooms = {};
  // File _imageFile;

  // _onImageButtonPressed() async {
  //   // ignore: deprecated_member_use
  //   File image = await ImagePicker.pickImage(
  //         source: ImageSource.gallery, imageQuality: 50);
  //         print(image);
  //   setState(()  {
      
  //     _imageFile=image;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Room" : "Add Room"}'),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                 SizedBox(height: getProportionateScreenHeight(15),),
                  TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.room.description : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'description'),
                      onSaved: (value) {
                        setState(() {
                          this._rooms["description"] = value;
                        });
                      }),
                      SizedBox(height: getProportionateScreenHeight(15),),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue:
                          widget.args.edit ? widget.args.room.pricePerNight.toString() : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter room pricePerNight';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                      
                        labelText: 'Room PricePerNight'),
                      onSaved: (value) {
                        this._rooms["pricePerNight"] = value;
                      }),
                  SizedBox(height: getProportionateScreenHeight(15),),

                  TextFormField(
                    keyboardType: TextInputType.number,
                      initialValue:
                          widget.args.edit ? widget.args.room.count.toString() : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter number of rooms';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Number of rooms'),
                      onSaved: (value) {
                        setState(() {
                          this._rooms["count"] = value;
                        });
                      }),
                                          SizedBox(height: getProportionateScreenHeight(15),),

                  TextFormField(
                    keyboardType: TextInputType.number,
                      initialValue:
                          widget.args.edit ? widget.args.room.numberOfBedrooms.toString(): '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter numberOfBedrooms';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Number of bed rooms'),
                      onSaved: (value) {
                        setState(() {
                          this._rooms["numberOfBedrooms"] = value;
                        });
                      }),
                  // RaisedButton(
                  //     onPressed: () async {
                  //       await _onImageButtonPressed();
                  //       // Navigator.of(context).pop();
                  //       print("======printing image file");
                  //       print(_imageFile);
                  //       this._hotels["images"]=[_imageFile];
                  //     },
                  //     child: Text("Choose image")),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          final RoomEvent roomEvent = widget.args.edit
                              ? RoomUpdate(Room(
                                  id: widget.args.room.id,
                                  description: _rooms["description"],
                                  pricePerNight: int.parse(_rooms["pricePerNight"]),
                                  count: int.parse(_rooms["count"]),
                                  numberOfBedrooms:int.parse(_rooms["numberOfBedrooms"]),
                                  hotel: '602bab9f355bef35ec49e648'
                                ))
                              : RoomCreate(Room(
                                  description: _rooms["description"],
                                  pricePerNight: int.parse(_rooms["pricePerNight"]),
                                  count: int.parse(_rooms["count"]),
                                  numberOfBedrooms:int.parse(_rooms["numberOfBedrooms"]),
                                  hotel: '602bab9f355bef35ec49e648'
                                ));
                          BlocProvider.of<RoomBloc>(context).add(roomEvent);
                          Navigator.pop(context);
                        }
                      },
                      
                      icon: Icon(Icons.save),
                      label: Text("SAVE",style: TextStyle(fontSize: getProportionateScreenHeight(24)),),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

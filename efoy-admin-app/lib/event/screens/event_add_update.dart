import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/app_route.dart';
import 'package:hotels/event/event.dart';
import 'package:hotels/size_config.dart';
import 'package:image_picker/image_picker.dart';

class AddEventUpdate extends StatefulWidget {
  final EventArgument args;
  static const routeName = 'eventAddUpdate';
  AddEventUpdate({this.args});

  @override
  _AddEventUpdateState createState() => _AddEventUpdateState();
}

class _AddEventUpdateState extends State<AddEventUpdate> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _event = {};
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

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _event['images'] = [File(pickedFile.path)];
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit event" : "Add event"}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.event.name : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Title'),
                      onSaved: (value) {
                        setState(() {
                          this._event["name"] = value;
                        });
                      }),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.event.description : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter event description';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'event description'),
                      onSaved: (value) {
                        this._event["description"] = value;
                      }),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 60,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.orange[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.file_copy,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "get image",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          final EventsEvent eventEvent = widget.args.edit
                              ? EditEvent(
                                  event: Event(
                                  id: widget.args.event.id,
                                  description: _event["description"],
                                  name: _event["name"],
                                  imagepath: _event['images'],
                                ))
                              : CreateEvent(
                                  event: Event(
                                  id: widget.args.event.id,
                                  description: _event["description"],
                                  name: _event["name"],
                                  imagepath: _event['images'],
                                ));
                          BlocProvider.of<EventBloc>(context).add(eventEvent);
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
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Hotel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final String location;
  final List<dynamic> images;
  final int stars;
  Hotel(
      {this.id,
      @required this.name,
      this.imagePath,
      @required this.description,
      @required this.location,
      @required this.stars,
      this.images});

  @override
  List<Object> get props => [id, name, description, location, stars, images];

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      stars: json['stars'],
      images: json['images'],
      // imagePath: json['images'],
    );
  }

  @override
  String toString() => "Hotel($id,$name,$description,$location,$stars,$images)";
}

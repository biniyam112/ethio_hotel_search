import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Room extends Equatable {
  final String id;
  final bool status;
  final int pricePerNight;
  final int numberOfBedrooms;
  final String description;
  final int count;
  // final bool onDiscount;
  // final double discountPercent;
  final String hotel;
  Room({
  this.id,
  this.status,
  this.pricePerNight,
  this.numberOfBedrooms,
  this.description,
  this.count,
  // this.onDiscount,
  // this.discountPercent,
  this.hotel,
  });
  @override
  List<Object> get props => [id, status, description, pricePerNight, numberOfBedrooms,
   count,hotel];

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id:json['_id'],
      status:json['status'],
      pricePerNight:json['pricePerNight'],
      numberOfBedrooms:json['numberOfBedrooms'],
      description:json['description'],
      count:json['count'],
      // onDiscount:json['onDiscount'],
      // discountPercent:json['discountPercent'],
      // hotel:json['hotel'],
    );
  }

  // @override
  // String toString() => "Room($id,$name,$description,$location,$stars,$images)";
}

import 'package:efoy_hotel_management_app/feature/book/data/dataprovider/book_dataprovider.dart';
import 'package:efoy_hotel_management_app/feature/room/data/dataprovider/room_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';

class BookRepository {
  final BookDataProvider roomBookDataProvider;

  BookRepository({@required this.roomBookDataProvider})
      : assert(roomBookDataProvider != null);

  Future<void> bookRoom(Room room, String phone) async {
    await roomBookDataProvider.bookHotel(room, phone);
  }
}

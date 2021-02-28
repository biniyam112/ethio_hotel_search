import 'package:equatable/equatable.dart';
import 'package:hotels/hotel/models/hotel.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();
  @override
  List<Object> get props => [];
}

class HotelLoad extends HotelEvent {
  const HotelLoad();
}

class HotelCreate extends HotelEvent {
  final Hotel hotel;
  final String email, password;
  const HotelCreate({this.hotel, this.email, this.password});

  @override
  List<Object> get props => [hotel];

  @override
  String toString() {
    return "hotel created {hotel:$hotel}";
  }
}

class HotelUpdate extends HotelEvent {
  final Hotel hotel;
  const HotelUpdate(this.hotel);

  @override
  List<Object> get props => [hotel];

  @override
  String toString() {
    return "hotel updated {hotel:$hotel}";
  }
}

class HotelDelete extends HotelEvent {
  final Hotel hotel;
  const HotelDelete(this.hotel);

  @override
  List<Object> get props => [hotel];

  @override
  String toString() {
    return "Hotel deleted {hotel:$hotel}";
  }
}

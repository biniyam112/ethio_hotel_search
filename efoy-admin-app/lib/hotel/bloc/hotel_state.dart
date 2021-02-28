import 'package:equatable/equatable.dart';
import 'package:hotels/hotel/models/hotel.dart';
import 'package:meta/meta.dart';

abstract class HotelState extends Equatable {
  const HotelState();
  @override
  List<Object> get props => [];
}

class HotelLoading extends HotelState {}

class HotelLoadSuccess extends HotelState {
  final List<Hotel> hotels;
  HotelLoadSuccess({@required this.hotels}) : assert(hotels != null);
  @override
  List<Object> get props => [this.hotels];
}

class HotelDeletedState extends HotelState {}

class HotelDeletingState extends HotelState {}

class HotelDeleteFailedState extends HotelState {}

class HotelAddedState extends HotelState {}

class HotelAddFailedState extends HotelState {}

class HotelAddingState extends HotelState {}

class HotelOperationFailure extends HotelState {}

class SingleHotelLoadSuccess extends HotelState {
  final Hotel hotel;
  SingleHotelLoadSuccess({@required this.hotel}) : assert(hotel != null);
  @override
  List<Object> get props => [this.hotel];
}

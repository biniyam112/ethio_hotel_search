import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class BookState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookingSuccessState extends BookState {}

class BookingProcessingState extends BookState {}

class BookingFailedState extends BookState {}

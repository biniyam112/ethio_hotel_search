import 'package:efoy_hotel_management_app/feature/book/bloc/book_event.dart';
import 'package:efoy_hotel_management_app/feature/book/bloc/book_state.dart';
import 'package:efoy_hotel_management_app/feature/book/data/repository/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBlock extends Bloc<BookEvent, BookState> {
  BookBlock({
    BookingProcessingState bookingProcessingState,
    this.bookRepository,
  })  : assert(bookRepository != null),
        super(bookingProcessingState);
  final BookRepository bookRepository;

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is BookRoomEvent) {
      yield BookingProcessingState();
      try {
        await bookRepository.bookRoom(event.room, event.phone);
        yield BookingSuccessState();
      } catch (e) {
        yield BookingFailedState();
        print('booking exception $e');
      }
    }
  }
}

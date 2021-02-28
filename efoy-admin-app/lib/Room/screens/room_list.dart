// import 'package:hotels/Room/models/room.dart';
// import 'package:hotels/Room/bloc/bloc.dart';
// import 'package:hotels/Room/models/models.dart';
// import 'package:hotels/Room/screens/room_add_update.dart';
// import 'package:hotels/Room/screens/room_detail.dart';
// import 'package:hotels/app_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RoomList extends StatelessWidget {
//   static const routeName = '/rooms';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("List of Room"),
//       ),
//       body: BlocBuilder<RoomBloc, RoomState>(
//         builder: (_, state) {
//           if (state is RoomOperationFailure) {
//             return Text('Could not do Hotel operation');
//           }
//           if (state is RoomLoadSuccess) {
//             final rooms = state.rooms;

//             return ListView.builder(
//               itemCount: rooms.length,
//               itemBuilder: (_, index) => ListTile(
//                 title: Text("${rooms[index].description}"),
//                 subtitle: Text("${rooms[index].pricePerNight}"),
//                 onTap: () => Navigator.of(context)
//                     .pushNamed(RoomDetail.routeName, arguments: rooms[index]),
//               ),
//             );
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.add),
//       //   onPressed: () => Navigator.of(context).pushNamed(
//       //       AddUpdateRoom.routeName,
//       //       arguments: RoomArgument(edit: false, room: Room())),
//       // ),
//     );
//   }
// }

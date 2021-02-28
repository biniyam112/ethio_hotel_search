// import '../../../../feature/hotel/data/model/hotel.dart';
// import 'package:flutter/material.dart';

// import '../../../../size_config.dart';

// class HotelDetailsScreen extends StatelessWidget {
//   const HotelDetailsScreen({
//     Key key,
//     this.hotel,
//   }) : super(key: key);
//   static String route = '/hotel_details';
//   final Hotel hotel;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             height: SizeConfig.screenHeight * .4,
//             child: SafeArea(
//               child: Stack(
//                 children: [
//                   PageView.builder(
//                     itemCount: widget.hotel.images.length,
//                     onPageChanged: (value) {
//                       setState(() {
//                         currentPage = value;
//                       });
//                     },
//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         'http://10.0.2.2:3000/${widget.hotel.images[index]}',
//                         height: SizeConfig.screenHeight * (3 / 7),
//                         fit: BoxFit.fitHeight,
//                       );
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 12,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             CupertinoIcons.heart,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: SizeConfig.screenWidth,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ...List.generate(
//                               4,
//                               (index) => Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: AnimatedContainer(
//                                   duration: animationDuration * 2,
//                                   height: 8,
//                                   width: currentPage == index ? 22 : 8,
//                                   decoration: BoxDecoration(
//                                     color: currentPage == index
//                                         ? primaryColor
//                                         : Colors.white60,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           verticalSpacing(of: 10),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: getProportionateScreenWidth(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.hotel.name,
//                   style: TextStyle(
//                     fontSize: getProportionateScreenWidth(28),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: primaryColor,
//                     ),
//                     SizedBox(
//                       width: getProportionateScreenWidth(4),
//                     ),
//                     Text(
//                       widget.hotel.location,
//                       style: TextStyle(
//                         color: textLightColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: getProportionateScreenWidth(10),
//             ),
//             child: Container(
//               width: SizeConfig.screenWidth - 30,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 20,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Description',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: textDarkColor,
//                       fontSize: 18,
//                     ),
//                   ),
//                   verticalSpacing(of: 12),
//                   Text(
//                     widget.hotel.description,
//                     maxLines: 6,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: textDarkColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           BlocBuilder<RoomBloc, RoomState>(
//             builder: (context, roomState) {
//               if (roomState is RoomFetchedState) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenHeight(12),
//                   ),
//                   child: GridView.builder(
//                     physics: const ClampingScrollPhysics(),
//                     itemCount: roomState.rooms.length,
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: getProportionateScreenWidth(10),
//                       crossAxisSpacing: getProportionateScreenWidth(10),
//                     ),
//                     itemBuilder: (context, index) {
//                       return RoomCard(
//                         room: roomState.rooms[index],
//                       );
//                     },
//                   ),
//                 );
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//     );
//   }
// }

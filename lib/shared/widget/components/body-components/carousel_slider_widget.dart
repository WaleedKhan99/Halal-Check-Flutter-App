// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class CarouselSliderWidget extends StatefulWidget {
//   final List<String> imageList;

//   const CarouselSliderWidget({Key? key, required this.imageList})
//       : super(key: key);

//   @override
//   State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
// }

// class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             CarouselSlider(
//               items: widget.imageList.map((imagePath) {
//                 return Container(
//                   width: 393.0,
//                   height: 269.0,
//                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     image: DecorationImage(
//                       image: AssetImage(imagePath),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 aspectRatio: 393 / 269,
//                 initialPage: 0,
//                 enableInfiniteScroll: true,
//                 enlargeCenterPage: true,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16, left: 180),
//               child: Container(
//                 width: 58,
//                 height: 25,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFFCFCFC),
//                     borderRadius: BorderRadius.circular(40)),
//                 child: Center(
//                   child: Text(
//                     '${_currentIndex + 1} / ${widget.imageList.length}',
//                     style: TextStyle(
//                         fontFamily: "Euclid Circular A",
//                         color: Color(0xFF1A1E25),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// ========================= Converted into dynamic =========================

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Widget> imageList; // Change the type to List<Widget>

  const CarouselSliderWidget({Key? key, required this.imageList})
      : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              items: widget.imageList, // Use widget.imageList directly
              options: CarouselOptions(
                aspectRatio: 393 / 269,
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction:
                    1, // Using viewportfraction instead of scale factor
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 250),
              child: Container(
                width: 58,
                height: 25,
                decoration: BoxDecoration(
                    color: Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: Text(
                    '${_currentIndex + 1} / ${widget.imageList.length}',
                    style: TextStyle(
                        fontFamily: "Euclid Circular A",
                        color: Color(0xFF1A1E25),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

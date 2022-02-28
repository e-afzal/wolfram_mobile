import 'package:flutter/material.dart';

// THIRD PARTY PACKAGES
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  final List images;
  ImageSlider(this.images);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              disableCenter: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.images
                .map((item) => Container(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        // width: 1000,
                      ),
                    ))
                .toList(),
          ),
    
          // INDICATORS
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images
                  .asMap()
                  .entries
                  .map((entry) => Container(
                        width: 8.5,
                        height: 8.5,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4)),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

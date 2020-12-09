import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/home_manager.dart';

class HomeCarousel extends StatelessWidget {

  HomeCarousel(this.homeManager);

  final HomeManager homeManager;
  @override
  Widget build(BuildContext context) {
    return Carousel(images: homeManager.images.map((url){
      return Image.network(url);
    }).toList(),
      dotSize: 4,
      dotSpacing: 15,
      dotBgColor: Colors.transparent,
      autoplayDuration: const Duration(seconds: 10),);
  }
}

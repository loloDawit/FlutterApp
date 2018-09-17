import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFav;
  final String userEmail;
  final String userID;
  final String id;

  Product(
      {@required this.id,
        @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.userEmail,
      @required this.userID,
      this.isFav = false});
}

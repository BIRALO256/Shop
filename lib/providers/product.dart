import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _isFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  // Method to toggle the favorite status
  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://shop-e599a-default-rtdb.firebaseio.com/products/$id.json');
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'isFavorite': isFavorite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        _isFavValue(oldStatus);
      }
    } catch (error) {
      _isFavValue(oldStatus);
    }
  }
}

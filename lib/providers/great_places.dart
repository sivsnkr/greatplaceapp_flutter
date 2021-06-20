import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File imageFile) {
    final newPlace = new Place(
        id: DateTime.now().toIso8601String(),
        title: title,
        location: null,
        image: imageFile);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
    });
  }
}

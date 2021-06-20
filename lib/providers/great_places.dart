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
    DBHelper.insert('user_places', {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
    });
  }

  Future<void> getAndSetData() async {
    List<Map<String, dynamic>> data = await DBHelper.getData("user_places");
    _items = data
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            location: null,
            image: File(
              item["image"],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}

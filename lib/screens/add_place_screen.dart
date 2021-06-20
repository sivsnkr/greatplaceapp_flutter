import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

import '../providers/great_places.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlace({Key? key}) : super(key: key);

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter valid Place Name and Picture"),
        ),
      );
      return;
    }

    try {
      Provider.of<GreatPlaces>(context, listen: false).addPlace(
        _titleController.text,
        _pickedImage!,
      );
      Navigator.of(context).pop();
    } catch (error) {
      print("There is some error while saving the image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _savePlace();
            },
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              primary: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

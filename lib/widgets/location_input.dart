import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _userLocationUrl;

  Future<void> _getCurrentUserLocation() async {
    final LocationData? locData = await Location().getLocation();
    if (locData != null)
      print(locData.latitude.toString() + " " + locData.longitude.toString());
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          alignment: Alignment.center,
          width: double.infinity,
          child: _userLocationUrl != null
              ? Image.network(_userLocationUrl!,
                  fit: BoxFit.cover, width: double.infinity)
              : Text(
                  "No Location added",
                  textAlign: TextAlign.center,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

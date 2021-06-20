import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).getAndSetData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: const Text("No Places Found!"),
                    ),
                    builder: (ctx, greatPlaces, ch) {
                      if (greatPlaces.items.length <= 0) {
                        return ch!;
                      }
                      return ListView.builder(
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[i].image),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            onTap: () {},
                          );
                        },
                        itemCount: greatPlaces.items.length,
                      );
                    },
                  ),
      ),
    );
  }
}

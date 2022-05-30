import 'package:flutter/material.dart';
import 'package:mobileproject/src/bloc/provider_product.dart';
import 'package:mobileproject/src/bloc/provider_store.dart';
import 'package:mobileproject/src/bloc/store_bloc.dart';
import 'package:mobileproject/src/models/products.dart';
import 'package:mobileproject/src/views/products_view.dart';
import 'package:mobileproject/src/views/searched_stores.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../models/stores.dart';
import 'home.dart';

class SpecificMap extends StatelessWidget {
  final Stores store;

  SpecificMap({required this.store, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      child: MaterialApp(
        home: Map(store: store),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Map extends StatefulWidget {
  final Stores store;

  Map({required this.store, Key? key}) : super(key: key);

  @override
  _StateMap createState() => _StateMap(x: store);
}

class _StateMap extends State<Map> {
  late GoogleMapController myController;
  final Stores x;
  _StateMap({required this.x});
  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
      Marker startMarker = Marker(
        markerId: MarkerId('destination'),
        position: LatLng(x.latitude, x.longitude),
        infoWindow: InfoWindow(
          title: 'Start destination',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      markers.add(startMarker);


  @override
  Widget build(BuildContext context) {
    var lat = x.latitude;
    var log = x.longitude;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => mainSearchedStores(
        //                     store: x,
        //                   )));
        //     }),
        title: const Text("Stores On Map"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: Set<Marker>.from(markers),

            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(lat!), double.parse(log!)),
              zoom: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}

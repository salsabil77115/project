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

class MainMap extends StatelessWidget {
  final Products product;

  MainMap({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      child: MaterialApp(
        home: StoreMap(product: product),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class StoreMap extends StatefulWidget {
  final Products product;

  StoreMap({required this.product, Key? key}) : super(key: key);

  @override
  _StoreMapState createState() => _StoreMapState(x: product);
}

class _StoreMapState extends State<StoreMap> {
  late GoogleMapController myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
 final Products x;
  _StoreMapState({required this.x});

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final bloc = StoreProvider.of(context);
      bloc.getSearchedStores('getSearchedStores', widget.product.id!);
    });
  }
  @override
  Widget build(BuildContext context) {
    final storebloc = StoreProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => mainSearchedStores(
                            product: x,
                          )));
            }),
        title: const Text("Stores On Map"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(45.521563, -122.677433),
              zoom: 10.0,
            ),
          ),
      
        ],
      ),
    );
  }
  //final Products x;
  //_StoreMapState({required this.x});

  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () async {
  //     final bloc = StoreProvider.of(context);
  //     bloc.getSearchedStores('getSearchedStores', widget.product.id!);
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final storebloc = StoreProvider.of(context);

  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: IconButton(
  //           icon: Icon(Icons.arrow_back),
  //           onPressed: () {
  //             Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => mainSearchedStores(
  //                           product: x,
  //                         )));
  //           }),
  //       title: const Text("Stores On Map"),
  //       centerTitle: true,
  //     ),
  //     body: StreamBuilder<List<Stores>>(
  //       stream: storebloc.stores,
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return Text(snapshot.data![0].latitude!);
  //         //  return //Text(snapshot.data![index].storeName!),;
  //       },
  //     ),
  //   );
  // }}

}

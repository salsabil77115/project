import 'package:flutter/material.dart';
import 'package:mobileproject/src/bloc/provider_product.dart';
import 'package:mobileproject/src/bloc/provider_store.dart';
import 'package:mobileproject/src/models/products.dart';
import 'package:mobileproject/src/views/products_view.dart';
import 'package:mobileproject/src/views/searched_stores.dart';

import '../models/stores.dart';
import 'home.dart';

class MainAllProducts extends StatelessWidget {
  const MainAllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductProvider(
      child: MaterialApp(
        home: AllProducts(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);
  @override
  _AllProducts createState() => _AllProducts();
}

class _AllProducts extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final bloc = ProductProvider.of(context);
      bloc.getAllProducts('getAllProducts');
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProductProvider.of(context);
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }),
          title: const Text("All Products"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Products>>(
        stream: bloc.products,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].productName!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mainSearchedStores(
                                    product: snapshot.data![index])));
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

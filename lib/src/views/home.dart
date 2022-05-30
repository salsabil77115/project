import 'package:flutter/material.dart';
import 'package:mobileproject/src/bloc/provider_store.dart';
import 'package:mobileproject/src/views/products_view.dart';

import '../models/stores.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final bloc = StoreProvider.of(context);
      bloc.fetchData('getStores');
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = StoreProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
        backgroundColor: Color(0xff001D6E),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Stores>>(
        stream: bloc.stores,
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
                      title: Text(snapshot.data![index].storeName!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainlList(store: snapshot.data![index])));
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

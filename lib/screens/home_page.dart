import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constant/constant.dart';
import 'package:foodapp/screens/product_card_user.dart';
import 'package:foodapp/screens/shopping_card.dart';

import 'login.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference product =
  FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController soluongController = TextEditingController();
    String url = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 60,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF), size: 20),
            onPressed: () {
              Navigator.pop(context);
            }),
        titleSpacing: 0.0,
        backgroundColor: lightgreenshede1,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 1,
                ),
                Text('HomePage'),
                IconButton(
                    icon: Icon(Icons.shopping_cart,
                        color: Color(0xFFFFFFFF), size: 20),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCard()));
                    }),
              ]),
        ),
        elevation: 8,
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('product'),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> product = snapshot.data();

          return ProductCardUser(name: product['name'], price: product['price'], url: product['url'],soluong: product['soluong'],id: snapshot.id,);
        },
      ),
    );
  }
}

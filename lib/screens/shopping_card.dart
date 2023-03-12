import 'package:flutter/material.dart';
import 'dart:io';
import 'package:foodapp/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodapp/screens/product_card_shopping.dart';
import '../constant/constant.dart';
import 'product_card_admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import '../models/user.dart';

class ShoppingCard extends StatefulWidget {
  const ShoppingCard({Key? key}) : super(key: key);

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  CollectionReference product =
  FirebaseFirestore.instance.collection('card');
  int total = 0;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController soluongController = TextEditingController();
    String url = '';

    



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 20,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 1,
                ),
                Text('ShoppingCard'),

              ]),
        ),
        elevation: 8,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {

          });
        },
        label: Text("Thanh toán: $total"),
        icon: Icon(Icons.shopping_cart_checkout),

      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('card').where('username', isEqualTo: currentUser.email),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> product = snapshot.data();
          total = 0;
          total += int.parse(product["price"]) * product["soluong"] as int;
          print(total);
          return ProductCardShopping(name: product['name'], price: product['price'], url: product['url'],soluong: product['soluong'],id: snapshot.id,);
        },
      ),
    );
  }
}

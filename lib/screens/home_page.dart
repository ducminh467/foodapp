import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constant/constant.dart';
import 'package:foodapp/screens/product_card_user.dart';
import 'package:foodapp/screens/shopping_card.dart';
import '../history_page/history_page.dart';
import 'search_page.dart';

import '../models/product_model.dart';
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
    // TextEditingController nameController = TextEditingController();
    // TextEditingController priceController = TextEditingController();
    // TextEditingController soluongController = TextEditingController();
    String url = '';
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Lịch sử mua'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryPage()));
                },
              ),
              // Spacer(),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Giỏ hàng'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCard()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Đăng xuất'),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        backgroundColor: lightgreenshede1,
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SearchPage()));
              },
              icon: Icon(Icons.search)
          )
        ],
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  // width: 1,
                ),
                Text('Trang chủ'),

              ]),
        ),
        elevation: 8,
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('product').orderBy('timestamp'),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> product = snapshot.data();



          return ProductCardUser(product: Product(
              url: product['url'],
              id: snapshot.id,
              soluong: product['soluong'],
              price: product['price'],
              name: product['name'],
              loai: product['loai'],
              nguoidang: product['nguoidang'],
              diachi: product['diachi'],

          ),);
        },
      ),
    );
  }
}

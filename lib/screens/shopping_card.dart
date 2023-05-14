import 'package:flutter/material.dart';
import 'package:foodapp/models/history_model.dart';
import 'dart:io';
import 'package:foodapp/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodapp/screens/product_card_shopping.dart';
import '../constant/constant.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import '../history_page/history_manager.dart';
import '../models/product_model.dart';
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
    // TextEditingController nameController = TextEditingController();
    // TextEditingController priceController = TextEditingController();
    // TextEditingController soluongController = TextEditingController();
    // String url = '';
    List<Product> products= [];
    HistoryManager historyManager = HistoryManager();

    



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 20,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF), size: 20),
            onPressed: () {
              Navigator.pop(context);
            }),
        titleSpacing: 0.0,
        backgroundColor: lightgreenshede1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: 1,
                ),
                Text('Giỏ hàng'),

              ]),
        ),
        elevation: 8,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primarygreen,
          onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Hóa đơn'),
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              Text('Tổng cộng: $total vnđ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              //Checkbox(value: value, onChanged: onChanged)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {

              deleteAll()
              .then((value){
                historyManager.addHistory(
                  History(
                      tenNguoiMua: currentUser.name,
                      emailNguoiMua: currentUser.email,
                      ngay: DateTime.now().toString(),
                      products: products,
                    total: total.toString(),
                  )
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Thanh toán thành công, đơn hàng đang được xử lý, vào lịch sử để biết thêm chi tiết')
                  ),

                );
                Navigator.pop(context);
              });

              // historyManager.addHistory(
              //     History(
              //         tenNguoiMua: currentUser.name,
              //         emailNguoiMua: currentUser.email,
              //         ngay: DateTime.now().toString(),
              //         products: products
              //     )
              // );
              // print(products);

            },
            child: const Text('Thanh toán'),
          ),
        ],
      ),
    ),
        label: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('card').where("username", isEqualTo: currentUser.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return const Text('Trống!');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            if(snapshot.hasData && snapshot.data!.docs.isEmpty) return const Text("Giỏ hàng trống");

            total = 0;
            products.clear();
            for (var doc in snapshot.data!.docs) {
              int price = int.parse(doc["price"]);
              int sl = doc['soluong'] as int;
              total += price*sl;

              products.add(Product(
                  url: doc['url'],
                  id: doc.id,
                  soluong: doc['soluong'] as int,
                  price: doc['price'],
                  name: doc['name'],
                  loai: doc['loai'],
                  nguoidang: doc['nguoidang'],
                  diachi: doc['diachi'],
              ));

            }


            return Text("Thanh Toán: $total vnđ");

            },
        ),
        icon: const Icon(Icons.shopping_cart_checkout),

      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('card').where('username', isEqualTo: currentUser.email),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> product = snapshot.data();
          // total = 0;
          // total += int.parse(product["price"]) * product["soluong"] as int;
          // print(total);
          return ProductCardShopping(productId: product['productId'],
    product: Product(
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
  Future<void> deleteAll()  async {
   await FirebaseFirestore.instance
        .collection("card")
        .where("username", isEqualTo: currentUser.email)
        .get()
    .then((QuerySnapshot querySnapshot){
       for (var doc in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection("card")
            .doc(doc.id).delete();
      }
    });
  }
}

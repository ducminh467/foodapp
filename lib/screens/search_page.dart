import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/product_card_user.dart';

import '../constant/constant.dart';
import '../models/product_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchItem = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm"),
        centerTitle: true,
        titleSpacing: 0.0,
        backgroundColor: lightgreenshede1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                      child: TextField(
                        // controller: searchController,
                        onChanged: (value){
                          setState(() {
                            searchItem = value;
                          });
                        },
                      )
                  ),
                  // IconButton(onPressed: (){
                  //   setState(() {
                  //     searchItem = searchController.value.text;
                  //     print(searchItem);
                  //   });
                  // }, icon: Icon(Icons.search))
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: 500,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('product').where("name", isEqualTo: searchItem).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> product = document.data()! as Map<String, dynamic>;
                        return ProductCardUser(product: Product(
                          url: product['url'],
                          id: document.id,
                          soluong: product['soluong'],
                          price: product['price'],
                          name: product['name'],
                          loai: product['loai'],
                          nguoidang: product['nguoidang'],
                          diachi: product['diachi'],

                        ),);
                      }).toList(),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

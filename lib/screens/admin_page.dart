import 'package:flutter/material.dart';
import 'dart:io';
import 'package:foodapp/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constant/constant.dart';
import 'product_card_admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                Text('AdminPage'),

              ]),
        ),
        elevation: 8,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primarygreen,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Thêm sản phẩm'),
            content: SizedBox(
              height: 250,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        // image picker
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                        if(file == null) return;

                        // get reference
                        Reference rootRef = FirebaseStorage.instance.ref().child('images');
                        Reference imageRef = rootRef.child(DateTime.now().millisecondsSinceEpoch.toString());

                        // store file

                        try {
                          await imageRef.putFile(File(file.path));
                          // download url
                          url = await imageRef.getDownloadURL();

                        } on FirebaseException {
                          // ...
                        }



                      },
                      icon: Icon(Icons.image)),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text('Nhập tên sản phẩm'),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      label: Text('Nhập giá'),
                    ),
                    textAlign: TextAlign.start,

                  ),
                  TextField(
                    controller: soluongController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Nhập số lượng'),
                    ),
                    textAlign: TextAlign.start,

                  ),
                  //Checkbox(value: value, onChanged: onChanged)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('product').add({
                    'name': nameController.value.text,
                    'price': priceController.value.text,
                    'soluong': int.parse(soluongController.value.text),
                    'url': url
                  });
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        label: Text('Thêm sản phẩm'),
        icon: const Icon(Icons.add),
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('product'),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> product = snapshot.data();

          return ProductCard(name: product['name'], price: product['price'], url: product['url'],soluong: product['soluong'],id: snapshot.id,);
        },
      ),
    );
  }
}

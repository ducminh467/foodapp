import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/shopping_card.dart';

import '../constant/constant.dart';
import 'package:foodapp/models/user.dart';
class ProductCardUser extends StatefulWidget {
  const ProductCardUser({required this.name,required this.url, required this.soluong, required this.price,  Key? key, required this.id}) : super(key: key);
  final String name, price, url, id;
  final int soluong;
  @override
  State<ProductCardUser> createState() => _ProductCardUserState();
}

class _ProductCardUserState extends State<ProductCardUser> {

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController soluongController = TextEditingController();
    String url = '';
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color(0xFFEBEBEE),
          elevation: 10,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 100.0,
                        // height: 100.0,
                        padding: EdgeInsets.all(8),
                        // Border width
                        //decoration: BoxDecoration(color: Color(0xFF00000A), borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.network(widget.url)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // width: 180.0,
                        // height: 150.0,
                        // color: Colors.red,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tên sản phẩm: ${widget.name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,

                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Giá sản phẩm: ${widget.price}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số lượng: ${widget.soluong}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Thêm vào giỏ hàng'),
                              content: SizedBox(
                                height: 250,
                                child: Column(
                                  children: [
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
                                    if(int.parse(soluongController.value.text) > widget.soluong) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Số lượng không hợp lệ!'))
                                      );
                                      return;

                                    }
                                    FirebaseFirestore.instance.collection('product').doc(widget.id).update(
                                      {
                                        'soluong': widget.soluong-int.parse(soluongController.value.text)
                                      }
                                    );
                                    FirebaseFirestore.instance.collection('card').add({
                                      'name': widget.name,
                                      'price': widget.price,
                                      'soluong': int.parse(soluongController.value.text),
                                      'url': widget.url,
                                      'username': currentUser.email
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.red,
                          ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
      onTap: () async {
        // await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomePage(product: product)));
        setState(() {});
      },
    );
  }
}


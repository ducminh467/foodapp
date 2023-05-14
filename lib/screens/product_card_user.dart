import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:foodapp/models/user.dart';
class ProductCardUser extends StatefulWidget {
  const ProductCardUser({ required this.product,Key? key}) : super(key: key);
  final Product product;
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
        height: MediaQuery.of(context).size.height / 4,
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
                              size: const Size.fromRadius(48), // Image radius
                              child: Image.network(widget.product.url)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        // width: 180.0,
                        // height: 150.0,
                        // color: Colors.red,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tên sản phẩm: ${widget.product.name}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,

                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Giá sản phẩm: ${widget.product.price}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số lượng: ${widget.product.soluong}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Loại sản phẩm: ${widget.product.loai}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Người đăng: ${widget.product.nguoidang}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Địa chỉ: ${widget.product.diachi}',
                                  style: const TextStyle(
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
                                    if(int.parse(soluongController.value.text) > widget.product.soluong) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Số lượng không hợp lệ!'))
                                      );
                                      return;

                                    }
                                    FirebaseFirestore.instance.collection('product').doc(widget.product.id).update(
                                      {
                                        'soluong': widget.product.soluong-int.parse(soluongController.value.text)
                                      }
                                    );
                                    FirebaseFirestore.instance.collection('card').add({
                                      'productId': widget.product.id,
                                      'name': widget.product.name,
                                      'price': widget.product.price,
                                      'soluong': int.parse(soluongController.value.text),
                                      'url': widget.product.url,
                                      'nguoidang': currentUser.name,
                                      'loai': widget.product.loai,
                                      'username': currentUser.email,
                                      'diachi': widget.product.diachi
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
class ProductCard extends StatefulWidget {
  const ProductCard({required this.product,Key? key}) : super(key: key);

final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
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
                              size: Size.fromRadius(48), // Image radius
                              child: Image.network(widget.product.url)),
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
                              'Tên sản phẩm: ${widget.product.name}',
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
                                  'Giá sản phẩm: ${widget.product.price}',
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
                                  'Số lượng: ${widget.product.soluong}',
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
                                  'Loại sản phẩm: ${widget.product.loai}',
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
                                  'Người đăng: ${widget.product.nguoidang}',
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
                                  'Địa chỉ: ${widget.product.diachi}',
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
                          onPressed: () {
                            FirebaseFirestore.instance.collection('product').doc(widget.product.id).delete();

                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
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


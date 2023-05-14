import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/product_model.dart';
import '../constant/constant.dart';
import '../models/product_model.dart';
class HistoryDetail extends StatefulWidget {
  const HistoryDetail({ this.tongcong ,required this.products ,Key? key}) : super(key: key);

  final List<dynamic> products;
  final int? tongcong;


  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  // int total = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                Text('Chi tiết lịch sử'),

              ]),
        ),
        elevation: 8,

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Tổng tiền: ${widget.tongcong!}",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
      body: Column(
        children: widget.products.map((e){

          // total += int.parse(e['price']) * e['soluong'] as int;

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
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
                    padding: const EdgeInsets.all(12.0),
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
                                child: Image.network(e['url'])),
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
                                'Tên sản phẩm: ${e['name']}',
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
                                    'Giá sản phẩm: ${e['price']}',
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
                                    'Số lượng: ${e['soluong']}',
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
                                    'Loại sản phẩm: ${e['loai']}',
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
                                    'Người đăng: ${e['nguoidang']}',
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
                                    'Địa chỉ: ${e['diachi']}',
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
                      ],
                    ),
                  ),

                  Text('Đơn hàng đang được xử lý...')

                ],

              ),

            ),

          );
        }).toList(),
      ),
    );
  }

}

// class _HistoryDetailState extends State<HistoryDetail> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("hello"),
//     );
//   }
// }


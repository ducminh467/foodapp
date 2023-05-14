import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/history_page/history_detail.dart';
import 'package:foodapp/models/history_model.dart';
import 'package:foodapp/models/product_model.dart';

import '../constant/constant.dart';
import '../models/user.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

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
                Text('Lịch sử mua hàng'),

              ]),
        ),
        elevation: 8,

      ),
      body: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FirestoreListView(
      query: FirebaseFirestore.instance.collection('history').where("emailNguoiMua", isEqualTo: currentUser.email).orderBy("ngayMua"),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> his = snapshot.data();


        return SafeArea(
          child: InkWell(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color(0xFFEBEBEE),
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 12,
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
                                  'Tên người mua: ${his["tenNguoiMua"]}',
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
                                      'Ngày mua: ${his["ngayMua"]}',
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
                  ],
                ),
              ),
            ),
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail(
                  products: his['products'],
                  tongcong: int.parse(his['total']),
                )));
              // print(his['products'].first["url"]);

            },
          ),
        );
          // Text(his["tenNguoiMua"]);
      },
    );
  }
}


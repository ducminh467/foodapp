import 'package:flutter/material.dart';
import 'package:foodapp/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/constant/constant.dart';
import 'package:foodapp/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Signup extends StatefulWidget {


   const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreenshede1,
          title: Text('Đăng kí',
              style: TextStyle(color: primarygreen)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            bottom: true,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                    child: Image.asset(
                      'lib/assets/logo1.png',
                      width: 200,
                      height: 200,
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                     controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: lightgreenshede1,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Text('Đăng kí',
                          style: TextStyle(
                              fontSize: 18,
                              color: primarygreen
                          ),),
                      onPressed: () {
                        CollectionReference users = FirebaseFirestore.instance
                            .collection('user');

                        users.doc(emailController.value.text).get()
                          .then((DocumentSnapshot doc) {
                            if(!doc.exists){
                              users.doc(emailController.value.text).set(
                                {
                                  'email': emailController.value.text,
                                  'password': passwordController.value.text,
                                  'name': nameController.value.text,
                                  'defind': 1
                                },

                              ).then((value) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage())))
                                  .catchError((error) => print("Lỗi: $error"));
                            } else{
                              emailController.clear();
                              passwordController.clear();
                              nameController.clear();
                              ScaffoldMessenger.of(context).showSnackBar( const
                                SnackBar(content: Text("Tài khoản đã tồn tại"))
                              );
                            }
                        });


                      }
                      ),
                  )],
              ),
            ),
          ),
        ));
  }
}

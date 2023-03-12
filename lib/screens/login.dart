
import 'package:flutter/material.dart';
import 'package:foodapp/screens/home_page.dart';
import 'Signup.dart';
import 'package:foodapp/constant/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/models/user.dart';

import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreenshede1,
          title: Text('Đăng nhập',
            style: TextStyle(color: primarygreen)
          ),
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
                  SizedBox(height: 10,),
                  Container(
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: lightgreenshede1,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child:  Text('Đăng nhập',
                            style: TextStyle(
                                fontSize: 18,
                                color: primarygreen
                            )),
                        onPressed: () {
                          CollectionReference users = FirebaseFirestore.instance.collection('user');

                          users.doc(emailController.value.text).get()
                            .then((DocumentSnapshot documentSnapshot){
                              if(documentSnapshot.exists){

                                if(documentSnapshot.get("password") == passwordController.value.text){

                                  int dinhDanh = documentSnapshot.get("defind");
                                  currentUser = User(
                                    email: documentSnapshot.get("email"),
                                    password: documentSnapshot.get("password"),
                                    name: documentSnapshot.get("name"),
                                    define: dinhDanh,
                                  );

                                  if(dinhDanh == 0){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AdminPage()), (route) => false);
                                  }
                                  if(dinhDanh == 1) {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                                  }

                                } else {
                                  emailController.clear();
                                  passwordController.clear();
                                  print("Mật khẩu sai");
                                  ScaffoldMessenger.of(context).showSnackBar( const
                                    SnackBar(content: Text("Mật khẩu sai"))
                                  );
                                }
                              } else{
                                ScaffoldMessenger.of(context).showSnackBar( const
                                SnackBar(content: Text("Email sai"))
                                );
                              }
                          });

                        },
                      )),
           // const SizedBox(height: 0),
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
                    ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
                },
              ),
            ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

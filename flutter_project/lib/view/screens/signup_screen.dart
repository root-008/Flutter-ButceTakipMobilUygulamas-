import 'package:flutter_project/api/apis.dart';
import 'package:flutter_project/view/screens/SignIn_screen.dart';
import 'package:flutter_project/view/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> register() async {
    var url = Uri.parse(Apis.signUpApi);
    var response = await http.post(url, body: {
      "username": user.text.toString(),
      "password": pass.text.toString(),
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var status = data['status'];

      if (status == 'Error') {
        Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'Bu kullanıcı adına sahip bir kullanıcı sistemlerimizde kayıtlıdır',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Kayıt Başarılı',
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    } else {
      // İstek başarısız durumunu işleyebilirsiniz
      print("istek başarısız");
    }
  }


  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight*0.05),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kayıt",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Ramabhadra",
                          fontWeight: FontWeight.w600,
                          fontSize: 45,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Ol",
                        style: TextStyle(
                          color: Colors.pink,
                          fontFamily: "Ramabhadra",
                          fontWeight: FontWeight.w600,
                          fontSize: 45,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight*0.02,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: deviceWidth*0.7,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: user,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Kullanıcı Adı',
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2)),
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen kullanıcı adınızı giriniz...';
                            } else {
                              null;
                            }
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0)),
                        TextFormField(
                          controller: pass,
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Parola',
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2)),
                              icon: const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: Colors.white,
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen parolanızı giriniz...';
                            } else {
                              null;
                            }
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0)),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Parola Doğrulama',
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2)),
                              icon: const Icon(
                                Icons.keyboard_double_arrow_right_sharp,
                                color: Colors.white,
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen parolanızı doğrulayınız...';
                            } else {
                              null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 36),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                register();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth*0.13, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: const Text(
                              "Kayıt Ol",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Row(
                    children: [
                      Text(
                        "Hesabınız var mı? ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn()));
                        },
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.pink, fontSize: 19),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: deviceHeight*0.014,)
              ],
            ),
          ),
        ));
  }
}

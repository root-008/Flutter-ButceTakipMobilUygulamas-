import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/api/apis.dart';
import 'package:flutter_project/view/screens/home_screen.dart';
import 'package:flutter_project/view/screens/signup_screen.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SignInState();

}

class SignInState extends State{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    print("x");
    var url = Uri.parse(Apis.loginApi);
    print(url);

    var response = await http.post(url,body:{
        "username": user.text.toString(),
        "password": pass.text.toString(),
    });
    print("z");

    print("response.body : "+response.body);
    var data = jsonDecode(response.body);

    if(data["status"] == "Success"){

      await SessionManager().set('token',data["user_id"].toString());

      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Giriş Başarılı',
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }else{
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'Kullanıcı adınız yada parolanız yanlış.',
        toastLength: Toast.LENGTH_SHORT,
      );
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
                    fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight*0.1),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Giriş",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Ramabhadra",
                          fontWeight: FontWeight.w600,
                          fontSize: 45,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Yap",
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
                SizedBox(height: deviceHeight*0.02,),
                Image.asset("assets/images/logo.png",width: deviceWidth*0.7,),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceHeight*0.05,horizontal:  deviceWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: user,
                          style:
                          const TextStyle(color: Colors.white, fontSize: 15),
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
                              errorBorder:OutlineInputBorder(
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
                          style:
                          const TextStyle(color: Colors.white, fontSize: 15),
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
                              errorBorder:OutlineInputBorder(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth*0.2, vertical: deviceHeight*0.02),
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            child: const Text(
                              "Giriş Yap",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: deviceWidth*0.25),
                    child: Row(
                      children: [
                        Text("Hesabınız yok mu? ",
                          style:TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        TextButton(onPressed:() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                        },
                          child: Text("Kayıt Ol",
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 19
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: deviceHeight*0.08,)
              ],
            ),
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/SignIn_screen.dart';
import 'package:flutter_project/view/screens/signup_screen.dart';

class Wellcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WellcomeState();
}

class WellcomeState extends State {
  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: (deviceHeight*0.1))),
            const Center(
              child: Text(
                "Hoşgeldiniz",
                style: TextStyle(
                  color: Colors.pink,
                  fontFamily: "Ramabhadra",
                  fontWeight: FontWeight.w600,
                  fontSize: 60,
                ),
              ),
            ),
            SizedBox(height: deviceHeight*0.05,),
            Image.asset("assets/images/logo.png",width: deviceWidth*0.7,),
            SizedBox(height: deviceHeight*0.1,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  "Giriş Yap",
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  "Kayıt Ol",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

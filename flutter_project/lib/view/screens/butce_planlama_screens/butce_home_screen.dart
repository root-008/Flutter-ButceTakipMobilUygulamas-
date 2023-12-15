import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_diger_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_egitim_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_eglence_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_gelir_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_gida_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_konut_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_saglik_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_ulasim_screen.dart';
import 'package:flutter_project/view/screens/home_screen.dart';


class ButceHome extends StatefulWidget {
  const ButceHome({super.key});

  @override
  State<StatefulWidget> createState() => ButcehHomeState();
}

class ButcehHomeState extends State {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
       automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Bütçe Planlama',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                categories(deviceWidth, 'Gelir',const ButceGelir()),
                const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text('Giderler:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                ),
                const Divider(color: Colors.white,thickness: 4),
                categories(deviceWidth, 'Gıda',ButceGida()),//2
                categories(deviceWidth, 'Konut',ButceKonut()),//3
                categories(deviceWidth, 'Ulaşım',ButceUlasim()),//4
                categories(deviceWidth, 'Sağlık',ButceSaglik()),//5
                categories(deviceWidth, 'Eğitim',ButceEgitim()),//6
                categories(deviceWidth, 'Eğlence',ButceEglence()),//7
                categories(deviceWidth, 'Diğer',ButceDiger()),//8
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categories(double deviceWidth, String categoryName,var pageroute) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 65,
      width: deviceWidth - 15,
      child: Card(
        color: Colors.black26,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageroute,
              ),
            );
          },
          child: ListTile(
            leading: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
                maxWidth: 44,
                maxHeight: 44,
              ),
              child: Image.asset('assets/images/ok.png', fit: BoxFit.cover),
            ),
            title: Text(
              categoryName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

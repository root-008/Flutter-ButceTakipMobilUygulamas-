import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/SignIn_screen.dart';
import 'package:flutter_project/view/screens/butce_planlama_screens/butce_home_screen.dart';
import 'package:flutter_project/view/screens/calculator_screen.dart';
import 'package:flutter_project/view/screens/current_market_screens/stocks_screen.dart';
import 'package:flutter_project/view/screens/income_expense_cal_screens/income_home_screen.dart';
import 'package:flutter_project/view/screens/income_expense_cal_screens/income_main_screen.dart';
import 'package:flutter_project/view/screens/interest_calculation_screen.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Param Cebimde',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: deviceHeight*0.02 ,horizontal: deviceWidth*0.01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [CardButcePlanlama(), CardGelirGider()],
                ),
                Row(
                  children: [CardGuncelPiyasa(), CardFaizHesaplama()],
                ),
                Row(
                  children: [CardHesapMakinesi()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CardButcePlanlama() {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ButceHome(),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 190,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset('assets/images/butce_planlama.jpg',
                      height: 100),
                ),
              ),
              Text(
                "Bütçe Hesaplama",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10.0),
          color: Colors.black54,
          shadowColor: Colors.grey[800],
          borderOnForeground: true,
        ),
      ),
    );
  }

  Widget CardGelirGider() {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IncomeMain(),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 190,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/gelir_gider.jpg',
                    height: 100,
                  ),
                ),
              ),
              Text(
                "Gelir Gider Hesaplama",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10.0),
          color: Colors.black54,
          shadowColor: Colors.grey[800],
          borderOnForeground: true,
        ),
      ),
    );
  }

  Widget CardHesapMakinesi() {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Calculator(),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 190,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset('assets/images/hesap_makinesi.png',
                      height: 100),
                ),
              ),
              Text(
                "Hesap Makinesi",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10.0),
          color: Colors.black54,
          shadowColor: Colors.grey[800],
          borderOnForeground: true,
        ),
      ),
    );
  }

  Widget CardYatirimAraclari() {
    return Container(
      height: 200,
      width: 190,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/images/yatirim_araclari.jpg',
                    height: 100),
              ),
            ),
            Text(
              "Yatırım Araçları",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(10.0),
        color: Colors.black54,
        shadowColor: Colors.grey[800],
        borderOnForeground: true,
      ),
    );
  }

  Widget CardGuncelPiyasa() {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Stocks(),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 190,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:
                      Image.asset('assets/images/guncel_piyasa.jpg', height: 100),
                ),
              ),
              Text(
                "Guncel Piyasa",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10.0),
          color: Colors.black54,
          shadowColor: Colors.grey[800],
          borderOnForeground: true,
        ),
      ),
    );
  }

  Widget CardFaizHesaplama() {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FaizHesaplamaSayfasi(),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        width: 190,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset('assets/images/faiz_hesaplama.jpeg',
                      height: 100),
                ),
              ),
              Text(
                "Faiz Hesaplama",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10.0),
          color: Colors.black54,
          shadowColor: Colors.grey[800],
          borderOnForeground: true,
        ),
      ),
    );
  }

  void logout() {
    SessionManager().set('token', '');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }
}

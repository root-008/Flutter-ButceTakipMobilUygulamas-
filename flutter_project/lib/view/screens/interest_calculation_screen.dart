import 'package:flutter/material.dart';
import 'package:flutter_project/view/widgets/income_expense_cal_widget.dart';

class FaizHesaplamaSayfasi extends StatefulWidget {
  @override
  _FaizHesaplamaSayfasiState createState() => _FaizHesaplamaSayfasiState();
}

class _FaizHesaplamaSayfasiState extends State<FaizHesaplamaSayfasi> {
  double anapara = 0.0;
  double faizOrani = 0.0;
  int vade = 0;
  double toplamTutar = 0.0;

  void hesapla() {
    setState(() {
      toplamTutar = anapara + (anapara * faizOrani * vade) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenName: 'Faiz Hesaplama'),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Anapara',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  anapara = double.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Faiz Oranı (%)',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  faizOrani = double.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Vade (Ay)',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  vade = int.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            MaterialButton(
              child: Text('Hesapla'),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: hesapla,
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.deepPurple,
              ),
              child: Text(
                'Toplam Tutar: $toplamTutar',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



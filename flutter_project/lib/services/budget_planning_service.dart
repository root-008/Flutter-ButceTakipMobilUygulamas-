// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/budget_planning_model.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GelirService {
  Future<int> getUserId() async {
    dynamic token = await SessionManager().get('token');
    return int.parse(token.toString());
  }

  Future<List<Gelir>> getData(String apis, String categoryId, DateTime startDate, DateTime endDate) async {
    int userId = await getUserId();

    var url = Uri.parse(apis);

    var response = await http.post(url, body: {
      'categoryId': categoryId,
      'token': userId.toString(),
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    });

    //print(response.body);

    var data = jsonDecode(response.body);

    List<dynamic> gelirler = data as List;

    return gelirler.map<Gelir>((json) => Gelir.fromJson(json)).toList();
  }

  Future<List<GetGelirCategories>> getCategoriesForUser(int userId, String apis) async {
    var url = Uri.parse(apis);
    http.Response response = await http.get(url);
    var jsonResponse = response.body;

    //print(jsonResponse); // Check the JSON response

    try {
      var data = jsonDecode(jsonResponse);

      List<dynamic> categories0 = data as List;

      List<GetGelirCategories> categories = categories0
          .map<GetGelirCategories>((json) => GetGelirCategories.fromJson(json))
          .toList();

      List<GetGelirCategories> userCategories =
          categories.where((category) => category.userId == userId).toList();

      return userCategories;
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list or handle the error as needed
    }
  }

  Future deleteSubCategory(BuildContext context, int userId, int selectedCategory, int categoryId, String apis) async {
    var url = Uri.parse(apis);
    var response = await http.post(url, body: {
      'userId': userId.toString(),
      'selectedCategory': selectedCategory.toString(),
      'categoryId': categoryId.toString(),
    });
    //print(response.body);
    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'İşlem Başarılı',
          toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'İşlem Başarısız lütfen tekrar deneyiniz...',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future saveAmount(BuildContext context, int userId, int selectedCategory,
      String amount, String apis) async {
    var url = Uri.parse(apis);

    var response = await http.post(url, body: {
      'userId': userId.toString(),
      'subCategory_id': selectedCategory.toString(),
      'amount': amount.toString(),
    });
    print(response.body);
    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Kayıt Başarılı',
          toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'İşlem Başarısız lütfen bilgilerinizi kontrol ediniz',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future saveSubCategory(BuildContext context, int userId, String gelirType,
      String apis, int categoryId) async {
    var url = Uri.parse(apis);

    var response = await http.post(url, body: {
      'userId': userId.toString(),
      'gelirType': gelirType.toString(),
      'categoryId': categoryId.toString(),
    });


    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Kayıt Başarılı',
          toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'İşlem Başarısız lütfen bilgilerinizi kontrol ediniz',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future gelirAmountDelete(int amountId, String apis) async {
    var url = Uri.parse(apis);
    var response =
        await http.post(url, body: {'amountId': amountId.toString()});
    print(response.body);
    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'İşlem Başarılı',
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'İşlem Başarısız lütfen tekrar deneyiniz...',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future gelirAmountUpdate(
      BuildContext context, int amountId, String amount, String apis) async {
    var url = Uri.parse(apis);
    var response = await http.post(url, body: {
      'amountId': amountId.toString(),
      'amount': amount.toString(),
    });

    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Güncelleme Başarılı',
          toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'İşlem Başarısız lütfen bilgilerinizi kontrol ediniz',
          toastLength: Toast.LENGTH_SHORT);
    }
  }
}

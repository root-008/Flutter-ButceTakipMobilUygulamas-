import 'dart:convert';

import 'package:flutter_project/api/apis.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

class IncomeService{

  Future<int> getUserId() async {
    dynamic token = await SessionManager().get('token');
    return int.parse(token.toString());
  }

  Future<Map<String,dynamic>> getTotalAmount() async{
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getTotalAmountApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });

    //print(response.body);

    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }


  Future<List<dynamic>> getBankHistory() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getBankTransactionHistoryApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    List<dynamic> history = List.from(data);

    return history;
  }

  Future<Map<String, dynamic>> getMaxExpense() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getMaxExpenseApi);

    var response = await client.post(url,body:{
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }

  Future<Map<String, dynamic>> getLastUpdated() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getLastUpdatedApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }

  Future<Map<String, dynamic>> getExpenseQuery() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getExpenseQueryApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }

  Future<List<dynamic>> getTotalExpenses() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getTotalExpensesApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    List<dynamic> history = List.from(data);

    return history;
  }

  Future<Map<String, dynamic>> getMostExpenses() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getMostExpensesApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }

  Future<Map<String, dynamic>> getMinExpenses() async {
    int userId = await getUserId();

    var client = http.Client();
    var url = Uri.parse(Apis.getMinExpensesApi);

    var response = await client.post(url,body: {
      'token' : userId.toString()
    });
    var data = jsonDecode(response.body);

    var result = data[0];

    return result;
  }

}
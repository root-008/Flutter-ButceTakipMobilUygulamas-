import 'package:flutter_project/api/apis.dart';
import 'package:flutter_project/models/current_market_model.dart';
import 'package:http/http.dart' as http;


class StockService {

  Future<List<Stock>?> getStocks() async{
    var client = http.Client();

    var url = Uri.parse(Apis.getStoksApi);
    var response = await client.get(url);

    if(response.statusCode == 200){
      var json = response.body;
      return stockFromJson(json);
    }
  }
}


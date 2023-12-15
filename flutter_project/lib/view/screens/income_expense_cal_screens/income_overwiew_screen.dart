import 'package:flutter/material.dart';
import 'package:flutter_project/services/income_expense_cal_service.dart';
import 'package:flutter_project/view/widgets/income_expense_cal_widget.dart';
import 'package:pie_chart/pie_chart.dart';

class IncomeOverWiew extends StatefulWidget {
  const IncomeOverWiew({Key? key});

  @override
  State<StatefulWidget> createState() => IncomeOverWiewState();
}

class IncomeOverWiewState extends State<IncomeOverWiew> {
  IncomeService _incomeService = IncomeService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenName: 'Harcama Tavsiyeleri'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getMaxExpense(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    return IncomeWidgets().mostExpenseData(snapshot);
                  }
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getLastUpdated(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    return IncomeWidgets().LastUpdatedData(snapshot);
                  }
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getTotalAmount(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    String totalAmount = 'N/A';
                    totalAmount = snapshot.data?['giderler'] ?? 'N/A';

                    return Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Text('Toplam $totalAmount TL olan harcamalarının dağılımını grafikle veya liste olarak görebilirsin.',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FutureBuilder<List<dynamic>>(
                      future: _incomeService.getTotalExpenses(),
                      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Hata: ${snapshot.error}');
                        } else {
                          return IncomeWidgets().buildPieChart(snapshot.data,context);
                        }
                      },
                    ),
                    FutureBuilder<List<dynamic>>(
                      future: _incomeService.getTotalExpenses(),
                      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Hata: ${snapshot.error}');
                        } else {
                          return IncomeWidgets().buildListWidget(snapshot.data,context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getExpenseQuery(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('');
                  } else {
                    return IncomeWidgets().getExpenseQuery(snapshot);
                  }
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getMostExpenses(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('');
                  } else {
                    return IncomeWidgets().mostExpense(snapshot);
                  }
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: _incomeService.getMinExpenses(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('');
                  } else {
                    return IncomeWidgets().getMinExpenses(snapshot);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


}

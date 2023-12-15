import 'package:flutter/material.dart';
import 'package:flutter_project/services/income_expense_cal_service.dart';
import 'package:flutter_project/view/screens/home_screen.dart';
import 'package:pie_chart/pie_chart.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenName;

  CustomAppBar({required this.screenName});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        screenName,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            size: 30,
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class IncomeWidgets {
  IncomeService _incomeService = IncomeService();

  Widget buildPage(int index, var _pageTitles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            _pageTitles[index],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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
              if (index == 0) {
                totalAmount = snapshot.data?['net_gelir'] ?? 'N/A';
              } else if (index == 1) {
                totalAmount = snapshot.data?['gelirler'] ?? 'N/A';
              } else if (index == 2) {
                totalAmount = snapshot.data?['giderler'] ?? 'N/A';
              }
              return Text(
                "$totalAmount TL",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
        const Spacer(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.credit_card,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ],
    );
  }

  Widget mostExpenseData(snapshot) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            'Bu Ay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'En Çok Harcama Yapılan Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['Category_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Alt Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['subcategory_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Tutar:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['amount'] + " TL",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget LastUpdatedData(snapshot) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            'En Son Güncellenen Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['Category_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Alt Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['subcategory_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Tutar:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['amount'] + " TL",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget getExpenseQuery(snapshot) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Text(
        calculateExpense(snapshot),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  String calculateExpense(snapshot) {
    double thisMonthExpenses =
        double.parse(snapshot.data?['this_month_expenses']);
    double previousMonthExpenses =
        double.parse(snapshot.data?['previous_month_expenses']);

    if (thisMonthExpenses < previousMonthExpenses) {
      double difference = previousMonthExpenses - thisMonthExpenses;
      double percentage = (difference / previousMonthExpenses) * 100;
      return "Bu ay geçen aya göre %${percentage.toStringAsFixed(2)} daha az harcama yapılmıştır.";
    } else if (thisMonthExpenses > previousMonthExpenses) {
      double difference = thisMonthExpenses - previousMonthExpenses;
      double percentage = (difference / previousMonthExpenses) * 100;
      return "Bu ay geçen aya göre %${percentage.toStringAsFixed(2)} daha fazla harcama yapılmıştır.";
    } else {
      return "Bu ay geçen aya göre harcamada bir değişiklik olmamıştır.";
    }
  }

  Widget buildPieChart(List<dynamic>? data, BuildContext context) {
    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.white,
      Colors.orange,
      Colors.black,
      Colors.pink,
    ];

    if (data == null || data.isEmpty) {
      return Container();
    }

    Map<String, double> chartData = {};
    for (var item in data) {
      chartData[item['Category_name']] = double.parse(item['total_expense']);
    }

    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: PieChart(
        dataMap: chartData,
        animationDuration: Duration(milliseconds: 800),
        chartType: ChartType.disc,
        colorList: colorList,
        chartRadius: MediaQuery.of(context).size.width / 1.5,
        legendOptions: LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.bottom,
            legendTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            showLegendsInRow: true),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: true,
          showChartValuesInPercentage: true,
          decimalPlaces: 1,
        ),
      ),
    );
  }

  Widget buildListWidget(List<dynamic>? data, BuildContext context) {
    if (data == null || data.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          Color cardColor = Colors.purple;
          Color titleColor = Colors.black;
          Color subtitleColor = Colors.grey;

          switch (index % 4) {
            case 0:
              cardColor = Colors.blue;
              titleColor = Colors.black;
              subtitleColor = Colors.white;
              break;
            case 1:
              cardColor = Colors.green;
              titleColor = Colors.black;
              subtitleColor = Colors.white;
              break;
            case 2:
              cardColor = Colors.orange;
              titleColor = Colors.black;
              subtitleColor = Colors.white;
              break;
            case 3:
              cardColor = Colors.pink;
              titleColor = Colors.black;
              subtitleColor = Colors.white;
              break;
          }

          return Card(
            color: cardColor,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: subtitleColor,
                child: Icon(
                  Icons.category,
                  color: titleColor,
                ),
              ),
              title: Text(
                item['Category_name'],
                style: TextStyle(
                  color: titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item['total_expense'],
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mostExpense(snapshot) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            'Bu Ay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'En Sık Harcama Yapılan Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['Category_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(snapshot.data['repetition_count'].toString(),
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }

  Widget getMinExpenses(snapshot) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            'Bu Ay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'En Az Harcama Yapılan Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['Category_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Alt Kategori:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['subcategory_name'],
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Tutar:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            snapshot.data?['min_amount'] + " TL",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

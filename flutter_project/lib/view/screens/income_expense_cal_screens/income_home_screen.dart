import 'package:flutter/material.dart';
import 'package:flutter_project/services/income_expense_cal_service.dart';
import 'package:flutter_project/view/widgets/income_expense_cal_widget.dart';

class IncomeHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IncomeHomeState();
}

class IncomeHomeState extends State<IncomeHome> {
  int _currentPage = 0;

  List<Color> _pageColors = [
    Colors.purple,
    Colors.deepPurpleAccent,
    Colors.deepPurple,
  ];

  List<String> _pageTitles = [
    'Toplam Bütçe',
    'Toplam Gelir',
    'Toplam Gider',
  ];

  IncomeService _incomeService = IncomeService();

  List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    fetchBankHistory();
  }

  Future<void> fetchBankHistory() async {
    try {
      List<dynamic> bankHistory = await IncomeService().getBankHistory();
      setState(() {
        history = bankHistory;
      });
    } catch (error) {
      // Hata durumunda yapılacak işlemler
      print('Hata: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenName: 'Ana Sayfa'),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _pageColors[_currentPage],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _pageColors.length,
                    controller: PageController(viewportFraction: 0.9),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _pageColors[index],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IncomeWidgets().buildPage(index, _pageTitles),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> item = history[index];
                  String categoryName = item['Category_name'];
                  IconData categoryIcon = _getCategoryIcon(categoryName);
                  return Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          categoryIcon,
                          size: 24,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item['subcategory_name'],
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item['creation_time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item['amount'] + " TL",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Gelir':
        return Icons.attach_money;
      case 'Gıda':
        return Icons.restaurant;
      case 'Konut':
        return Icons.home;
      case 'Ulaşım':
        return Icons.directions_car;
      case 'Sağlık':
        return Icons.favorite;
      case 'Eğitim':
        return Icons.school;
      case 'Eğlence':
        return Icons.local_activity;
      case 'Diğer':
        return Icons.category;
      default:
        return Icons.category;
    }
  }


}

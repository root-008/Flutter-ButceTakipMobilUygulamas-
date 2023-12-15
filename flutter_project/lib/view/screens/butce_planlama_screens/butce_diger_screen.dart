// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/api/apis.dart';
import 'package:flutter_project/models/budget_planning_model.dart';
import 'package:flutter_project/services/budget_planning_service.dart';
import 'package:flutter_project/view/widgets/budget_planning_widget.dart';
import 'package:intl/intl.dart';

class ButceDiger extends StatefulWidget {
  const ButceDiger({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ButceDigerState();
}

class ButceDigerState extends State<ButceDiger> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GelirService _gelirService = GelirService();
  final GelirWidget _gelirWidget = GelirWidget();

  @override
  void initState() {
    super.initState();
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 12, 31),
    end: DateTime.now().add(Duration(days: 1)),
  );


  @override
  Widget build(BuildContext context) {
    final startDate = dateRange.start;
    final endDate = dateRange.end;

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.1),
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: pickDateRange,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  primary: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Başlangıç Tarihi",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(startDate),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: pickDateRange,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Bitiş Tarihi",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(endDate),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceWidth - 20,
                  height: deviceHeight * 0.74,
                  child: FutureBuilder(
                    future: _gelirService.getData(
                        Apis.getGelirApi, "8", startDate, endDate),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Gelir>> snapshot) {
                      if (snapshot.hasData) {
                        List<Gelir> _gelirler = snapshot.data!;
                        //print('Gelirler: ${_gelirler.length}');
                        return ListView(
                          children: _gelirler.map((document) {
                            return Card(
                              color: Colors.black12,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _gelirWidget.showGelirDetails(context,
                                      document.id, "8", startDate, endDate);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 20),
                                      child: Text(
                                        document.id.toString(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        document.type,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${document.tutar.toStringAsFixed(2)} TL',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      child: IconButton(
                                        icon: const Icon(Icons.update_rounded),
                                        onPressed: () {
                                          //print(document.id.toString());
                                          _showAmountUpdate(document.id,
                                              document.tutar.toString());
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          var updatedList;
                                          _gelirService.gelirAmountDelete(
                                              document.id,
                                              Apis.deleteGelirAmountApi);
                                          setState(() {
                                            _gelirler = updatedList;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    },
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: deviceHeight * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.deepPurpleAccent.withOpacity(0.5),
                        width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_backspace),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        onPressed: () async {
                          int userId = await _gelirService.getUserId();
                          _showAddAmount(userId);
                        },
                        child: const Text(
                          'Tutar Ekle',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        onPressed: () async {
                          int userId = await _gelirService.getUserId();
                          _showAddSubCategoryDialog(userId);
                        },
                        child: const Text(
                          'Yeni Diğer Türü Ekle',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        onPressed: () async {
                          int userId = await _gelirService.getUserId();
                          setState(() {
                            _showDeleteSubCategoryDialog(userId);
                          });
                        },
                        child: const Text(
                          'Diğer Türü Sil',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Future<void> _showAddAmount(int userId) async {
    var select_dataItem, amount;
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Diğer Ekle"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                      future: _gelirService.getCategoriesForUser(
                          userId, "${Apis.getGelirCategoriesApi}8"),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<GetGelirCategories>>
                          snapshot) {
                        if (snapshot.hasData) {
                          //List<GetGelirCategories> _categories = snapshot.data!;
                          //print('_categories: ${_categories.length}');
                          return Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: snapshot.data?.map((value) {
                                    return DropdownMenuItem(
                                      value: value.id,
                                      child: Text(
                                        value.type,
                                      ),
                                    );
                                  }).toList(),
                                  value: select_dataItem == ""
                                      ? null
                                      : select_dataItem,
                                  onChanged: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      select_dataItem = v;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: const Text('Diğer Türü'),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text('Yükleniyor...');
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Tutar:',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen Tutar Bilgisini giriniz';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    _gelirService.saveAmount(context, userId,
                        select_dataItem, amount, Apis.saveGelirAmountApi);
                  });
                },
                child: const Text('Kaydet')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('İptal'))
          ],
        ));
  }

  Future<void> _showDeleteSubCategoryDialog(int userId) async {
    var selectDataItem;
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Diğer Türü Kaldır"),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder(
                    future: _gelirService.getCategoriesForUser(
                        userId, "${Apis.getGelirCategoriesApi}8"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<GetGelirCategories>> snapshot) {
                      if (snapshot.hasData) {
                        //List<GetGelirCategories> _categories = snapshot.data!;
                        //print('_categories: ${_categories.length}');
                        return Column(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: snapshot.data?.map((value) {
                                  return DropdownMenuItem(
                                    value: value.id,
                                    child: Text(
                                      value.type,
                                    ),
                                  );
                                }).toList(),
                                value: selectDataItem == ""
                                    ? null
                                    : selectDataItem,
                                onChanged: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  setState(() {
                                    selectDataItem = v;
                                  });
                                },
                                isExpanded: true,
                                hint: const Text('Diğer Türü'),
                              ),
                            ),
                          ],
                        );
                      }
                      return const Text('Yükleniyor...');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _gelirService.deleteSubCategory(context, userId, selectDataItem,
                    8 /*categoryId*/, Apis.deleteGelirSubCategoriesApi);
              });
            },
            child: const Text('Sil'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'))
        ],
      ),
    );
  }

  Future<void> _showAddSubCategoryDialog(int userId) async {
    late String gelirType;
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Diğer Türü Ekle'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Diğer Türü',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Geçerli bir Diğer Türü giriniz';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      gelirType = value;
                    });
                  },
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _gelirService.saveSubCategory(context, userId, gelirType,
                      Apis.saveGelirSubCategoriesApi, 8 /*categoryId*/);
                },
                child: const Text('Kaydet')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('İptal'))
          ],
        ));
  }

  Future<void> _showAmountUpdate(int amountId, String amount) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Tutarı Güncelle"),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.attach_money),
                      labelText: 'Tutar:',
                    ),
                    initialValue: amount,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen Tutar Bilgisini giriniz';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                _gelirService.gelirAmountUpdate(
                    context, amountId, amount, Apis.updateGelirAmountApi);
              },
              child: const Text('Güncelle')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'))
        ],
      ),
    );
  }
}

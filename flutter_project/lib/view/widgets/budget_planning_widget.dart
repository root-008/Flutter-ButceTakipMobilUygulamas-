import 'package:flutter/material.dart';
import 'package:flutter_project/api/apis.dart';
import 'package:flutter_project/models/budget_planning_model.dart';
import 'package:flutter_project/services/budget_planning_service.dart';
import 'package:intl/intl.dart';

class GelirWidget{

  final GelirService _gelirService = GelirService();

  Future showGelirDetails(BuildContext context,int userId,String categoryId,DateTime start,DateTime end) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Detaylar'),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: _gelirService.getData(Apis.getGelirApi,categoryId,start,end),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Gelir>> snapshot) {
                    if (snapshot.hasData) {
                      List<Gelir> gelirler = snapshot.data!;
                      Gelir gelir = gelirler.where((e) => e.id == userId).first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDetailRow("Tür:", gelir.type),
                          const SizedBox(height: 10),
                          buildDetailRow(
                              "Tutar:", "${gelir.tutar.toStringAsFixed(2)} ₺"),
                          const SizedBox(height: 10),
                          buildDetailRow(
                              "Oluşturma Tarihi:",
                              DateFormat('dd/MM/yyyy')
                                  .format(gelir.creationTime)),
                          buildDetailRow("Oluşturma Saati:",
                              DateFormat('HH:mm').format(gelir.creationTime)),
                          const SizedBox(height: 10),
                          buildDetailRow(
                              "Güncelleme Tarihi:",
                              DateFormat('dd/MM/yyyy')
                                  .format(gelir.updateTime)),
                          buildDetailRow("Güncelleme Saati:",
                              DateFormat('HH:mm').format(gelir.updateTime)),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
      ],
    );
  }

}

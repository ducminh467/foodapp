import '../models/history_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryManager {
  HistoryManager();

  CollectionReference history = FirebaseFirestore.instance.collection('history');


  Future<void> addHistory(History historyItem) {
    return history
        .doc()
        .set({
      'products': historyItem.toMapList(),
      'tenNguoiMua': historyItem.tenNguoiMua,
      'emailNguoiMua': historyItem.emailNguoiMua,
      'ngayMua': "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      'total': historyItem.total
    });
  }



}
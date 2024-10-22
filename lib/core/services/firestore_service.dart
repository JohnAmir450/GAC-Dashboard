import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gac_dashboard/core/services/database_service.dart';

class FireStoreService extends DatabaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await fireStore.collection(path).doc(documentId).set(data);
    } else {
      await fireStore.collection(path).add(data);
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String documentId}) async {
    var data = await fireStore.collection(path).doc(documentId).get();
    if (data.exists) {
      return true;
    }
    return false;
  }

  @override
  Future getData(
      {required String path,
      String? documentId,
      Map<String, dynamic>? query}) async {
    if (documentId != null) {
      var data = await fireStore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      Query<Map<String, dynamic>> data = fireStore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descendingField = query['descending'];
          data = data.orderBy(orderByField, descending: descendingField);
        }
        if (query['limit'] != null) {
          var limitField = query['limit'];
          data = data.limit(limitField);
        }
      }
      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }
}

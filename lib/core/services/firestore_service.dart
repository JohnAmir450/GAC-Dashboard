import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';
import 'package:gac_dashboard/core/services/database_service.dart';

class FireStoreService extends DatabaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Future<void> addData( 
      {required String path,
      required Map<String, dynamic> data,
      String? documentId,
    
      }) async {
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
Future<dynamic> getData({
  required String path,
  String? documentId,
  Map<String, dynamic>? query,
  String? filterValueEqualTo,
  String? filterValue, // Add this optional parameter for user-specific queries
}) async {
  try {
    // If documentId is provided, fetch the document by its ID
    if (documentId != null) {
      var data = await fireStore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      // Query the collection
      Query<Map<String, dynamic>> data = fireStore.collection(path);

      // If userId is provided, filter the query by userId (only for orders)
      if (filterValueEqualTo != null &&filterValue != null) {
        data = data.where(filterValue, isEqualTo: filterValueEqualTo);
      }

      // Apply additional query filters if provided
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending']??false;
           
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
        if (query['where'] != null && query['isEqualTo'] != null) {
          data = data.where(query['where'], isEqualTo: query['isEqualTo']);
        }
      }

      // Fetch the data from Firestore
      var result = await data.get();

      // Return the fetched data
      return result.docs.map((e) => e.data()).toList();
    }
  } catch (e) {
    throw CustomException(message: 'Failed to fetch data: ${e.toString()}');
  }
}
 
  
   @override
    Stream<List<Map<String, dynamic>>> getDataStream({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) {
    Query<Map<String, dynamic>> data = fireStore.collection(path);

    if (documentId != null) {
      return fireStore.collection(path).doc(documentId).snapshots().map((snapshot) {
        return [snapshot.data() as Map<String, dynamic>];
      });
    } else {
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }

      return data.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    }
  }
  
  @override
  Future<void> updateProduct({required String path,required String documentId,  Map<String, dynamic>? data}) async {
    try {
  await fireStore.collection(path).doc(documentId).update(data!);
}  catch (e) {
  throw CustomException(message: e.toString());
}
  }

  @override
  Future<List<String>> getDocumentIdsByField({
  required String path,
  required String field,
  required dynamic value,
}) async {
  try {
    final snapshot = await fireStore.collection(path).where(field, isEqualTo: value).get();
    return snapshot.docs.map((doc) => doc.id).toList();
  } catch (e) {
    throw CustomException(message: 'Failed to retrieve document ID by field: ${e.toString()}');
  }
}

  @override
  Future<void> deleteProduct({required String path, required String documentId}) {
    try {
  return fireStore.collection(path).doc(documentId).delete();
} on CustomException catch (e) {
  throw CustomException(message: 'حدث خطأ ما، حاول مرة اخرى');
}
  }


}

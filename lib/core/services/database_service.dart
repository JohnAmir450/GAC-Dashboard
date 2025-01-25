abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId});
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
    String? filterValueEqualTo,
    String? filterValue,
  });

  Future<bool> checkIfDataExists(
      {required String path, required String documentId});

  Stream<List<Map<String, dynamic>>> getDataStream(
      {required String path, String? documentId, Map<String, dynamic>? query});

  Future<void> updateProduct(
      {required String path,
      required String documentId,
      Map<String, dynamic>? data});
  Future<void> deleteProduct(
      {required String path, required String documentId});
  Future<List<String>> getDocumentIdsByField({
    required String path,
    required String field,
    required dynamic value,
  });
}

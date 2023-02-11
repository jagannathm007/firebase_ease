import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreService {

  CollectionReference getCollectionRef(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  Future getAll(CollectionReference ref) async {
    try {
      QuerySnapshot querySnapshot = await ref.get();
      List dataList = querySnapshot.docs.map((doc) => doc.data()).toList();
      return dataList;
    } catch (err) {
      return 0;
    }
  }

  Future getByLimit(CollectionReference ref, DocumentSnapshot? lastDocument, int limit) async {
    try {
      QuerySnapshot? querySnapshot;
      if (lastDocument == null) {
        querySnapshot = await ref.orderBy("createdAt", descending: true).limit(limit).get();
      } else {
        querySnapshot = await ref.orderBy("createdAt", descending: true).startAfterDocument(lastDocument).limit(limit).get();
      }
      List dataList = querySnapshot.docs.map((doc) => doc.data()).toList();
      return dataList;
    } catch (err) {
      return 0;
    }
  }

  Future<int> create(CollectionReference ref, Map<String, dynamic> json) async {
    try {
      final myUuid = const Uuid().v4();
      json["id"] = myUuid;
      json["createdAt"] = DateTime.now();
      await ref.doc(json["id"]).set(json);
      return 1;
    } catch (err) {
      return 0;
    }
  }

  Future<int> updateById(String documentId, Map<String, dynamic> json, CollectionReference ref) async {
    try {
      ref.doc(documentId).update(json);
      return 1;
    } catch (err) {
      return 0;
    }
  }

  Future<int> deleteById(String documentId, CollectionReference ref) async {
    try {
      await ref.doc(documentId).delete();
      return 1;
    } catch (err) {
      return 0;
    }
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs.map((snapshot) => builder(snapshot.data() as Map<String, dynamic>, snapshot.id)).where((value) => value != null).toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }

}
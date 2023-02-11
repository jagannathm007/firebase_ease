import 'dart:io';
import 'package:firebase_ease/services/function_response.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<FunctionResponse> uploadFile(File file) async {
    try {
      final myUuid = const Uuid().v4();
      String fileName = "$myUuid.${file.path.split(".").last}";
      Reference uploadTask = storageRef.child("uploads/$fileName");
      await uploadTask.putFile(file);
      String fileURL = await uploadTask.getDownloadURL();
      return FunctionResponse(message: "file uploaded!", data: fileURL);
    } on FirebaseException catch (e) {
      return FunctionResponse(message: e.toString(), data: null);
    }
  }
}
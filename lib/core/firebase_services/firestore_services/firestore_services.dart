import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telead/core/firebase_services/firestore_services/data_services.dart';

class FireStoreServices extends DataBaseServices{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path , required Map<String,dynamic>data
})async{
    await firestore.collection(path).add(data);

  }
}
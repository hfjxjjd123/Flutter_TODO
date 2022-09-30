import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/data/stuff_model.dart';

class StuffService{
  Future uploadNewStuff(StuffModel stuffModel, String day, String todo) async{
    DocumentReference<Map<String, dynamic>> stuffDocReference = FirebaseFirestore.instance.collection('AllStuffs').doc(day).collection('stuffs').doc(todo);
    final DocumentSnapshot documentSnapshot = await stuffDocReference.get();

    if(!documentSnapshot.exists){
      await stuffDocReference.set(stuffModel.toJson());
    }
  }


  Future<List<StuffModel>> getAllStuffs(String day) async{
    CollectionReference<Map<String,dynamic>> collectionReference =  FirebaseFirestore.instance.collection('AllStuffs').doc(day).collection('stuffs');
    QuerySnapshot<Map<String, dynamic>> snapshots = await collectionReference.get();

    List<StuffModel> products = [];

    for(int i=0; i<snapshots.size ; i++){
      StuffModel stuffModel = StuffModel.fromQuerySnapshot(snapshots.docs[i]);
      products.add(stuffModel);
    }

    return products;
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/data/stuff_model.dart';

class StuffService{
  static Future uploadNewStuff(StuffModel stuffModel) async{
    DocumentReference<Map<String, dynamic>> stuffDocReference = FirebaseFirestore.instance
        .collection('AllStuffs').doc(stuffModel.day)
        .collection('stuffs').doc(stuffModel.todo);

    final DocumentSnapshot documentSnapshot = await stuffDocReference.get();

    if(!documentSnapshot.exists){
      await stuffDocReference.set(stuffModel.toJson());
    }
  }

  static Future updateStuff(StuffModel stuffModel) async{
    DocumentReference<Map<String, dynamic>> preStuffDocReference = FirebaseFirestore.instance
        .collection('AllStuffs').doc(stuffModel.day)
        .collection('stuffs').doc(stuffModel.todo);

    final DocumentSnapshot documentSnapshot = await preStuffDocReference.get();

    if(!documentSnapshot.exists){
      print("not exist");
    } else await preStuffDocReference.update(stuffModel.toJson());
  }

//수정과 생성을 나누면?//수정은 바뀐 onCOunt값을?

  static Future<List<StuffModel>> getAllStuffs(String day) async{
    CollectionReference<Map<String,dynamic>> collectionReference =  FirebaseFirestore.instance
        .collection('AllStuffs').doc(day).collection('stuffs');
    QuerySnapshot<Map<String, dynamic>> snapshots = await collectionReference.get();

    List<StuffModel> products = [];

    for(int i=0; i<snapshots.size ; i++){
      StuffModel stuffModel = StuffModel.fromQuerySnapshot(snapshots.docs[i]);
      products.add(stuffModel);
    }

    return products;
  }

  static Future<void> deleteStuff(StuffModel stuffModel) async{
    DocumentReference<Map<String, dynamic>> docReference = FirebaseFirestore.instance
        .collection('AllStuffs').doc(stuffModel.day)
        .collection('stuffs').doc(stuffModel.todo);

    final DocumentSnapshot documentSnapshot = await docReference.get();

    if(documentSnapshot.exists){
      await docReference.delete();
    } else{
      print("there is no such data model");
    }

  } // test this code in home


}
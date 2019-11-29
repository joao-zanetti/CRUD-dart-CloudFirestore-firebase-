/*
    Developed by João Zanetti
    https://github.com/joao-zanetti
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


//VERIFY IF USER LOGGED IN
class crudMethods{
  bool isLogged(){
    if(FirebaseAuth.instance.currentUser()!=null){
      return true;
    }else{
      return false;
    }
  }

  //ADD USER DATA IN DATABASE
  Future<void> addData(userData) async{
    if(isLogged()){
      Firestore.instance.collection('users')
        .add(userData)
        .catchError((e){
          print(e);
          });
    }
    else{
      print('You need to be logged in');
    }
  }

  //UPDATE USER DATA IN DATABASE
  updateData(selectedDoc, newValues){
    Firestore.instance
      .collection('users')
      .document(selectedDoc)
      .updateData(newValues)
      .catchError((e){
        print(e);
      });
  }

  //GET USERS DATA IN DATABASE
  getData() async {
    return await Firestore.instance.collection('users').snapshots();
  }

  //GET USER DATA IN DATABASE
  getDatauserfb(String userName) async{
    return await Firestore.instance
    .collection('users')
    .where('username',isEqualTo: userName)
    .getDocuments()
    .catchError((e){
        print(e);
      });
  }


  //VERIFY IF USER HAVE A REGISTERED E-MAIL IN DATABASE
  verifyDatauserfb(String userName) async{
    var ver= await Firestore.instance
    .collection('users')
    .where('username',isEqualTo: userName);
    if(ver!=null)
      return true;
  }
}
import 'package:amal_firebase/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final String collectionName = 'users';

Future<String> registerByEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> loginByEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}

singOut() async {
  auth.signOut();
}

String getUserId() {
  String id = auth.currentUser != null ? auth.currentUser.uid : null;
  return id;
}

saveDummyDataFromFireStore() async {
  DocumentReference documentReference =
      await firebaseFirestore.collection(collectionName).add({
    'name': 'Ahmad',
    'age': 60,
    'family': {'sons': 2, 'daugthar': 4, 'address': 'Gaza'},
    'work': ['teacher', 'Driver']
  });
  print(documentReference.id);
}

setSpecificUserId() async {
  firebaseFirestore.collection(collectionName).doc('mother').set({
    'name': 'Ahmad',
    'age': 60,
    'family': {'sons': 2, 'daugthar': 4, 'address': 'Gaza'},
    'work': ['teacher', 'Driver']
  });
}

Future<List<UserData>> readDummyDataFromFireStore() async {
  QuerySnapshot querySnapshot =
      await firebaseFirestore.collection(collectionName).get();
  List<QueryDocumentSnapshot> documentSnapshot = querySnapshot.docs;
  List<UserData> docList =
      documentSnapshot.map((e) => UserData.fromMap(e.data())).toList();
  return docList;
}

saveUser(Map map) async {
  String userId = await registerByEmailPassword(map['email'], map['password']);
  print(userId);
  map.remove('password');
  map['userId'] = userId;
  firebaseFirestore.collection('Users').doc(userId).set({...map});
}

import 'package:amal_firebase/backend/server.dart';
import 'package:amal_firebase/model/user.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('SAVE DATA'),
                onPressed: () {
                  setSpecificUserId();
                }),
            RaisedButton(
                child: Text('READ DATA'),
                onPressed: ()async {
                  List<UserData> users=await   readDummyDataFromFireStore();
                  print(users[0].name);
                }),
          ],
        ),
      ),
    );
  }
}

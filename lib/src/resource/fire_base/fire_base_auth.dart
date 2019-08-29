import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String password, String name, String phone, Function onSuccess) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      _createUser(user.user.uid, name, phone, onSuccess);

      print(user);
    }).catchError((err) {
      print(err);
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = {
      "name" : name,
      "phone" : phone,
    };

    var ref = FirebaseDatabase.instance.reference().child("Users");
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      //
    });
  }
}
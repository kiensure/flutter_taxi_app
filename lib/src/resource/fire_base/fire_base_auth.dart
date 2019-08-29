import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class FireAuth {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String password, String name, String phone, Function onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      _createUser(user.user.uid, name, phone, onSuccess, onRegisterError);

      print(user);
    }).catchError((err) {
      _onSignUpError(err.code, onRegisterError);
      print(err);
    });
  }

  void signIn(String email, String pass, Function onSuccess, Function(String) onSignInError) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      onSuccess();
    }).catchError((err) {
      print(err);
      _onSignInError(err.code, onSignInError);
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess, Function(String) onRegisterError) {
    var user = {
      "name" : name,
      "phone" : phone,
    };

    var ref = FirebaseDatabase.instance.reference().child("Users");
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onRegisterError('Đăng ký thất bại, vui lòng thử lại sau');
    });
  }

  _onSignUpError(String code, Function(String) onRegisterError) {
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
        onRegisterError('Email sai định dạng');
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        onRegisterError('Email đã tồn tại');
        break;
      case 'ERROR_WEAK_PASSWORD':
        onRegisterError('Mật khẩu yếu');
        break;
      default:
        onRegisterError('Đăng ký thất bại, vui lòng thử lại sau');
        break;
    }
  }

  _onSignInError(String code, Function(String) onSignInError) {
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
        onSignInError('Email sai định dạng');
        break;
      case 'ERROR_WRONG_PASSWORD':
        onSignInError('Sai tên đăng nhập hoặc mật khẩu');
        break;
      case 'ERROR_USER_NOT_FOUND':
        onSignInError('Email chưa được đăng ký');
        break;
      default:
        onSignInError('Đăng nhập thất bại, vui lòng thử lại sau');
        break;
    }
  }
}
import 'dart:async';

import 'package:taxi_app/src/resource/fire_base/fire_base_auth.dart';


class AuthBloc {
  var _fireAuth = FireAuth();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String name, String email, String pass, String phone) {

    bool isValid = true;

    if(name == null || name.length == 0) {
      _nameController.sink.addError('Nhập tên');
      isValid = false;
    } else {
      _nameController.sink.add("");
    }

    if(phone == null || phone.length == 0) {
      _phoneController.sink.addError('Nhập số điện thoại');
      isValid = false;
    } else {
      _phoneController.sink.add("");
    }

    if(email == null || email.length == 0) {
      _emailController.sink.addError('Nhập email');
      isValid = false;
    } else {
      _emailController.sink.add("");
    }

    if(pass == null || pass.length < 6) {
      _passController.sink.addError('Mật khẩu phải trên 5 ký tự');
      isValid = false;
    } else {
      _passController.sink.add("");
    }

    return isValid;
  }

  void signUp(String email, String password, String phone, String name, Function onSuccess) {
    _fireAuth.signUp(email, password, name, phone, onSuccess);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
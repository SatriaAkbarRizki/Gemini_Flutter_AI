import 'package:aispeak/databases/databases_user.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _list = [];
  List<UserModel> get data => _list;
  DatabasesUser databasesUser = DatabasesUser();

  UserProvider() {
    databasesUser.checkDatabase().whenComplete(() => getAllData());
  }

  Future getAllData() async {
    await databasesUser.all().then((value) => _list = value);
    notifyListeners();
    return _list;
  }

  Future insertData(String? username, String? image) async {
    await databasesUser
        .insert(UserModel(0, username: username, image: image))
        .whenComplete(() => getAllData());
  }

  Future deleteData(int index) async {
    await databasesUser.delete(index);
  }

  Future updateData(String username, String image) async {
    await databasesUser.update(UserModel(0, username: username, image: image));
    notifyListeners();
  }
}

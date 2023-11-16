import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static final SharedPref _instance = SharedPref._();
  static SharedPref get instance => _instance;

  final userId = 'userId';
  final token = 'token';

  late final SharedPreferences storage;

  initSharedPref() async {
    storage = await SharedPreferences.getInstance();
  }

  setUser(String userToken) async {
    await storage.setString(token, userToken);
  }

  setUserId(String userID) async {
    await storage.setString(userId, userID);
  }

  logOutUser() {
    storage.remove(token);
    storage.remove(userId);
  }

  String? getUser() => storage.getString(token);
  String? getUserId() => storage.getString(userId);
}

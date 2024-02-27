import 'package:app/models/user.dart';
import 'package:hive/hive.dart';

class LocalAuthService {
  late Box<String> _token;
  late Box<User> _user;

  Future<void> init() async {
    _token = await Hive.openBox<String>("token");
    _user = await Hive.openBox<User>("user");
  }

  Future<void> addToken({required String token}) async {
    await _token.put("token", token);
  }

  Future<void> addUser({required User user}) async {
    await _user.put("user", user);
  }

  Future<void> clear() async{
    await _token.clear();
    await _user.clear();
  }

  String? getToken() => _token.get("token");
  User? getUser() => _user.get("user");
}

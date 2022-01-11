
import 'package:shared_preferences/shared_preferences.dart';

///If using flavors, delete this part
const HOMOLOG_URL = '';
const PROD_URL = '';
const DEV_URL = '';

const ENV = "DEV";

const DOMAIN_URL = ENV == "HOMOLOG" ? HOMOLOG_URL : ENV == "PROD" ? PROD_URL : DEV_URL;
const BASE_URL = "$DOMAIN_URL/api";

const CLIENT_ID = '';
const CLIENT_SECRET = '';

class Authentication {
  static String _tokenKey = "token";

  static Future<bool> authenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  static void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }

  static void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey)!;
  }
}

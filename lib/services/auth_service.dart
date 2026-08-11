import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://192.168.17.108:8000";

  // ==================================================
  // SIGN UP
  // ==================================================

  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/signup");

      print("Calling Signup API: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print("Signup Status: ${response.statusCode}");
      print("Signup Response: ${response.body}");

      if (response.statusCode != 200) {
        return {
          "success": false,
          "message": "Server error: ${response.statusCode}",
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print("Signup API Error: $e");

      return {
        "success": false,
        "message": "Failed to connect with JECTX backend",
      };
    }
  }

  // ==================================================
  // LOGIN
  // ==================================================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/login");

      print("Calling Login API: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("Login Status: ${response.statusCode}");
      print("Login Response: ${response.body}");

      if (response.statusCode != 200) {
        return {
          "success": false,
          "message": "Server error: ${response.statusCode}",
        };
      }

      final data = jsonDecode(response.body);

      // ==================================================
      // SAVE LOGIN SESSION
      // ==================================================

      if (data["success"] == true) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isLoggedIn", true);

        if (data["user"] != null) {
          await prefs.setInt(
            "userId",
            data["user"]["id"],
          );

          await prefs.setString(
            "userName",
            data["user"]["name"],
          );

          await prefs.setString(
            "userEmail",
            data["user"]["email"],
          );
        }
      }

      return data;
    } catch (e) {
      print("Login API Error: $e");

      return {
        "success": false,
        "message": "Failed to connect with JECTX backend",
      };
    }
  }

  // ==================================================
  // CHECK WHETHER USER IS LOGGED IN
  // ==================================================

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isLoggedIn") ?? false;
  }

  // ==================================================
  // GET USER NAME
  // ==================================================

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("userName");
  }

  // ==================================================
  // GET USER EMAIL
  // ==================================================

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("userEmail");
  }

  // ==================================================
  // LOGOUT
  // ==================================================

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
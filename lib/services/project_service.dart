import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectService {
  static const String baseUrl = "http://192.168.17.108:8000";

  Future<List<dynamic>> getProjects({
    required String domain,
    required String level,
  }) async {
    final url = Uri.parse("$baseUrl/projects/$domain/$level");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["projects"];
    } else {
      throw Exception("Failed to load projects");
    }
  }
}
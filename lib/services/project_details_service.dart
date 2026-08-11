import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectDetailsService {
   static const String baseUrl = "http://192.168.17.108:8000";

  Future<Map<String, dynamic>> generateProjectDetails({
    required String title,
    required String projectType,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/generate-project-details"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "project_type": projectType,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String baseUrl = "http://192.168.17.108:8000";

  static Future<String> generateProjectIdea(
    String field,
    String level,
  ) async {
    try {
      final url = Uri.parse(
        "$baseUrl/generate-project-ideas",
      );

      print("Calling Gemini Idea API: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "field": field,
          "level": level,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode != 200) {
        return "Backend Error: ${response.statusCode}";
      }

      final data = jsonDecode(response.body);

      if (data["error"] != null) {
        return "Backend Error: ${data["error"]}";
      }

      final ideas = data["ideas"];

      if (ideas == null || ideas is! List) {
        return "No project ideas were generated.";
      }

      String result = "";

      for (var project in ideas) {
        final technologies = project["technologies"];

        result +=
            "Project Name:\n"
            "${project["title"]}\n\n"
            "Description:\n"
            "${project["description"]}\n\n"
            "Technologies:\n"
            "${technologies is List ? technologies.join(", ") : technologies}\n\n"
            "Difficulty:\n"
            "${project["difficulty"]}\n\n"
            "----------------------------\n\n";
      }

      return result;
    } catch (e) {
      print("API Error: $e");

      return "Failed to connect with JECTX backend";
    }
  }
}
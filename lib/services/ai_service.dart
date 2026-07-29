import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {

static const String baseUrl = "http://192.168.186.108:8000";
  static Future<String> generateProjectIdea(
    String field,
    String level,
  ) async {

    try {

      final url =
          "$baseUrl/project-ideas?field=$field&level=$level";


      print("Calling API: $url");


      final response = await http.get(
        Uri.parse(url),
      );


      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");


      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);


        final projects = data["projects"];


        String result = "";


        for (var project in projects) {

          result +=
              "Project Name:\n"
              "${project["title"]}\n\n"
              "Description:\n"
              "${project["description"]}\n\n"
              "----------------------------\n\n";

        }


        return result;


      } else {

        return "Backend Error: ${response.statusCode}";

      }


    } catch (e) {

      print("API Error: $e");

      return "Failed to connect with JECTX backend";

    }

  }

}
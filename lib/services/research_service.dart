import 'dart:convert';
import 'package:http/http.dart' as http;

class ResearchService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<List<dynamic>> searchPapers(String project) async {
    try {
      final url =
          "$baseUrl/search-papers?project=${Uri.encodeComponent(project)}";

      print("Searching URL:");
      print(url);

      final response = await http.get(Uri.parse(url));

      print("Status Code:");
      print(response.statusCode);

      print("Response Body:");
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("Decoded JSON:");
        print(data);

        if (data["papers"] != null) {
          return data["papers"];
        } else {
          return [];
        }
      } else {
        print("API returned an error.");
        return [];
      }
    } catch (e) {
      print("Exception:");
      print(e);
      return [];
    }
  }
}
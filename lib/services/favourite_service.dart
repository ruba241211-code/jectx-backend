import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteService {
  static const String _key = "favourites";

  // ============================================================
  // GET ALL FAVOURITES
  // ============================================================

  static Future<List<Map<String, dynamic>>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_key);

    if (data == null || data.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(data);

      return decoded
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // ============================================================
  // ADD FAVOURITE
  // ============================================================

  static Future<void> addFavourite({
    required String type,
    required String title,
    required String description,
    String? url,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final favourites = await getFavourites();

    // Prevent duplicate favourites
    final alreadyExists = favourites.any(
      (item) =>
          item["type"] == type &&
          item["title"] == title,
    );

    if (alreadyExists) {
      return;
    }

    favourites.add({
      "type": type,
      "title": title,
      "description": description,
      "url": url ?? "",
    });

    await prefs.setString(
      _key,
      jsonEncode(favourites),
    );
  }

  // ============================================================
  // REMOVE FAVOURITE
  // ============================================================

  static Future<void> removeFavourite({
    required String type,
    required String title,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final favourites = await getFavourites();

    favourites.removeWhere(
      (item) =>
          item["type"] == type &&
          item["title"] == title,
    );

    await prefs.setString(
      _key,
      jsonEncode(favourites),
    );
  }

  // ============================================================
  // CHECK WHETHER ITEM IS FAVOURITE
  // ============================================================

  static Future<bool> isFavourite({
    required String type,
    required String title,
  }) async {
    final favourites = await getFavourites();

    return favourites.any(
      (item) =>
          item["type"] == type &&
          item["title"] == title,
    );
  }

  // ============================================================
  // CLEAR ALL FAVOURITES
  // ============================================================

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}
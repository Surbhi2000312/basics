import 'dart:convert';

import 'package:basics/SP/sp_helper.dart';

class SpManager {
  static Future<List<String>> createOrRetrieveList(int id) async {
    await SpHelper.init();
    String listKey = 'list_$id';

    // Retrieve the list by ID (key)
    String? listJson = await SpHelper.getString(listKey);
    if (listJson != null) {
      return List<String>.from(json.decode(listJson));
    } else {
      // Create a new list with the length of ID
      List<String> newList = List<String>.filled(id, "", growable: true);
      await SpHelper.setString(listKey, json.encode(newList));
      return newList;
    }
  }

  static Future<void> setList(int id, List<String> list) async {
    await SpHelper.init();
    String listKey = 'list_$id';
    await SpHelper.setString(listKey, json.encode(list));
  }

  static Future<List<String>?> getList(int id) async {
    await SpHelper.init();
    String listKey = 'list_$id';
    String? listJson = await SpHelper.getString(listKey);
    if (listJson != null) {
      return List<String>.from(json.decode(listJson));
    } else {
      return null;
    }
  }
}
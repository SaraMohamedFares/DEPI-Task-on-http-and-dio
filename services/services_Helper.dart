import 'dart:convert';
import 'package:depi/models/item_Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServicesHelper {
  static const String baseUrl = "https://68b71de173b3ec66cec3d740.mockapi.io";

  static Future<List<Item>> getItems() async {
    final String url = "$baseUrl/depi/expense_tracker/expense/";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.body;
      final itemsMap = jsonDecode(dataFromServer) as List;
      final items = itemsMap.map((e) => Item.fromMap(e)).toList();
      return items;
    } else {
      throw Exception("Failed to load items");
    }
  }

  static Future<void> addItem(Item item, BuildContext context) async {
    try {
      final String url = "$baseUrl/depi/expense_tracker/expense/";
      final uri = Uri.parse(url);
      final response = await http.post(uri, body: jsonEncode(item.toMap()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        final dataFromServer = response.body;
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(dataFromServer)));
        }
      } else {
        throw Exception("Failed to post item");
      }
    }catch(e){
      debugPrint("Error adding data: $e");
    }
  }

  static Future<void> updateItem(Item item, BuildContext context) async {
    final String url = "$baseUrl/depi/expense_tracker/expense/${item.id}";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(item.toMap()),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.body;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dataFromServer)));
      }
    } else {
      throw Exception("Failed to put item");
    }
  }

  static Future<void> deleteItem(String id, BuildContext context) async {
    final String url = "$baseUrl/depi/expense_tracker/expense/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.body;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dataFromServer)));
      }
    } else {
      throw Exception("Failed to delete item");
    }
  }
}

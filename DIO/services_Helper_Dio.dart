import 'dart:convert';
import 'package:depi/models/item_Model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ServicesHelperDio {
  static const String baseUrl = "https://68b71de173b3ec66cec3d740.mockapi.io";
  static final _dio = Dio();

  static Future<List<Item>> getItems() async {
    final String url = "$baseUrl/depi/expense_tracker/expense/";
    final response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        )
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final itemsMap = response.data as List;
      final items = itemsMap.map((e) => Item.fromMap(e)).toList();
      return items;
    } else {
      throw Exception("Failed to load items");
    }
  }

  static Future<void> addItem(Item item, BuildContext context) async {
    final String url = "$baseUrl/depi/expense_tracker/expense/";
    final response = await _dio.post(
      url,
      data: item.toMap(),
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.data;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dataFromServer.toString())));
      }
    } else {
      throw Exception("Failed to post item");
    }
  }


  static Future<void> updateItem(Item item, BuildContext context) async {
    final String url = "$baseUrl/depi/expense_tracker/expense/${item.id}";
    final response = await _dio.put(
        url,
        data: item.toMap(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        )
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.data ;
      if(context.mounted){
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dataFromServer.toString())));
      }
    } else {
      throw Exception("Failed to update item");
    }
  }


  static Future<void> deleteItem(String id, BuildContext context) async {
    final String url = "$baseUrl/depi/expense_tracker/expense/$id";
    final response = await _dio.delete(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final dataFromServer = response.data;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dataFromServer.toString())));
      }
    } else {
      throw Exception("Failed to delete item");
    }

  }

}

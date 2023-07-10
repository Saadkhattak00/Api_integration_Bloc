import 'dart:convert';

import 'package:api_integration_bloc/Models/News_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Repository{
  String url ="https://reqres.in/api/users?page=2";

  Future<List<Welcome>> getapi() async{
    Response response = await get(Uri.parse(url));

    if (response.statusCode ==200) {
      final List result = jsonDecode(response.body)['data'];
      print(response.body);
      return result.map((e) => Welcome.fromJson(e)).toList();

    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }

}
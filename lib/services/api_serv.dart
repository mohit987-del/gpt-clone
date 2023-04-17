import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../constants/api.dart';

class ApiService {
  static Future<List<String>> getModels() async {
    try {
      final modalLink = Uri.parse("$baseurl/models");
      var res = await http.get(
        modalLink,
        headers: {"Authorization": "Bearer $apikey"},
      );
      Map jsonres = json.decode(res.body);
      if (jsonres["error"] != null) {
        throw HttpException(jsonres["error"]["message"]);
      }
      List<String> temp = [];
      for (var i in jsonres["data"] as List) {
        //print( i["id".toString()]);
        temp.add(i["id"].toString());
      }
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> sendMessage(
      {required String message, required String modelid}) async {
    try {
      final modalLink = Uri.parse("$baseurl/completions");
      var res = await http.post(
        modalLink,
        headers: {
          "Authorization": "Bearer $apikey",
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "model": modelid,
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );
      Map jsonres = json.decode(res.body);
      if (jsonres["error"] != null) {
        throw HttpException(jsonres["error"]["message"]);
      }
      if (jsonres["choices"].length > 0) {
        return (jsonres["choices"][0]["text"].toString().trim());
      }
    } catch (e) {
      rethrow;
    }
    return "";
  }

  static Future<String> gptmsg(
      {required String message, required String modelid}) async {
    try {
      final modalLink = Uri.parse("$baseurl/chat/completions");
      var res = await http.post(
        modalLink,
        headers: {
          "Authorization": "Bearer $apikey",
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "model": modelid,
            "messages": [
              {
                "role": "user",
                "content": message,
              },
            ]
          },
        ),
      );
      Map jsonres = json.decode(res.body);
      if (jsonres["error"] != null) {
        throw HttpException(jsonres["error"]["message"]);
      }
      if (jsonres["choices"].length > 0) {
        return (jsonres["choices"][0]["message"]["content"].toString().trim());
      }
    } catch (e) {
      rethrow;
    }
    return "";
  }
}

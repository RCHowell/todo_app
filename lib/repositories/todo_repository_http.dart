import 'dart:convert';
import 'dart:io';

import 'package:todo_app/models/todo.dart';
import 'dart:async';

import 'package:todo_app/repositories/todo_repository.dart';

/// Implementation of a [ToDoRepository] using our REST backend
class ToDoRepositoryHttp implements ToDoRepository {

  /// Where should we point our requests?
  static const String SCHEME = 'http';
  static const String HOST = 'localhost';
  static const int PORT = 1337;

  @override
  Future<String> create(String text) async {
    HttpClient client = new HttpClient();
    Uri url = new Uri(
      scheme: SCHEME,
      host: HOST,
      port: PORT,
      queryParameters: {
        "text": text,
      }
    );
    try {
      HttpClientRequest req = await client.postUrl(url);
      HttpClientResponse res = await req.close();
      if (res.statusCode == HttpStatus.CREATED) return await res.transform(UTF8.decoder).join();
      else throw('Http Error: ${res.statusCode}');
    } catch (exception) {
      throw(exception.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> read() async {
    HttpClient client = new HttpClient();
    Uri url = new Uri(
      scheme: SCHEME,
      host: HOST,
      port: PORT,
    );
    Map<String, dynamic> result = new Map();
    try {
      HttpClientRequest req = await client.getUrl(url);
      HttpClientResponse res = await req.close();
      if (res.statusCode == HttpStatus.OK) {
        String rawJSON = await res.transform(UTF8.decoder).join();
        List<Map<String, dynamic>> list = JSON.decode(rawJSON);
        result['todos'] = list.map((t) => new ToDo.fromJSON(t)).toList();
        return result;
      } else {
        result['error'] = 'Http Error: ${res.statusCode}';
        return result;
      }
    } catch (exception) {
      result['error'] = exception.toString();
      return result;
    }
  }

  @override
  Future<String> update(int id) async {
    HttpClient client = new HttpClient();
    Uri url = new Uri(
      scheme: SCHEME,
      host: HOST,
      port: PORT,
      queryParameters: {
        "id": id.toString(),
      }
    );
    try {
      HttpClientRequest req = await client.putUrl(url);
      HttpClientResponse res = await req.close();
      if (res.statusCode == HttpStatus.OK) return await res.transform(UTF8.decoder).join();
      else throw('Http Error: ${res.statusCode}');
    } catch (exception) {
      throw(exception.toString());
    }
  }

  @override
  Future<String> delete(int id) async {
    HttpClient client = new HttpClient();
    Uri url = new Uri(
      scheme: SCHEME,
      host: HOST,
      port: PORT,
      queryParameters: {
        "id": id.toString(),
      }
    );
    try {
      HttpClientRequest req = await client.deleteUrl(url);
      HttpClientResponse res = await req.close();
      if (res.statusCode == HttpStatus.OK) return await res.transform(UTF8.decoder).join();
      else throw('Http Error: ${res.statusCode}');
    } catch (exception) {
      throw(exception.toString());
    }
  }

}

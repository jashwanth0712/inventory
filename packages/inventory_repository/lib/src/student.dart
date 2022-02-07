import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/constants.dart';
import './handlers/error_handler.dart';
part './service/auth.dart';

class Student {
  Auth auth = Auth();
  final String rollNumber;
  final String collegeMail;
  final String password;
  final String token;
  final String url = URL.base + URL.student;
  Student({
    this.rollNumber = '',
    this.collegeMail = '',
    this.password = '',
    this.token = '',
  });

  Student copyWith(
      {String? rollNumber,
      String? collegeMail,
      String? password,
      String? token}) {
    auth = auth.copyWith(
      rollNumber: rollNumber ?? this.rollNumber,
      collegeMail: collegeMail ?? this.collegeMail,
      password: password ?? this.password,
      token: token ?? this.token,
    );
    return Student(
      rollNumber: rollNumber ?? this.rollNumber,
      collegeMail: collegeMail ?? this.collegeMail,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  Future<dynamic> login() async {
    return await auth.login(url: url + '/login');
  }

  Future<dynamic> signup() async {
    return await auth.signup(url: url + '/signup');
  }

  Future<dynamic> getProducts() async {
    return await _get(url: url + '/products');
  }

  Future<dynamic> getMyProducts() async {
    return await _get(url: url + '/myProducts');
  }

  Future<dynamic> getNotice() async {
    return await _get(url: url + '/notice');
  }

  Future<dynamic> getGuidelines() async {
    return await _get(url: url + '/guidelines');
  }

  Future<dynamic> _get({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    var response = await http.get(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }
}

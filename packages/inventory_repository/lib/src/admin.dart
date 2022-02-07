import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/constants.dart';
import './handlers/error_handler.dart';

part 'service/product.dart';
part 'service/notice.dart';
part 'service/guidelines.dart';

class Admin {
  final String adminName;
  final String adminPassword;
  final String token;
  final String url = URL.base + URL.admin;
  Product product = Product();
  Notice notice = Notice();
  Guidelines guidelines = Guidelines();
  Admin({
    this.adminName = '',
    this.adminPassword = '',
    this.token = '',
  });
  Admin copyWith({
    String? adminName,
    String? adminPassword,
    String? token,
  }) {
    return Admin(
      adminName: adminName ?? this.adminName,
      adminPassword: adminPassword ?? this.adminPassword,
      token: token ?? this.token,
    );
  }

  Future<dynamic> login() async {
    final Uri parsedUrl = Uri.parse(url + '/login');
    var response = await http.post(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, String?>{
          'adminName': adminName,
          'adminPassword': adminPassword,
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      final token = data['data']['token'];
      await _saveToken(token: token);
      _updateToken(token: token);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<void> _saveToken({required String token}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }

  _updateToken({required String token}) {
    product = product.copyWith(token: token);
    notice = notice.copyWith(token: token);
    guidelines = guidelines.copyWith(token: token);
  }
}

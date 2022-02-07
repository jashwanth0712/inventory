part of './../student.dart';

class Auth {
  final String rollNumber;
  final String collegeMail;
  final String password;
  final String token;
  Auth(
      {this.rollNumber = '',
      this.collegeMail = '',
      this.password = '',
      this.token = ''});

  Auth copyWith(
      {String? rollNumber,
      String? collegeMail,
      String? password,
      String? token}) {
    return Auth(
      rollNumber: rollNumber ?? this.rollNumber,
      collegeMail: collegeMail ?? this.collegeMail,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  Future<dynamic> signup({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    var response = await http.post(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, String?>{
          'collegeMail': collegeMail,
          'rollNumber': rollNumber,
          'password': password,
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      final token = data['data']['token'];
      await _saveToken(token: token);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<dynamic> login({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    var response = await http.post(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, String?>{
          'collegeMail': collegeMail,
          'password': password,
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      final token = data['data']['token'];
      await _saveToken(token: token);
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
}

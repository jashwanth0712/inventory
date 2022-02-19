part of './../admin.dart';

class Guidelines {
  final String url = URL.base + URL.admin + '/guidelines';
  final String token;
  Guidelines({
    this.token = '',
  });

  Guidelines copyWith({
    String? token,
  }) {
    return Guidelines(
      token: token ?? this.token,
    );
  }

  Future<dynamic> create({
    required String productName,
    required bool isAvailable,
  }) async {
    final Uri parsedUrl = Uri.parse(url);
    var response = await http.post(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, String?>{
          'productName': productName,
          'isAvailable': isAvailable.toString(),
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<dynamic> getAll() async {
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
      return data['data'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<dynamic> update({
    required guidelinesType type,
    required String data,
    required String id,
  }) async {
    final Uri parsedUrl = Uri.parse(url + '/$id');
    var response = await http.patch(
      parsedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, String?>{
          getTypeFromEnum(
            type: type.toString(),
          ): data,
        },
      ),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<dynamic> get({
    required String id,
  }) async {
    final Uri parsedUrl = Uri.parse(url + '/$id');
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
      return data['data'];
    } else {
      final error = jsonDecode(response.body);
      throw APIRequestError.fromMessage(error['message']);
    }
  }

  Future<dynamic> delete({
    required String id,
  }) async {
    final Uri parsedUrl = Uri.parse(url + '/$id');
    var response = await http.delete(
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

mixin URL {
  // Base URLs
  static const String base = 'https://inventory-dm.herokuapp.com';
  // static const String base = 'http://localhost:8000';
  static const String student = '/api/v1/student';
  static const String admin = '/api/v1/admin';
}

enum noticeType {
  noticeTitle,
  noticeDescription,
}

enum guidelinesType {
  guidelinesTitle,
  guidelines,
}

enum productType {
  productName,
  isAvailable,
  lendHistory,
  productDetails,
}

String getTypeFromEnum({required String type}) {
  return type.split('.')[1];
}

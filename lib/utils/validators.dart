class Validators {
  static final RegExp _mailRegExp = RegExp(
    r"\S+@\S+\.\S+",
  );

  static isValidCollegeMail(String password) {
    return _mailRegExp.hasMatch(password);
  }

  static isValidRollNumber(String rollNumber) {
    return rollNumber.length >= 5;
  }

  static isValidAdminName(String adminName) {
    return adminName.length >= 4;
  }

  static isNotEmpty(String val) {
    return val.isNotEmpty;
  }

  static isValidPassword(String password) {
    return password.length >= 8;
  }
}

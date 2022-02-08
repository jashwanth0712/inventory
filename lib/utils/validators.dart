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

  static isValidPassword(String password) {
    return password.length >= 8;
  }
}

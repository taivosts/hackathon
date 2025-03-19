class Validator {
  Validator._();

  static bool validateFullname(String? fullname) {
    return fullname != null && fullname.isNotEmpty;
  }

  static String? validateFullnameDetail(String? fullname) {
    if (fullname == null || fullname.length <= 3) {
      return 'Data must be greater than 3 characters';
    }

    if (fullname.length >= 25) {
      return 'Data must be smaller than 25 characters';
    }

    if (fullname.length >= 25) {
      return 'Data must be smaller than 25 characters';
    }

    if (!_containsNoDigits(fullname)) {
      return 'Data must not have number';
    }

    return null;
  }

  static bool validateBirthday(DateTime? birthday) {
    return birthday != null;
  }

  static bool validateEmail(String? email) {
    return email != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }

  static bool _containsNoDigits(String str) {
    RegExp regex = RegExp(r'\d'); // Matches any digit
    return !regex.hasMatch(str);
  }
}

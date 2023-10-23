class Validations {
  static String? isEmpty(String? value, String field) =>
      value == null || value.isEmpty ? '$field is Required' : null;

  static String? isNumber(String? value, String field) {
    final hasNumber = RegExp(r'^\d+$');
    if (value == null || value.isEmpty) return '$field is Required';
    return hasNumber.hasMatch(value) ? null : 'only Number is allowed';
  }

  static String? isEmail(String? value) {
    final hasEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty) return 'Email is Required';
    return hasEmail.hasMatch(value) ? null : 'Invalid email';
  }

  static String? isPasswordMatch(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty || value2 == null || value2.isEmpty) {
      return 'confirm your password';
    }
    return value1 == value2 ? null : 'password is not matches';
  }
}

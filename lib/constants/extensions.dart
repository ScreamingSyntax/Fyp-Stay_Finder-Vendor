extension StringExtension on String {
  bool get isValidEmail {
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$');
    return emailPattern.hasMatch(this);
  }

  bool get isValidName {
    final namePattern = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$');
    return namePattern.hasMatch(this);
  }

  bool get isValidPhone {
    final phonePattern = RegExp(r'^\d{10}$'); // 10-digit U.S. phone number
    return phonePattern.hasMatch(this);
  }
}

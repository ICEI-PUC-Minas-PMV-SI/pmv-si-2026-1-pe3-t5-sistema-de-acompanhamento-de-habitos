abstract final class SahValidators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return password.length >= 8 && RegExp(r'\d').hasMatch(password);
  }

  static PasswordStrength passwordStrength(String password) {
    if (password.isEmpty) return PasswordStrength.none;
    if (password.length < 6) return PasswordStrength.weak;
    if (password.length < 8 || !RegExp(r'\d').hasMatch(password)) {
      return PasswordStrength.fair;
    }
    if (password.length >= 12 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[!@#\$%^&*]').hasMatch(password)) {
      return PasswordStrength.strong;
    }
    return PasswordStrength.good;
  }

  static bool isNotEmpty(String value) => value.trim().isNotEmpty;
}

enum PasswordStrength { none, weak, fair, good, strong }

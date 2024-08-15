class ValidatorFunction {
  static final RegExp _emailRegex =
      RegExp(r'^[\w.-]+@[a-zA-Z_-]+?(?:\.[a-zA-Z]{2,})+$');

  static String? emailValidation(String? value) {
    final trimEmail = value!.trim();
    if (trimEmail.isNotEmpty) {
      if (!_emailRegex.hasMatch(value)) {
        return 'Please provide a valid email.';
      } else {
        return null;
      }
    } else {
      return '*This field is mandatory';
    }
  }

  static String? emptyValidationCheck(String? value) {
    final trimtext = value!.trim();
    if (trimtext.isEmpty) {
      return '*This field is mandatory';
    } else {
      return null;
    }
  }

  static String? otpValidation(String? value) {
    final trimtext = value!.trim();
    if (trimtext.isEmpty) {
      return '*This field is mandatory';
    } else if (trimtext.length < 6) {
      return '*Enter valid OTP';
    } else {
      return null;
    }
  }

  static String? phoneNumberValidation(String? value) {
    final trimtext = value!.trim();
    if (trimtext.isEmpty) {
      return '*This field is mandatory';
    } else if (!trimtext.startsWith('+')) {
      return '*Phone number should starts with +';
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? value) {
    final trimValue = value?.trim() ?? '';
    if (trimValue.isEmpty) {
      return '*This field is mandatory';
    } else if (trimValue.length < 8) {
      return '*Password must contain 8 character';
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidation(String? value, String password) {
    final trimValue = value?.trim() ?? '';
    if (trimValue.isEmpty) {
      return '*This field is mandatory';
    } else if (trimValue.length < 8) {
      return '*Password must contain 8 character';
    } else if (value != password) {
      return 'Password do not match';
    } else {
      return null;
    }
  }
}

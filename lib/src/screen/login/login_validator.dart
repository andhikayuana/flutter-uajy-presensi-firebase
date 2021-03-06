class LoginValidator {
  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email wajib diisi";
    }

    const String emailPattern =
        r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    if (!RegExp(emailPattern).hasMatch(value)) {
      return "Email tidak valid";
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password wajib diisi";
    }

    if (value.length < 8) {
      return "Password kurang dari 8 karakter";
    }

    return null;
  }
}

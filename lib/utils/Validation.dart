class Validation {

  static validationUsername (String value) {

    String txtValue = value.trim();

    if(txtValue.length < 3 ) {
      return "Username must be more than 2 character";
    }

    return null;
  }

  static validationPhoneNumber (String value) {
    String txtValue = value.trim();

    if(txtValue.length <= 6 ) {
      return "Password must be more than 6 character";
    }

    return null;
  }
  static validationPassword ( String value) {

    String txtValue = value.trim();

    if(txtValue.length < 6) {
      return "Password must be more than 6 character";
    }

    return null;
  }

  static validationConfirmPassword(String password, String confirm) {

    if(confirm.trim().length == 0) {
      return "Confirm Password can't be null";
    }

    if(password.trim() != confirm.trim()) {
      return "មិនត្រឹមត្រូវទេ";
    }

    return null;
  }
}
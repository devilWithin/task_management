extension ValidatedString on String? {
  bool get isNotNull {
    return this != null;
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this!);
  }

  bool get isValidNameEn {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this!);
  }

  bool get isValidNameAr {
    final nameRegExp = RegExp(r"^[\u0621-\u064A ]+$");

    return nameRegExp.hasMatch(this!);
  }

  bool get isValidPassword {
    final RegExp passwordRegex = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}|:<>?~`[\]\-\\';,/]).{8,}$");

    return passwordRegex.hasMatch(this!);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this!);
  }

  bool get isValidCreditCard {
    final RegExp creditCardRegex =
        RegExp(r'^[0-9]{4}[0-9]{4}[0-9]{4}[0-9]{4}$');
    return creditCardRegex.hasMatch(this!);
  }

  bool get isValidMonthExpiryDate {
    final RegExp monthExpiryDateRegex = RegExp(r'^(0[1-9]|1[0-2])$');
    return monthExpiryDateRegex.hasMatch(this!);
  }

  bool get isValidYearExpiryDate {
    final RegExp yearExpiryDateRegex = RegExp(r'^[2-9][0-9]$');
    return yearExpiryDateRegex.hasMatch(this!);
  }

  bool get isValidCvv {
    final RegExp cvvRegex = RegExp(r'^[0-9]{3}$');
    return cvvRegex.hasMatch(this!);
  }
}

enum ValidationType {
  email,
  nameEn,
  nameAr,
  password,
  phone,
  notRequired,
  postalCode,
  creditCard,
  monthExpiryDate,
  yearExpiryDate,
  cvv,
}

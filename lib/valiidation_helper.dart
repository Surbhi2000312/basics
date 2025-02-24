import 'package:get/get.dart';

class ValidationHelper {

  static String? empty(String value, String msg) {
    if (value.isEmpty) {
      return msg;
    }
    return null;
  }
  static String? validatePrescriptionName(String? value) {
    if (value?.isEmpty == true) {
      return "Prescription name is Required";
    }
    return null;
  }
  static String? validateWifiPassword(String? value) {
    if (value?.isEmpty == true) {
      return "Password is Required";
    }
    return null;
  }
  static String? validateUserName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "User Name is Required";
    } else if (!regExp.hasMatch(value!)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value!)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
  static String? validateGender(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Gender is Required";
    } else if (!regExp.hasMatch(value!)) {
      return "Gender must be a-z and A-Z";
    }
    return null;
  }
  static String? validateMobile(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Mobile is Required";
    } else if (value!.length < 9 || value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
  static String? validateMobile91(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Mobile is Required";
    } else if (value?.length != 12) {
      return "Mobile number must start with 91 and 10 digits";
    } else if (!regExp.hasMatch(value!)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
  static String? validateZipCode(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "ZipCode is Required";
    } else if (value!.length != 6) {
      return "ZipCode must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "ZipCode must be digits";
    }
    return null;
  }

  static String? validateAadhar(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Aadhar Number is Required";
    } else if (value!.length != 12) {
      return "Aadhar number must 12 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Aadhar number must be digits";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value?.trim().isBlank == true) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value!)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
  static String? validateNormalPass(String? value) {
    if (value?.trim().isBlank == true) {
      return "Password is Required";
    } else if (value!.length < 7) {
      return "Password must grater then 7 digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    RegExp upperCasePatten = RegExp("[A-Z]");
    RegExp lowerCasePatten = RegExp("[a-z]");
    RegExp digitCasePatten = RegExp("[0-9]");
    RegExp specialCasePatten = RegExp("[!@#\$&*~]");
    if (value?.trim().isBlank == true) {
      return "Password is Required";
    } else if (!upperCasePatten.hasMatch(value!)) {
      return 'Password must have atleast one uppercase character';
    } else if (!lowerCasePatten.hasMatch(value)) {
      return 'Password must have atleast one lowercase character';
    } else if (!digitCasePatten.hasMatch(value)) {
      return 'Password must have atleast one digit character';
    } else if (!specialCasePatten.hasMatch(value)) {
      return 'Password must have atleast one special character';
    } else if (value.length < 8) {
      return "Password must grater then 8 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Password";
    } else {
      return null;
    }
  }

  static String? validateOtpAadhar(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.trim().isBlank == true) {
      return "OTP is Required";
    } else if (value!.length != 6) {
      return "OTP must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "OTP must be digits";
    }
    return null;
  }
  static String? validateOtp(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.trim().isBlank == true){
      return "OTP is Required";
    } else if (value!.length != 6) {
      return "OTP must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "OTP must be digits";
    }
    return null;
  }
  static String? validateDob(String? value) {
    if (value?.trim().isBlank == true) {
      return "DOB is Required";
    }
    return null;
  }
  static String? validateStart(String? value) {
    if (value?.trim().isBlank == true) {
      return "Start Date is Required";
    }
    return null;
  }

  static String? validateEnd(String? value) {
    if (value?.trim().isBlank == true) {
      return "End Date is Required";
    }
    return null;
  }
  static String? validateCity(String? value) {
    if (value?.trim().isBlank == true) {
      return "City is Required";
    }
    return null;
  }
  static String? validateCenter(String? value) {
    if (value?.trim().isBlank == true) {
      return "Center is Required";
    }
    return null;
  }
  static String? validateDocType(String? value) {
    if (value?.trim().isBlank == true) {
      return "Document Type is Required";
    }
    return null;
  }

  static String? validateCoupon(String? value) {
    if (value?.trim().isBlank == true) {
      return "Coupon is Required";
    }
    return null;
  }

  static String? validateMoney(String? value) {
    if (value?.trim().isBlank == true) {
      return "Amount is Required";
    }
    return null;
  }

  static String? validateTitle(String? value) {
    if (value?.trim().isBlank == true) {
      return "Title is Required";
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value?.trim().isBlank == true) {
      return "Description is Required";
    }
    return null;
  }
  static String? validateExtendDate(String? value) {
    if (value?.trim().isBlank == true) {
      return "Select extend date & time";
    }
    return null;
  }
  static String? validateMeterReading(String? value) {
    if (value?.trim().isBlank == true) {
      return "Please enter meter reading";
    }
    return null;
  }
}

final RegExp passwordRegex =
    RegExp(r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*])(?=.*[0-9])\S{8,20}$');

final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

String? validatePassword(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    // 공백 입력은 TextFormField에서 막았으므로, Empty인 경우는 입력을 하지 않았을 때 밖에 없음
    return "값을 입력해 주세요.";
  } else if (!passwordRegex.hasMatch(value)) {
    return "8 ~ 20자 사이로, 최소한 하나의 알파벳, 특수 문자 및 숫자를 포함해주세요.";
  } else {
    return null;
  }
}

String? validatePasswordCheck(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    // 공백 입력은 TextFormField에서 막았으므로, Empty인 경우는 입력을 하지 않았을 때 밖에 없음
    return "값을 입력해 주세요.";
  } else if (!passwordRegex.hasMatch(value)) {
    return "비밀번호 양식이 옳지 않습니다.";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  if (value == null) return null;
  if (value.contains(" ")) return "공백은 포함될 수 없습니다.";
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else if (!emailRegex.hasMatch(value)) {
    return "이메일 주소 형식이 옳지 않습니다.";
  } else {
    return null;
  }
}

String? validateId(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    return "아이디는 영어 또는 숫자만 입력해 주세요.";
  } else if (value.length < 6) {
    return "아이디는 6자리 이상 입력해 주세요.";
  } else {
    return null;
  }
}

String? validateMessage(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else if (value.isEmpty || value.length > 20) {
    return "글자는 1자 이상 20자 이하로 입력해 주세요.";
  } else {
    return null;
  }
}

String? validateNumeric(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return "숫자만 입력해 주세요.";
  } else if (value.length != 8) {
    return "학번은 숫자 8자리로 입력해 주세요.";
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else if (!RegExp(r'^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$').hasMatch(value)) {
    return "올바른 전화번호 형식이 아닙니다. (예: 010-1234-5678)";
  } else {
    return null;
  }
}

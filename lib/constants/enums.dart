enum SingUpResponse {
  success,
  failure,
  invalidEmail,
  emailAlreadyUsed,
  weakPassword,
}

enum SingInResponse {
  success,
  failure,
  wrong,
}

enum DataResponse {
  success,
  failure,
}

enum ChangePasswordResponse {
  success,
  failure,
  wrongCurrentPassword,
  weakNewPassword,
}

enum ForgotPasswordResponse {
  success,
  failure,
  invalidEmail,
  userNotFound,
}

enum PaymentMethod { cash, creditCard }

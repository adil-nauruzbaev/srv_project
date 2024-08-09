// Пример адреса электронной почты: example.email@example-domain.com
// ignore: non_constant_identifier_names
final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

// Пример пароля: Password1
// ignore: non_constant_identifier_names
final RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

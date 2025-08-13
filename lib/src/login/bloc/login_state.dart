part of 'login_bloc.dart';

enum LoginStatus { idle, submitting, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.status = LoginStatus.idle,
    this.errorMessage = '',
  });

  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final LoginStatus status;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid && email.isNotEmpty && password.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, isEmailValid, isPasswordValid, status, errorMessage];
}


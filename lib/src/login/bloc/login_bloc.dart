import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final String email = event.email.trim();
    final bool isValidEmail = _emailRegex.hasMatch(email);
    emit(state.copyWith(email: email, isEmailValid: isValidEmail, errorMessage: ''));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final String password = event.password;
    final bool isValidPassword = _passwordRegex.hasMatch(password);
    emit(state.copyWith(password: password, isPasswordValid: isValidPassword, errorMessage: ''));
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final bool isValidEmail = _emailRegex.hasMatch(state.email);
    final bool isValidPassword = _passwordRegex.hasMatch(state.password);
    if (!isValidEmail || !isValidPassword) {
      emit(state.copyWith(
        isEmailValid: isValidEmail,
        isPasswordValid: isValidPassword,
        errorMessage: 'Please fix the errors before submitting',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.submitting, errorMessage: ''));

    // Simulate API call (replace with real API if available)
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Consider any valid inputs as success for this assignment
    emit(state.copyWith(status: LoginStatus.success));
  }
}

final RegExp _emailRegex = RegExp(
  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
);

// Password: min 8 chars, at least one upper, one lower, one digit, one symbol
final RegExp _passwordRegex = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
);


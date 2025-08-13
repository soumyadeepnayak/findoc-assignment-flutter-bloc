import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/view/home_screen.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (state.status == LoginStatus.failure && state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: const _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email || previous.isEmailValid != current.isEmailValid,
              builder: (context, state) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: state.isEmailValid ? null : 'Enter a valid email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value)),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.password != current.password || previous.isPasswordValid != current.isPasswordValid,
              builder: (context, state) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorMaxLines: 2,
                    errorText: state.isPasswordValid
                        ? null
                        : 'Min 8 chars, include upper, lower, number, symbol',
                  ),
                  obscureText: true,
                  onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.status != current.status || previous.isFormValid != current.isFormValid,
              builder: (context, state) {
                final bool isLoading = state.status == LoginStatus.submitting;
                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? true) {
                            context.read<LoginBloc>().add(const LoginSubmitted());
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          'Submit',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                        ),
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (p, c) => p.errorMessage != c.errorMessage,
              builder: (context, state) {
                if (state.errorMessage.isEmpty) return const SizedBox.shrink();
                return Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}


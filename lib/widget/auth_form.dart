import 'package:flutter/material.dart';
import 'package:flutter_firestore/screen/auth_screen.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitFn}) : super(key: key);

  final void Function(
    String userName,
    String email,
    String password,
    bool isLogin,
    BuildContext context
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _fromKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _username = "";
  var _userEmail = "";
  var _userPassword = "";

  void _trySubmit() {
    final isVaid = _fromKey.currentState!.validate();
    // entery done keybord auto gone
    FocusScope.of(context).unfocus();

    if (isVaid) {
      _fromKey.currentState!.save();
      widget.submitFn(
        _username.trim(),
        _userEmail.trim(),
        _userPassword.trim(),
        _isLogin,
        context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey("userName"),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "Please enter at least 4 charecters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        decoration:
                            const InputDecoration(labelText: 'user name'),
                      ),
                    TextFormField(
                      key: const ValueKey('userEmail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "plz enter your valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                        key: const ValueKey('Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return "password must be 6 charater long";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPassword = value!;
                        },
                        decoration:
                            const InputDecoration(labelText: 'password')),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: _trySubmit,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text(_isLogin ? 'Login' : 'SignUp')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create Account'
                            : 'I have  already a account'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

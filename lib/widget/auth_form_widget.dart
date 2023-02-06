import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AuthFormWidget extends StatefulWidget {

  final void Function(String email, String username, String password, bool isLoading, BuildContext ctx) submitAuthentication;
  final bool isLoading;

  const AuthFormWidget(this.submitAuthentication, this.isLoading);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();

}

class _AuthFormWidgetState extends State<AuthFormWidget> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String ?_userEmail;
  String ?_userName;
  String ?_userPassword;

  void _tryToAuthenticate() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      // remove scope off input field
      FocusScope.of(context).unfocus();

      // trigger on save function
      _formKey.currentState!.save();

      // authenticate user
      widget.submitAuthentication(_userEmail!, _userName != null ? _userName! : '', _userPassword!, _isLogin, context);
    }
  }

  String? _emailValidation(String inputtedEmail, BuildContext emailValidationContext) {
    if (inputtedEmail.isEmpty) {
      return AppLocalizations.of(emailValidationContext).emailValidation;
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(inputtedEmail);
    if (!emailValid) {
      return AppLocalizations.of(emailValidationContext).emailValidation;
    }

    // valid input
    return null;
  }

  String? _usernameValidation(String inputtedUsername, BuildContext usernameValidationContext) {
    if (inputtedUsername.isEmpty) {
      return AppLocalizations.of(usernameValidationContext).usernameValidation;
    }

    if (inputtedUsername.length < 6) {
      return AppLocalizations.of(usernameValidationContext).usernameLengthValidation;
    }

    // valid input
    return null;
  }

  String? _passwordValidation(String inputtedPassword, BuildContext passwordValidationContext) {
    if (inputtedPassword.isEmpty) {
      return AppLocalizations.of(passwordValidationContext).passwordValidation;
    }

    //
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    bool passwordValid = RegExp(pattern).hasMatch(inputtedPassword);
    if (!passwordValid) {
      return AppLocalizations.of(passwordValidationContext).passwordConstraint;
    }

    // input valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).emailInput,),
                    validator: (inputtedEmail) {
                      return _emailValidation(inputtedEmail!, context);
                    },
                    onSaved: (inputtedEmail) {
                      _userEmail = inputtedEmail!.trim();
                    },
                  ),
                  if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).usernameInput),
                    validator: (inputtedUsername) {
                      return _usernameValidation(inputtedUsername!, context);
                    },
                    onSaved: (inputtedUsername) {
                      _userName = inputtedUsername!.trim();
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).passwordInput),
                    obscureText: true,
                    validator: (inputtedPassword) {
                      return _passwordValidation(inputtedPassword!, context);
                    },
                    onSaved: (inputtedPasswordValue) {
                      _userPassword = inputtedPasswordValue!.trim();
                    },
                  ),
                  const SizedBox(height: 12,),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading) ElevatedButton(
                      onPressed: _tryToAuthenticate,
                      child: _isLogin ? Text(AppLocalizations.of(context).loginLabel) : Text(AppLocalizations.of(context).registerLabel)
                  ),
                  if (!widget.isLoading) TextButton(
                      onPressed: () {
                        setState(() {_isLogin = !_isLogin;});
                      },
                      child: _isLogin ? Text(AppLocalizations.of(context).newAccountLabel) : Text(AppLocalizations.of(context).haveAccountLabel)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

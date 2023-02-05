import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobile_authnetication_client/service/auth_service.dart';
import '../widget/auth_form_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AuthScreen extends StatefulWidget {

  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {

  var _isLoading = false;
  AuthenticationService authenticationService = AuthenticationService();

  void _submitAuthForm(String email, String username, String password, bool isLogin, BuildContext authContext) async {
    try {
      setState(() {_isLoading = true;});

      if(isLogin) {
        authenticationService.login(email, password);
      } else {
        authenticationService.register(email, password, username);
      }

      setState(() {_isLoading = false;});
    } on PlatformException catch(error) {
      setState(() {_isLoading = false;});

      var message = AppLocalizations.of(authContext).loginErrorMessage;
      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(authContext).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Theme.of(authContext).colorScheme.error,)
      );
    } catch(error) {
      setState(() {_isLoading = false;});

      ScaffoldMessenger.of(authContext).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(authContext).unknownErrorMessage),
          backgroundColor: Theme.of(authContext).colorScheme.error,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(_submitAuthForm, _isLoading),
    );
  }

}
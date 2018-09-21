import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

import '../models/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required!';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      //controller: _emailTextController,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
                .hasMatch(value)) {
          return 'Email is requried!';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _confirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          print(value + 'teeeest ' + _passwordTextController.text);
          return 'Password does not match';
        }
      },
    );
  }

  _showAlert(Text title, Text content) {
    var alert = new CupertinoAlertDialog(
      title: title, //new Text("Error Loging In"),
      content: content, //new Text("Please make sure the fields all filled!"),
      actions: <Widget>[
        new CupertinoDialogAction(
            child: const Text('Ok'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Ok');
            }),
      ],
    );
    showDialog(context: context, child: alert);
  }

  Widget _buildAcceptTerms() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return _showAlert(Text("Error Loging In"),
          Text("Please make sure the fields all filled!"));
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInfo;
    successInfo = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInfo['Success']) {
      _showAlert(
          Text('User Created'), Text('User has been successfully created'));
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      _showAlert(Text('Error Has Occurred'), Text('${successInfo['Message']}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double tagetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.8;
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/Login.jpg'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(),
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: tagetWidth,
                child: Column(
                  children: <Widget>[
                    logo,
                    _emailTextField(),
                    SizedBox(height: 10.0),
                    _passwordTextField(),
                    SizedBox(height: 10.0),
                    _authMode == AuthMode.Signup
                        ? _confirmPasswordTextField()
                        : Container(),
                    SizedBox(height: 10.0),
                    _buildAcceptTerms(),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading
                            ? CupertinoActivityIndicator()
                            : CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                    '${_authMode == AuthMode.Login ? 'Login' : 'Signup'}'),
                                //textColor: Colors.white,
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                              );
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                        style: TextStyle(color: Colors.black54),
                      ),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AuthPage> {
  String _emailfield;
  String _passwordfield;
  bool _acceptTerms = false;

  Widget _passwordTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _passwordfield = value;
        });
      },
    );
  }

  Widget _emailTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'E-mail'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailfield = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width; 
    final double tagetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth *0.8;
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
            child: Container( 
              width: tagetWidth,
              child:Column(
              children: <Widget>[
                logo,
                _emailTextField(),
                SizedBox(height: 10.0),
                _passwordTextField(),
                SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  title: Text('Accept Terms'),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('LogIn'),
                    textColor: Colors.white,
                    onPressed: () {
                      print(_emailfield);
                      print(_passwordfield);

                      Navigator.pushReplacementNamed(context, '/home');
                    }),
                FlatButton(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  btnPressed() {
    print(_emailfield);
    print(_passwordfield);

    Navigator.pushReplacementNamed(context, '/home');
  }
}

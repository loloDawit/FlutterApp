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

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                logo,
                TextField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _emailfield = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _passwordfield = value;
                    });
                  },
                ),
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
    );
  }

  btnPressed() {
    print(_emailfield);
    print(_passwordfield);

    Navigator.pushReplacementNamed(context, '/home');
  }
}

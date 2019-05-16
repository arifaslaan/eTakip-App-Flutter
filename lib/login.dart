// Flutter code sample for widgets.Form.1

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'dart:async';
import 'dart:convert';
import 'package:e_takip/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  var resp;
  
  _userControl(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/controlUserApi.php'),
      body: {'kimlikno': ''+_data.kimlikno+'', 'password': ''+_data.password+''}).then((UriResponse) {
        resp = json.decode(UriResponse.body);
        if(resp['statu']=='ok'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabsDemoScreen(kimlikno: _data.kimlikno, mycurrentTabIndex: 0,)),
          );
        }
        else{
          _neverSatisfied();
        }
      });
    }
  }


  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uyarı'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Kullanıcı adı veya parola yanlış!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            inputSection,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  child: Text('Giriş'),
                  onPressed:() {
                    _userControl(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget inputSection = Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kimlik Numarası',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen kimlik numaranızı giriniz.';
              }
              if (value.length < 11) {
                return 'Lütfen geçerli bir kimlik numarası giriniz.';
              }
            },
            onSaved: (String value) {
              _data.kimlikno = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Parola',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen parolanızı giriniz.';
              }
              if (value.length < 8) {
                return 'Lütfen geçerli bir parola giriniz.';
              }
            },
            onSaved: (String value) {
              _data.password = value;
            },
          ),
        ),
      ],
    ),
  );
}
final _formKey = GlobalKey<FormState>();
class _LoginData {
  String kimlikno = '';
  String password = '';
}
final _LoginData _data = new _LoginData();

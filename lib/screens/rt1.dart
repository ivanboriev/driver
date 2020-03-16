import 'package:flutter/material.dart';

class RT1 extends StatefulWidget {
  RT1({Key key}) : super(key: key);

  @override
  _RT1State createState() => _RT1State();
}

class _RT1State extends State<RT1> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Регистрация'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Имя'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Фамилия'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Отчество'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

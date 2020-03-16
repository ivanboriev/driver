import 'package:driver/screens/transportRegisterTypes/truck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RT1 extends StatefulWidget {
  RT1({Key key}) : super(key: key);

  @override
  _RT1State createState() => _RT1State();
}

class _RT1State extends State<RT1> {
  final _formKey = GlobalKey<FormState>();

  String selectedCity;
  String selectedTransportType;
  String name;
  String lastName;
  String otherName;
  String vin;
  String gosNumber;

  List<String> cities = ['Ярославль'];
  List<String> transportTypes = ['Грузовик'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Регистрация'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Введите имя';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Имя'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Введите фамилию';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Фамилия'),
                onChanged: (val) {
                  setState(() {
                    lastName = val;
                  });
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Введите отчество';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Отчество'),
                onChanged: (val) {
                  setState(() {
                    otherName = val;
                  });
                },
              ),
              DropdownButtonFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Выберите город';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Город'),
                value: selectedCity,
                onChanged: (val) {
                  setState(() {
                    selectedCity = val;
                  });
                },
                items: cities.map((String cityName) {
                  return DropdownMenuItem<String>(
                    value: cityName,
                    child: Text(cityName),
                  );
                }).toList(),
              ),
              DropdownButtonFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Выберите тип грузового транспорта';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Тип транспорта'),
                value: selectedTransportType,
                onChanged: (val) {
                  setState(() {
                    selectedTransportType = val;
                  });
                },
                items: transportTypes.map((String cityName) {
                  return DropdownMenuItem<String>(
                    value: cityName,
                    child: Text(cityName),
                  );
                }).toList(),
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Введите VIN';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'VIN транспорта'),
                onChanged: (val) {
                  setState(() {
                    vin = val;
                  });
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Введите гос. номер';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Гос. номер транспорта'),
                onChanged: (val) {
                  setState(() {
                    gosNumber = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Далее'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (selectedTransportType == 'Грузовик') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Truck()));
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

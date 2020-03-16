import 'package:driver/helpers/decimal_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Truck extends StatefulWidget {
  @override
  _TruckState createState() => _TruckState();
}

class _TruckState extends State<Truck> {
  final _formKey = GlobalKey<FormState>();

  double capacity;
  double carrying;
  double length;
  double width;
  double height;
  bool tailLift = false;
  bool allTerrain = false;

  String selectedBordType;
  List<dynamic> selectedLoadTypes;

  List<String> bordTypes = [
    'Бортовой',
    'Тент',
    'Фургон',
    'Изотермический',
    'Рифрежиратор'
  ];

  List<dynamic> loadTypes = [
    {"display": "Задняя", "value": "Задняя"},
    {"display": "Боковая", "value": "Боковая"},
    {"display": "Передняя", "value": "Передняя"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Характеристики'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Укажите грузоподъёмность (тонн)';
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: 'Грузоподъёмность (тонн)'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      setState(() {
                        carrying = double.parse(val.replaceAll(",", "."));
                      });
                    },
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Укажите объём кузова';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Объём кузова (м3)'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      setState(() {
                        capacity = double.parse(val.replaceAll(",", "."));
                      });
                    },
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Укажите длину кузова';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Длина кузова (м)'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      setState(() {
                        length = double.parse(val.replaceAll(",", "."));
                      });
                    },
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Укажите ширину кузова';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Ширина кузова (м)'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      setState(() {
                        width = double.parse(val.replaceAll(",", "."));
                      });
                    },
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Укажите высоту кузова';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Высота кузова (м)'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      setState(() {
                        length = double.parse(val.replaceAll(",", "."));
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    validator: (val) {
                      if (val == null) {
                        return 'Выберите тип кузова';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Тип кузова'),
                    value: selectedBordType,
                    onChanged: (val) {
                      setState(() {
                        selectedBordType = val;
                      });
                    },
                    items: bordTypes.map((String bordType) {
                      return DropdownMenuItem<String>(
                        value: bordType,
                        child: Text(bordType),
                      );
                    }).toList(),
                  ),
                  MultiSelectFormField(
                    titleText: 'Тип загрузки',
                    hintText: 'Укажите тип загрузки',
                    validator: (val) {
                      if (val == null || val.length == 0) {
                        return 'Укажите тип загрузки';
                      }
                      return null;
                    },
                    dataSource: loadTypes,
                    value: selectedLoadTypes,
                    textField: 'display',
                    valueField: 'value',
                    cancelButtonLabel: 'Отмена',
                    onSaved: (val) {
                      if (val == null) return;
                      setState(() {
                        selectedLoadTypes = val;
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Гидроборт'),
                    trailing: Switch(
                        value: tailLift,
                        onChanged: (val) {
                          setState(() {
                            tailLift = val;
                          });
                        }),
                  ),
                  ListTile(
                    title: Text('Вездеход'),
                    trailing: Switch(
                        value: allTerrain,
                        onChanged: (val) {
                          setState(() {
                            allTerrain = val;
                          });
                        }),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Далее'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('validate');
                      }
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}

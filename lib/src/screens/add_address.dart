import 'package:flutter/material.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/screens/splash.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addressTextController;
  TextEditingController _areaTextController;
  TextEditingController _postalCodeController;
  var _cities = ['Jeddah'];
  var _currentSelectedValue = "Jeddah";
  String _completeAddress = '';

  @override
  void initState() {
    _addressTextController = TextEditingController();
    _areaTextController = TextEditingController();
    _postalCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {Navigator.pop(context);},),
        centerTitle: true,
        title: Text(S.of(context).addNewAddress),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(height: 20,),
          TextField(
            controller: _addressTextController,
            decoration: InputDecoration(
              labelText: S.of(context).address,
              labelStyle: TextStyle(
                color: Theme.of(context).accentColor
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )
            ),
          ),
          SizedBox(height: 10,),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    labelText: S.of(context).city,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: S.of(context).pleaseSelectCity,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                isEmpty: _currentSelectedValue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedValue,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _currentSelectedValue = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _cities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _areaTextController,
            decoration: InputDecoration(
              labelText: S.of(context).area,
              labelStyle: TextStyle(
                color: Theme.of(context).accentColor
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _postalCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: S.of(context).postalCode,
              labelStyle: TextStyle(
                color: Theme.of(context).accentColor
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  minWidth: 120,
                  height: 40,
                  child: Text(S.of(context).add, textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
                  shape: StadiumBorder(),
                  onPressed: () {
                    if (_areaTextController.text != null && _addressTextController.text != null) {
                      _completeAddress = _addressTextController.text+', '
                          +_currentSelectedValue+', '
                          +_areaTextController.text+', '
                          +_postalCodeController.text+', '
                          +S.of(context).saudiArabia;

                      appUser.address = _addressTextController.text;
                      appUser.area = _areaTextController.text;
                      appUser.city = _currentSelectedValue;
                      appUser.postalCode = _postalCodeController.text;

                    }
                    print(_completeAddress);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}

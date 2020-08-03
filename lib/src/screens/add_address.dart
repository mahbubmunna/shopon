import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addressTextController;
  TextEditingController _areaTextController;
  TextEditingController _phoneTextController;
  var _cities = ['Jeddah'];
  var _currentSelectedValue = "Jeddah";
  String _completeAddress = '';

  @override
  void initState() {
    _addressTextController = TextEditingController();
    _areaTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {Navigator.pop(context);},),
        centerTitle: true,
        title: Text('ADD NEW ADDRESS'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(height: 20,),
          TextField(
            controller: _addressTextController,
            decoration: InputDecoration(
              labelText: 'Address',
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
                    labelText: 'City',
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Please select city',
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
              labelText: 'Area',
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
            controller: _phoneTextController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Phone',
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
                  child: Text('ADD', textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
                  shape: StadiumBorder(),
                  onPressed: () {
                    if (_areaTextController.text != null && _addressTextController.text != null) {
                      _completeAddress = _addressTextController.text+', '
                          +_currentSelectedValue+', '
                          +_areaTextController.text+', '
                          +_phoneTextController.text+', '
                          +'Saudi Arabia';
                    }
                    print(_completeAddress);
                    Navigator.pop(context, _completeAddress);
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

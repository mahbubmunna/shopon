import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/repositories/user_repository.dart';
import 'package:sunbulahome/src/screens/splash.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addressTextController;
  TextEditingController _areaTextController;
  TextEditingController _postalCodeController;
  var _cities = [ 'Riaydh', 'Jeddah', 'Makkah'];
  Map _citiesMap = {
    'Riaydh': 'RI',
    'Jeddah': 'JE',
    'Makkah': 'MA'
  };
  var _currentSelectedValue = "JE";
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
        title: Text('Add more info for delivery'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(height: 20,),
          TextField(
            controller: _addressTextController,
            decoration: InputDecoration(
              labelText: S.of(context).apartmentBuildingStreetName,
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
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    labelText: S.of(context).yourStoreCity,
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
                        value: _citiesMap[value],
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
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
                  child: Text(S.of(context).saveLocation, textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
                  shape: StadiumBorder(),
                  onPressed: () async {
                    if (_areaTextController.text != null && _addressTextController.text != null) {
                      _completeAddress = _addressTextController.text+', '
                          +_currentSelectedValue+', '
                          +_areaTextController.text+', '
                          +S.of(context).saudiArabia;

                      appUser.address = _addressTextController.text;
                      appUser.area = _areaTextController.text;
                      appUser.city = _currentSelectedValue;

                    }
                    print(_completeAddress);

                    try {
                      await UserRepository.postUser(appUser.toMap()).then((response) {
                        appUser = response.user;
                        print('Addresses to test');
                        print(appUser.address);
                        print(appUser.area);
                        print(appUser.city);
                        print(appUser.postalCode);
                      });
                    } catch (error){
                      print(error);
                    }

                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        body: Text(S.of(context).locationSaved)
                    ).show();

                    await Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/Tabs', ModalRoute.withName('/'),
                          arguments: 0);
                    });
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

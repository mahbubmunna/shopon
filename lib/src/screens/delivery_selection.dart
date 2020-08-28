import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/repositories/user_repository.dart';
import 'package:smartcommercebd/src/screens/add_address.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/config/app_config.dart' as config;

class DeliverySelect extends StatefulWidget {
  @override
  _DeliverySelectState createState() => _DeliverySelectState();
}

class _DeliverySelectState extends State<DeliverySelect> {
  Completer<GoogleMapController> _controller = Completer();
  Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position _position;
  Widget _child;
  String _completeAddress = 'Not added';

  //static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  void setCurrentPosition(Position _currentPosition) async {
    try {
      List<Placemark> p =  await geoLocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

        appUser.address = place.name;
        appUser.city = place.administrativeArea;
        appUser.postalCode = place.postalCode;
        appUser.country = place.country;
        appUser.area = place.locality;

      allAddressInOneLine();

    } catch (e) {
      print(e);
    }
  }

  void getCurrentLocation() async{
    Position res = await Geolocator().getCurrentPosition();

    setState(() {
      _position = res;
      Marker _marker = Marker
        (markerId: MarkerId('currentLocation'),
          position: LatLng(_position.latitude, _position.longitude),
          infoWindow: InfoWindow(title: 'home',)
      );

      final Map<String, Marker> _markers = {};
      _markers['currentLocation'] = _marker;

      _child = GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target:  LatLng(_position.latitude, _position.longitude),
            zoom: 15
        ),
        markers: _markers.values.toSet(),
      );
      setCurrentPosition(_position);
    });


  }

  @override
  void initState() {
    _child = SpinKitDoubleBounce(color: Colors.black,);
    getCurrentLocation();
    super.initState();
  }

  void goToAddAddressScreen() async {
//    String _manualValue = await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AddAddress()));
//    if (_manualValue != null) _result = _manualValue;
    await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AddAddress()));
    allAddressInOneLine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MaterialButton(
        onPressed: () async{
          try {
            await UserRepository.postUser(appUser.toMap()).then((response) {
              appUser = response.user;
            });
          } catch (error){
            print(error);
          }
          AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              body: Text('Location Saved')
          ).show();
          await Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Tabs', ModalRoute.withName('/'),
                arguments: 0);
          });
          },
        shape: StadiumBorder(),
        color: Theme.of(context).accentColor,
        minWidth: 80,
        child: Text('Save Location', textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _child,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Text(S.of(context).welcome + ' ${appUser.name}', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),)),
                Center(child: Text(S.of(context).whereDoYouWantYourDelivery, textScaleFactor: 1.2,)),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: MaterialButton(
                    onPressed: (){goToAddAddressScreen();},
                    color: config.Colors().mainColor(1),
                    shape: StadiumBorder(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.add_location, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text('SELECT NEW LOCATION', textScaleFactor: 1.1,style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Text('home', textScaleFactor: 1.2, style: TextStyle(color: config.Colors().mainColor(1)),),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Icon(Icons.location_on, color: config.Colors().mainColor(.7), size: 15,),
                    SizedBox(width: 5,),
                    Flexible(child: Text(_completeAddress, textScaleFactor: 1.1,))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void allAddressInOneLine() {
    _completeAddress = appUser.address+ ", " + appUser.area + ", " + appUser.city + ", " + appUser.postalCode + ", " + appUser.country;
    setState(() {

    });
  }


}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:sunbulahome/config/app_config.dart' as config;

import 'add_address.dart';

class DeliveryMap extends StatefulWidget {
  @override
  _DeliveryMapState createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  Completer<GoogleMapController> _controller = Completer();
  Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position _position;
  Widget _child;
  String _completeAddress = 'Not added';

  BitmapDescriptor _bitmapDescriptor;


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
          draggable: true,
          icon: _bitmapDescriptor,
          position: LatLng(_position.latitude, _position.longitude),
          onDragEnd: (value) {
            print(value.latitude);
            print(value.longitude);
            setState(() {
              setCurrentPosition(Position(latitude: value.latitude, longitude: value.longitude));
            });
          },
          infoWindow: InfoWindow(title: S.of(context).home,)
      );

      final Map<String, Marker> _markers = {};
      _markers['currentLocation'] = _marker;

      _child = GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target:  LatLng(_position.latitude, _position.longitude),
            zoom: 12
        ),
        markers: _markers.values.toSet(),
      );
      setCurrentPosition(_position);

    });


  }

  @override
  void initState() {
    _child = SpinKitDoubleBounce(color: Colors.black,);
    getProperBitmap();
    getCurrentLocation();
    super.initState();
  }

  void getProperBitmap() async {
    await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(128, 128)), 'assets/img/location.png')
        .then((value) => _bitmapDescriptor = value);
  }

  void goToAddAddressScreen() async {
//    String _manualValue = await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AddAddress()));
//    if (_manualValue != null) _result = _manualValue;
    await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: AddAddress()));
  }

  String _value = 'RI';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MaterialButton(
        onPressed: () async{
          goToAddAddressScreen();
        },
        shape: StadiumBorder(),
        color: Theme.of(context).accentColor,
        minWidth: 80,
        child: Text(S.of(context).next, textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height /2,
              width: MediaQuery.of(context).size.width,
              child: _child),
          SizedBox(height: 20,),
          Center(child: Text(S.of(context).welcome + ' ${appUser.name}', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(S.of(context).whereDoYouWantYourDelivery, textScaleFactor: 1.2,)),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15),
            child: Text(S.of(context).home, textScaleFactor: 1.2, style: TextStyle(color: config.Colors().mainColor(1)),),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(Icons.location_on, color: config.Colors().mainColor(.7), size: 15,),
              SizedBox(width: 5,),
              Flexible(child: Text(_completeAddress, textScaleFactor: 1.1,)),
            ],
          ),

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

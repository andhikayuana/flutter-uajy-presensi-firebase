import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  final Position position;
  final Address address;

  Location(this.position, this.address);
}

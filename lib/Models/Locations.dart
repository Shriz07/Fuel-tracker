import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part '../screens/petrol_map/locations.g.dart';

final apiKey = 'AIzaSyA9G5AZzH5uPhA-p5K1jU7J98bwveQe0XI';

@JsonSerializable()
class Locations {
  Locations({
    required this.stations,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Station> stations;
}

@JsonSerializable()
class Station {
  Station({
    required this.geometry,
    required this.name,
    //required this.priceLevel,
    required this.rating,
    required this.vicinity,
    required this.place_id,
    required this.price95,
    required this.price98,
    required this.priceON,
    required this.priceLPG,
    required this.updateTimestamp,
    required this.updateUserID,
  });

  factory Station.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  Geometry geometry;
  String name;
  double rating;
  String vicinity;
  String place_id;
  String price95;
  String price98;
  String priceON;
  String priceLPG;
  Timestamp updateTimestamp;
  String updateUserID;

  Map<String, dynamic> toMap() => {
        'place_id': place_id,
        'lat': geometry.location.lat,
        'lng': geometry.location.lng,
        'name': name,
        'rating': rating,
        'vicinity': vicinity,
        'price95': price95,
        'price98': price98,
        'priceON': priceON,
        'priceLPG': priceLPG,
        'updateTimestamp': Timestamp.now(),
        'updateUserID': updateUserID,
      };

  void setData(DocumentSnapshot<Object?> snapshot) {
    price95 = snapshot['price95'];
    price98 = snapshot['price98'];
    priceON = snapshot['priceON'];
    priceLPG = snapshot['priceLPG'];
    updateTimestamp = snapshot['updateTimestamp'];
    updateUserID = snapshot['updateUserID'];
  }
}

@JsonSerializable()
class Geometry {
  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);

  Location location;
}

@JsonSerializable()
class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  double lat;
  double lng;
}

Future<Locations> getPetrolStations(double lat, double lng) async {
  var nearbyStationsURL =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + lat.toString() + ',' + lng.toString() + '&radius=10000&type=gas_station&key=' + apiKey;

  final response = await http.get(Uri.parse(nearbyStationsURL));
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'HTTP error with status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nearbyStationsURL));
  }
}

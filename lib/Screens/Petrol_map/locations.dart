import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Locations {
  Locations({
    required this.results,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Result> results;
}

@JsonSerializable()
class Result {
  Result({
    required this.geometry,
    required this.name,
    //required this.priceLevel,
    //required this.rating,
    required this.vicinity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  Geometry geometry;
  String name;
  //String priceLevel;
  //double rating;
  String vicinity;
}

@JsonSerializable()
class Geometry {
  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);

  Location location;
}

@JsonSerializable()
class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  double lat;
  double lng;
}

Future<Locations> getPetrolStations(double lat, double lng) async {
  var petrolLocationsURL =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
          lat.toString() +
          ',' +
          lng.toString() +
          '&opennow&radius=15000&type=gas_station&key=AIzaSyA9G5AZzH5uPhA-p5K1jU7J98bwveQe0XI';

  final response = await http.get(Uri.parse(petrolLocationsURL));
  if (response.statusCode == 200) {
    //debugPrint(response.body);
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(petrolLocationsURL));
  }
}

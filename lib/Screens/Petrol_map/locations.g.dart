// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    stations: (json['results'] as List<dynamic>)
        .map((e) => Station.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'results': instance.stations,
    };

Station _$ResultFromJson(Map<String, dynamic> json) {
  return Station(
    geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    name: json['name'] as String,
    rating: (json['rating'] == null ? 0 : json['rating'] as num).toDouble(),
    vicinity: json['vicinity'] as String,
    place_id: json['place_id'] as String,
    price95: 'b.d.',
    price98: 'b.d.',
    priceON: 'b.d.',
    priceLPG: 'b.d.',
  );
}

Map<String, dynamic> _$ResultToJson(Station instance) => <String, dynamic>{
      'geometry': instance.geometry,
      'name': instance.name,
      'rating': instance.rating,
      'vicinity': instance.vicinity,
      'place_id': instance.place_id,
      'price95': instance.price95,
      'price96': instance.price98,
      'priceON': instance.priceON,
      'priceLPG': instance.priceLPG,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    location: Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

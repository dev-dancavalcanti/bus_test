import 'package:bus_teste/domain/dtos/coordinates_dto.dart';
import 'package:bus_teste/domain/dtos/street_dto.dart';
import 'package:bus_teste/domain/dtos/timezone_dto.dart';
import 'package:bus_teste/domain/entities/location_entity.dart';

class LocationDto {
  final StreetDto street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final CoordinatesDto coordinates;
  final TimezoneDto timezone;

  LocationDto({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      street: StreetDto.fromJson(json['street'] ?? {}),
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postcode: json['postcode'].toString(),
      coordinates: CoordinatesDto.fromJson(json['coordinates'] ?? {}),
      timezone: TimezoneDto.fromJson(json['timezone'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street.toJson(),
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'coordinates': coordinates.toJson(),
      'timezone': timezone.toJson(),
    };
  }

  LocationEntity toEntity() {
    return LocationEntity(
      street: street.toEntity(),
      city: city,
      state: state,
      country: country,
      postcode: postcode,
      coordinates: coordinates.toEntity(),
      timezone: timezone.toEntity(),
    );
  }

  factory LocationDto.fromEntity(LocationEntity entity) {
    return LocationDto(
      street: StreetDto.fromEntity(entity.street),
      city: entity.city,
      state: entity.state,
      country: entity.country,
      postcode: entity.postcode,
      coordinates: CoordinatesDto.fromEntity(entity.coordinates),
      timezone: TimezoneDto.fromEntity(entity.timezone),
    );
  }
}

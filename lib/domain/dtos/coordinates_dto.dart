import 'package:bus_teste/domain/entities/coordinates_entity.dart';

class CoordinatesDto {
  final String latitude;
  final String longitude;

  CoordinatesDto({required this.latitude, required this.longitude});

  factory CoordinatesDto.fromJson(Map<String, dynamic> json) {
    return CoordinatesDto(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  CoordinatesEntity toEntity() {
    return CoordinatesEntity(latitude: latitude, longitude: longitude);
  }

  factory CoordinatesDto.fromEntity(CoordinatesEntity entity) {
    return CoordinatesDto(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}

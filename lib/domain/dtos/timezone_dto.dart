import 'package:bus_teste/domain/entities/timezone_entity.dart';

class TimezoneDto {
  final String offset;
  final String description;

  TimezoneDto({required this.offset, required this.description});

  factory TimezoneDto.fromJson(Map<String, dynamic> json) {
    return TimezoneDto(
      offset: json['offset'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'offset': offset, 'description': description};
  }

  TimezoneEntity toEntity() {
    return TimezoneEntity(offset: offset, description: description);
  }

  factory TimezoneDto.fromEntity(TimezoneEntity entity) {
    return TimezoneDto(offset: entity.offset, description: entity.description);
  }
}

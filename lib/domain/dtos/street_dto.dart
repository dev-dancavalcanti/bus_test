import 'package:bus_teste/domain/entities/street_entity.dart';

class StreetDto {
  final int number;
  final String name;

  StreetDto({required this.number, required this.name});

  factory StreetDto.fromJson(Map<String, dynamic> json) {
    return StreetDto(
      number: int.parse(json['number']?.toString() ?? '0'),
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'name': name};
  }

  StreetEntity toEntity() {
    return StreetEntity(number: number, name: name);
  }

  factory StreetDto.fromEntity(StreetEntity entity) {
    return StreetDto(number: entity.number, name: entity.name);
  }
}

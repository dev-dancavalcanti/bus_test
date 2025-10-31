import 'package:bus_teste/domain/entities/id_entity.dart';

class IdDto {
  final String? name;
  final String? value;

  IdDto({this.name, this.value});

  factory IdDto.fromJson(Map<String, dynamic> json) {
    return IdDto(name: json['name'] ?? '', value: json['value'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }

  IdEntity toEntity() {
    return IdEntity(name: name, value: value);
  }

  factory IdDto.fromEntity(IdEntity entity) {
    return IdDto(name: entity.name, value: entity.value);
  }
}

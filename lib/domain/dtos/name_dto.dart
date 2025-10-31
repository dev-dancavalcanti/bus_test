import 'package:bus_teste/domain/entities/name_entity.dart';

class NameDto {
  final String title;
  final String first;
  final String last;

  NameDto({required this.title, required this.first, required this.last});

  factory NameDto.fromJson(Map<String, dynamic> json) {
    return NameDto(
      title: json['title'] ?? '',
      first: json['first'] ?? '',
      last: json['last'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'first': first, 'last': last};
  }

  NameEntity toEntity() {
    return NameEntity(title: title, first: first, last: last);
  }

  factory NameDto.fromEntity(NameEntity entity) {
    return NameDto(title: entity.title, first: entity.first, last: entity.last);
  }
}

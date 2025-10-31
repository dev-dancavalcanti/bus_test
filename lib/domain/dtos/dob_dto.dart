import 'package:bus_teste/domain/entities/dob_entity.dart';

class DobDto {
  final String date;
  final int age;

  DobDto({required this.date, required this.age});

  factory DobDto.fromJson(Map<String, dynamic> json) {
    return DobDto(
      date: json['date'] ?? '',
      age: int.parse(json['age']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'age': age};
  }

  DobEntity toEntity() {
    return DobEntity(date: date, age: age);
  }

  factory DobDto.fromEntity(DobEntity entity) {
    return DobDto(date: entity.date, age: entity.age);
  }
}

import 'package:bus_teste/domain/entities/dob_entity.dart';
import 'package:bus_teste/domain/entities/id_entity.dart';
import 'package:bus_teste/domain/entities/location_entity.dart';
import 'package:bus_teste/domain/entities/login_entity.dart';
import 'package:bus_teste/domain/entities/name_entity.dart';

class UserEntity {
  final String gender;
  final NameEntity name;
  final LocationEntity location;
  final String email;
  final LoginEntity login;
  final DobEntity dob;
  final String registered;
  final String phone;
  final String cell;
  final IdEntity id;
  final String picture;
  final String nat;

  UserEntity({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });
}

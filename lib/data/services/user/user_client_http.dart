import 'package:bus_teste/data/services/client_http.dart';
import 'package:bus_teste/domain/dtos/user_dto.dart';
import 'package:result_dart/result_dart.dart';

class UserClientHttp {
  final ClientHttp _clientHttp;

  UserClientHttp(this._clientHttp);

  AsyncResult<UserDto> getUser() async {
    final response = await _clientHttp.get(
      'https://randomuser.me/api/?results=1',
    );
    return response.map((data) => UserDto.fromJson(data.data['results'][0]));
  }
}

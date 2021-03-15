import 'package:coex_clover/model/aule.dart';
import 'package:http/http.dart' as http;

class DroneApi {
  String _urlServer;

  DroneApi(String urlServer) {
    _urlServer = urlServer;
  }

  Future<bool> goTo(Aule aula) async {
    var response = await http.post(
      Uri.parse("$_urlServer/" + aula.toShortString()),
      body: aula.toShortString(),
    );
    return (response.statusCode == 200) ? true : false;
  }
}

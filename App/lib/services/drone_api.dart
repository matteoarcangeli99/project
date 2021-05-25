import 'package:coex_clover/model/aule.dart';
import 'package:http/http.dart' as http;

class DroneApi {
  String _urlServer;

  DroneApi(String urlServer) {
    _urlServer = urlServer;
  }

  Future<int> goTo(Aule aula) async {
    print("$_urlServer/" + aula.toShortString().toLowerCase());
    var response = await http.get(
      Uri.parse("$_urlServer/" + aula.toShortString().toLowerCase()),
    );
    return response.statusCode;
  }
}

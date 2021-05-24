import 'package:coex_clover/model/aule.dart';
import 'package:http/http.dart' as http;

class DroneApi {
  String _urlServer;

  DroneApi(String urlServer) {
    _urlServer = urlServer;
  }

  void goTo(Aule aula) async {
    await http.get(
      Uri.parse("$_urlServer/" + aula.toShortString()),
    );
  }

  Future<bool> status() async {
    var response = await http.get(
      Uri.parse("$_urlServer/stato"),
    );
    return response.statusCode == 200;
  }
}

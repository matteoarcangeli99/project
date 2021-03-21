import 'package:coex_clover/model/aule.dart';
import 'package:http/http.dart' as http;

class DroneApi {
  String _urlServer;

  DroneApi(String urlServer) {
    _urlServer = urlServer;
  }

  Future<bool> goTo(Aule aula) async {
    var response = await http.get(
      Uri.parse(/*"$_urlServer/" + aula.toShortString()*/'http://192.168.189.130:8090/api/prova/test'),
    );
    return response.statusCode == 200;
  }
}

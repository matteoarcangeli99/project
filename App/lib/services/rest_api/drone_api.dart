import 'package:http/http.dart' as http;

class DroneApi {
  final String urlServer = 'http://localhost:8090/api';

  Future<bool> goTo(String aula) async {
      var response = await http.post(
      Uri.parse("http://localhost:8090/api/prova/prova"),
        body: aula,
    );
    return (response.statusCode == 200) ? true : false;
  }
}
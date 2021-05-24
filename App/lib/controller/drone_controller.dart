import '../model/aule.dart';
import '../services/drone_api.dart';

class DroneController {
  DroneApi _droneApi;

  DroneController(String urlServer) {
    _droneApi = DroneApi(urlServer);
  }

  Future<bool> navigate(Aule aula) async {
    bool ris = await _droneApi.status();
    if (!ris) {
      return false;
    } else {
      _droneApi.goTo(aula);
      return true;
    }
  }
}

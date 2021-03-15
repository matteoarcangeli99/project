enum Aule { Aula1, Aula2, Aula3, Laboratorio }

extension ParseToString on Aule {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

import 'package:basic_utils/basic_utils.dart';

enum Aule { Aula1, Aula2, Aula3, Laboratorio }

extension ParseToString on Aule {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String toSpacedString() {
    var index = toShortString().indexOf(RegExp('[0-9]'));
    if (index != -1)
      return StringUtils.addCharAtPosition(toShortString(), ' ', index);
    return toShortString();
  }
}

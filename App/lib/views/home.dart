import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:coex_clover/model/aule.dart';
import 'package:coex_clover/services/rest_api/drone_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DroneApi droneApi;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    droneApi = DroneApi("http://localhost:8090/api/prova/prova");
  }

  Widget build(BuildContext context) {
    final title = 'Selezionare l\'aula';
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                title,
                style: GoogleFonts.mcLaren(),
              ),
              backgroundColor: Color(0xFF5c687d),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(4, (index) {
                      return Center(
                        child: SizedBox(
                          width: 150.0,
                          height: 100.0,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF28435F)),
                              onPressed: () =>
                                  onButtonTap(context, Aule.values[index]),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.mcLaren(),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            Aule.values[index].toSpacedString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
                  ),
                ),
                Image.asset('assets/unicam.png', scale: 1.30),
                SizedBox(height: 30),
              ],
            )));
  }

  Future<void> onButtonTap(BuildContext context, Aule aula) async {
    try {
      if (await droneApi.goTo(aula))
        awesomeDialog(context, DialogType.INFO, "DRONE IN MOVIMENTO",
            "Attendi il ritorno");
    } on Exception catch (exception) {
      awesomeDialog(context, DialogType.ERROR, "ERRORE", exception.toString());
    }
  }

  AwesomeDialog awesomeDialog(BuildContext context, DialogType dialogType,
      String titolo, String descrizione) {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      headerAnimationLoop: true,
      animType: AnimType.SCALE,
      title: titolo,
      desc: descrizione,
      autoHide: Duration(seconds: 4),
    )..show();
  }
}

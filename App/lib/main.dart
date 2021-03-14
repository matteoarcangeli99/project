import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.mcLarenTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> aule = [
    "Aula 1",
    "Aula 2",
    "Laboratorio 1",
    "Sala studio 1",
    "Aula 3",
    "Sala studio 2"
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
                    children: List.generate(6, (index) {
                      return Center(
                        child: SizedBox(
                          width: 150.0,
                          height: 100.0,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF28435F)
                              ),
                              onPressed: () {
                                if (prova(index))
                                  awesomeDialog(context, "BOTTONE PREMUTO",
                                      "Hai premuto il bottone $index");
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.mcLaren(),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: aule[index],
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
                Image.asset('assets/unicam.png', scale: 1.5),
                SizedBox(height: 10),
              ],
            )));
  }

  bool prova(int index) {
    //if(index%2==0)
    return true;
    // return false;
  }

  AwesomeDialog awesomeDialog(
      BuildContext context, String titolo, String descrizione) {
    return AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      animType: AnimType.SCALE,
      title: titolo,
      desc: descrizione,
      autoHide: Duration(seconds: 5),
    )..show();
  }
}

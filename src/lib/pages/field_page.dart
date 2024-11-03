import "dart:convert";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:http/http.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";

class Field extends StatefulWidget {
  const Field({super.key});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  int? pressed;
  bool scanned = false;
  List<Row> rows = [];

  void getData() async {
    var response = await post(Uri.parse("http://127.0.0.1:5000/section-heatmap"), body: {"width": "15", "height": "14", "section": "${pressed!+1}"});

    var section_data = jsonDecode(response.body)["data"];

    for (List row in section_data) {
      List<Container> a = [];
      for (int x in row) {
        Container? t;
        double box_width = 20;
        double box_height = 20;
        if (x == 1) {
          t = Container(
            color: Colors.green,
            width: box_width,
            height: box_height,
          );
        }
        else if (x == 0) {
          t = Container(
            color: Colors.orange,
            width: box_width,
            height: box_height,
          );
        }
        else {
          t = Container(
            color: Colors.red,
            width: box_width,
            height: box_height,
          );
        }
        a.add(t);
      }
      rows.add(
        Row(
          children: a,
        )
      );
    }

    setState(() {
      rows = rows;
    });
  }

  void generateHeatmap() {
    getData();
  }

  Widget floatSection() {
    if (pressed != null) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0x99000000),
          ),
          Center(
            child: TapRegion(
                onTapOutside: (event) {
                  setState(() {
                    pressed = null;
                    scanned = false;
                    rows = [];
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: (!scanned) ? TextButton(
                      child: Text(
                        "Scan Section",
                        style: TextStyle(
                            fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                            fontSize: 30),
                      ),
                      onPressed: () {
                        setState(() {
                          scanned = true;
                          generateHeatmap();
                        });
                      },
                    ) : ((rows.isNotEmpty) ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: rows,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.green,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Healthy Leaf"),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.orange,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Helopeltis Infected"),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Red Spider Infected"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ) : LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 200)),
                  ),
                )),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GridView.count(
              crossAxisCount: 4,
              children: List.generate(8, (index) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        pressed = index;
                      });
                    },
                    child: Text(
                      "Section ${index + 1}",
                      style: TextStyle(
                          fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                          fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(Size(
                            MediaQuery.of(context).size.width * 0.2,
                            MediaQuery.of(context).size.height * 0.4)),
                        side: WidgetStateProperty.all(BorderSide()),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                  ),
                );
              })),
          floatSection()
        ],
      ),
    );
  }
}

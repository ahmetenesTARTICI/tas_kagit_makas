import 'package:flutter/material.dart';
import 'package:tas_kagit_makas/gameArea.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaMenu(),
    ));

class AnaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TAS KAGİT MAKAS"),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 400,
          child: ElevatedButton(
            child: Text("offline"),
            onPressed: () {
              Navigator.pushReplacement(context,
                  (MaterialPageRoute(builder: (context) => gameArea())));
            },
          ),
        ),
      ),
    );
  }
}

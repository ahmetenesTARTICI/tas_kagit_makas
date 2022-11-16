import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../model/card.dart';
import 'main.dart';

class gameArea extends StatefulWidget {
  const gameArea({Key? key}) : super(key: key);

  @override
  _gameAreaState createState() => _gameAreaState();
}

card tas = new card(id: 1, name: "tas");
card kagit = new card(id: 2, name: "kagit");
card makas = new card(id: 3, name: "makas");
List<card> elemanlar = [tas, kagit, makas];
int userSkor = 0;
int pcSkor = 0;

class _gameAreaState extends State<gameArea> {
  @override
  late String secenek1;
  late String secenek2;

  Widget build(BuildContext context) {
    var yukseklik = MediaQuery.of(context).size.height;
    var en = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TAŞ-KAĞIT-MAKAS(offline)",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.white12,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            pcList(yukseklik, en),
            skorTablePc(yukseklik, en),
            okayButton(yukseklik, en),
            skorTableUser(yukseklik, en),
            userList(yukseklik, en),
          ],
        ),
      ),
    );
  }

  pcList(double yukseklik, double en) {
    return Container(
        height: yukseklik / 4,
        width: en * 0.80,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, crossAxisCount: 3),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return nesnePc(elemanlar[index], Colors.red, yukseklik, en);
          },
        ));
  }

  pcDeger() {
    var random = new Random();
    card randomCard = elemanlar[random.nextInt(elemanlar.length)];
    secenek1 = randomCard.name;
    print(randomCard.name);
  }

  nesnePc(
    card eleman,
    MaterialColor renk,
    double yukseklik,
    double en,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: renk,
      ),
      height: yukseklik / 8,
      width: en / 5,
      alignment: Alignment.center,
      child: Text(
        eleman.name,
        style: TextStyle(fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  userList(double yukseklik, double en) {
    return Container(
        height: yukseklik / 4,
        width: en * 0.80,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, crossAxisCount: 3),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return nesneUser(elemanlar[index], Colors.blue, yukseklik, en);
          },
        ));
  }

  nesneUser(card eleman, MaterialColor renk, double yukseklik, double en) {
    return InkWell(
      onTap: () {
        secenek2 = eleman.name;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: renk,
        ),
        height: yukseklik / 8,
        width: en / 5,
        alignment: Alignment.center,
        child: Text(
          eleman.name,
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  kontrol() {
    if (secenek1 != null && secenek2 != null) {
      if (secenek1 == secenek2) {
        print("berabere");
        return "berabere";
      } else if ((secenek1 == "tas" || secenek1 == "kagit") &&
          (secenek2 == "tas" || secenek2 == "kagit")) {
        if (secenek1 == "kagit") {
          print("kazanan oyuncu pc");
          return "Kaybettiniz";
        } else {
          print("kazanan oyuncu insan");
          return "Kazandınız";
        }
      } else if ((secenek1 == "tas" || secenek1 == "makas") &&
          (secenek2 == "tas" || secenek2 == "makas")) {
        if (secenek1 == "tas") {
          print("kazanan oyuncu pc");
          return "Kaybettiniz";
        } else {
          print("kazanan oyuncu insan");
          return "Kazandınız";
        }
      } else if ((secenek1 == "kagit" || secenek1 == "makas") &&
          (secenek2 == "kagit" || secenek2 == "makas")) {
        if (secenek1 == "makas") {
          print("kazanan oyuncu pc");
          return "Kaybettiniz";
        } else {
          print("kazanan oyuncu insan");
          return "Kazandınız";
        }
      } else {
        return "tekli seçimde bir hata meydana geldiiiiiii";
      }
    } else {
      print("hatali seçim");
      return "ikili seçimde bi hata meydana geldi";
    }
  }

  void mesaj(String kazanan, BuildContext context) {
    String title = "-----";
    if (kazanan == "berabere") {
      title = "'-'";
    } else if (kazanan == "Kaybettiniz") {
      title = ":(";
    } else if (kazanan == "Kazandınız") {
      title = ":)";
    } else {}
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(kazanan),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                userSkor = 0;
                pcSkor = 0;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AnaMenu()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text("çık")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => gameArea()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text("tekrar oyna"))
        ],
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  okayButton(double yukseklik, double en) {
    return SizedBox(
      height: yukseklik / 13,
      width: en / 4,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          onPressed: () {
            pcDeger();
            String kazanan = kontrol();
            skorHesapla(kazanan);
            mesaj(kazanan, context);
          },
          child: Text("TAMAM")),
    );
  }

  skorTablePc(double yukseklik, double en) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: yukseklik / 10,
        width: en / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.red,
        ),
        alignment: Alignment.center,
        child: Text(pcSkor.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  skorTableUser(double yukseklik, double en) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        height: yukseklik / 10,
        width: en / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(userSkor.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  void skorHesapla(String kazanan) {
    setState(() {
      if (kazanan == "Kazandınız") {
        userSkor++;
      } else if (kazanan == "Kaybettiniz") {
        pcSkor++;
      } else if (kazanan == "berabere") {
      } else {
        print("skor hesaplamada hata");
      }
    });
  }
}

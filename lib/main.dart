import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproje/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:finalproje/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(t1.text)
          .set({"KullaniciEposta": t1.text, "KullaniciSifre": t2.text});
    });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Profile()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 57, 57),
      body: Container(
        width: 300, // genişlik
        height: 300, // yükseklik
        padding: EdgeInsets.symmetric(
          horizontal: 20, // yatayda sol ve sağdan 20 birim iç boşluk verir
        ),
        // Container içindeki nesnenin hizalanması için
        alignment: Alignment.center,
        // kutu biçimlendirmesi için
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          // Container'ın tüm kenarlarını yuvarlamak için
          //borderRadius: BorderRadius.circular(20),
          // sadece istediğimiz kenarları yuvarlamak için
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Icon(
                Icons.login,
                color: Color.fromARGB(255, 255, 0, 0),
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "GİRİŞ EKRANI", // metin widgetı
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "e-mail  giriniz...",
                ),
                controller: t1,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "parola giriniz...",
                ),
                controller: t2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  RaisedButton(child: Text("Kaydol"), onPressed: kayitOl),
                  SizedBox(width: 60),
                  RaisedButton(child: Text("Giriş Yap"), onPressed: girisYap),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HandlingInet extends StatefulWidget {
  final VoidCallback tampil_data;
  const HandlingInet({Key key, this.tampil_data}) : super(key: key);
  // final PenggunaModal modal;
  // PengaturanAkun(this.modal);
  @override
  _HandlingInet createState() => _HandlingInet();
}

class _HandlingInet extends State<HandlingInet> {
  tampil_data() {
    setState(() {
      widget.tampil_data();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                size.height * 0.15,
              ),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(
                        top: 120,
                        bottom: 10,
                      ),
                      child: Text(
                        "Sinyal internet Anda\nbermasalah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF18b15a)),
                      )),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        image: new AssetImage('assets/icons/lost.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 30.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        tampil_data();
                      },
                      color: Color(0xFF18b15a),
                      child: Text(
                        "Coba Lagi",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

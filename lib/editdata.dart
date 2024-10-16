import 'package:cobatokophp/adminpage.dart';
import 'package:flutter/material.dart';
import 'package:cobatokophp/adminpage.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;
  EditData({super.key, required this.list, required this.index});
  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerKode;
  late TextEditingController controllerNama;
  late TextEditingController controllerHarga;
  late TextEditingController controllerStok;

  void EditData() {
    var url = Uri.parse("http://localhost/cbtoko/editdata.php");
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "kode_item": controllerKode.text,
      "nama_item": controllerNama.text,
      "harga": controllerHarga.text,
      "stok": controllerStok.text,
    });
  }

  @override
  void initState() {
    controllerKode =
        new TextEditingController(text: widget.list[widget.index]['kode_item']);
    controllerNama =
        new TextEditingController(text: widget.list[widget.index]['nama_item']);
    controllerHarga =
        new TextEditingController(text: widget.list[widget.index]['harga']);
    controllerStok =
        new TextEditingController(text: widget.list[widget.index]['stok']);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            new TextField(
              controller: controllerKode,
              decoration: new InputDecoration(
                hintText: "Kode Item",
                labelText: "Kode Item",
              ),
            ),
            new TextField(
              controller: controllerNama,
              decoration: new InputDecoration(
                hintText: "Nama Item",
                labelText: "Nama Item",
              ),
            ),
            new TextField(
              controller: controllerHarga,
              decoration: new InputDecoration(
                hintText: "Harga",
                labelText: "Harga",
              ),
            ),
            new TextField(
              controller: controllerStok,
              decoration: new InputDecoration(
                hintText: "Stok",
                labelText: "Stok",
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new MaterialButton(
              child: new Text("Edit Data"),
              color: Colors.blueAccent,
              onPressed: () {
                EditData();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Admin(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:cobatokophp/detail.dart';
import 'package:cobatokophp/login.dart';
import 'package:cobatokophp/tambahdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Admin> {
  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://localhost/cbtoko/getdata.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TOKO"),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (result) { //TOMBOL YG MENGARAH KE BANTUAN DART YG MEMILIKI CLASS FAQPage
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Logout'),
                value: 0,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new TambahData(),
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('images/bg.jpg'), // Ganti dengan path gambar Anda
            fit: BoxFit
                .cover, // Untuk menyesuaikan gambar dengan ukuran container
          ),
        ),
      child: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data ?? [],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      )
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Atur warna latar belakang sesuai keinginan
            borderRadius: BorderRadius.circular(8.0), // Contoh: Tambahkan border radius
          ),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Detail(
                list: list,
                index: i,
              ),
            )),
            child: ListTile(
              title: Text(list[i]['nama_item']),
              leading: Icon(Icons.widgets),
              subtitle: Text("stok : ${list[i]['stok']}"),
            ),
          ),
        );
      },
    );
  }
}

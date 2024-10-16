import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cobatokophp/login.dart';

class Pengguna extends StatefulWidget {
  @override
  _ProductDataState createState() => _ProductDataState();
}

class _ProductDataState extends State<Pengguna> {
  Future<List> getProductData() async {
    final response =
        await http.get(Uri.parse("http://localhost/cbtoko/getdata.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Produk'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                // Perform logout logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Logout'),
                value: 0,
              ),
            ],
          )
        ],
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
        future: getProductData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ProductList(list: snapshot.data ?? [])
              : Center(child: CircularProgressIndicator());
        },
      ),
      )
    );
  }
}

class ProductList extends StatelessWidget {
  final List list;

  const ProductList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0), // Tambahkan margin vertical di sini
          child: ListTile(
            title: Text(list[i]['nama_item']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stok : ${list[i]['stok']}"),
                Text("Harga : ${list[i]['harga']}"),
              ],
            ),
            leading: Icon(Icons.widgets),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    productName: list[i]['nama_item'],
                    productStock: list[i]['stok'],
                    productPrice: list[i]['harga'],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProductDetail extends StatelessWidget {
  final String productName;
  final String productStock;
  final String productPrice;

  const ProductDetail({
    Key? key,
    required this.productName,
    required this.productStock,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nama Produk: $productName',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Stok: $productStock',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Harga: $productPrice',
              style: TextStyle(fontSize: 18),
            ),
            // Tambahkan informasi atau aksi lainnya jika diperlukan
          ],
        ),
      ),
    );
  }
}
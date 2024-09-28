import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}

class   ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final int _limit = 10; // Number of products to fetch per page
  int _currentPage = 1; // Current page
  List<Product> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=$_limit&skip=${(_currentPage - 1) * _limit}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = data['products'] as List<dynamic>;
      setState(() {
        _products.addAll(products.map((product) => Product.fromJson(product)).toList());
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
             Navigator.pushReplacementNamed(context, '/login');
          },
        ),
       // iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
          toolbarHeight: 80.10, //set your height
          flexibleSpace: SafeArea(
            child: Container(
             // color: const Color.fromARGB(255, 77, 233, 194), // set your color
              child: Column(
                children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: 
                  [
                  Text(
              'Welcome, ${FirebaseAuth.instance.currentUser?.email}!', // Display user's email
              style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold),
            ),// set your search bar setting
                ],
              ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text("Product Listing",style: TextStyle(fontSize: 20,color: Colors.white),),
             SizedBox(width: 30,) ,// set an icon or image
                  IconButton(
                      icon: Icon(Icons.sort,size: 40,color: Colors.yellow,),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/filterpage');  
                      }) ,
                      Text("Filter",style: TextStyle(fontSize: 12,color: Colors.yellow),)
           
            //SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut().then((_) {
            //       // Navigate back to the login screen after signing out
            //       Navigator.pushReplacementNamed(context, '/'); // Or '/login' if you have a separate login route
            //     });
            //   },
            //   child: Text('Sign Out'),
            // ),
          ],
        ),
      ]),
            ),
          ),
        //title: const Text('Product Listing'),
      ),
      body: 
      //_isLoading
         // ? Center(child: CircularProgressIndicator())
          Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return ListTile(
                     tileColor: index % 2 == 0 ? const Color.fromARGB(255, 207, 229, 240) : const Color.fromARGB(255, 203, 225, 243), 
                      
                        leading: Image.network(product.thumbnail),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                if (!_isLoading)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _currentPage < 5
                          ? () {
                              setState(() {
                                _currentPage++;
                                _fetchProducts();
                              });
                            }
                          : null,
                      child: Text('Load More'),
                    ),
                  ),
              ],
            ),
    );
  }
}
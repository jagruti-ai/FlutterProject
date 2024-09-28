import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
      brand: json['brand'],
    );
  }
}

class ProductFilterPage extends StatefulWidget {
  @override
  _ProductFilterPage createState() => _ProductFilterPage();
}

class _ProductFilterPage extends State<ProductFilterPage> {
  final int _limit = 10;
  int _currentPage = 1;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
List<Product> _allProducts = [];
  // Filter options
  double? _minPrice;
  double? _maxPrice;
  List<String> _selectedCategories = [];
  List<String> _selectedBrands = [];

  // Unique categories and brands for filter chips
  Set<String> _uniqueCategories = {};
  Set<String> _uniqueBrands = {};

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
        _uniqueCategories.addAll(_products.map((product) => product.category).toSet());
        _uniqueBrands.addAll(_products.map((product) => product.brand).toSet());
        _filteredProducts = _products; // Initialize filtered products with all products
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch products');
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredProducts = _products.where((product) {
        // Price filtering
        if (_minPrice != null && product.price < _minPrice!) return false;
        if (_maxPrice != null && product.price > _maxPrice!) return false;

        // Category filtering
        if (_selectedCategories.isNotEmpty &&
            !_selectedCategories.contains(product.category)) return false;

        // Brand filtering
        if (_selectedBrands.isNotEmpty &&
            !_selectedBrands.contains(product.brand)) return false;

        return true;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
             Navigator.pushReplacementNamed(context, '/productpage');
          },
        ),
        backgroundColor: Colors.blue,
        title: Text('Product Filter',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          // Filter section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price filter
                Text('Price Range'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Min Price'),
                        initialValue: _minPrice?.toStringAsFixed(2),
                        onChanged: (value) {
                          setState(() {
                            _minPrice = double.tryParse(value);
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Max Price'),
                        initialValue: _maxPrice?.toStringAsFixed(2),
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = double.tryParse(value);
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Category filter
                Text('Categories'),
                Wrap(
                  spacing: 8,
                  children: _uniqueCategories.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: _selectedCategories.contains(category),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                          _applyFilters();
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                // Brand filter
                Text('Brands'),
                Wrap(
                  spacing: 8,
                  children: _uniqueBrands.map((brand) {
                    return FilterChip(
                      label: Text(brand),
                      selected: _selectedBrands.contains(brand),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedBrands.add(brand);
                          } else {
                            _selectedBrands.remove(brand);
                          }
                          _applyFilters();
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return ListTile(
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
            child:  Column(
        // ... (Other widgets in your body)
        children:[ Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             ElevatedButton(
                onPressed: _currentPage < 5
                    ? () {
                        setState(() {
                          _currentPage++;
                        //  _fetchProducts();
                        });
                      }
                    : null,
                child: Text('Apply Filter'),
              ),
         ElevatedButton(
              onPressed: () {
                setState(() {
                  _filteredProducts = _allProducts; 
                });
              },
              child: const Text('Clear'),
            ), 
        ]),
        ],
      ),
      )]));
  }
}
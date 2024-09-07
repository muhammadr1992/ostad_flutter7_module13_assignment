import 'package:flutter/material.dart';

void main() {
  runApp(CheckoutPage());
}

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutScreen(),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<Product> products = [
    Product(name: 'Pullover', price: 51, count: 1),
    Product(name: 'T-Shirt', price: 30, count: 1),
    Product(name: 'Sport Dress', price: 43, count: 1),
  ];

  double get totalAmount => products.fold(0, (previousValue, element) => previousValue + (element.price * element.count));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var product in products) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: TextStyle(fontSize: 16)),
                      Text('Color: Black, Size: L', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product.count > 1) product.count--;
                          });
                        },
                      ),
                      Text(product.count.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            product.count++;
                          });
                        },
                      ),
                      Text('\$${(product.price * product.count).toString()}'),
                    ],
                  ),
                ],
              ),
              Divider(),
            ],
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount:', style: TextStyle(fontSize: 18)),
                Text('\$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Congratulations! Your order has been placed.'),
                  ),
                );
              },
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  String name;
  double price;
  int count;

  Product({required this.name, required this.price, required this.count});
}


import 'package:flutter/material.dart';
import 'package:prathee/View/product_page.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: cartProvider.cart.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cart[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Image
                        Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height:30),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Container(
                height:height*0.07,
                width:double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Center(
                  child: Text('Proceed to Checkout',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),
          const SizedBox(height:40),
        ],
      ),
    );
  }
}


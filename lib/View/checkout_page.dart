import 'package:flutter/material.dart';
import 'package:prathee/Model/product_model.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';


class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Screen'),
      ),
      body: Column(
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
                            IconButton(
                              icon: const Icon(Icons.delete,color: Colors.red,),
                              onPressed: () {
                                _DeleteDialog(context,cartProvider,product);

                                
                              },
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
          const SizedBox(height:20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,40,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total : \$${cartProvider.totalAmount.toStringAsFixed(2)}',style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
          const SizedBox(height:30),
          InkWell(
            onTap: (){
              _showPaymentDialog(context, cartProvider.totalAmount);
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
                  child: Text('Proceed to Payment',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),
          const SizedBox(height:30),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, double totalAmount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: Text('You have been charged \$${totalAmount.toStringAsFixed(2)}.',),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Thanks for Shopping!')));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _DeleteDialog(BuildContext context, CartProvider cartProvider, Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure want to Delete?'),
          actions: [
            TextButton(
              onPressed: () {
                cartProvider.removeFromCart(product);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Product Deleted')));
                Navigator.of(context).pop();
              },
              child: const Text('YES'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO'),
            ),
          ],
        );
      },
    );
  }


}

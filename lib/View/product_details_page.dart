import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/product_model.dart';
import '../provider/cart_provider.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,10,0),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              ),
              // Cart Icon Badge
              Positioned(
                left: 20,
                top: 2,
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return cartProvider.cart.isNotEmpty
                        ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 1,
                        minHeight: 1,
                      ),
                      child: Text(
                        cartProvider.cart.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(product.image, height: 250),
          const Padding(
            padding: EdgeInsets.fromLTRB(16,0,0,0),
            child: Text('Description :',style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16,10,0,0),
            child: Text(product.description),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16,20,0,0),
            child: Row(
              children: [
                const Text('Price : ',style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),
                Text('\$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const SizedBox(height:50),
          InkWell(
            onTap: (){
              cartProvider.addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Added to cart!'),
              ));
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
                  child: Text('Add to cart',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

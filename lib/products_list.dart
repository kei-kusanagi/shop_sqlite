import 'package:flutter/material.dart';
import 'package:shop_sqlite/shop_database.dart';
import 'models.dart';

class ProductsList extends StatelessWidget {
  var products = [
    Product(1, "Laptop Gamer Asus", "con mas RGB para mas FPS", 10000),
    Product(2, "Gamer Asus", "Laptop con descuento", 8000),
    Product(3, "Laptop Gamer", "la Laptop mas cara", 20000)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              color: Colors.blue[300],
              child: _ProductItem(products[index]),
            ),
            onTap: () async {
              addToCart(products[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Producto agregado!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 5,
            ),
        itemCount: products.length);
  }

  Future<void> addToCart(Product product) async {
    final item = CartItem(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: 1,
    );
    await ShopDatabase.instance.insert(item);
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;

  const _ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/laptopgamer.jpg',
            width: 100,
          ),
          Padding(padding: EdgeInsets.only(right: 3, left: 3)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text(product.description),
              Text("\$" + product.price.toString()),
            ],
          )
        ],
      ),
    );
  }
}

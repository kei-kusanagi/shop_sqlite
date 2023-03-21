import 'package:flutter/material.dart';
import 'package:shop_sqlite/shop_database.dart';
import 'models.dart';

class MyCart extends StatelessWidget {
  // var cartItems = [CartItem(id: 1, name: "name", price: 2000, quantity: 3)];
  // var cartItems = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ShopDatabase.instance.getAllItems(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.hasData) {
            List<CartItem> cartItems = snapshot.data!;
            return cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'No hay productos en tu carrito',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          color: Colors.grey,
                          child: _CartItem(cartItems[index]));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          height: 10,
                        ),
                    itemCount: cartItems.length);
          } else {
            return const Center(
              child: Text(
                'No hay productos en tu carrito',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        });
  }
}

class _CartItem extends StatelessWidget {
  final CartItem cartItem;

  const _CartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 20, color: Colors.white),
        child: Row(
          children: [
            Image.asset(
              'assets/images/laptopgamer.jpg',
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cartItem.name),
                  Text("\$" + cartItem.price.toString()),
                  Text(cartItem.quantity.toString() + " unidades"),
                  Text("Total: \$" + cartItem.totalPrice.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

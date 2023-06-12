import 'package:flutter/material.dart';

class ListItemCheckout extends StatefulWidget {
  final Map cart;
  final String totalCart;
  const ListItemCheckout({
    Key? key,
    required this.cart,
    required this.totalCart,
  }) : super(key: key);

  @override
  _ListItemCheckoutState createState() => _ListItemCheckoutState();
}

class _ListItemCheckoutState extends State<ListItemCheckout> {
  int count = 0;
  String totalCart = '0.0';

  @override
  void initState() {
    super.initState();
    count = int.parse(widget.cart['quantity']);
    totalCart = widget.totalCart;
  }

  @override
  Widget build(BuildContext context) {
    Map cart = widget.cart;
    print('hello');
    return ListTile(
      onTap: () {},
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(cart['image']),
            fit: BoxFit.scaleDown,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      title: Text(cart['name']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('₱${cart['price']}/${cart['unit']}'),
          Text('Quantity: ' + cart['buyQuantity'])
        ],
      ),
      trailing: Text('₱' +
          (num.parse(cart['buyQuantity']) * num.parse(cart['price']))
              .toString()),
    );
  }
}

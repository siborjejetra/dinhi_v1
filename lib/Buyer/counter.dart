import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final ValueChanged<int> onCountChanged;
  final ValueChanged<double> onPriceChanged;
  final double price;

  const CounterWidget({
    Key? key,
    required this.onCountChanged,
    required this.onPriceChanged,
    required this.price,
  }) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;
  double price = 0.0;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    price = widget.price;
  }

  void incrementCount() {
    setState(() {
      count++;
      total = price * count;
      widget.onCountChanged(count);
    });
  }

  void decrementCount() {
    setState(() {
      if (count > 0) {
        count--;
        total = price * count;
        widget.onCountChanged(count);
      }
    });
  }

  void updatePrice(double newPrice) {
    setState(() {
      price = newPrice;
      total = price * count;
      widget.onPriceChanged(price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '₱${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16.0),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: decrementCount,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: incrementCount,
        ),
      ],
    );
  }
}

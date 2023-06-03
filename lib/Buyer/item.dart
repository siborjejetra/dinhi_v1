import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemParent extends StatelessWidget {
  const ItemParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ItemChild extends StatefulWidget {
  const ItemChild({Key? key}) : super(key: key);

  @override
  State<ItemChild> createState() => _ItemChildState();
}

class _ItemChildState extends State<ItemChild> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

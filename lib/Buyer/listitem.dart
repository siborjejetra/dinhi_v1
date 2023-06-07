import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class CustomListItem extends StatefulWidget {
//   final Map cart;
//   final double totalCart;
//   final void Function(double) updateTotal;

//   const CustomListItem({
//     Key? key,
//     required this.cart,
//     required this.totalCart,
//     required this.updateTotal,
//   }) : super(key: key);
//   // const CustomListItem({Key? key, required this.cart}) : super(key: key);
//   @override
//   _CustomListItemState createState() => _CustomListItemState();
// }

// class _CustomListItemState extends State<CustomListItem> {
//   int count = 0;
//   double totalCart = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     Map cart = widget.cart;

//     return ListTile(
//       onTap: () {},
//       leading: Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(cart['image']),
//             fit: BoxFit.scaleDown,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       title: Text(cart['name']),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(cart['price'] + '/' + cart['unit']),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.remove),
//                 onPressed: () {
//                   setState(() {
//                     // Update count and totalCart
//                     if (count > 0) {
//                       count--;
//                       totalCart -= num.parse(cart['price']);

//                       // Ensure totalCart is not below 0.0
//                       if (totalCart < 0.0) {
//                         totalCart = 0.0;
//                       }

//                       // Call the updateTotal callback function from the parent widget
//                       widget.updateTotal(totalCart);
//                     }
//                   });
//                 },
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//                 child: Text(
//                   count.toString(),
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   setState(() {
//                     // Update count and totalCart
//                     count++;
//                     totalCart += num.parse(cart['price']);

//                     // Call the updateTotal callback function from the parent widget
//                     widget.updateTotal(totalCart);
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       trailing: IconButton(
//         icon: Icon(Icons.delete),
//         onPressed: () {
//           setState(() {
//             // deleteItem(index);
//           });
//         },
//       ),
//     );
//   }
// }
class CustomListItem extends StatefulWidget {
  final Map cart;
  final double totalCart;
  final void Function(double) updateTotal;
  const CustomListItem({
    Key? key,
    required this.cart,
    required this.totalCart,
    required this.updateTotal,
  }) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  int count = 0;
  double totalCart = 0.0;

  @override
  void initState() {
    super.initState();
    count = int.parse(widget.cart['quantity']) ?? 0;
    totalCart = widget.totalCart;
  }

  @override
  Widget build(BuildContext context) {
    Map cart = widget.cart;

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
          Text('${cart['price']}/${cart['unit']}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    // Update count and totalCart
                    if (count > 0) {
                      count--;
                      totalCart -= num.parse(cart['price']);

                      // Ensure totalCart is not below 0.0
                      if (totalCart < 0.0) {
                        totalCart = 0.0;
                      }

                      // Call the updateTotal callback function from the parent widget
                      widget.updateTotal(totalCart);
                    }
                  });
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    // Update count and totalCart
                    count++;
                    totalCart += num.parse(cart['price']);

                    // Call the updateTotal callback function from the parent widget
                    widget.updateTotal(totalCart);
                  });
                },
              ),
            ],
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            // deleteItem(index);
          });
        },
      ),
    );
  }
}

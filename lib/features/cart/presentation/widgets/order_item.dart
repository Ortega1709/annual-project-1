import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderItem extends StatelessWidget {
  final Orderl orderl;
  final bool isLandscape;
  final Function()? onPressed;

  const OrderItem({
    super.key,
    required this.orderl,
    required this.onPressed,
    this.isLandscape = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.cartArrowDown),
      title: Text(orderl.id),
      subtitle: Text(
        orderl.isdelivered ? 'Livrée' : 'En attente',
        style: TextStyle(
          color: orderl.isdelivered? Colors.green : Colors.red,
        ),
      ),
      trailing: Text('€ ${(orderl.total).toStringAsFixed(2)}'),
    );
  }
}

import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:e_commerce/features/cart/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class OrderList extends StatelessWidget {
  final List<Orderl> orders;

  const OrderList({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    'assets/svg/empty-cart.svg',
                    width: 150,
                    height: 150,
                  ),
                ),
                Text(
                  'Oops !',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppDimen.p8),
                Text(
                  textAlign: TextAlign.center,
                  'Aucun commande trouvée.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.p16),
              child: Container(
                height: .5,
                color: AppColor.greyColor.withOpacity(.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderItem(
                orderl: order,
                isLandscape: true,
                onPressed: () {
                  debugPrint('click: $order');
                  context.push('/order-detail', extra: order);
                },
              );
            },
          );
  }
}

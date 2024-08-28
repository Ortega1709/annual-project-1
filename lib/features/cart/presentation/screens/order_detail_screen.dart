import 'package:e_commerce/core/shared/widgets/progress.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/cart/presentation/bloc/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final Orderl order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetDetailOrderByOrderIdEvent(orderId: widget.order.id));
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd-MM-yyyy hh:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails commande"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimen.p16),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColor.grayColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppDimen.p12))),
              child: Column(
                children: [
                  const ListTile(
                    title: Text("Détails commande"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.p16, vertical: AppDimen.p4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Commande ID',
                          style: TextStyle(color: AppColor.greyColor),
                        ),
                        Text(
                          widget.order.id,
                          style: const TextStyle(color: AppColor.greyColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.p16, vertical: AppDimen.p4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date de commande',
                          style: TextStyle(color: AppColor.greyColor),
                        ),
                        Text(
                          f.format(widget.order.created),
                          style: const TextStyle(color: AppColor.greyColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.p16, vertical: AppDimen.p4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(color: AppColor.greyColor),
                        ),
                        Text(
                          '€ ${widget.order.total.toStringAsFixed(2)}',
                          style: const TextStyle(color: AppColor.greyColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimen.p12),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimen.p8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimen.p16),
            child: Text("Produits"),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimen.p16),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.grayColor,
                borderRadius: BorderRadius.all(Radius.circular(AppDimen.p12)),
              ),
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderDetailErrorState) {
                    Messages.error('Erreur', state.errorMessage, context);
                  }
                },
                builder: (context, state) {
                  if (state is OrderDetailLoadingState) {
                    return const Center(child: Progress());
                  }
                  if (state is OrderDetailLoadedState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.p16),
                        child: Container(
                          height: .5,
                          color: AppColor.greyColor.withOpacity(.5),
                        ),
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: AppDimen.p16),
                      itemCount: state.orderDetails.length,
                      itemBuilder: (context, index) {
                        final order = state.orderDetails[index];
                        return ListTile(
                          title: Text(order.productname),
                          subtitle: Text('€ ${order.productprice} x ${order.quantity}'),
                          trailing: Text('€ ${order.subtotal.toStringAsFixed(2)}'),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

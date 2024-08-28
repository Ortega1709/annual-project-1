import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/shared/widgets/progress.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/cart/presentation/widgets/order_list.dart';
import 'package:e_commerce/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = serviceLocator<SharedPreferences>();
    final isAuthenticated = preferences.getBool('authentication') ?? false;
    final userId = preferences.getString('id');

    context.read<CartBloc>().add(GetOrderByUserIdEvent(userId: userId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: isAuthenticated ? const Text("Commandes") : const Text(''),
      ),
      body: isAuthenticated
          ? BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is OrderErrorState) {
                  Messages.error("Erreur", state.errorMessage, context);
                }
              },
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const Center(child: Progress());
                }

                if (state is OrderLoadedState) {
                  return OrderList(
                    orders: state.orders,
                  );
                }
                return const SizedBox.shrink();
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.p24),
                  child: Text(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    'Connectez-vous ou inscrivez-vous dès maintenant pour découvrir tout ce que nous avons à offrir.',
                  ),
                ),
                const SizedBox(height: AppDimen.p24),
                Center(
                  child: MButton(
                    text: 'Se connecter',
                    onPressed: () {
                      context.go('/sign-in');
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

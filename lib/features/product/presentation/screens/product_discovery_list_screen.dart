import 'package:e_commerce/core/shared/widgets/progress.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_filter_dialog.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

class ProductDiscoveryListScreen extends StatefulWidget {
  const ProductDiscoveryListScreen({super.key});

  @override
  State<ProductDiscoveryListScreen> createState() =>
      _ProductDiscoveryListScreenState();
}

class _ProductDiscoveryListScreenState
    extends State<ProductDiscoveryListScreen> {
  int selectedSort = 0;

  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Découvrir nos produits"),
        actions: [
          IconButton(
              onPressed: () {
                productFilterDialog(
                  context,
                  [
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedSort = 0;
                          Navigator.pop(context);
                        });
                        context.read<ProductBloc>().add(GetAllProductsEvent());
                      },
                      leading: const Icon(Icons.sort),
                      title: const Text("Par défaut"),
                      trailing: selectedSort == 0
                          ? const Icon(Icons.check_circle)
                          : null,
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedSort = 1;
                          Navigator.pop(context);
                        });
                        context
                            .read<ProductBloc>()
                            .add(GetProductsOrderByName());
                      },
                      leading: const Icon(Icons.sort_by_alpha_rounded),
                      title: const Text("Ordre alphabétique"),
                      trailing: selectedSort == 1
                          ? const Icon(Icons.check_circle)
                          : null,
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedSort = 2;
                          Navigator.pop(context);
                        });
                        context
                            .read<ProductBloc>()
                            .add(GetProductsOrderByPrice());
                      },
                      leading: const Icon(CupertinoIcons.money_euro),
                      title: const Text("Prix de produit"),
                      trailing: selectedSort == 2
                          ? const Icon(Icons.check_circle)
                          : null,
                    ),
                  ],
                );
              },
              icon: const Icon(CupertinoIcons.slider_horizontal_3)),
          const SizedBox(width: AppDimen.p16)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(GetAllProductsEvent());
        },
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductErrorState) {
              Messages.error("Error", state.message, context);
            }
          },
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(child: Progress(size: 60));
            } else if (state is ProductLoadedState) {
              return ProductList(products: state.products);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/shared/widgets/auth_required_dialog.dart';
import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/shared/widgets/quantity_counter.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/shared/widgets/progress.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_dimen.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/secrets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  void initState() {
    quantity = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is AddToCartSuccessState) {
              Messages.success("Panier", state.message, context);
            }

            if (state is CartErrorState) {
              Messages.error("Panier", "Erreur d'ajout", context);
            }
          },
          builder: (context, state) {
            return MButton(
              text:
                  "Ajouter au panier | € ${(widget.product.price! * quantity).toStringAsFixed(2)}",
              onPressed: () {
                final isAuthenticated = serviceLocator<SharedPreferences>()
                        .getBool('authentication') ??
                    false;
                if (!isAuthenticated) {
                  authRequiredDialog(context);
                  return;
                }
                context.read<CartBloc>().add(
                      AddItemToCartEvent(
                        widget.product.id,
                        widget.product.name,
                        widget.product.image,
                        widget.product.price,
                        quantity,
                      ),
                    );
              },
            );
          },
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: AppColor.blackColor.withOpacity(0.4),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => context.pop(),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.blackColor.withOpacity(0.4),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
            elevation: 0,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            snap: false,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              stretchModes: const [StretchMode.zoomBackground],
              background: Hero(
                tag: widget.product.name,
                transitionOnUserGestures: true,
                child: CachedNetworkImage(
                  imageUrl:
                      "${Secrets.pocketbaseFileUrl}/${widget.product.id}/${widget.product.image}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Progress();
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text(
                    widget.product.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimen.p16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "€ ${widget.product.price}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                      ),
                      QuantityCounter(
                        quantity: quantity,
                        onAdd: () {
                          if (quantity < widget.product.seuilRupture) {
                            setState(() {
                              quantity++;
                            });
                          }
                        },
                        onRemove: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Description",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  subtitle: Text(
                    widget.product.description.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColor.greyColor),
                  ),
                ),
                const SizedBox(height: AppDimen.p16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: AppDimen.p16),
                      Chip(
                        avatar: const Icon(FontAwesomeIcons.layerGroup),
                        label: Row(
                          children: [
                            const Text("Catégorie: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.product.category.name)
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimen.p16),
                      Chip(
                        avatar: const Icon(FontAwesomeIcons.boxArchive),
                        label: Row(
                          children: [
                            const Text("En stock: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.product.seuilRupture.toString())
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimen.p16)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/widgets/visible_products_item.dart';

class VisibleProductsListView extends StatelessWidget {
  const VisibleProductsListView({
    super.key, required this.products,
  });
final List<ProductEntity>products;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        itemBuilder: (context, index) =>  Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: VisibleProductsItem(productEntity: products[index],),
        ),
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}


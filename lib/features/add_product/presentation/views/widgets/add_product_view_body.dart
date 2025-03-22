import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_button.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/add_product/presentation/manager/add_product/add_product_cubit.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/add_product_text_fields.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/image_field.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/is_featured_check_box.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/is_organic_check_box.dart';

class AddProductViewBody extends StatelessWidget {
  const AddProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddProductCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              AddProductTextFields(cubit: cubit),
              verticalSpace(16),
              ImageField(
                onChanged: (value) {
                  cubit.productImage = value;
                },
              ),
              verticalSpace(16),
              IsFeaturedCheckBox(onChanged: (value) {
                cubit.isFeatured = value;
              }),
              verticalSpace(16),
              IsOrganicCheckBox(onChanged: (value) {
                cubit.isOrganic = value;
              }),
              verticalSpace(30),
              CustomButton(
                  text: 'اضافة المنتج',
                  onPressed: () {
                    if (cubit.productImage != null) {
                      if (cubit.formKey.currentState!.validate()) {
                        ProductEntity input = productData(cubit);
                        cubit.addProduct(addProductEntity: input);
                      }
                    } else {
                      showSnackBar(context, text: 'يجب اضافة صورة للمنتج');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  ProductEntity productData(AddProductCubit cubit) {
    ProductEntity input = ProductEntity(
        salesCount: 0,
        fileImage: cubit.productImage,
        discountPrice: cubit.discountPrice?.toDouble() ?? 0,
        expirationMonths: cubit.expirationMonths?.toInt() ?? 12,
        isOrganic: cubit.isOrganic,
        productQuantity: cubit.productQuantity?.toInt() ?? 0,
        name: cubit.productName.text,
        price: cubit.productPrice?.toInt() ?? 0,
        description: cubit.productDescription.text,
        code: cubit.productCode.text,
        isFeatured: cubit.isFeatured,
        category: cubit.selectedCategory ?? 'الفئة',
        productType: cubit.selectedProductType ?? 'النوع',
        reviews: []);
    return input;
  }
}

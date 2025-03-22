import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_drop_down_form_field.dart';
import 'package:gac_dashboard/core/widgets/custom_product_type_drop_down_button.dart';
import 'package:gac_dashboard/core/widgets/custom_text_field.dart';
import 'package:gac_dashboard/features/add_product/presentation/manager/add_product/add_product_cubit.dart';

class AddProductTextFields extends StatelessWidget {
  const AddProductTextFields({
    super.key,
    required this.cubit,
  });

  final AddProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            hintText: 'اسم المنتج',
            controller: cubit.productName,
            onChanged: (value) {
              cubit.productName.text = value;
            }),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'كود المنتج',
          onChanged: (value) {
            cubit.productCode.text = value;
          },
          controller: cubit.productCode,
        ),
        verticalSpace(16),
        CustomTextFormField(
            textInputType: TextInputType.number,
            hintText: 'السعر',
            onChanged: (value) {
              cubit.productPrice = num.parse(value);
            }),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'شهور الصلاحية',
          onChanged: (value) {
            cubit.expirationMonths = num.parse(value);
          },
          textInputType: TextInputType.number,
        ),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'سعر الخصم، ضعه بـ 0 اذا لا يوجد خصم',
          onChanged: (value) {
            cubit.discountPrice = num.parse(value);
          },
          textInputType: TextInputType.number,
        ),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'الكمية',
          onChanged: (value) {
            cubit.productQuantity = num.parse(value);
          },
          textInputType: TextInputType.number,
        ),
        verticalSpace(16),
         CustomCategoryDropDownButtonFormField(
                value: cubit.selectedCategory ,
                items: cubit.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: FittedBox(child: Text(category)),
                  );
                }).toList(),
                onChanged: (value) {
                  cubit.selectedCategory = value;
                },
              ),
        verticalSpace(16),
        CustomProductTypeDropDownButtonFormField(
        value: cubit.selectedProductType,
        items: cubit.productTypes.map((productType) {
          return DropdownMenuItem<String>(
            value: productType,
            child: FittedBox(child: Text(productType)),
          );
        }).toList(
        ),
        onChanged: (value) {
          cubit.selectedProductType = value;
        },
        
        ),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'وصف المنتج',
          onChanged: (value) {
            cubit.productDescription.text = value;
          },
          controller: cubit.productDescription,
          maxLines: 5,
        ),
      ],
    );
  }
}

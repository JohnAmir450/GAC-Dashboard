import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gac_dashboard/core/cubits/product_updates/product_updates_cubit.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_button.dart';
import 'package:gac_dashboard/core/widgets/custom_drop_down_form_field.dart';
import 'package:gac_dashboard/core/widgets/custom_text_field.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/is_featured_check_box.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UpdateProductViewBody extends StatefulWidget {
  final ProductEntity product;
  const UpdateProductViewBody({super.key, required this.product});

  @override
  State<UpdateProductViewBody> createState() => _UpdateProductViewBodyState();
}

class _UpdateProductViewBodyState extends State<UpdateProductViewBody> {
  bool hasChanges = false;

  @override
  void initState() {
   
    context
        .read<ProductUpdatesCubit>()
        .getProduct(code:  widget.product.code);
    context.read<ProductUpdatesCubit>().productName?.text = widget.product.name;
    context.read<ProductUpdatesCubit>().productCode?.text = widget.product.code;
    context.read<ProductUpdatesCubit>().productDescription?.text =
        widget.product.description;
    context.read<ProductUpdatesCubit>().selectedCategory =
        widget.product.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductUpdatesCubit>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                height: MediaQuery.sizeOf(context).height * 0.3,
                imageUrl: widget.product.imageUrl!,
                placeholder: (context, url) =>
                    LoadingAnimationWidget.threeRotatingDots(
                        color: AppColors.lightSecondaryColor, size: 23),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline, color: Colors.amber),
              ),
            ),
            verticalSpace(24),
            updateProductTextFields(cubit),
            verticalSpace(16),
            IsFeaturedCheckBox(
              isAlreadyChecked: widget.product.isFeatured,
              onChanged: (value) {
             
              cubit.isFeatured = value;
              hasChanges = true;
            }),
            verticalSpace(24),
            CustomButton(
              text: 'تحديث المنتج',
              onPressed: () {
                if (hasChanges) {
                  updateProductDataFromCubit(cubit);
                  showSnackBar(context,
                      text: 'تم التحديث بنجاح', color: Colors.green);
                } else {
                  showSnackBar(context,
                      text: 'لا توجد تغييرات', color: Colors.amber);
                }
              },
              backgroundColor: Colors.cyan,
            ),
            verticalSpace(16),
            CustomButton(
              text: 'حذف المنتج',
              onPressed: () {
                cubit.deleteProduct();
                showSnackBar(context,
                    text: 'تم حذف المنتج بنجاح', color: Colors.red);
                context.pop();
              },
              backgroundColor: Colors.red,
            ),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }

  Column updateProductTextFields(ProductUpdatesCubit cubit) {
    return Column(
      children: [
        CustomTextFormField(
            hintText: 'اسم المنتج : ${widget.product.name}',
            onChanged: (value) {
              cubit.productName?.text = value;
              hasChanges = true;
            }),
        verticalSpace(16),
        CustomTextFormField(
          hintText: 'كود المنتج : ${widget.product.code}',
          onChanged: (value) {
            cubit.productCode?.text = value;
            hasChanges = true;
          },
        ),
        verticalSpace(16),
        CustomTextFormField(
            textInputType: TextInputType.number,
            hintText: 'سعر المنتج : ${widget.product.price.toString()}',
            onChanged: (value) {
              cubit.productPrice = num.parse(value);
              hasChanges = true;
            }),
        verticalSpace(16),
        CustomTextFormField(
          hintText:
              'شهور الصلاحية : ${widget.product.expirationMonths.toString()}',
          onChanged: (value) {
            cubit.expirationMonths = num.parse(value);
          },
          textInputType: TextInputType.number,
        ),
        verticalSpace(16),
        CustomTextFormField(
          hintText:
              ' سعر الخصم، ضعه بـ 0 إذا لا يوجد خصم: ${widget.product.discountPrice.roundToDouble().toString()}',
          onChanged: (value) {
            cubit.numberOfCalories = num.parse(value);
            hasChanges = true;
          },
          textInputType: TextInputType.number,
        ),
        verticalSpace(16),
        CustomTextFormField(
          hintText:
              'الكمية المتوفرة : ${widget.product.productQuantity.toString()}',
          onChanged: (value) {
            cubit.productQuantity = num.parse(value);
            hasChanges = true;
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
        CustomTextFormField(
          hintText: 'وصف المنتج : ${widget.product.description}',
          onChanged: (value) {
            cubit.productDescription?.text = value;
            hasChanges = true;
          },
          //controller: cubit.productDescription,
          maxLines: 5,
        ),
      ],
    );
  }

  void updateProductDataFromCubit(ProductUpdatesCubit cubit) {
    cubit.updateProduct(
        productEntity: ProductEntity(
          salesCount:widget.product.salesCount ,
            imageUrl: widget.product.imageUrl,
            category: cubit.selectedCategory ,
            fileImage: widget.product.fileImage,
            discountPrice: cubit.numberOfCalories?.toInt() ??
                widget.product.discountPrice,
            expirationMonths: cubit.expirationMonths?.toInt() ??
                widget.product.expirationMonths,
            isOrganic: widget.product.isOrganic,
            productQuantity: cubit.productQuantity?.toInt() ??
                widget.product.productQuantity,
            name: cubit.productName?.text ?? widget.product.name,
            price: cubit.productPrice?.toInt() ?? widget.product.price,
            description:
                cubit.productDescription?.text ?? widget.product.description,
            code: cubit.productCode?.text ?? widget.product.code,
            isFeatured: cubit.isFeatured ?? widget.product.isFeatured,
            reviews: widget.product.reviews));
  }
}


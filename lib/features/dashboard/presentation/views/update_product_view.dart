import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/cubits/product_updates/product_updates_cubit.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/widgets/update_product_view_body.dart';

class UpdateProductView extends StatelessWidget {
  const UpdateProductView({super.key, required this.productEntity});
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'تعديل بيانات المنتج',leading: IconButton(onPressed: (){context.pop();}, icon: const Icon(Icons.arrow_back_ios)),),
      body: BlocConsumer<ProductUpdatesCubit, ProductUpdatesState>(
        listener: (context, state) {
         {
          
          if (state is ProductUpdatesFailureState) {
            showSnackBar(context, text: state.errorMessage, color: Colors.red);
          }
          if(state is DeleteProductSuccessState)
          {
            showSnackBar(context, text: 'تم حذف المنتج بنجاح', color: Colors.green);
          }
          if (state is DeleteProductFailureState) {
            showSnackBar(context, text: state.errorMessage, color: Colors.red);
          } 
         }},
        builder: (context, state) {
          return UpdateProductViewBody(
            product: productEntity,
          );
        },
      ),
    );
  }
}

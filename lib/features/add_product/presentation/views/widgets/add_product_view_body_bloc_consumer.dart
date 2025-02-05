import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/add_product_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../manager/add_product/add_product_cubit.dart';

class AddProductViewBodyBlocConsumer extends StatelessWidget {
  const AddProductViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if(state is AddProductSuccessState){
          showSnackBar(context, text: 'تم اضافة المنتج بنجاح', color: Colors.green);
          context.pop();
        }
        if (state is AddProductFailureState) {
          showSnackBar(context, text: state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
          inAsyncCall: state is AddProductLoadingState,
          child: const AddProductViewBody());
      },
    );
  }
}

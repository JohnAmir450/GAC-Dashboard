import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/repos/images_repo/images_repo.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/add_product/presentation/manager/add_product/add_product_cubit.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/widgets/add_product_view_body_bloc_consumer.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'منتج جديد',
          leading: Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          )),
      body: BlocProvider(
        create: (context) => AddProductCubit(
          getIt.get<ImagesRepo>(),
          getIt.get<ProductsRepo>(),
        ),
        child: const AddProductViewBodyBlocConsumer(),
      ),
    );
  }
}


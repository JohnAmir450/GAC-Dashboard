import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/cusom_quick_alret_view.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/services/notification_service.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CustomDropDownButton extends StatefulWidget {
  final OrderEntity orderEntity;

  const CustomDropDownButton({
    super.key,
    required this.orderEntity,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late String selectedOrderStatus; // Current displayed status
  String? pendingStatusChange; // Temporarily holds the selected status

  @override
  void initState() {
    super.initState();
    selectedOrderStatus = widget.orderEntity.orderStatus;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedOrderStatus,
      items: const [
        DropdownMenuItem(
          value: 'جاري التأكيد',
          child: Text('جاري التأكيد'), // Pending confirmation
        ),
        DropdownMenuItem(
          value: 'تم الإلغاء',
          child: Text('تم الإلغاء'), // Canceled
        ),
        DropdownMenuItem(
          value: 'تم التأكيد',
          child: Text('تم التأكيد'), // Confirmed
        ),
        DropdownMenuItem(
          value: 'خرج للتوصيل',
          child: Text('خرج للتوصيل'), // Out for delivery
        ),
        DropdownMenuItem(
          value: 'تم الاستلام',
          child: Text('تم الاستلام'), // Delivered
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          if (value == 'تم الإلغاء' || value == 'تم الاستلام') {
            customQuickAlertView(
              context,
              title: 'هل انت متأكد من حالة هذا الطلب ؟ : $value',
              text: 'لا يمكن استرجاع الطلب بعد حذفه',
              type: QuickAlertType.confirm,
              confirmBtnText: 'نعم',
              onConfirmBtnTap: () {
                showSnackBar(context, text: 'تم تنفيذ العملية بنجاح');
                Navigator.pop(context); // Close the dialog

                updateOrderStatus(context, value);
                if (value == 'تم الإلغاء') {
                  context.read<OrdersCubit>().updateProductQuantityIfCancelled(
                        orderId: widget.orderEntity.orderId,
                        products:
                            widget.orderEntity.checkoutProductDetails.toList(),
                      );
                }
                context
                    .read<OrdersCubit>()
                    .deleteOrder(orderId: widget.orderEntity.orderId);
              },
            );
          } else {
            updateOrderStatus(context, value);
          }
        }
      },
    );
  }

  void updateOrderStatus(BuildContext context, String value) {
    setState(() {
      selectedOrderStatus = value; // Update UI status
    });

    // Call Cubit to update status in the backend
    context.read<OrdersCubit>().updateProductStatus(
          orderId: widget.orderEntity.orderId,
          status: value,
        );

    // Send a notification for the status change
    NotificationService().sendNotification(
      pushId: widget.orderEntity.notificationId,
      title: 'تم تحديث حالة الطلب رقم ${widget.orderEntity.orderId}',
      body: 'تم تحديث حالة الطلب الى "$value"، يمكنك متابعة حالة الطلبات من خلال التطبيق',
    );
  }
}

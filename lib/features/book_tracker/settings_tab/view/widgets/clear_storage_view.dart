import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/helpers/app_alerts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../../../../shared/widgets/custom_ink_well.dart';

class ClearStorageView extends StatelessWidget {
  const ClearStorageView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        _showClearStorageConfirmationDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.cleaning_services_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              12.customHorizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body1(text: TextConstants.clearStorage),
                    6.customVerticalSpace,
                    AppText.subText2(
                      text: TextConstants.clearStorageDescription,
                    ),
                  ],
                ),
              ),
              12.customHorizontalSpace,
              Icon(Icons.delete_forever_rounded, color: Colors.red, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearStorageConfirmationDialog(BuildContext context) {
    AppAlerts.showConfirmationDialog(
      title: TextConstants.clearStorage,
      message: TextConstants.clearStorageConfirmation,
      confirmBtnTitle: TextConstants.clear,
      cancelBtnTitle: TextConstants.cancel,
      onTapCancel: (value) {},
      onTapConfirm: (value) {},
    );
  }
}

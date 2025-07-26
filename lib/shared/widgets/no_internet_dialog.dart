import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/widgets/lottie_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes.dart';
import '../../config/text_styles.dart';
import '../../core/constants/assets_constants.dart';
import '../../core/constants/text_constants.dart';
import '../helpers/app_alerts.dart';
import 'custom_button.dart';

showNoInternetDialog(Function() onRetry) {
  AppAlerts.showCustomDialog(child: NoInternetDialog(onRetry: onRetry));
}
class NoInternetDialog extends StatelessWidget {
  final void Function()? onRetry;
  const NoInternetDialog({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.r),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieAsset(
            path: AssetsConstants.noInternet,
            width: 240.r,
            height: 240.r,
          ),
          AppText.title1(
            text: TextConstants.noInternetConnection,
            fontWeight: FontWeight.w600,
          ),
          5.customVerticalSpace,
          AppText.body1(
            text: TextConstants.noInternetConnectionDescription,
            textAlign: TextAlign.center,
          ),
          40.customVerticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (onRetry != null) ? 10.w : 50.w),
            child: Row(
              children: [
                if (onRetry != null) ...[
                  Expanded(
                    child: CustomButton(
                      borderColor: Theme.of(context).colorScheme.primary,
                      backgroundColorActive:
                          Theme.of(context).colorScheme.surface,
                      textColorActive: Theme.of(context).colorScheme.primary,
                      btnTitle: TextConstants.retry,
                      onTap: () {
                        onRetry!();
                        NavigationService.pop();
                      },
                    ),
                  ),
                  10.customHorizontalSpace,
                ],
                Expanded(
                  child: CustomButton(
                    btnTitle: TextConstants.ok,
                    onTap: () {
                      NavigationService.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

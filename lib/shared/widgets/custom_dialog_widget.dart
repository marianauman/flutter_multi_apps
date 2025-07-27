import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/text_styles.dart';
import '../../config/routes.dart';
import '../../core/constants/assets_constants.dart';
import '../../core/constants/app_constants.dart';
import 'custom_button.dart';
import 'custom_icon_button.dart';
import 'image_asset.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? confirmBtnTitle;
  final String? cancelBtnTitle;
  final DialogType dialogType;
  final String? imagePath;
  final double? imageHeight;
  final double? imageWidth;
  final VoidCallback? onTapConfirm;
  final VoidCallback? onTapCancel;
  const CustomDialogWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      this.confirmBtnTitle,
      required this.dialogType,
      this.imagePath,
      this.imageHeight,
      this.imageWidth,
      this.onTapConfirm,
      this.onTapCancel,
      this.cancelBtnTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(dialogType != DialogType.confirmation)
          ...[
            _dialogIcon(),
            10.customVerticalSpace,
          ],
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(fit: FlexFit.loose, child: AppText.title1(text: title, fontWeight: FontWeight.w700, fontSize: 22.sp)),
            dialogType == DialogType.confirmation
                ? CustomIconButton(
                    onPressed: () {
                      NavigationService.pop(false);
                    },
                    imagePath: AssetsConstants.closeIcon,
                      size: 20.r,
                    paddingAll: 10.r,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .customOpacity(0.05),
                )
                : const SizedBox.shrink(),
          ]),

          10.customVerticalSpace,
         
          AppText.body2(text: subtitle),

          30.customVerticalSpace,
          dialogType == DialogType.confirmation
              ? _confirmationButtons(context)
              : _okButton(
                  context: context,
                )
        ],
      ),
    );
  }

  Widget _okButton({
    required BuildContext context,
  }) {
    if (confirmBtnTitle?.isEmpty ?? true) return const SizedBox.shrink();
    return CustomButton(
      btnTitle: confirmBtnTitle!,
      onTap: onTapConfirm,
    );
  }
  Widget _confirmationButtons(BuildContext context) {
    return Row(
      children: [
        if (cancelBtnTitle?.isNotEmpty ?? false) ...[
          Expanded(
            child: _cancelButton(
              context: context,
            ),
          ),
          20.customHorizontalSpace,
        ],
        if (confirmBtnTitle?.isNotEmpty ?? false)
          Expanded(
            child: _okButton(
              context: context,
            ),
          ),
      ],
    );
  }

  Widget _cancelButton({
    required BuildContext context,
  }) {
    if (cancelBtnTitle?.isEmpty ?? true) return const SizedBox.shrink();

    return CustomButton(
      btnTitle: cancelBtnTitle!,
      onTap: onTapCancel,
      backgroundColorActive: Theme.of(context).colorScheme.surfaceContainer,
      borderColor: Theme.of(context).colorScheme.primary,
      textColorActive: Theme.of(context).colorScheme.primary,
    );
  }
  Widget _dialogIcon() {
    return ImageAsset(
      imagePath: imagePath ?? AssetsConstants.successIcon,
      height: imageHeight ?? 45.r,
      width: imageWidth ?? 45.r,
    );
  }
}
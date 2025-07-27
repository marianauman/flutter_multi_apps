import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/routes.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../../../../shared/widgets/custom_ink_well.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        NavigationService.push(Routes.faq);
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
                Icons.question_answer_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              12.customHorizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body1(text: TextConstants.faqs),
                    6.customVerticalSpace,
                    AppText.subText2(
                      text: TextConstants.faqsDescription,
                    ),
                  ],
                ),
              ),
              12.customHorizontalSpace,
              Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface, size: 24.r),
            ],
          ),
        ),
      ),
    );
  }
}
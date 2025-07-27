import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/text_styles.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../shared/widgets/custom_expansion_tile.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});
  static const List<Map<String, String>> faqs = [
    {
      'question': 'How do I mark a book as finished?',
      'answer': 'Go to the book card, tap the status button, and select "Finished".',
    },
    {
      'question': 'Can I read books offline?',
      'answer': 'No, books are opened via external sources like Internet Archive, which require internet access.',
    },
    {
      'question': 'How do I change the theme?',
      'answer': 'Go to Settings > Theme and choose Light, Dark, or System default.',
    },
    {
      'question': 'How do I clear my reading data?',
      'answer': 'Go to Settings > Clear Data to remove saved books and preferences.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: TextConstants.faqs,
      child: ListView.separated (
        padding: EdgeInsets.all(15.r),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return CustomExpansionTile(
            title: faq['question']!,
            children: [
              AppText.body1(text: faq['answer']!),
            ],
            childrenPadding: true,
          );
        },
        separatorBuilder: (context, index) {
          return 10.customVerticalSpace;
        },
      ),
    );
  }
}
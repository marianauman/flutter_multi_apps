import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/text_styles.dart';
import 'package:flutter_multi_apps/core/constants/text_constants.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/widgets/custom_ink_well.dart';
import '../../provider/book_listing_provider.dart';

class BookAppliedFilters extends ConsumerStatefulWidget {
  const BookAppliedFilters({super.key});

  @override
  ConsumerState<BookAppliedFilters> createState() => _BookAppliedFiltersState();
}

class _BookAppliedFiltersState extends ConsumerState<BookAppliedFilters> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(bookListingProvider).bookAppliedFiltersData.isNotEmpty
        ? _buildAppliedFilters(ref.watch(bookListingProvider).bookAppliedFiltersData)
        : const SizedBox.shrink();
  }

  Widget _buildAppliedFilters(Map<String, dynamic> filters) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.r, top: 12.r, bottom: 12.r),
      margin: EdgeInsets.only(top: 15.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterHeader(),
          10.customVerticalSpace,
          _buildFilterChips(filters),
        ],
      ),
    );
  }

  Widget _buildFilterHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.body3(text: TextConstants.appliedFilters, fontWeight: FontWeight.w600),
        _clearButton(),
      ],
    );
  }

  Widget _buildFilterChips(Map<String, dynamic> filters) {
    return Wrap(
      spacing: 0,
      runSpacing: 8.r,
      children: [
        _buildTitleFilterChip(filters),
        _buildAuthorFilterChip(filters),
        _buildIsReadableFilterChip(filters),
      ],
    );
  }

  Widget _buildTitleFilterChip(Map<String, dynamic> filters) {
    if (filters['title']?.isEmpty ?? true) return const SizedBox.shrink();
    return _buildFilterChip('${TextConstants.title}:', filters['title'], 'title');
  }

  Widget _buildAuthorFilterChip(Map<String, dynamic> filters) {
    if (filters['author']?.isEmpty ?? true) return const SizedBox.shrink();
    return _buildFilterChip('${TextConstants.author}:', filters['author'], 'author');
  }

  Widget _buildIsReadableFilterChip(Map<String, dynamic> filters) {
    if (filters['is_readable'] == null || filters['is_readable'] != true) return const SizedBox.shrink();
    return _buildFilterChip('${TextConstants.isReadable}:', filters['is_readable'], 'is_readable');
  }

  Widget _buildFilterChip(String label, String value, String filterKey) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
        margin: EdgeInsets.only(right: 8.r),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: AppTextStyles.body3(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: ' $value',
                    style: AppTextStyles.body3(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            5.horizontalSpace,
            CustomInkWell(
              onTap: () {
                ref.read(bookListingProvider.notifier).clearFilters();
              },
              child: Icon( Icons.close, size: 16.r, color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _clearButton() {
    return Padding(
      padding: EdgeInsets.only(right: 12.r),
      child: CustomInkWell(
        onTap: () {
          ref.read(bookListingProvider.notifier).clearFilters();
        },
        child: AppText.body3(text: TextConstants.clear, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}

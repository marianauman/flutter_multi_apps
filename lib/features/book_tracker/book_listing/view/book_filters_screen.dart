import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/constants/text_constants.dart';
import 'package:flutter_multi_apps/shared/helpers/app_alerts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../provider/book_listing_provider.dart';

class BookFiltersScreen extends ConsumerStatefulWidget {
  const BookFiltersScreen({super.key});

  @override
  ConsumerState<BookFiltersScreen> createState() => _BookFiltersScreenState();
}

class _BookFiltersScreenState extends ConsumerState<BookFiltersScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    convertMapToFilters(ref.read(bookListingProvider).bookAppliedFiltersData);
  }

  void convertMapToFilters(Map<String, dynamic> map) {
    _titleController.text = map['title'] ?? '';
    _authorController.text = map['author'] ?? '';
  }

  Map<String, dynamic> convertFiltersToMap() {
    return {
      'title': _titleController.text,
      'author': _authorController.text,
    };
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputType keyboardType,
  }) {
    return CustomTextField(
      heading: label,
      controller: controller,
      hintText: hint,
      isFilled: true,
      keyboardType: keyboardType,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 100.r,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      ),
      child: Center(
        child: Consumer(
          builder: (context, ref, _) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            height: 50.r,
            child: CustomButton(
              btnTitle: TextConstants.applyFilters,
              icon: Icons.filter_alt_outlined,
              onTap: () {
                if (_titleController.text.isNotEmpty ||
                    _authorController.text.isNotEmpty) {
                  NavigationService.pop();
                  ref
                      .read(bookListingProvider.notifier)
                      .applyFilter(convertFiltersToMap());
                } else {
                  AppAlerts.showErrorDialog(title: TextConstants.error, message: TextConstants.pleaseEnterTitleOrAuthor);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return _buildTextField(
      controller: _titleController,
      label: TextConstants.title,
      hint: TextConstants.enterTitle,
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildAuthorField() {
    return _buildTextField(
      controller: _authorController,
      label: TextConstants.author,
      hint: TextConstants.enterAuthor,
      keyboardType: TextInputType.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: TextConstants.filters,
      bottomNavigationBar: _buildBottomNavigationBar(context),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleField(),
            20.verticalSpace,
            _buildAuthorField(),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}

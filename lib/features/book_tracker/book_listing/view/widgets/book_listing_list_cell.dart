import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/widgets/custom_icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/image_network.dart';
import '../../model/book_model.dart';

class BookListingListCell extends StatelessWidget {
  final BookModel book;

  const BookListingListCell({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _coverImage(),
          10.customHorizontalSpace,
          _bookDetails(context: context),
        ],
      ),
    );
  }

  Widget _coverImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: ImageNetwork(
        imageUrl: book.coverImageUrl,
        width: 80.r,
        height: 120.r,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _bookDetails({required BuildContext context}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.title3(
            text: book.title,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          4.customVerticalSpace,
          AppText.subText1(
            text: "${TextConstants.by} ${book.authors.join(", ")}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (book.status != BookStatus.none) ...[
            10.customVerticalSpace,
            _buildStatus(context: context),
          ],
          20.customVerticalSpace,
          _buildActionButtons(context: context),
        ],
      ),
    );
  }

  Widget _buildStatus({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: AppText.subText1(text: getBookStatusText(book.status)),
    );
  }

  Widget _buildActionButtons({required BuildContext context}) {
    return Row(
      children: [
        _buildFavouriteButton(context: context),
        10.customHorizontalSpace,
        _buildActionButton(context: context),
      ],
    );
  }

  Widget _buildFavouriteButton({required BuildContext context}) {
    return CustomIconButton(
      onPressed: () {},
      icon: book.isFavourite ? Icons.favorite : Icons.favorite_border,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconColor: book.isFavourite
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface.customOpacity(0.6),
      borderRadius: 10.r,
    );
  }

  Widget _buildActionButton({required BuildContext context}) {
    return Expanded(
      child: CustomButton(
        btnTitle: getBookActionText(book.bookAction),
        onTap: () {},
        borderRadius: 10.r,
      ),
    );
  }
}

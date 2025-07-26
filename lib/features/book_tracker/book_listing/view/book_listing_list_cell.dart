import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/text_styles.dart';
import '../../../../shared/widgets/image_network.dart';
import '../model/book_model.dart';

class BookListingListCell extends StatelessWidget {
  final BookModel book; 

  const BookListingListCell({
    super.key,
    required this.book,
  });

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

  Widget _coverImage(){
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

  Widget _bookDetails({required BuildContext context}){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body1(text: book.title, fontWeight: FontWeight.w700, maxLines: 2, overflow: TextOverflow.ellipsis),
          4.customVerticalSpace,
          AppText.subText1(text: book.authors.join(", "), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

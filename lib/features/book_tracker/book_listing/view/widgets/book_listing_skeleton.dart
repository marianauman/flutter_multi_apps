import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/widgets/skeleton_loader_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookListingSkeleton extends StatelessWidget {
  const BookListingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 25.r, horizontal: 15.r),
        itemBuilder: (context, index) => BookListingSkeletonCell(),
        separatorBuilder: (context, index) => 15.customVerticalSpace,
        itemCount: 3,
    );
  }
}

class BookListingSkeletonCell extends StatelessWidget {
  const BookListingSkeletonCell({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoaderShimmer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
        decoration: BoxDecoration(
          border: Border.all(color:Theme.of(context).colorScheme.surface,width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _coverImageSkeleton(),
            10.customHorizontalSpace,
            _bookDetailsSkeleton(context: context),
          ],
        ),
      ),
    );
  }

  Widget _coverImageSkeleton() {
    return SkeletonLoaderBox(
      width: 80.r,
      height: 120.r,
      borderRadius: 10.r,
    );
  }

  Widget _bookDetailsSkeleton({required BuildContext context}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title skeleton
          SkeletonLoaderBox(
            width: double.infinity,
            height: 20.r,
            borderRadius: 4.r,
          ),
          4.customVerticalSpace,
          SkeletonLoaderBox(
            width: 150.r,
            height: 16.r,
            borderRadius: 4.r,
          ),
          10.customVerticalSpace,
          // Status skeleton
          SkeletonLoaderBox(
            width: 80.r,
            height: 24.r,
            borderRadius: 15.r,
          ),
          20.customVerticalSpace,
          // Action buttons skeleton
          Row(
            children: [
              SkeletonLoaderBox(
                width: 40.r,
                height: 40.r,
                borderRadius: 10.r,
              ),
              10.customHorizontalSpace,
              Expanded(
                child: SkeletonLoaderBox(
                  height: 40.r,
                  borderRadius: 10.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

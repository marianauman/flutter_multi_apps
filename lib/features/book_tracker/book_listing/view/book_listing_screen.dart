import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/features/book_tracker/book_listing/provider/book_listing_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../shared/widgets/base_screen.dart';
import 'widgets/book_listing_list_cell.dart';
import 'widgets/book_listing_skeleton.dart';

class BookListingScreen extends ConsumerStatefulWidget {
  const BookListingScreen({super.key});

  @override
  ConsumerState<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends ConsumerState<BookListingScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _getBookListing();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _getBookListing() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookListingProvider.notifier).fetchBookListing(page: 1);
    });
  }

  void _onScroll() {
    ref
        .read(bookListingProvider.notifier)
        .handleScroll(_scrollController.position);
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(bookListingProvider);
    return BaseScreen(
      title: TextConstants.discoverBooks,
      isLoading: state.isLoading,
      loaderScreen: BookListingSkeleton(),
      isEmpty: state.booksListing.books.isEmpty,
      actions: [_buildRefreshButton(context: context)],
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await ref
              .read(bookListingProvider.notifier)
              .fetchBookListing(page: 1);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.r),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 25.r),
                  itemCount:
                      state.booksListing.books.length +
                      (state.isMoreLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.booksListing.books.length) {
                      return state.isMoreLoading
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: const LinearProgressIndicator(
                                backgroundColor: Colors.transparent,
                              ),
                            )
                          : null;
                    }
                    return BookListingListCell(
                      book: state.booksListing.books[index],
                    );
                  },
                  separatorBuilder: (context, index) => 10.customVerticalSpace,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        _getBookListing();
      },
      child: Icon(
        Icons.refresh,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

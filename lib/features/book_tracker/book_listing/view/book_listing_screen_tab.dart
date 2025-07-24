import 'package:flutter/material.dart';
import '../../../../shared/helpers/app_alerts.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/no_internet_dialog.dart';

class BookListingScreenTab extends StatefulWidget {
  const BookListingScreenTab({super.key});
  @override
  State<BookListingScreenTab> createState() => _BookListingScreenTabState();
}

class _BookListingScreenTabState extends State<BookListingScreenTab> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          CustomButton(
            btnTitle: "check",
            icon: Icons.wifi_tethering,
            onTap: () {
              AppAlerts.showErrorDialog(title: "Error", message: "Error");
            },
          ),
        ],
      ),
    );
  }
}
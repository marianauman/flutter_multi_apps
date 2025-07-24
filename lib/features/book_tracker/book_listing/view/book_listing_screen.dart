import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/shared/widgets/custom_button.dart';
import '../../../../shared/helpers/app_alerts.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../../../shared/widgets/no_internet_dialog.dart';

class BookListingScreen extends StatefulWidget {
  const BookListingScreen({super.key});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          CustomButton(
            btnTitle: "check",
            onTap: () {
              AppAlerts.showSuccessDialog(title: "Success", message: "Success");
            },
          ),
        ],
      ),
    );
  }
}

import '../../../main/main_common.dart';

class AssetsConstants {
  //Base Paths
  static const String baseAssetsPath = 'assets/';
  static const String baseAssetsCommonPath = '${baseAssetsPath}common/';

  //Flavour based assets i.e book_tracker, expense_tracker, etc
  static final String splash = '$baseAssetsPath${appconfig.flavorAssetsFolder}/splash.json';
  static final String appIcon =
      '$baseAssetsPath${appconfig.flavorAssetsFolder}/app_icon.png';

  //General pngs
  static final String successIcon = '${baseAssetsCommonPath}icon_success.png';
  static final String errorIcon = '${baseAssetsCommonPath}icon_error.png';
  static final String infoIcon = '${baseAssetsCommonPath}icon_info.png';
  static final String closeIcon = '${baseAssetsCommonPath}icon_close.png';
  static final String booksImage = '${baseAssetsCommonPath}books_image.png';

  //General json
  static final String emptyState = '${baseAssetsCommonPath}empty_state.json';
  static final String noInternet = '${baseAssetsCommonPath}no_internet.json';
}

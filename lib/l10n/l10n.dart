import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_es.dart';
import 'l10n_fr.dart';
import 'l10n_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// The title of the application shown in the app bar and launcher
  ///
  /// In en, this message translates to:
  /// **'Fidely'**
  String get app_title;

  /// Label for edit action on a loyalty card
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get card_edit_title;

  /// Title for the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get card_delete_title;

  /// Confirmation message shown when the user attempts to delete a card
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this loyalty card?'**
  String get card_delete_description;

  /// Confirm button label in delete dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get card_delete_confirm;

  /// Cancel button label in delete dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get card_delete_cancel;

  /// Error message shown when barcode generation fails
  ///
  /// In en, this message translates to:
  /// **'Unable to generate barcode. Please check the code and type.'**
  String get card_barcode_invalid;

  /// Title for code source selection dialog
  ///
  /// In en, this message translates to:
  /// **'Pick a code'**
  String get card_page_code_pick_title;

  /// Option to pick code using camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get card_page_code_pick_buttons_camera;

  /// Option to pick code from gallery
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get card_page_code_pick_buttons_gallery;

  /// Title for color picker dialog
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get card_page_color_pick_title;

  /// Confirm button label in color picker
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get card_page_color_pick_buttons_confirm;

  /// Cancel button label in color picker
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get card_page_color_pick_buttons_cancel;

  /// Generic error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get card_page_generic_error_title;

  /// Message shown when required permission is denied
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please go to device settings to enable it.'**
  String get card_page_permission_error_title;

  /// Placeholder store name shown in card preview
  ///
  /// In en, this message translates to:
  /// **'Store Name'**
  String get card_page_card_preview_title;

  /// Placeholder code shown in card preview
  ///
  /// In en, this message translates to:
  /// **'123456'**
  String get card_page_card_preview_code;

  /// Validation error message for required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get card_page_input_error_required;

  /// Label for the store name input field
  ///
  /// In en, this message translates to:
  /// **'Store Name'**
  String get card_page_input_store_name_title;

  /// Label for the card code input field
  ///
  /// In en, this message translates to:
  /// **'Card Code'**
  String get card_page_input_code_title;

  /// Label for the card type input
  ///
  /// In en, this message translates to:
  /// **'Card Type'**
  String get card_page_input_type_title;

  /// Label for owner name input field
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get card_page_input_owner_title;

  /// Label for notes input field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get card_page_input_notes_title;

  /// Label for category selection
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get card_page_input_category_title;

  /// Category option: none
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get card_page_input_category_option_none;

  /// Category option: market and grocery
  ///
  /// In en, this message translates to:
  /// **'Market and Grocery'**
  String get card_page_input_category_option_grocery;

  /// Category option: food
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get card_page_input_category_option_food;

  /// Category option: pets
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get card_page_input_category_option_pets;

  /// Category option: fuel and energy
  ///
  /// In en, this message translates to:
  /// **'Fuel and Energy'**
  String get card_page_input_category_option_fuel;

  /// Category option: entertainment
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get card_page_input_category_option_entertainment;

  /// Category option: fashion and beauty
  ///
  /// In en, this message translates to:
  /// **'Fashion and Beauty'**
  String get card_page_input_category_option_fashion;

  /// Category option: electronics
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get card_page_input_category_option_electronics;

  /// Category option: health and wellness
  ///
  /// In en, this message translates to:
  /// **'Health and Wellness'**
  String get card_page_input_category_option_health;

  /// Category option: travel and transportation
  ///
  /// In en, this message translates to:
  /// **'Travel and Transportation'**
  String get card_page_input_category_option_travel;

  /// Category option: sport
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get card_page_input_category_option_sport;

  /// Category option: other
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get card_page_input_category_option_other;

  /// Title for card color selection
  ///
  /// In en, this message translates to:
  /// **'Card Color'**
  String get card_page_color_title;

  /// Helper text describing card color selection
  ///
  /// In en, this message translates to:
  /// **'Select a surface color for your card'**
  String get card_page_color_description;

  /// Label for front photo of the card
  ///
  /// In en, this message translates to:
  /// **'Front Photo'**
  String get card_page_photo_front_title;

  /// Label for rear photo of the card
  ///
  /// In en, this message translates to:
  /// **'Rear Photo'**
  String get card_page_photo_rear_title;

  /// Save button label on card page
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get card_page_save_button_title;

  /// Message shown on home when no cards are present
  ///
  /// In en, this message translates to:
  /// **'Whoa, such empty!'**
  String get home_page_no_cards_title;

  /// Description shown on home when no cards are present
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any loyalty cards yet.\nStart by adding your first one!'**
  String get home_page_no_cards_description;

  /// CTA to add the first card
  ///
  /// In en, this message translates to:
  /// **'Add your first card'**
  String get home_page_no_cards_add_button;

  /// Generic error shown on home page
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get home_page_generic_error_title;

  /// Title for photo source selection dialog
  ///
  /// In en, this message translates to:
  /// **'Pick a photo'**
  String get photo_pick_title;

  /// Option to pick photo using camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get photo_pick_buttons_camera;

  /// Option to pick photo from gallery
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get photo_pick_buttons_gallery;

  /// Hint shown on photo widget to change it
  ///
  /// In en, this message translates to:
  /// **'Tap to change'**
  String get photo_change_tap;

  /// Title for the change photo dialog
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get photo_change_title;

  /// Option to pick a new photo
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get photo_change_buttons_repick;

  /// Option to remove the current photo
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get photo_change_buttons_remove;

  /// Title for photo cropping screen
  ///
  /// In en, this message translates to:
  /// **'Crop Photo'**
  String get photo_crop_title;

  /// Title for theme selection in settings
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get settings_page_theme_title;

  /// Description explaining theme selection
  ///
  /// In en, this message translates to:
  /// **'Select your preferred theme mode'**
  String get settings_page_theme_description;

  /// Theme option: light
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_page_theme_mode_light;

  /// Theme option: dark
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_page_theme_mode_dark;

  /// Theme option: system default
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_page_theme_mode_system;

  /// Title for view mode selection
  ///
  /// In en, this message translates to:
  /// **'View Mode'**
  String get settings_page_view_mode_title;

  /// Description for view mode selection
  ///
  /// In en, this message translates to:
  /// **'Select your preferred view mode'**
  String get settings_page_view_mode_description;

  /// View mode option: list
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get settings_page_view_mode_list;

  /// View mode option: grid
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get settings_page_view_mode_grid;

  /// Title for using front photo in cards
  ///
  /// In en, this message translates to:
  /// **'Use Card Photo'**
  String get settings_page_view_mode_use_photo_title;

  /// Description for using front photo in cards
  ///
  /// In en, this message translates to:
  /// **'Use the front photo of the card as its thumbnail'**
  String get settings_page_view_mode_use_photo_description;

  /// Title for sort mode selection
  ///
  /// In en, this message translates to:
  /// **'Sort Mode'**
  String get settings_page_sort_title;

  /// Description for sort mode selection
  ///
  /// In en, this message translates to:
  /// **'Select your preferred sort mode'**
  String get settings_page_sort_description;

  /// Sort option: recently added
  ///
  /// In en, this message translates to:
  /// **'Recently Added'**
  String get settings_page_sort_mode_date;

  /// Sort option: alphabetical
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get settings_page_sort_mode_name;

  /// Sort option: by category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get settings_page_sort_mode_category;

  /// Label for reversing the sort order
  ///
  /// In en, this message translates to:
  /// **'Reverse'**
  String get settings_page_sort_reverse_title;

  /// Explains the current sort direction. {direction} is replaced with ascending or descending.
  ///
  /// In en, this message translates to:
  /// **'Cards are actually sorted in {direction} order'**
  String settings_page_sort_reverse_description(String direction);

  /// Label to indicate ascending sort direction
  ///
  /// In en, this message translates to:
  /// **'ascending'**
  String get settings_page_sort_reverse_direction_asc;

  /// Label to indicate descending sort direction
  ///
  /// In en, this message translates to:
  /// **'descending'**
  String get settings_page_sort_reverse_direction_desc;

  /// Title for language selection in settings
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_page_language_title;

  /// Description explaining language selection
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get settings_page_language_description;

  /// Language option: system default
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_page_language_option_system;

  /// Language option: English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_page_language_option_english;

  /// Language option: French
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get settings_page_language_option_french;

  /// Language option: Spanish
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settings_page_language_option_spanish;

  /// Language option: Italian
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get settings_page_language_option_italian;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'fr':
      return L10nFr();
    case 'it':
      return L10nIt();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

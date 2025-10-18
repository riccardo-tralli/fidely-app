// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Fidely';

  @override
  String get card_edit_title => 'Edit';

  @override
  String get card_delete_title => 'Delete';

  @override
  String get card_delete_description =>
      'Are you sure you want to delete this loyalty card?';

  @override
  String get card_delete_confirm => 'Confirm';

  @override
  String get card_delete_cancel => 'Cancel';

  @override
  String get card_barcode_invalid =>
      'Unable to generate barcode. Please check the code and type.';

  @override
  String get card_page_code_pick_title => 'Pick a code';

  @override
  String get card_page_code_pick_description =>
      'How would you like to pick a code?';

  @override
  String get card_page_code_pick_buttons_camera => 'Camera';

  @override
  String get card_page_code_pick_buttons_gallery => 'Gallery';

  @override
  String get card_page_color_pick_title => 'Pick a color';

  @override
  String get card_page_color_pick_buttons_confirm => 'Select';

  @override
  String get card_page_color_pick_buttons_cancel => 'Cancel';

  @override
  String get card_page_generic_error_title => 'Error';

  @override
  String get card_page_permission_error_title =>
      'Permission denied. Please go to device settings to enable it.';

  @override
  String get card_page_card_preview_title => 'Store Name';

  @override
  String get card_page_card_preview_code => '123456';

  @override
  String get card_page_input_error_required => 'This field is required';

  @override
  String get card_page_input_store_name_title => 'Store Name';

  @override
  String get card_page_input_code_title => 'Card Code';

  @override
  String get card_page_input_type_title => 'Card Type';

  @override
  String get card_page_input_owner_title => 'Owner Name';

  @override
  String get card_page_input_notes_title => 'Notes';

  @override
  String get card_page_input_category_title => 'Category';

  @override
  String get card_page_input_category_option_none => 'None';

  @override
  String get card_page_input_category_option_grocery => '🛒 Market and Grocery';

  @override
  String get card_page_input_category_option_food => '🍕 Food';

  @override
  String get card_page_input_category_option_fuel => '⛽ Fuel and Energy';

  @override
  String get card_page_input_category_option_entertainment =>
      '🎉 Entertainment';

  @override
  String get card_page_input_category_option_fashion => '👗 Fashion and Beauty';

  @override
  String get card_page_input_category_option_electronics => '📺 Electronics';

  @override
  String get card_page_input_category_option_health =>
      '❤️‍🩹 Health and Wellness';

  @override
  String get card_page_input_category_option_travel =>
      '✈️ Travel and Transportation';

  @override
  String get card_page_input_category_option_sport => '⚽️ Sport';

  @override
  String get card_page_input_category_option_other => 'Other';

  @override
  String get card_page_color_title => 'Card Color';

  @override
  String get card_page_color_description =>
      'Select a surface color for your card';

  @override
  String get card_page_photo_front_title => 'Front Photo';

  @override
  String get card_page_photo_rear_title => 'Rear Photo';

  @override
  String get card_page_save_button_title => 'Save';

  @override
  String get home_page_no_cards_title => 'No loyalty cards found';

  @override
  String get home_page_no_cards_add_button => 'Add the first one';

  @override
  String get home_page_generic_error_title => 'Something went wrong';

  @override
  String get photo_pick_title => 'Pick a photo';

  @override
  String get photo_pick_description => 'How would you like to pick a photo?';

  @override
  String get photo_pick_buttons_camera => 'Camera';

  @override
  String get photo_pick_buttons_gallery => 'Gallery';

  @override
  String get photo_change_tap => 'Tap to change';

  @override
  String get photo_change_title => 'Change Photo';

  @override
  String get photo_change_description =>
      'How would you like to change the photo?';

  @override
  String get photo_change_buttons_repick => 'Pick a new photo';

  @override
  String get photo_change_buttons_remove => 'Remove photo';

  @override
  String get photo_crop_title => 'Crop Photo';

  @override
  String get settings_page_theme_title => 'Theme Mode';

  @override
  String get settings_page_theme_description =>
      'Select your preferred theme mode';

  @override
  String get settings_page_theme_mode_light => 'Light';

  @override
  String get settings_page_theme_mode_dark => 'Dark';

  @override
  String get settings_page_theme_mode_system => 'System';

  @override
  String get settings_page_sort_title => 'Sort Mode';

  @override
  String get settings_page_sort_description =>
      'Select your preferred sort mode';

  @override
  String get settings_page_sort_mode_date => 'Recently Added';

  @override
  String get settings_page_sort_mode_name => 'Alphabetical';

  @override
  String get settings_page_sort_mode_category => 'Category';

  @override
  String get settings_page_sort_reverse_title => 'Reverse';

  @override
  String settings_page_sort_reverse_description(String direction) {
    return 'Cards are actually sorted in $direction order';
  }

  @override
  String get settings_page_sort_reverse_direction_asc => 'ascending';

  @override
  String get settings_page_sort_reverse_direction_desc => 'descending';
}

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
  String get backup_settings_page_title => 'Backup & Restore';

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
  String get card_barcode_tap => 'Code copied to clipboard';

  @override
  String get card_page_code_pick_title => 'Scan a code by';

  @override
  String get card_page_code_pick_buttons_camera => 'Camera';

  @override
  String get card_page_code_pick_buttons_gallery => 'Gallery';

  @override
  String get card_page_color_pick_title => 'Pick a color';

  @override
  String get card_page_color_pick_colors_tab_title => 'Colors';

  @override
  String get card_page_color_pick_list_tab_title => 'List';

  @override
  String get card_page_color_pick_palette_tab_title => 'Palette';

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
  String get card_page_input_code_button => 'Scan';

  @override
  String get card_page_input_type_title => 'Card Type';

  @override
  String get card_page_input_type_autodetected =>
      'Type was autodetected based on the code format';

  @override
  String get card_page_input_owner_title => 'Owner Name';

  @override
  String get card_page_input_notes_title => 'Notes';

  @override
  String get card_page_input_category_title => 'Category';

  @override
  String get card_page_input_category_option_none => 'None';

  @override
  String get card_page_input_category_option_grocery => 'Market and Grocery';

  @override
  String get card_page_input_category_option_food =>
      'Restaurants and Fast-Food';

  @override
  String get card_page_input_category_option_pets => 'Pets';

  @override
  String get card_page_input_category_option_fuel => 'Fuel and Energy';

  @override
  String get card_page_input_category_option_entertainment => 'Entertainment';

  @override
  String get card_page_input_category_option_fashion => 'Fashion and Beauty';

  @override
  String get card_page_input_category_option_home => 'Home and Gardening';

  @override
  String get card_page_input_category_option_electronics => 'Electronics';

  @override
  String get card_page_input_category_option_health => 'Health and Wellness';

  @override
  String get card_page_input_category_option_travel =>
      'Travel and Transportation';

  @override
  String get card_page_input_category_option_sport => 'Sport';

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
  String get export_import_settings_page_title => 'Export & Import';

  @override
  String get export_import_settings_page_export_title => 'Export Data';

  @override
  String get export_import_settings_page_export_description =>
      'You can export your data as a JSON or ZIP file.\nThis file can be used to backup your data or to transfer it to another device.';

  @override
  String get export_import_settings_page_export_images_options_title =>
      'Include Card Photos';

  @override
  String get export_import_settings_page_export_images_options_include =>
      'Exported file will include images, making it larger.';

  @override
  String get export_import_settings_page_export_images_options_exclude =>
      'Exported file will not include images, making it smaller.';

  @override
  String get export_import_settings_page_export_button =>
      'Select where to save the exported file';

  @override
  String get export_import_settings_page_import_title => 'Import Data';

  @override
  String get export_import_settings_page_import_description =>
      'You can import your data from a JSON or ZIP file.\nJSON files include only your data, while ZIP files can include images as well.';

  @override
  String get export_import_settings_page_import_alert_title => 'Warning';

  @override
  String get export_import_settings_page_import_alert_description =>
      'Importing data will overwrite your current data. Make sure to create a backup before proceeding.';

  @override
  String get export_import_settings_page_import_button =>
      'Select file to import';

  @override
  String get home_page_no_cards_title => 'Whoa, such empty!';

  @override
  String get home_page_no_cards_description =>
      'You don\'t have any loyalty cards yet.\nStart by adding your first one!';

  @override
  String get home_page_no_cards_add_button => 'Add your first card';

  @override
  String get home_page_generic_error_title => 'Something went wrong';

  @override
  String get home_page_search_close_button => 'Close';

  @override
  String get home_page_search_empty_results => 'No results found';

  @override
  String get home_page_favorite_section_title => 'Favorites';

  @override
  String get info_page_title => 'Info';

  @override
  String get info_page_repository_title => 'Repository';

  @override
  String get info_page_terms_title => 'Terms of Use';

  @override
  String get info_page_privacy_title => 'Privacy Policy';

  @override
  String get info_page_illustrations_title => 'Illustrations';

  @override
  String get language_settings_page_title => 'Language';

  @override
  String get photo_pick_title => 'Pick a photo';

  @override
  String get photo_pick_buttons_camera => 'Camera';

  @override
  String get photo_pick_buttons_gallery => 'Gallery';

  @override
  String get photo_change_tap => 'Tap to change';

  @override
  String get photo_change_title => 'Change Photo';

  @override
  String get photo_change_buttons_repick => 'Pick';

  @override
  String get photo_change_buttons_remove => 'Remove';

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
  String get settings_page_view_mode_title => 'View Mode';

  @override
  String get settings_page_view_mode_description =>
      'Select your preferred view mode';

  @override
  String get settings_page_view_mode_list => 'List';

  @override
  String get settings_page_view_mode_grid => 'Grid';

  @override
  String get settings_page_view_mode_use_photo_title => 'Use Card Photo';

  @override
  String get settings_page_view_mode_use_photo_description =>
      'Use the front photo of the card as its thumbnail';

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

  @override
  String get settings_page_language_option_system => 'System Default';

  @override
  String get settings_page_language_option_english => 'English';

  @override
  String get settings_page_language_option_french => 'French';

  @override
  String get settings_page_language_option_spanish => 'Spanish';

  @override
  String get settings_page_language_option_italian => 'Italian';

  @override
  String get ui_settings_page_title => 'Interface';
}

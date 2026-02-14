// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get app_title => 'Fidely';

  @override
  String get backup_settings_page_title => 'Sauvegarde et restauration';

  @override
  String get card_edit_title => 'Modifier';

  @override
  String get card_delete_title => 'Supprimer';

  @override
  String get card_delete_description =>
      'Voulez-vous vraiment supprimer cette carte de fidélité ?';

  @override
  String get card_delete_confirm => 'Confirmer';

  @override
  String get card_delete_cancel => 'Annuler';

  @override
  String get card_barcode_invalid =>
      'Impossible de générer le code-barres. Vérifiez le code et le type.';

  @override
  String get card_barcode_tap => 'Code copié dans le presse-papiers';

  @override
  String get card_page_code_pick_title => 'Scannez un code avec';

  @override
  String get card_page_code_pick_buttons_camera => 'Caméra';

  @override
  String get card_page_code_pick_buttons_gallery => 'Galerie';

  @override
  String get card_page_color_pick_title => 'Choisir une couleur';

  @override
  String get card_page_color_pick_colors_tab_title => 'Couleurs';

  @override
  String get card_page_color_pick_list_tab_title => 'Liste';

  @override
  String get card_page_color_pick_palette_tab_title => 'Palette';

  @override
  String get card_page_color_pick_buttons_confirm => 'Sélectionner';

  @override
  String get card_page_color_pick_buttons_cancel => 'Annuler';

  @override
  String get card_page_generic_error_title => 'Erreur';

  @override
  String get card_page_permission_error_title =>
      'Permission refusée. Veuillez aller dans les paramètres de l\'appareil pour l\'activer.';

  @override
  String get card_page_card_preview_title => 'Nom du magasin';

  @override
  String get card_page_card_preview_code => '123456';

  @override
  String get card_page_input_error_required => 'Ce champ est obligatoire';

  @override
  String get card_page_input_store_name_title => 'Nom du magasin';

  @override
  String get card_page_input_code_title => 'Code de la carte';

  @override
  String get card_page_input_code_button => 'Scanner';

  @override
  String get card_page_input_type_title => 'Type de carte';

  @override
  String get card_page_input_type_autodetected =>
      'Le type a été détecté automatiquement d\'après le format du code';

  @override
  String get card_page_input_owner_title => 'Nom du propriétaire';

  @override
  String get card_page_input_notes_title => 'Notes';

  @override
  String get card_page_input_category_title => 'Catégorie';

  @override
  String get card_page_input_category_option_none => 'Aucune';

  @override
  String get card_page_input_category_option_grocery =>
      'Supermarché et Épicerie';

  @override
  String get card_page_input_category_option_food =>
      'Restaurants et Restauration Rapide';

  @override
  String get card_page_input_category_option_pets => 'Animaux de compagnie';

  @override
  String get card_page_input_category_option_fuel => 'Carburant et Énergie';

  @override
  String get card_page_input_category_option_entertainment => 'Divertissement';

  @override
  String get card_page_input_category_option_fashion => 'Mode et Beauté';

  @override
  String get card_page_input_category_option_home => 'Maison et Jardinage';

  @override
  String get card_page_input_category_option_electronics => 'Électronique';

  @override
  String get card_page_input_category_option_health => 'Santé et Bien-être';

  @override
  String get card_page_input_category_option_travel => 'Voyage et Transport';

  @override
  String get card_page_input_category_option_sport => 'Sport';

  @override
  String get card_page_input_category_option_other => 'Autre';

  @override
  String get card_page_color_title => 'Couleur de la carte';

  @override
  String get card_page_color_description =>
      'Sélectionnez une couleur de surface pour votre carte';

  @override
  String get card_page_photo_front_title => 'Photo avant';

  @override
  String get card_page_photo_rear_title => 'Photo arrière';

  @override
  String get card_page_save_button_title => 'Enregistrer';

  @override
  String get export_import_settings_page_title => 'Exportation et Importation';

  @override
  String get export_import_settings_page_export_title => 'Exporter les données';

  @override
  String get export_import_settings_page_export_description =>
      'Vous pouvez exporter vos données sous forme de fichier JSON ou ZIP.\nCe fichier peut être utilisé pour sauvegarder vos données ou les transférer vers un autre appareil.';

  @override
  String get export_import_settings_page_export_images_options_title =>
      'Inclure les photos de cartes';

  @override
  String get export_import_settings_page_export_images_options_include =>
      'Le fichier exporté inclura les images, le rendant plus volumineux.';

  @override
  String get export_import_settings_page_export_images_options_exclude =>
      'Le fichier exporté n\'inclura pas les images, le rendant plus léger.';

  @override
  String get export_import_settings_page_export_button =>
      'Sélectionner où enregistrer le fichier exporté';

  @override
  String get export_import_settings_page_import_title => 'Importer les données';

  @override
  String get export_import_settings_page_import_description =>
      'Vous pouvez importer vos données à partir d\'un fichier JSON ou ZIP.\nLes fichiers JSON incluent uniquement vos données, tandis que les fichiers ZIP peuvent également inclure des images.';

  @override
  String get export_import_settings_page_import_alert_title => 'Avertissement';

  @override
  String get export_import_settings_page_import_alert_description =>
      'L\'importation de données écrasera vos données actuelles. Assurez-vous de créer une sauvegarde avant de continuer.';

  @override
  String get export_import_settings_page_import_button =>
      'Sélectionner le fichier à importer';

  @override
  String get export_import_settings_page_operation_title_export =>
      'Exportation des données';

  @override
  String get export_import_settings_page_operation_title_import =>
      'Importation des données';

  @override
  String get export_import_settings_page_operation_title_success =>
      'Opération réussie';

  @override
  String get export_import_settings_page_operation_title_failure =>
      'Opération échouée';

  @override
  String get export_import_settings_page_operation_message_loading =>
      'Veuillez patienter...';

  @override
  String get export_import_settings_page_operation_message_export_success =>
      'Vous pouvez maintenant déplacer ou partager le fichier exporté en toute sécurité. N\'oubliez pas qu\'il contient toutes vos données, gardez-le en sécurité !';

  @override
  String get export_import_settings_page_operation_message_import_success =>
      'L\'importation des données a réussi. Vos données ont été mises à jour. Profitez-en !';

  @override
  String get export_import_settings_page_operation_message_failure_no_data =>
      'Aucune donnée à exporter. Veuillez ajouter des cartes avant d\'exporter.';

  @override
  String get export_import_settings_page_operation_close => 'Fermer';

  @override
  String get home_page_no_cards_title => 'Woah, tellement vide !';

  @override
  String get home_page_no_cards_description =>
      'Vous n\'avez pas encore de cartes de fidélité.\nAjoutez la première pour commencer !';

  @override
  String get home_page_no_cards_add_button => 'Ajouter la première carte';

  @override
  String get home_page_generic_error_title => 'Une erreur est survenue';

  @override
  String get home_page_search_close_button => 'Fermer';

  @override
  String get home_page_search_empty_results => 'Aucun résultat trouvé';

  @override
  String get home_page_favorite_section_title => 'Favoris';

  @override
  String get info_page_title => 'Infos';

  @override
  String get info_page_repository_title => 'Dépôt';

  @override
  String get info_page_terms_title => 'Conditions d\'utilisation';

  @override
  String get info_page_privacy_title => 'Politique de confidentialité';

  @override
  String get info_page_illustrations_title => 'Illustrations';

  @override
  String get language_settings_page_title => 'Langue';

  @override
  String get photo_pick_title => 'Choisir une photo';

  @override
  String get photo_pick_buttons_camera => 'Caméra';

  @override
  String get photo_pick_buttons_gallery => 'Galerie';

  @override
  String get photo_change_tap => 'Appuyez pour changer';

  @override
  String get photo_change_title => 'Changer la photo';

  @override
  String get photo_change_buttons_repick => 'Choisir';

  @override
  String get photo_change_buttons_remove => 'Supprimer';

  @override
  String get photo_crop_title => 'Rogner la photo';

  @override
  String get settings_page_theme_title => 'Mode thème';

  @override
  String get settings_page_theme_description =>
      'Sélectionnez votre mode de thème préféré';

  @override
  String get settings_page_theme_mode_light => 'Clair';

  @override
  String get settings_page_theme_mode_dark => 'Sombre';

  @override
  String get settings_page_theme_mode_system => 'Système';

  @override
  String get settings_page_view_mode_title => 'Mode d\'affichage';

  @override
  String get settings_page_view_mode_description =>
      'Sélectionnez votre mode d\'affichage préféré';

  @override
  String get settings_page_view_mode_list => 'Liste';

  @override
  String get settings_page_view_mode_grid => 'Grille';

  @override
  String get settings_page_view_mode_use_photo_title =>
      'Utiliser la photo de la carte';

  @override
  String get settings_page_view_mode_use_photo_description =>
      'Utilisez la photo avant de la carte comme vignette';

  @override
  String get settings_page_sort_title => 'Mode de tri';

  @override
  String get settings_page_sort_description =>
      'Sélectionnez votre mode de tri préféré';

  @override
  String get settings_page_sort_mode_date => 'Ajoutés récemment';

  @override
  String get settings_page_sort_mode_name => 'Alphabétique';

  @override
  String get settings_page_sort_mode_category => 'Catégorie';

  @override
  String get settings_page_sort_reverse_title => 'Inverse';

  @override
  String settings_page_sort_reverse_description(String direction) {
    return 'Les cartes sont triées en ordre $direction';
  }

  @override
  String get settings_page_sort_reverse_direction_asc => 'ascendant';

  @override
  String get settings_page_sort_reverse_direction_desc => 'descendant';

  @override
  String get settings_page_language_option_system => 'Système';

  @override
  String get settings_page_language_option_english => 'Anglais';

  @override
  String get settings_page_language_option_french => 'Français';

  @override
  String get settings_page_language_option_spanish => 'Espagnol';

  @override
  String get settings_page_language_option_italian => 'Italien';

  @override
  String get ui_settings_page_title => 'Interface';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class L10nIt extends L10n {
  L10nIt([String locale = 'it']) : super(locale);

  @override
  String get app_title => 'Fidely';

  @override
  String get backup_settings_page_title => 'Backup e Ripristino';

  @override
  String get card_edit_title => 'Modifica';

  @override
  String get card_delete_title => 'Elimina';

  @override
  String get card_delete_description =>
      'Sei sicuro di voler eliminare questa carta fedeltà?';

  @override
  String get card_delete_confirm => 'Conferma';

  @override
  String get card_delete_cancel => 'Annulla';

  @override
  String get card_barcode_invalid =>
      'Impossibile generare il codice a barre. Controlla il codice e il tipo.';

  @override
  String get card_barcode_tap => 'Codice copiato negli appunti';

  @override
  String get card_page_code_pick_title => 'Scansiona un codice con';

  @override
  String get card_page_code_pick_buttons_camera => 'Fotocamera';

  @override
  String get card_page_code_pick_buttons_gallery => 'Galleria';

  @override
  String get card_page_color_pick_title => 'Seleziona un colore';

  @override
  String get card_page_color_pick_colors_tab_title => 'Colori';

  @override
  String get card_page_color_pick_list_tab_title => 'Elenco';

  @override
  String get card_page_color_pick_palette_tab_title => 'Palette';

  @override
  String get card_page_color_pick_buttons_confirm => 'Seleziona';

  @override
  String get card_page_color_pick_buttons_cancel => 'Annulla';

  @override
  String get card_page_generic_error_title => 'Errore';

  @override
  String get card_page_permission_error_title =>
      'Permesso negato. Vai alle impostazioni del dispositivo per abilitarlo.';

  @override
  String get card_page_card_preview_title => 'Nome negozio';

  @override
  String get card_page_card_preview_code => '123456';

  @override
  String get card_page_input_error_required => 'Questo campo è obbligatorio';

  @override
  String get card_page_input_store_name_title => 'Nome negozio';

  @override
  String get card_page_input_code_title => 'Codice carta';

  @override
  String get card_page_input_code_button => 'Scansiona';

  @override
  String get card_page_input_type_title => 'Tipo carta';

  @override
  String get card_page_input_type_autodetected =>
      'Il tipo è stato rilevato automaticamente in base al formato del codice';

  @override
  String get card_page_input_owner_title => 'Nome del proprietario';

  @override
  String get card_page_input_notes_title => 'Note';

  @override
  String get card_page_input_category_title => 'Categoria';

  @override
  String get card_page_input_category_option_none => 'Nessuna';

  @override
  String get card_page_input_category_option_grocery =>
      'Supermercato e Alimentari';

  @override
  String get card_page_input_category_option_food => 'Ristoranti e Fast Food';

  @override
  String get card_page_input_category_option_pets => 'Animali da compagnia';

  @override
  String get card_page_input_category_option_fuel => 'Carburante ed Energia';

  @override
  String get card_page_input_category_option_entertainment => 'Intrattenimento';

  @override
  String get card_page_input_category_option_fashion => 'Moda e Bellezza';

  @override
  String get card_page_input_category_option_home => 'Casa e Giardinaggio';

  @override
  String get card_page_input_category_option_electronics => 'Elettronica';

  @override
  String get card_page_input_category_option_health => 'Salute e Benessere';

  @override
  String get card_page_input_category_option_travel => 'Viaggi e Trasporti';

  @override
  String get card_page_input_category_option_sport => 'Sport';

  @override
  String get card_page_input_category_option_other => 'Altro';

  @override
  String get card_page_color_title => 'Colore carta';

  @override
  String get card_page_color_description =>
      'Seleziona il colore di superficie per la tua carta';

  @override
  String get card_page_photo_front_title => 'Foto fronte';

  @override
  String get card_page_photo_rear_title => 'Foto retro';

  @override
  String get card_page_save_button_title => 'Salva';

  @override
  String get export_import_settings_page_title => 'Esporta & Importa';

  @override
  String get export_import_settings_page_export_title => 'Esporta dati';

  @override
  String get export_import_settings_page_export_description =>
      'Puoi esportare i tuoi dati come file JSON o ZIP.\nQuesto file può essere utilizzato per fare un backup dei tuoi dati o per trasferirli su un altro dispositivo.';

  @override
  String get export_import_settings_page_export_images_options_title =>
      'Includi foto delle carte';

  @override
  String get export_import_settings_page_export_images_options_include =>
      'Il file esportato includerà le immagini, rendendolo più grande.';

  @override
  String get export_import_settings_page_export_images_options_exclude =>
      'Il file esportato non includerà le immagini, rendendolo più piccolo.';

  @override
  String get export_import_settings_page_export_button =>
      'Seleziona dove salvare il file esportato';

  @override
  String get export_import_settings_page_import_title => 'Importa dati';

  @override
  String get export_import_settings_page_import_description =>
      'Puoi importare i tuoi dati da un file JSON o ZIP.\nI file JSON includono solo i tuoi dati, mentre i file ZIP possono includere anche le immagini.';

  @override
  String get export_import_settings_page_import_alert_title => 'Avviso';

  @override
  String get export_import_settings_page_import_alert_description =>
      'L\'importazione dei dati sovrascriverà i tuoi dati attuali. Assicurati di creare un backup prima di procedere.';

  @override
  String get export_import_settings_page_import_button =>
      'Seleziona file da importare';

  @override
  String get home_page_no_cards_title => 'Woah, così vuoto!';

  @override
  String get home_page_no_cards_description =>
      'Non hai ancora carte fedeltà.\nAggiungi la tua prima per iniziare!';

  @override
  String get home_page_no_cards_add_button => 'Aggiungi la prima carta';

  @override
  String get home_page_generic_error_title => 'Qualcosa è andato storto';

  @override
  String get home_page_search_close_button => 'Chiudi';

  @override
  String get home_page_search_empty_results => 'Nessun risultato trovato';

  @override
  String get home_page_favorite_section_title => 'Preferiti';

  @override
  String get info_page_title => 'Informazioni';

  @override
  String get info_page_repository_title => 'Repository';

  @override
  String get info_page_terms_title => 'Termini di utilizzo';

  @override
  String get info_page_privacy_title => 'Informativa sulla privacy';

  @override
  String get info_page_illustrations_title => 'Illustrazioni';

  @override
  String get language_settings_page_title => 'Lingua';

  @override
  String get photo_pick_title => 'Scegli una foto';

  @override
  String get photo_pick_buttons_camera => 'Fotocamera';

  @override
  String get photo_pick_buttons_gallery => 'Galleria';

  @override
  String get photo_change_tap => 'Tocca per cambiare';

  @override
  String get photo_change_title => 'Cambia foto';

  @override
  String get photo_change_buttons_repick => 'Scegli';

  @override
  String get photo_change_buttons_remove => 'Rimuovi';

  @override
  String get photo_crop_title => 'Ritaglia foto';

  @override
  String get settings_page_theme_title => 'Modalità tema';

  @override
  String get settings_page_theme_description =>
      'Seleziona la modalità tema preferita';

  @override
  String get settings_page_theme_mode_light => 'Chiaro';

  @override
  String get settings_page_theme_mode_dark => 'Scuro';

  @override
  String get settings_page_theme_mode_system => 'Sistema';

  @override
  String get settings_page_view_mode_title => 'Modalità di visualizzazione';

  @override
  String get settings_page_view_mode_description =>
      'Seleziona la modalità di visualizzazione preferita';

  @override
  String get settings_page_view_mode_list => 'Elenco';

  @override
  String get settings_page_view_mode_grid => 'Griglia';

  @override
  String get settings_page_view_mode_use_photo_title =>
      'Usa la foto della carta';

  @override
  String get settings_page_view_mode_use_photo_description =>
      'Usa la foto frontale della carta come miniatura';

  @override
  String get settings_page_sort_title => 'Modalità di ordinamento';

  @override
  String get settings_page_sort_description =>
      'Seleziona la modalità di ordinamento preferita';

  @override
  String get settings_page_sort_mode_date => 'Aggiunte di recente';

  @override
  String get settings_page_sort_mode_name => 'Alfabetico';

  @override
  String get settings_page_sort_mode_category => 'Categoria';

  @override
  String get settings_page_sort_reverse_title => 'Inverti';

  @override
  String settings_page_sort_reverse_description(String direction) {
    return 'Le carte sono ordinate in ordine $direction';
  }

  @override
  String get settings_page_sort_reverse_direction_asc => 'crescente';

  @override
  String get settings_page_sort_reverse_direction_desc => 'decrescente';

  @override
  String get settings_page_language_option_system => 'Sistema';

  @override
  String get settings_page_language_option_english => 'Inglese';

  @override
  String get settings_page_language_option_french => 'Francese';

  @override
  String get settings_page_language_option_spanish => 'Spagnolo';

  @override
  String get settings_page_language_option_italian => 'Italiano';

  @override
  String get ui_settings_page_title => 'Interfaccia';
}

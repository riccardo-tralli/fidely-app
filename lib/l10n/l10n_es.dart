// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'Fidely';

  @override
  String get card_edit_title => 'Editar';

  @override
  String get card_delete_title => 'Eliminar';

  @override
  String get card_delete_description =>
      '¿Estás seguro de que deseas eliminar esta tarjeta de fidelidad?';

  @override
  String get card_delete_confirm => 'Confirmar';

  @override
  String get card_delete_cancel => 'Cancelar';

  @override
  String get card_barcode_invalid =>
      'No se puede generar el código de barras. Comprueba el código y el tipo.';

  @override
  String get card_page_code_pick_title => 'Elegir un código';

  @override
  String get card_page_code_pick_buttons_camera => 'Cámara';

  @override
  String get card_page_code_pick_buttons_gallery => 'Galería';

  @override
  String get card_page_color_pick_title => 'Elegir un color';

  @override
  String get card_page_color_pick_buttons_confirm => 'Seleccionar';

  @override
  String get card_page_color_pick_buttons_cancel => 'Cancelar';

  @override
  String get card_page_generic_error_title => 'Error';

  @override
  String get card_page_permission_error_title =>
      'Permiso denegado. Ve a la configuración del dispositivo para habilitarlo.';

  @override
  String get card_page_card_preview_title => 'Nombre de la tienda';

  @override
  String get card_page_card_preview_code => '123456';

  @override
  String get card_page_input_error_required => 'Este campo es obligatorio';

  @override
  String get card_page_input_store_name_title => 'Nombre de la tienda';

  @override
  String get card_page_input_code_title => 'Código de la tarjeta';

  @override
  String get card_page_input_type_title => 'Tipo de tarjeta';

  @override
  String get card_page_input_owner_title => 'Nombre del dueño';

  @override
  String get card_page_input_notes_title => 'Notas';

  @override
  String get card_page_input_category_title => 'Categoría';

  @override
  String get card_page_input_category_option_none => 'Ninguna';

  @override
  String get card_page_input_category_option_grocery => 'Supermercado y Tienda';

  @override
  String get card_page_input_category_option_food => 'Comida';

  @override
  String get card_page_input_category_option_pets => 'Mascotas';

  @override
  String get card_page_input_category_option_fuel => 'Combustible y Energía';

  @override
  String get card_page_input_category_option_entertainment => 'Entretenimiento';

  @override
  String get card_page_input_category_option_fashion => 'Moda y Belleza';

  @override
  String get card_page_input_category_option_electronics => 'Electrónica';

  @override
  String get card_page_input_category_option_health => 'Salud y Bienestar';

  @override
  String get card_page_input_category_option_travel => 'Viajes y Transporte';

  @override
  String get card_page_input_category_option_sport => 'Deporte';

  @override
  String get card_page_input_category_option_other => 'Otro';

  @override
  String get card_page_color_title => 'Color de la tarjeta';

  @override
  String get card_page_color_description =>
      'Selecciona un color de superficie para tu tarjeta';

  @override
  String get card_page_photo_front_title => 'Foto frontal';

  @override
  String get card_page_photo_rear_title => 'Foto trasera';

  @override
  String get card_page_save_button_title => 'Guardar';

  @override
  String get home_page_no_cards_title => 'Woah, así vacío!';

  @override
  String get home_page_no_cards_description =>
      'No tienes tarjetas de fidelidad aún.\n¡Agrega la primera para comenzar!';

  @override
  String get home_page_no_cards_add_button => 'Agregar la primera tarjeta';

  @override
  String get home_page_generic_error_title => 'Algo salió mal';

  @override
  String get photo_pick_title => 'Elegir una foto';

  @override
  String get photo_pick_buttons_camera => 'Cámara';

  @override
  String get photo_pick_buttons_gallery => 'Galería';

  @override
  String get photo_change_tap => 'Toca para cambiar';

  @override
  String get photo_change_title => 'Cambiar foto';

  @override
  String get photo_change_buttons_repick => 'Elegir';

  @override
  String get photo_change_buttons_remove => 'Eliminar';

  @override
  String get photo_crop_title => 'Recortar foto';

  @override
  String get settings_page_theme_title => 'Modo de tema';

  @override
  String get settings_page_theme_description =>
      'Selecciona tu modo de tema preferido';

  @override
  String get settings_page_theme_mode_light => 'Claro';

  @override
  String get settings_page_theme_mode_dark => 'Oscuro';

  @override
  String get settings_page_theme_mode_system => 'Sistema';

  @override
  String get settings_page_view_mode_title => 'Modo de visualización';

  @override
  String get settings_page_view_mode_description =>
      'Selecciona tu modo de visualización preferido';

  @override
  String get settings_page_view_mode_list => 'Lista';

  @override
  String get settings_page_view_mode_grid => 'Cuadrícula';

  @override
  String get settings_page_view_mode_use_photo_title =>
      'Usar foto de la tarjeta';

  @override
  String get settings_page_view_mode_use_photo_description =>
      'Usa la foto frontal de la tarjeta como su miniatura';

  @override
  String get settings_page_sort_title => 'Modo de ordenamiento';

  @override
  String get settings_page_sort_description =>
      'Selecciona tu modo de ordenamiento preferido';

  @override
  String get settings_page_sort_mode_date => 'Recientemente añadidas';

  @override
  String get settings_page_sort_mode_name => 'Alfabético';

  @override
  String get settings_page_sort_mode_category => 'Categoría';

  @override
  String get settings_page_sort_reverse_title => 'Invertir';

  @override
  String settings_page_sort_reverse_description(String direction) {
    return 'Las tarjetas están ordenadas en orden $direction';
  }

  @override
  String get settings_page_sort_reverse_direction_asc => 'ascendente';

  @override
  String get settings_page_sort_reverse_direction_desc => 'descendente';

  @override
  String get settings_page_language_title => 'Idioma';

  @override
  String get settings_page_language_description =>
      'Selecciona tu idioma preferido';

  @override
  String get settings_page_language_option_system => 'Sistema';

  @override
  String get settings_page_language_option_english => 'Inglés';

  @override
  String get settings_page_language_option_french => 'Francés';

  @override
  String get settings_page_language_option_spanish => 'Español';

  @override
  String get settings_page_language_option_italian => 'Italiano';
}

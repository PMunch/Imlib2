import x11 / [x, xlib]
{.passL: "`imlib2-config --libs`".}

type
  DATA64* = culonglong
  DATA32* = cuint
  DATA16* = cushort
  DATA8* = cuchar
##  opaque data types

type
  Imlib_Context* = pointer
  Imlib_Image* = pointer
  Imlib_Color_Modifier* = pointer
  Imlib_Updates* = pointer
  Imlib_Font* = pointer
  Imlib_Color_Range* = pointer
  Imlib_Filter* = pointer
  ImlibPolygon* = pointer

  ##i  blending operations

  Imlib_operation* = enum
    IMLIB_OP_COPY, IMLIB_OP_ADD, IMLIB_OP_SUBTRACT, IMLIB_OP_RESHADE


  Imlib_text_direction* = enum
    IMLIB_TEXT_TO_RIGHT = 0, IMLIB_TEXT_TO_LEFT = 1, IMLIB_TEXT_TO_DOWN = 2,
    IMLIB_TEXT_TO_UP = 3, IMLIB_TEXT_TO_ANGLE = 4

  Imlib_load_error* = enum
    IMLIB_LOAD_ERROR_NONE, IMLIB_LOAD_ERROR_FILE_DOES_NOT_EXIST,
    IMLIB_LOAD_ERROR_FILE_IS_DIRECTORY,
    IMLIB_LOAD_ERROR_PERMISSION_DENIED_TO_READ,
    IMLIB_LOAD_ERROR_NO_LOADER_FOR_FILE_FORMAT, IMLIB_LOAD_ERROR_PATH_TOO_LONG,
    IMLIB_LOAD_ERROR_PATH_COMPONENT_NON_EXISTANT,
    IMLIB_LOAD_ERROR_PATH_COMPONENT_NOT_DIRECTORY,
    IMLIB_LOAD_ERROR_PATH_POINTS_OUTSIDE_ADDRESS_SPACE,
    IMLIB_LOAD_ERROR_TOO_MANY_SYMBOLIC_LINKS, IMLIB_LOAD_ERROR_OUT_OF_MEMORY,
    IMLIB_LOAD_ERROR_OUT_OF_FILE_DESCRIPTORS,
    IMLIB_LOAD_ERROR_PERMISSION_DENIED_TO_WRITE,
    IMLIB_LOAD_ERROR_OUT_OF_DISK_SPACE, IMLIB_LOAD_ERROR_UNKNOWN

  ##  Encodings known to Imlib2 (so far)

  Imlib_TTF_encoding* = enum
    IMLIB_TTF_ENCODING_ISO_8859_1, IMLIB_TTF_ENCODING_ISO_8859_2,
    IMLIB_TTF_ENCODING_ISO_8859_3, IMLIB_TTF_ENCODING_ISO_8859_4,
    IMLIB_TTF_ENCODING_ISO_8859_5

  Imlib_border* {.bycopy.} = object
    left*: cint
    right*: cint
    top*: cint
    bottom*: cint

  Imlib_color* {.bycopy.} = object
    alpha*: cint
    red*: cint
    green*: cint
    blue*: cint


##  Progressive loading callbacks

type
  Imlib_Progress_Function* = proc (im: Imlib_Image; percent: uint8; update_x: cint;
                                update_y: cint; update_w: cint; update_h: cint): cint
  Imlib_Data_Destructor_Function* = proc (im: Imlib_Image; data: pointer)

##  *INDENT-OFF*

##  *INDENT-ON*
##  context handling

proc imlib_context_new*(): Imlib_Context {.importc, cdecl.}
proc imlib_context_free*(context: Imlib_Context) {.importc, cdecl.}
proc imlib_context_push*(context: Imlib_Context) {.importc, cdecl.}
proc imlib_context_pop*() {.importc, cdecl.}
proc imlib_context_get*(): Imlib_Context {.importc, cdecl.}
##  context setting

when not defined(X_DISPLAY_MISSING):
  proc imlib_context_set_display*(display: ptr Display) {.importc, cdecl.}
  proc imlib_context_disconnect_display*() {.importc, cdecl.}
  proc imlib_context_set_visual*(visual: ptr Visual) {.importc, cdecl.}
  proc imlib_context_set_colormap*(colormap: Colormap) {.importc, cdecl.}
  proc imlib_context_set_drawable*(drawable: Drawable) {.importc, cdecl.}
  proc imlib_context_set_mask*(mask: Pixmap) {.importc, cdecl.}
proc imlib_context_set_dither_mask*(dither_mask: uint8) {.importc, cdecl.}
proc imlib_context_set_mask_alpha_threshold*(mask_alpha_threshold: cint) {.importc, cdecl.}
proc imlib_context_set_anti_alias*(anti_alias: uint8) {.importc, cdecl.}
proc imlib_context_set_dither*(dither: uint8) {.importc, cdecl.}
proc imlib_context_set_blend*(blend: uint8) {.importc, cdecl.}
proc imlib_context_set_color_modifier*(color_modifier: Imlib_Color_Modifier) {.importc, cdecl.}
proc imlib_context_set_operation*(operation: Imlib_Operation) {.importc, cdecl.}
proc imlib_context_set_font*(font: Imlib_Font) {.importc, cdecl.}
proc imlib_context_set_direction*(direction: Imlib_Text_Direction) {.importc, cdecl.}
proc imlib_context_set_angle*(angle: cdouble) {.importc, cdecl.}
proc imlib_context_set_color*(red: cint; green: cint; blue: cint; alpha: cint) {.importc, cdecl.}
proc imlib_context_set_color_hsva*(hue: cfloat; saturation: cfloat; value: cfloat; alpha: cint) {.importc, cdecl.}
proc imlib_context_set_color_hlsa*(hue: cfloat; lightness: cfloat;
                                  saturation: cfloat; alpha: cint) {.importc, cdecl.}
proc imlib_context_set_color_cmya*(cyan: cint; magenta: cint; yellow: cint; alpha: cint) {.importc, cdecl.}
proc imlib_context_set_color_range*(color_range: Imlib_Color_Range) {.importc, cdecl.}
proc imlib_context_set_progress_function*(
    progress_function: Imlib_Progress_Function) {.importc, cdecl.}
proc imlib_context_set_progress_granularity*(progress_granularity: uint8) {.importc, cdecl.}
proc imlib_context_set_image*(image: Imlib_Image) {.importc, cdecl.}
proc imlib_context_set_cliprect*(x: cint; y: cint; w: cint; h: cint) {.importc, cdecl.}
proc imlib_context_set_TTF_encoding*(encoding: Imlib_TTF_Encoding) {.importc, cdecl.}
##  context getting

when not defined(X_DISPLAY_MISSING):
  proc imlib_context_get_display*(): ptr Display {.importc, cdecl.}
  proc imlib_context_get_visual*(): ptr Visual {.importc, cdecl.}
  proc imlib_context_get_colormap*(): Colormap {.importc, cdecl.}
  proc imlib_context_get_drawable*(): Drawable {.importc, cdecl.}
  proc imlib_context_get_mask*(): Pixmap {.importc, cdecl.}
proc imlib_context_get_dither_mask*(): uint8 {.importc, cdecl.}
proc imlib_context_get_anti_alias*(): uint8 {.importc, cdecl.}
proc imlib_context_get_mask_alpha_threshold*(): cint {.importc, cdecl.}
proc imlib_context_get_dither*(): uint8 {.importc, cdecl.}
proc imlib_context_get_blend*(): uint8 {.importc, cdecl.}
proc imlib_context_get_color_modifier*(): Imlib_Color_Modifier {.importc, cdecl.}
proc imlib_context_get_operation*(): Imlib_Operation {.importc, cdecl.}
proc imlib_context_get_font*(): Imlib_Font {.importc, cdecl.}
proc imlib_context_get_angle*(): cdouble {.importc, cdecl.}
proc imlib_context_get_direction*(): Imlib_Text_Direction {.importc, cdecl.}
proc imlib_context_get_color*(red: ptr cint; green: ptr cint; blue: ptr cint;
                             alpha: ptr cint) {.importc, cdecl.}
proc imlib_context_get_color_hsva*(hue: ptr cfloat; saturation: ptr cfloat;
                                  value: ptr cfloat; alpha: ptr cint) {.importc, cdecl.}
proc imlib_context_get_color_hlsa*(hue: ptr cfloat; lightness: ptr cfloat;
                                  saturation: ptr cfloat; alpha: ptr cint) {.importc, cdecl.}
proc imlib_context_get_color_cmya*(cyan: ptr cint; magenta: ptr cint; yellow: ptr cint;
                                  alpha: ptr cint) {.importc, cdecl.}
proc imlib_context_get_imlib_color*(): ptr Imlib_Color {.importc, cdecl.}
proc imlib_context_get_color_range*(): Imlib_Color_Range {.importc, cdecl.}
proc imlib_context_get_progress_function*(): Imlib_Progress_Function {.importc, cdecl.}
proc imlib_context_get_progress_granularity*(): uint8 {.importc, cdecl.}
proc imlib_context_get_image*(): Imlib_Image {.importc, cdecl.}
proc imlib_context_get_cliprect*(x: ptr cint; y: ptr cint; w: ptr cint; h: ptr cint) {.importc, cdecl.}
proc imlib_context_get_TTF_encoding*(): Imlib_TTF_Encoding {.importc, cdecl.}
proc imlib_get_cache_used*(): cint {.importc, cdecl.}
proc imlib_get_cache_size*(): cint {.importc, cdecl.}
proc imlib_set_cache_size*(bytes: cint) {.importc, cdecl.}
proc imlib_get_color_usage*(): cint {.importc, cdecl.}
proc imlib_set_color_usage*(max: cint) {.importc, cdecl.}
proc imlib_flush_loaders*() {.importc, cdecl.}
when not defined(X_DISPLAY_MISSING):
  proc imlib_get_visual_depth*(display: ptr Display; visual: ptr Visual): cint {.importc, cdecl.}
  proc imlib_get_best_visual*(display: ptr Display; screen: cint;
                             depth_return: ptr cint): ptr Visual {.importc, cdecl.}
proc imlib_load_image*(file: cstring): Imlib_Image {.importc, cdecl.}
proc imlib_load_image_immediately*(file: cstring): Imlib_Image {.importc, cdecl.}
proc imlib_load_image_without_cache*(file: cstring): Imlib_Image {.importc, cdecl.}
proc imlib_load_image_immediately_without_cache*(file: cstring): Imlib_Image {.importc, cdecl.}
proc imlib_load_image_with_error_return*(file: cstring;
                                        error_return: ptr Imlib_Load_Error): Imlib_Image {.importc, cdecl.}
proc imlib_free_image*() {.importc, cdecl.}
proc imlib_free_image_and_decache*() {.importc, cdecl.}
##  query/modify image parameters

proc imlib_image_get_width*(): cint {.importc, cdecl.}
proc imlib_image_get_height*(): cint {.importc, cdecl.}
proc imlib_image_get_filename*(): cstring {.importc, cdecl.}
proc imlib_image_get_data*(): ptr DATA32 {.importc, cdecl.}
proc imlib_image_get_data_for_reading_only*(): ptr DATA32 {.importc, cdecl.}
proc imlib_image_put_back_data*(data: ptr DATA32) {.importc, cdecl.}
proc imlib_image_has_alpha*(): uint8 {.importc, cdecl.}
proc imlib_image_set_changes_on_disk*() {.importc, cdecl.}
proc imlib_image_get_border*(border: ptr Imlib_Border) {.importc, cdecl.}
proc imlib_image_set_border*(border: ptr Imlib_Border) {.importc, cdecl.}
proc imlib_image_set_format*(format: cstring) {.importc, cdecl.}
proc imlib_image_set_irrelevant_format*(irrelevant: uint8) {.importc, cdecl.}
proc imlib_image_set_irrelevant_border*(irrelevant: uint8) {.importc, cdecl.}
proc imlib_image_set_irrelevant_alpha*(irrelevant: uint8) {.importc, cdecl.}
proc imlib_image_format*(): cstring {.importc, cdecl.}
proc imlib_image_set_has_alpha*(has_alpha: uint8) {.importc, cdecl.}
proc imlib_image_query_pixel*(x: cint; y: cint; color_return: ptr Imlib_Color) {.importc, cdecl.}
proc imlib_image_query_pixel_hsva*(x: cint; y: cint; hue: ptr cfloat;
                                  saturation: ptr cfloat; value: ptr cfloat;
                                  alpha: ptr cint) {.importc, cdecl.}
proc imlib_image_query_pixel_hlsa*(x: cint; y: cint; hue: ptr cfloat;
                                  lightness: ptr cfloat; saturation: ptr cfloat;
                                  alpha: ptr cint) {.importc, cdecl.}
proc imlib_image_query_pixel_cmya*(x: cint; y: cint; cyan: ptr cint; magenta: ptr cint;
                                  yellow: ptr cint; alpha: ptr cint) {.importc, cdecl.}
##  rendering functions

when not defined(X_DISPLAY_MISSING):
  proc imlib_render_pixmaps_for_whole_image*(pixmap_return: ptr Pixmap;
      mask_return: ptr Pixmap) {.importc, cdecl.}
  proc imlib_render_pixmaps_for_whole_image_at_size*(pixmap_return: ptr Pixmap;
      mask_return: ptr Pixmap; width: cint; height: cint) {.importc, cdecl.}
  proc imlib_free_pixmap_and_mask*(pixmap: Pixmap) {.importc, cdecl.}
  proc imlib_render_image_on_drawable*(x: cint; y: cint) {.importc, cdecl.}
  proc imlib_render_image_on_drawable_at_size*(x: cint; y: cint; width: cint;
      height: cint) {.importc, cdecl.}
  proc imlib_render_image_part_on_drawable_at_size*(source_x: cint; source_y: cint;
      source_width: cint; source_height: cint; x: cint; y: cint; width: cint; height: cint) {.importc, cdecl.}
  proc imlib_render_get_pixel_color*(): DATA32 {.importc, cdecl.}
proc imlib_blend_image_onto_image*(source_image: Imlib_Image; merge_alpha: uint8;
                                  source_x: cint; source_y: cint;
                                  source_width: cint; source_height: cint;
                                  destination_x: cint; destination_y: cint;
                                  destination_width: cint;
                                  destination_height: cint) {.importc, cdecl.}
##  creation functions

proc imlib_create_image*(width: cint; height: cint): Imlib_Image {.importc, cdecl.}
proc imlib_create_image_using_data*(width: cint; height: cint; data: ptr DATA32): Imlib_Image {.importc, cdecl.}
proc imlib_create_image_using_copied_data*(width: cint; height: cint;
    data: ptr DATA32): Imlib_Image {.importc, cdecl.}
when not defined(X_DISPLAY_MISSING):
  proc imlib_create_image_from_drawable*(mask: Pixmap; x: cint; y: cint; width: cint;
                                        height: cint; need_to_grab_x: uint8): Imlib_Image {.importc, cdecl.}
  proc imlib_create_image_from_ximage*(image: ptr XImage; mask: ptr XImage; x: cint;
                                      y: cint; width: cint; height: cint;
                                      need_to_grab_x: uint8): Imlib_Image {.importc, cdecl.}
  proc imlib_create_scaled_image_from_drawable*(mask: Pixmap; source_x: cint;
      source_y: cint; source_width: cint; source_height: cint;
      destination_width: cint; destination_height: cint; need_to_grab_x: uint8;
      get_mask_from_shape: uint8): Imlib_Image {.importc, cdecl.}
  proc imlib_copy_drawable_to_image*(mask: Pixmap; x: cint; y: cint; width: cint;
                                    height: cint; destination_x: cint;
                                    destination_y: cint; need_to_grab_x: uint8): uint8 {.importc, cdecl.}
  proc imlib_get_ximage_cache_count_used*(): cint {.importc, cdecl.}
  proc imlib_get_ximage_cache_count_max*(): cint {.importc, cdecl.}
  proc imlib_set_ximage_cache_count_max*(count: cint) {.importc, cdecl.}
  proc imlib_get_ximage_cache_size_used*(): cint {.importc, cdecl.}
  proc imlib_get_ximage_cache_size_max*(): cint {.importc, cdecl.}
  proc imlib_set_ximage_cache_size_max*(bytes: cint) {.importc, cdecl.}
proc imlib_clone_image*(): Imlib_Image {.importc, cdecl.}
proc imlib_create_cropped_image*(x: cint; y: cint; width: cint; height: cint): Imlib_Image {.importc, cdecl.}
proc imlib_create_cropped_scaled_image*(source_x: cint; source_y: cint;
                                       source_width: cint; source_height: cint;
                                       destination_width: cint;
                                       destination_height: cint): Imlib_Image {.importc, cdecl.}
##  imlib updates. lists of rectangles for storing required update draws

proc imlib_updates_clone*(updates: Imlib_Updates): Imlib_Updates {.importc, cdecl.}
proc imlib_update_append_rect*(updates: Imlib_Updates; x: cint; y: cint; w: cint; h: cint): Imlib_Updates {.importc, cdecl.}
proc imlib_updates_merge*(updates: Imlib_Updates; w: cint; h: cint): Imlib_Updates {.importc, cdecl.}
proc imlib_updates_merge_for_rendering*(updates: Imlib_Updates; w: cint; h: cint): Imlib_Updates {.importc, cdecl.}
proc imlib_updates_free*(updates: Imlib_Updates) {.importc, cdecl.}
proc imlib_updates_get_next*(updates: Imlib_Updates): Imlib_Updates {.importc, cdecl.}
proc imlib_updates_get_coordinates*(updates: Imlib_Updates; x_return: ptr cint;
                                   y_return: ptr cint; width_return: ptr cint;
                                   height_return: ptr cint) {.importc, cdecl.}
proc imlib_updates_set_coordinates*(updates: Imlib_Updates; x: cint; y: cint;
                                   width: cint; height: cint) {.importc, cdecl.}
proc imlib_render_image_updates_on_drawable*(updates: Imlib_Updates; x: cint; y: cint) {.importc, cdecl.}
proc imlib_updates_init*(): Imlib_Updates {.importc, cdecl.}
proc imlib_updates_append_updates*(updates: Imlib_Updates;
                                  appended_updates: Imlib_Updates): Imlib_Updates {.importc, cdecl.}
##  image modification

proc imlib_image_flip_horizontal*() {.importc, cdecl.}
proc imlib_image_flip_vertical*() {.importc, cdecl.}
proc imlib_image_flip_diagonal*() {.importc, cdecl.}
proc imlib_image_orientate*(orientation: cint) {.importc, cdecl.}
proc imlib_image_blur*(radius: cint) {.importc, cdecl.}
proc imlib_image_sharpen*(radius: cint) {.importc, cdecl.}
proc imlib_image_tile_horizontal*() {.importc, cdecl.}
proc imlib_image_tile_vertical*() {.importc, cdecl.}
proc imlib_image_tile*() {.importc, cdecl.}
##  fonts and text

proc imlib_load_font*(font_name: cstring): Imlib_Font {.importc, cdecl.}
proc imlib_free_font*() {.importc, cdecl.}
##  NB! The four functions below are deprecated.

proc imlib_insert_font_into_fallback_chain*(font: Imlib_Font;
    fallback_font: Imlib_Font): cint {.importc, cdecl.}
proc imlib_remove_font_from_fallback_chain*(fallback_font: Imlib_Font) {.importc, cdecl.}
proc imlib_get_prev_font_in_fallback_chain*(fn: Imlib_Font): Imlib_Font {.importc, cdecl.}
proc imlib_get_next_font_in_fallback_chain*(fn: Imlib_Font): Imlib_Font {.importc, cdecl.}
##  NB! The four functions above are deprecated.

proc imlib_text_draw*(x: cint; y: cint; text: cstring) {.importc, cdecl.}
proc imlib_text_draw_with_return_metrics*(x: cint; y: cint; text: cstring;
    width_return: ptr cint; height_return: ptr cint;
    horizontal_advance_return: ptr cint; vertical_advance_return: ptr cint) {.importc, cdecl.}
proc imlib_get_text_size*(text: cstring; width_return: ptr cint;
                         height_return: ptr cint) {.importc, cdecl.}
proc imlib_get_text_advance*(text: cstring; horizontal_advance_return: ptr cint;
                            vertical_advance_return: ptr cint) {.importc, cdecl.}
proc imlib_get_text_inset*(text: cstring): cint {.importc, cdecl.}
proc imlib_add_path_to_font_path*(path: cstring) {.importc, cdecl.}
proc imlib_remove_path_from_font_path*(path: cstring) {.importc, cdecl.}
proc imlib_list_font_path*(number_return: ptr cint): cstringArray {.importc, cdecl.}
proc imlib_text_get_index_and_location*(text: cstring; x: cint; y: cint;
                                       uint8_x_return: ptr cint;
                                       uint8_y_return: ptr cint;
                                       uint8_width_return: ptr cint;
                                       uint8_height_return: ptr cint): cint {.importc, cdecl.}
proc imlib_text_get_location_at_index*(text: cstring; index: cint;
                                      uint8_x_return: ptr cint;
                                      uint8_y_return: ptr cint;
                                      uint8_width_return: ptr cint;
                                      uint8_height_return: ptr cint) {.importc, cdecl.}
proc imlib_list_fonts*(number_return: ptr cint): cstringArray {.importc, cdecl.}
proc imlib_free_font_list*(font_list: cstringArray; number: cint) {.importc, cdecl.}
proc imlib_get_font_cache_size*(): cint {.importc, cdecl.}
proc imlib_set_font_cache_size*(bytes: cint) {.importc, cdecl.}
proc imlib_flush_font_cache*() {.importc, cdecl.}
proc imlib_get_font_ascent*(): cint {.importc, cdecl.}
proc imlib_get_font_descent*(): cint {.importc, cdecl.}
proc imlib_get_maximum_font_ascent*(): cint {.importc, cdecl.}
proc imlib_get_maximum_font_descent*(): cint {.importc, cdecl.}
##  color modifiers

proc imlib_create_color_modifier*(): Imlib_Color_Modifier {.importc, cdecl.}
proc imlib_free_color_modifier*() {.importc, cdecl.}
proc imlib_modify_color_modifier_gamma*(gamma_value: cdouble) {.importc, cdecl.}
proc imlib_modify_color_modifier_brightness*(brightness_value: cdouble) {.importc, cdecl.}
proc imlib_modify_color_modifier_contrast*(contrast_value: cdouble) {.importc, cdecl.}
proc imlib_set_color_modifier_tables*(red_table: ptr DATA8; green_table: ptr DATA8;
                                     blue_table: ptr DATA8; alpha_table: ptr DATA8) {.importc, cdecl.}
proc imlib_get_color_modifier_tables*(red_table: ptr DATA8; green_table: ptr DATA8;
                                     blue_table: ptr DATA8; alpha_table: ptr DATA8) {.importc, cdecl.}
proc imlib_reset_color_modifier*() {.importc, cdecl.}
proc imlib_apply_color_modifier*() {.importc, cdecl.}
proc imlib_apply_color_modifier_to_rectangle*(x: cint; y: cint; width: cint;
    height: cint) {.importc, cdecl.}
##  drawing on images

proc imlib_image_draw_pixel*(x: cint; y: cint; make_updates: uint8): Imlib_Updates {.importc, cdecl.}
proc imlib_image_draw_line*(x1: cint; y1: cint; x2: cint; y2: cint; make_updates: uint8): Imlib_Updates {.importc, cdecl.}
proc imlib_image_draw_rectangle*(x: cint; y: cint; width: cint; height: cint) {.importc, cdecl.}
proc imlib_image_fill_rectangle*(x: cint; y: cint; width: cint; height: cint) {.importc, cdecl.}
proc imlib_image_copy_alpha_to_image*(image_source: Imlib_Image; x: cint; y: cint) {.importc, cdecl.}
proc imlib_image_copy_alpha_rectangle_to_image*(image_source: Imlib_Image; x: cint;
    y: cint; width: cint; height: cint; destination_x: cint; destination_y: cint) {.importc, cdecl.}
proc imlib_image_scroll_rect*(x: cint; y: cint; width: cint; height: cint; delta_x: cint;
                             delta_y: cint) {.importc, cdecl.}
proc imlib_image_copy_rect*(x: cint; y: cint; width: cint; height: cint; new_x: cint;
                           new_y: cint) {.importc, cdecl.}
##  polygons

proc imlib_polygon_new*(): ImlibPolygon {.importc, cdecl.}
proc imlib_polygon_free*(poly: ImlibPolygon) {.importc, cdecl.}
proc imlib_polygon_add_point*(poly: ImlibPolygon; x: cint; y: cint) {.importc, cdecl.}
proc imlib_image_draw_polygon*(poly: ImlibPolygon; closed: cuchar) {.importc, cdecl.}
proc imlib_image_fill_polygon*(poly: ImlibPolygon) {.importc, cdecl.}
proc imlib_polygon_get_bounds*(poly: ImlibPolygon; px1: ptr cint; py1: ptr cint;
                              px2: ptr cint; py2: ptr cint) {.importc, cdecl.}
proc imlib_polygon_contains_point*(poly: ImlibPolygon; x: cint; y: cint): cuchar {.importc, cdecl.}
##  ellipses

proc imlib_image_draw_ellipse*(xc: cint; yc: cint; a: cint; b: cint) {.importc, cdecl.}
proc imlib_image_fill_ellipse*(xc: cint; yc: cint; a: cint; b: cint) {.importc, cdecl.}
##  color ranges

proc imlib_create_color_range*(): Imlib_Color_Range {.importc, cdecl.}
proc imlib_free_color_range*() {.importc, cdecl.}
proc imlib_add_color_to_color_range*(distance_away: cint) {.importc, cdecl.}
proc imlib_image_fill_color_range_rectangle*(x: cint; y: cint; width: cint;
    height: cint; angle: cdouble) {.importc, cdecl.}
proc imlib_image_fill_hsva_color_range_rectangle*(x: cint; y: cint; width: cint;
    height: cint; angle: cdouble) {.importc, cdecl.}
##  image data

proc imlib_image_attach_data_value*(key: cstring; data: pointer; value: cint;
    destructor_function: Imlib_Data_Destructor_Function) {.importc, cdecl.}
proc imlib_image_get_attached_data*(key: cstring): pointer {.importc, cdecl.}
proc imlib_image_get_attached_value*(key: cstring): cint {.importc, cdecl.}
proc imlib_image_remove_attached_data_value*(key: cstring) {.importc, cdecl.}
proc imlib_image_remove_and_free_attached_data_value*(key: cstring) {.importc, cdecl.}
##  saving

proc imlib_save_image*(filename: cstring) {.importc, cdecl.}
proc imlib_save_image_with_error_return*(filename: cstring;
                                        error_return: ptr Imlib_Load_Error) {.importc, cdecl.}
##  FIXME:
##  need to add arbitrary rotation routines
##  rotation/skewing

proc imlib_create_rotated_image*(angle: cdouble): Imlib_Image {.importc, cdecl.}
##  rotation from buffer to context (without copying)

proc imlib_rotate_image_from_buffer*(angle: cdouble; source_image: Imlib_Image) {.importc, cdecl.}
proc imlib_blend_image_onto_image_at_angle*(source_image: Imlib_Image;
    merge_alpha: uint8; source_x: cint; source_y: cint; source_width: cint;
    source_height: cint; destination_x: cint; destination_y: cint; angle_x: cint;
    angle_y: cint) {.importc, cdecl.}
proc imlib_blend_image_onto_image_skewed*(source_image: Imlib_Image;
    merge_alpha: uint8; source_x: cint; source_y: cint; source_width: cint;
    source_height: cint; destination_x: cint; destination_y: cint; h_angle_x: cint;
    h_angle_y: cint; v_angle_x: cint; v_angle_y: cint) {.importc, cdecl.}
when not defined(X_DISPLAY_MISSING):
  proc imlib_render_image_on_drawable_skewed*(source_x: cint; source_y: cint;
      source_width: cint; source_height: cint; destination_x: cint;
      destination_y: cint; h_angle_x: cint; h_angle_y: cint; v_angle_x: cint;
      v_angle_y: cint) {.importc, cdecl.}
  proc imlib_render_image_on_drawable_at_angle*(source_x: cint; source_y: cint;
      source_width: cint; source_height: cint; destination_x: cint;
      destination_y: cint; angle_x: cint; angle_y: cint) {.importc, cdecl.}
##  image filters

proc imlib_image_filter*() {.importc, cdecl.}
proc imlib_create_filter*(initsize: cint): Imlib_Filter {.importc, cdecl.}
proc imlib_context_set_filter*(filter: Imlib_Filter) {.importc, cdecl.}
proc imlib_context_get_filter*(): Imlib_Filter {.importc, cdecl.}
proc imlib_free_filter*() {.importc, cdecl.}
proc imlib_filter_set*(xoff: cint; yoff: cint; a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_set_alpha*(xoff: cint; yoff: cint; a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_set_red*(xoff: cint; yoff: cint; a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_set_green*(xoff: cint; yoff: cint; a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_set_blue*(xoff: cint; yoff: cint; a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_constants*(a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_filter_divisors*(a: cint; r: cint; g: cint; b: cint) {.importc, cdecl.}
proc imlib_apply_filter*(script: cstring) {.varargs, importc, cdecl.}
proc imlib_image_clear*() {.importc, cdecl.}
proc imlib_image_clear_color*(r: cint; g: cint; b: cint; a: cint) {.importc, cdecl.}
##  *INDENT-OFF*

##  *INDENT-ON*

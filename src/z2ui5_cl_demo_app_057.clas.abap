CLASS z2ui5_cl_demo_app_057 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .


    TYPES:
      BEGIN OF ty_s_tab,
        selkz            TYPE abap_bool,
        product          TYPE string,
        create_date      TYPE string,
        create_by        TYPE string,
        storage_location TYPE string,
        quantity         TYPE i,
      END OF ty_s_tab .
    TYPES
      ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH DEFAULT KEY .

    DATA mt_table TYPE ty_t_table .
    DATA mv_check_download TYPE abap_bool .

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    DATA:
      BEGIN OF app,
        check_initialized TYPE abap_bool,
        view_main         TYPE string,
        view_popup        TYPE string,
        get               TYPE z2ui5_if_types=>ty_s_get,
      END OF app.

    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.
    METHODS z2ui5_on_render.
    METHODS z2ui5_on_render_main.

    METHODS z2ui5_set_data.

  PRIVATE SECTION.

ENDCLASS.



CLASS z2ui5_cl_demo_app_057 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.
    app-get        = client->get( ).

    IF app-check_initialized = abap_false.
      app-check_initialized = abap_true.
      z2ui5_on_init( ).
    ENDIF.

    IF app-get-event IS NOT INITIAL.
      z2ui5_on_event( ).
    ENDIF.

    z2ui5_on_render( ).

    CLEAR app-get.

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE app-get-event.

      WHEN 'BUTTON_START'.
        z2ui5_set_data( ).

      WHEN `BUTTON_DOWNLOAD`.
        mv_check_download = abap_true.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( app-get-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    app-view_main = `MAIN`.

  ENDMETHOD.


  METHOD z2ui5_on_render.

    CASE app-view_main.
      WHEN 'MAIN'.
        z2ui5_on_render_main( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_render_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp3 TYPE xsdboolean.
    temp3 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view = view->page( id    = `page_main`
              title          = 'abap2UI5 - List Report Features'
              navbuttonpress = client->_event( 'BACK' )
              shownavbutton  = temp3 ).

    IF mv_check_download = abap_true.
      mv_check_download = abap_false.

      DATA lv_csv TYPE string.
      lv_csv = z2ui5_cl_util=>itab_get_csv_by_itab( mt_table ).
      DATA lv_csv_x TYPE xstring.
      lv_csv_x = z2ui5_cl_util=>conv_get_xstring_by_string( lv_csv ).
      DATA lv_base64 TYPE string.
      lv_base64 = z2ui5_cl_util=>conv_encode_x_base64( lv_csv_x ).

      DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-n = `src`.
      temp2-v = `data:text/csv;base64,` && lv_base64.
      INSERT temp2 INTO TABLE temp1.
      temp2-n = `hidden`.
      temp2-v = `hidden`.
      INSERT temp2 INTO TABLE temp1.
      view->_generic( ns     = `html`
                      name   = `iframe`
                      t_prop = temp1 ).

    ENDIF.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->dynamic_page( headerexpanded = abap_true
                                     headerpinned   = abap_true ).

    DATA header_title TYPE REF TO z2ui5_cl_xml_view.
    header_title = page->title( ns = 'f' )->get( )->dynamic_page_title( ).
    header_title->heading( ns = 'f' )->hbox( )->title( `Download CSV` ).
    header_title->expanded_content( 'f' ).
    header_title->snapped_content( ns = 'f' ).

    DATA lo_box TYPE REF TO z2ui5_cl_xml_view.
    lo_box = page->header( )->dynamic_page_header( pinnable = abap_true
         )->flex_box( alignitems     = `Start`
                      justifycontent = `SpaceBetween` )->flex_box( alignitems = `Start` ).


    lo_box->get_parent( )->hbox( justifycontent = `End` )->button(
        text  = `Go`
        press = client->_event( `BUTTON_START` )
        type  = `Emphasized` ).

    DATA cont TYPE REF TO z2ui5_cl_xml_view.
    cont = page->content( ns = 'f' ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = cont->table( items = client->_bind( val = mt_table ) ).

    tab->header_toolbar(
            )->toolbar(
                )->toolbar_spacer(
                )->button(
                    icon  = 'sap-icon://download'
                    press = client->_event( 'BUTTON_DOWNLOAD' ) ).

    DATA lo_columns TYPE REF TO z2ui5_cl_xml_view.
    lo_columns = tab->columns( ).
    lo_columns->column( )->text( text = `Product` ).
    lo_columns->column( )->text( text = `Date` ).
    lo_columns->column( )->text( text = `Name` ).
    lo_columns->column( )->text( text = `Location` ).
    lo_columns->column( )->text( text = `Quantity` ).

    DATA lo_cells TYPE REF TO z2ui5_cl_xml_view.
    lo_cells = tab->items( )->column_list_item( ).
    lo_cells->text( `{PRODUCT}` ).
    lo_cells->text( `{CREATE_DATE}` ).
    lo_cells->text( `{CREATE_BY}` ).
    lo_cells->text( `{STORAGE_LOCATION}` ).
    lo_cells->text( `{QUANTITY}` ).

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.


  METHOD z2ui5_set_data.

    DATA temp3 TYPE z2ui5_cl_demo_app_057=>ty_t_table.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    mt_table = temp3.

  ENDMETHOD.
ENDCLASS.

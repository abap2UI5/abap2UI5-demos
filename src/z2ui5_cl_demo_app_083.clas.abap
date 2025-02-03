CLASS z2ui5_cl_demo_app_083 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_tab_01,
        screen_name TYPE string,
      END OF ty_s_tab_01.

    TYPES temp1_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_tab_01 WITH DEFAULT KEY.
DATA mt_01 TYPE temp1_ccb5cca2d1.

    TYPES:
      BEGIN OF ty_s_tab_02,
        screen_name TYPE string,
        field       TYPE string,
        field_doma  TYPE string,
      END OF ty_s_tab_02.

    TYPES temp2_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_tab_02 WITH DEFAULT KEY.
DATA mt_02 TYPE temp2_ccb5cca2d1.
    TYPES temp3_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_tab_02 WITH DEFAULT KEY.
DATA mt_02_display TYPE temp3_ccb5cca2d1.
    TYPES:
      BEGIN OF ty_s_tab_02_input,
        name  TYPE string,
        value TYPE string,
      END OF ty_s_tab_02_input.

    TYPES temp4_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_tab_02_input WITH DEFAULT KEY.
DATA mt_tab_02_input TYPE temp4_ccb5cca2d1.

    TYPES:
      BEGIN OF ty_s_filter_pop,
        option TYPE string,
        low    TYPE string,
        high   TYPE string,
        key    TYPE string,
      END OF ty_s_filter_pop.
    TYPES temp5_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_filter_pop WITH DEFAULT KEY.
DATA mt_filter TYPE temp5_ccb5cca2d1.

    TYPES:
      BEGIN OF ty_s_token,
        key      TYPE string,
        text     TYPE string,
        visible  TYPE abap_bool,
        selkz    TYPE abap_bool,
        editable TYPE abap_bool,
      END OF ty_s_token.

    DATA mv_value       TYPE string.
    DATA mv_value2      TYPE string.
    TYPES temp6_ccb5cca2d1 TYPE STANDARD TABLE OF ty_s_token WITH DEFAULT KEY.
DATA mt_token       TYPE temp6_ccb5cca2d1.

    DATA mt_mapping TYPE z2ui5_if_types=>ty_t_name_value.

    TYPES ty_t_range TYPE RANGE OF string.
    TYPES ty_s_range TYPE LINE OF ty_t_range.
    TYPES:
      BEGIN OF ty_s_filter,
        product TYPE ty_t_range,
      END OF ty_s_filter.

    DATA ms_filter TYPE ty_s_filter.
    DATA mv_name TYPE string.

    DATA mt_table TYPE REF TO data.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.
    METHODS z2ui5_on_render_main.
    METHODS z2ui5_on_render_pop_filter.
    METHODS z2ui5_set_data.

  PRIVATE SECTION.
    DATA mt_cols TYPE string_table.

ENDCLASS.



CLASS z2ui5_cl_demo_app_083 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.
    DATA ls_range TYPE z2ui5_cl_util=>ty_s_range.

    CASE client->get( )-event.

      WHEN 'BUTTON_POST'.
        CREATE DATA mt_table TYPE (mv_name).
        z2ui5_on_render_main( ).

      WHEN `FILTER_UPDATE`.
        IF mv_value IS NOT INITIAL.

          ls_range = z2ui5_cl_util=>filter_get_range_by_token( mv_value ).
          INSERT ls_range INTO TABLE ms_filter-product.
        ENDIF.

      WHEN `FILTER_VALUE_HELP_OK`.
        CLEAR ms_filter-product.
        DATA temp1 LIKE LINE OF mt_filter.
        DATA lr_filter LIKE REF TO temp1.
        LOOP AT mt_filter REFERENCE INTO lr_filter.
          DATA temp2 LIKE LINE OF ms_filter-product.
          CLEAR temp2.
          temp2-sign = `I`.
          temp2-option = lr_filter->option.
          temp2-low = lr_filter->low.
          temp2-high = lr_filter->high.
          INSERT temp2 INTO TABLE ms_filter-product.
        ENDLOOP.

        client->popup_destroy( ).

      WHEN `POPUP_ADD`.
        DATA temp3 TYPE z2ui5_cl_demo_app_083=>ty_s_filter_pop.
        CLEAR temp3.
        temp3-key = z2ui5_cl_util=>uuid_get_c32( ).
        INSERT temp3 INTO TABLE mt_filter.
        client->popup_model_update( ).

      WHEN `POPUP_DELETE`.
        DATA lt_item TYPE string_table.
        lt_item = client->get( )-t_event_arg.
        DATA temp4 LIKE LINE OF lt_item.
        DATA temp5 LIKE sy-tabix.
        temp5 = sy-tabix.
        READ TABLE lt_item INDEX 1 INTO temp4.
        sy-tabix = temp5.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        DELETE mt_filter WHERE key = temp4.
        client->popup_model_update( ).

      WHEN `POPUP_DELETE_ALL`.
        DATA temp6 LIKE mt_filter.
        CLEAR temp6.
        mt_filter = temp6.
        client->popup_model_update( ).

      WHEN `FILTER_VALUE_HELP`.
        z2ui5_on_render_pop_filter( ).

        CLEAR mt_filter.
        DATA temp7 LIKE LINE OF ms_filter-product.
        DATA lr_product LIKE REF TO temp7.
        LOOP AT ms_filter-product REFERENCE INTO lr_product.
          DATA temp8 TYPE z2ui5_cl_demo_app_083=>ty_s_filter_pop.
          CLEAR temp8.
          temp8-low = lr_product->low.
          temp8-high = lr_product->high.
          temp8-option = lr_product->option.
          temp8-key = z2ui5_cl_util=>uuid_get_c32( ).
          INSERT temp8 INTO TABLE mt_filter.

        ENDLOOP.

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    DATA temp9 LIKE mt_01.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-screen_name = `screen_01`.
    INSERT temp10 INTO TABLE temp9.
    temp10-screen_name = `screen_02`.
    INSERT temp10 INTO TABLE temp9.
    mt_01 = temp9.

    DATA temp11 LIKE mt_02.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-screen_name = `screen_01`.
    temp12-field_doma = `CHAR30`.
    temp12-field = `MATNR`.
    INSERT temp12 INTO TABLE temp11.
    temp12-screen_name = `screen_01`.
    temp12-field_doma = `STRING`.
    temp12-field = `LGNUM`.
    INSERT temp12 INTO TABLE temp11.
    temp12-screen_name = `screen_02`.
    temp12-field_doma = `PRODUCT`.
    temp12-field = `PRODUCT`.
    INSERT temp12 INTO TABLE temp11.
    mt_02 = temp11.

    mv_name = `screen_01`.
    z2ui5_on_render_main( ).

    DATA temp13 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp13.
    DATA temp14 LIKE LINE OF temp13.
    temp14-n = `EQ`.
    temp14-v = `={LOW}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `LT`.
    temp14-v = `<{LOW}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `LE`.
    temp14-v = `<={LOW}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `GT`.
    temp14-v = `>{LOW}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `GE`.
    temp14-v = `>={LOW}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `CP`.
    temp14-v = `*{LOW}*`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `BT`.
    temp14-v = `{LOW}...{HIGH}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `NE`.
    temp14-v = `!(={LOW})`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `NE`.
    temp14-v = `!(<leer>)`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `<leer>`.
    temp14-v = `<leer>`.
    INSERT temp14 INTO TABLE temp13.
    mt_mapping = temp13.

  ENDMETHOD.

  METHOD z2ui5_on_render_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view = view->page( id   = `page_main`
             title          = 'abap2UI5 - Select-Options'
             navbuttonpress = client->_event( 'BACK' )
             shownavbutton  = temp1 ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->dynamic_page(
            headerexpanded = abap_true
            headerpinned   = abap_true ).

    DATA header_title TYPE REF TO z2ui5_cl_xml_view.
    header_title = page->title( ns = 'f'
            )->get( )->dynamic_page_title( ).

    header_title->heading( ns = 'f' )->hbox(
        )->title( `Select-Option` ).
    header_title->expanded_content( 'f' ).
    header_title->snapped_content( ns = 'f' ).

    DATA lo_box TYPE REF TO z2ui5_cl_xml_view.
    lo_box = page->header( )->dynamic_page_header( pinnable = abap_true
         )->flex_box( alignitems     = `Start`
                      justifycontent = `SpaceBetween` )->flex_box( alignitems = `Start` ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = lo_box->vbox( ).
    vbox->simple_form( editable = abap_true
            )->content( `form`
                )->title( 'Table'
                )->label( 'Name' ).

    vbox->input( client->_bind_edit( mv_name ) ).

    vbox->button(
                text  = 'read'
                press = client->_event( 'BUTTON_POST' ) ).

    vbox = lo_box->vbox( ).

    IF mt_02 IS NOT INITIAL.

      mt_02_display = mt_02.
      DELETE mt_02_display WHERE screen_name <> mv_name.

      DATA temp15 LIKE mt_tab_02_input.
      CLEAR temp15.
      DATA line LIKE LINE OF mt_cols.
      LOOP AT mt_cols INTO line.
        DATA temp16 LIKE LINE OF temp15.
        temp16-name = line.
        INSERT temp16 INTO TABLE temp15.
      ENDLOOP.
      mt_tab_02_input = temp15.

      DATA temp17 LIKE LINE OF mt_02_display.
      DATA lr_tab LIKE REF TO temp17.
      LOOP AT mt_02_display REFERENCE INTO lr_tab.
        DATA temp18 TYPE z2ui5_cl_demo_app_083=>ty_s_tab_02_input.
        CLEAR temp18.
        temp18-name = lr_tab->field.
        INSERT temp18 INTO TABLE mt_tab_02_input.
      ENDLOOP.
*
      vbox->list(
        items      = client->_bind( mt_tab_02_input )
        headertext = `Filter`
        )->custom_list_item(
            )->hbox(
                )->text( `{NAME}`
            )->multi_input(
                tokens           = client->_bind( mt_token )
                showclearicon    = abap_true
                value            = `{VALUE}`
                tokenupdate      = client->_event( val = 'FILTER_UPDATE1' )
                submit           = client->_event( 'FILTER_UPDATE' )
                id               = `FILTER`
                valuehelprequest = client->_event( 'FILTER_VALUE_HELP' )
            )->item(
                    key  = `{KEY}`
                    text = `{TEXT}`
            )->tokens(
                )->token(
                    key      = `{KEY}`
                    text     = `{TEXT}`
                    visible  = `{VISIBLE}`
                    selected = `{SELKZ}`
                    editable = `{EDITABLE}` ).
    ENDIF.

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.


  METHOD z2ui5_on_render_pop_filter.

    DATA lo_popup TYPE REF TO z2ui5_cl_xml_view.
    lo_popup = z2ui5_cl_xml_view=>factory_popup( ).

    lo_popup = lo_popup->dialog(
      contentheight = `50%`
      contentwidth  = `50%`
        title       = 'Define Conditons - Product' ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = lo_popup->vbox( height         = `100%`
                                 justifycontent = 'SpaceBetween' ).

    DATA pan TYPE REF TO z2ui5_cl_xml_view.
    pan  = vbox->panel(
         expandable = abap_false
         expanded   = abap_true
         headertext = `Product` ).
    DATA item TYPE REF TO z2ui5_cl_xml_view.
    item = pan->list(
           "   headertext = `Product`
              nodata         = `no conditions defined`
             items           = client->_bind_edit( mt_filter )
             selectionchange = client->_event( 'SELCHANGE' )
                )->custom_list_item( ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = item->grid( ).

    DATA temp19 TYPE string_table.
    CLEAR temp19.
    INSERT `${KEY}` INTO TABLE temp19.
    grid->combobox(
                 selectedkey = `{OPTION}`
                 items       = client->_bind_edit( mt_mapping )
             )->item(
                     key  = '{N}'
                     text = '{N}'
             )->get_parent(
             )->input( value = `{LOW}`
             )->input( value   = `{HIGH}`
                       visible = `{= ${OPTION} === 'BT' }`
             )->button( icon  = 'sap-icon://decline'
                        type  = `Transparent`
                        press = client->_event( val = `POPUP_DELETE` t_arg = temp19 ) ).

    lo_popup->footer( )->overflow_toolbar(
        )->button( text  = `Delete All`
                   icon  = 'sap-icon://delete'
                   type  = `Transparent`
                   press = client->_event( val = `POPUP_DELETE_ALL` )
        )->button( text  = `Add Item`
                   icon  = `sap-icon://add`
                   press = client->_event( val = `POPUP_ADD` )
        )->toolbar_spacer(
        )->button(
            text  = 'OK'
            press = client->_event( 'FILTER_VALUE_HELP_OK' )
            type  = 'Emphasized'
       )->button(
            text  = 'Cancel'
            press = client->_event( 'FILTER_VALUE_HELP_CANCEL' ) ).

    client->popup_display( lo_popup->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_set_data.



  ENDMETHOD.
ENDCLASS.

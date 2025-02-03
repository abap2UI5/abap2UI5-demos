CLASS z2ui5_cl_demo_app_056 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_tab,
        selkz            TYPE abap_bool,
        product          TYPE string,
        create_date      TYPE string,
        create_by        TYPE string,
        storage_location TYPE string,
        quantity         TYPE i,
      END OF ty_s_tab.
    TYPES ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH DEFAULT KEY.

    DATA mt_table TYPE ty_t_table.
    DATA mt_token TYPE z2ui5_cl_util=>ty_t_token.

    DATA mt_tokens_added TYPE z2ui5_cl_util=>ty_t_token.
    DATA mt_tokens_removed TYPE z2ui5_cl_util=>ty_t_token.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA mv_check_initialized TYPE abap_bool.
    METHODS on_event.
    METHODS view_display.
    METHODS set_data.

  PRIVATE SECTION.
    DATA mt_range TYPE z2ui5_cl_pop_get_range=>ty_s_result-t_range.
ENDCLASS.



CLASS z2ui5_cl_demo_app_056 IMPLEMENTATION.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN `BUTTON_START`.
        set_data( ).
        client->view_model_update( ).

      WHEN `UPDATE_TOKENS`.
        DATA ls_token LIKE LINE OF mt_tokens_removed.
        LOOP AT mt_tokens_removed INTO ls_token.
          DELETE mt_token WHERE key = ls_token-key.
        ENDLOOP.

        LOOP AT mt_tokens_added INTO ls_token.
          DATA temp1 TYPE z2ui5_cl_util=>ty_s_token.
          CLEAR temp1.
          temp1-key = ls_token-key.
          temp1-text = ls_token-text.
          temp1-visible = abap_true.
          temp1-editable = abap_true.
          INSERT temp1 INTO TABLE mt_token.
        ENDLOOP.

        CLEAR mt_tokens_removed.
        CLEAR mt_tokens_added.

        mt_range = z2ui5_cl_util=>filter_get_range_t_by_token_t( mt_token ).
        set_data( ).
        client->view_model_update( ).

      WHEN `FILTER_VALUE_HELP`.
        client->nav_app_call( z2ui5_cl_pop_get_range=>factory( mt_range ) ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD set_data.

    DATA temp2 TYPE z2ui5_cl_demo_app_056=>ty_t_table.
    CLEAR temp2.
    DATA temp3 LIKE LINE OF temp2.
    temp3-product = 'table'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    temp3-product = 'chair'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    temp3-product = 'sofa'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    temp3-product = 'computer'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    temp3-product = 'oven'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    temp3-product = 'table2'.
    temp3-create_date = `01.01.2023`.
    temp3-create_by = `Peter`.
    temp3-storage_location = `AREA_001`.
    temp3-quantity = 400.
    INSERT temp3 INTO TABLE temp2.
    mt_table = temp2.

    DELETE mt_table WHERE product NOT IN mt_range.

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view = view->shell( )->page( id = `page_main`
             title                  = 'abap2UI5 - Select-Options'
             navbuttonpress         = client->_event( 'BACK' )
             shownavbutton          = temp1
        )->get_parent( ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = view->vbox( ).
    vbox->_z2ui5( )->multiinput_ext(
                       addedtokens   = client->_bind_edit( mt_tokens_added )
                       removedtokens = client->_bind_edit( mt_tokens_removed )
                       change        = client->_event( 'UPDATE_TOKENS' )
                       multiinputid  = `MultiInput` ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = vbox->table(
        items = client->_bind( val = mt_table )
           )->header_toolbar(
             )->overflow_toolbar(
             )->text( `Product:`
             )->multi_input(
                width            = `30%`
                id               = `MultiInput`
                tokens           = client->_bind( mt_token )
                showclearicon    = abap_true
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
                    editable = `{EDITABLE}`
                )->get_parent( )->get_parent(
                 )->toolbar_spacer(
               )->button(
        text  = `Go`
        press = client->_event( `BUTTON_START` )
        type  = `Emphasized`
            )->get_parent( )->get_parent( ).

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

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_check_initialized = abap_false.
      mv_check_initialized = abap_true.
      view_display( ).
      RETURN.
    ENDIF.

    IF client->get( )-check_on_navigated = abap_true.
      TRY.
          DATA temp4 TYPE REF TO z2ui5_cl_pop_get_range.
          temp4 ?= client->get_app( client->get( )-s_draft-id_prev_app ).
          DATA lo_value_help LIKE temp4.
          lo_value_help = temp4.
          IF lo_value_help->result( )-check_confirmed = abap_false.
            RETURN.
          ENDIF.

          mt_range = lo_value_help->result( )-t_range.
          mt_token = z2ui5_cl_util=>filter_get_token_t_by_range_t( mt_range ).
          set_data( ).
          client->view_model_update( ).

        CATCH cx_root.
      ENDTRY.
      RETURN.
    ENDIF.

    IF client->get( )-event IS NOT INITIAL.
      on_event( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

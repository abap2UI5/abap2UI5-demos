CLASS z2ui5_cl_demo_app_035 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_type           TYPE string.
    DATA mv_path           TYPE string.
    DATA mv_editor         TYPE string.
    DATA mv_check_editable TYPE abap_bool.
    DATA check_initialized TYPE abap_bool.

    DATA client            TYPE REF TO z2ui5_if_client.
    DATA: lt_types TYPE z2ui5_if_types=>ty_t_name_value.
    METHODS view_display.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.


CLASS z2ui5_cl_demo_app_035 IMPLEMENTATION.
  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp6 TYPE xsdboolean.
    temp6 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell( )->page( title          = 'abap2UI5 - File Editor'
                                       navbuttonpress = client->_event( 'BACK' )
                                       shownavbutton  = temp6 ).

    DATA temp TYPE REF TO z2ui5_cl_xml_view.
    temp = page->simple_form( title    = 'File'
                                    editable = abap_true )->content( `form`
         )->label( 'path'
         )->input( client->_bind_edit( mv_path )
         )->label( 'Option' ).

    DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp1.
    lt_types = temp1.
    DATA temp2 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp2.
    DATA temp5 TYPE string_table.
    temp5 = z2ui5_cl_util=>source_get_file_types( ).
    DATA row LIKE LINE OF temp5.
    LOOP AT temp5 INTO row.
      DATA temp4 LIKE LINE OF temp2.
      temp4-n = shift_right( shift_left( row ) ).
      temp4-v = shift_right( shift_left( row ) ).
      INSERT temp4 INTO TABLE temp2.
    ENDLOOP.
    LT_TYPES = temp2.

    DATA temp3 TYPE REF TO z2ui5_cl_xml_view.
    temp3 = temp->input( value = client->_bind_edit( mv_type )
                   suggestionitems   = client->_bind_local( LT_TYPES )
                    )->get( ).

    temp3->suggestion_items(
                )->list_item( text           = '{N}'
                              additionaltext = '{V}' ).

    temp->label( '' )->button( text = 'Download'
                    press           = client->_event( 'DB_LOAD' )
                    icon            = 'sap-icon://download-from-cloud' ).

    page->code_editor( type     = client->_bind_edit( mv_type )
                       editable = client->_bind( mv_check_editable )
                       value    = client->_bind( mv_editor ) ).

    DATA temp7 TYPE xsdboolean.
    temp7 = boolc( mv_editor IS NOT INITIAL ).
    page->footer( )->overflow_toolbar(
        )->button( text  = 'Clear'
                   press = client->_event( 'CLEAR' )
                   icon  = 'sap-icon://delete'
        )->toolbar_spacer(
        )->button( text  = 'Edit'
                   press = client->_event( 'EDIT' )
                   icon  = 'sap-icon://edit'
        )->button( text    = 'Upload'
                   press   = client->_event( 'DB_SAVE' )
                   type    = 'Emphasized'
                   icon    = 'sap-icon://upload-to-cloud'
                   enabled = temp7 ).

    client->view_display( page->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      mv_path = '../../demo/text'.
      mv_type = 'plain_text'.
      view_display( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'DB_LOAD'.

        DATA temp5 TYPE string.
        IF mv_path CS 'abap'.
          temp5 = lcl_file_api=>read_abap( ).
        ELSEIF mv_path CS 'json'.
          temp5 = lcl_file_api=>read_json( ).
        ELSEIF mv_path CS 'yaml'.
          temp5 = lcl_file_api=>read_yaml( ).
        ELSEIF mv_path CS 'text'.
          temp5 = lcl_file_api=>read_text( ).
        ELSEIF mv_path CS 'js'.
          temp5 = lcl_file_api=>read_js( ).
        ELSE.
          CLEAR temp5.
        ENDIF.
        mv_editor = temp5.

        client->message_toast_display( 'Download successfull' ).

        client->view_model_update( ).

      WHEN 'DB_SAVE'.
        client->message_box_display( text = 'Upload successfull. File saved!'
                                     type = 'success' ).
      WHEN 'EDIT'.
        DATA temp8 TYPE xsdboolean.
        temp8 = boolc( mv_check_editable = abap_false ).
        mv_check_editable = temp8.
        client->view_model_update( ).

      WHEN 'CLEAR'.
        mv_editor = ``.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

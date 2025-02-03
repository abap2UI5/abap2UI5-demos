CLASS z2ui5_cl_demo_app_167 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_value TYPE string.

    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_167 IMPLEMENTATION.

  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp4 TYPE xsdboolean.
    temp4 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Event with add Information and t_arg'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp4 ).

    page->link( text   = 'More Infos..'
                target = '_blank'
                href   = `https://sapui5.hana.ondemand.com/sdk/#/topic/b0fb4de7364f4bcbb053a99aa645affe` ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `FIX_VAL` INTO TABLE temp1.
    page->button( text  = `EVENT_FIX_VAL`
                  press = client->_event( val = `EVENT_FIX_VAL` t_arg = temp1 ) ).

    page->input( client->_bind_edit( mv_value ) ).
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    DATA temp2 LIKE LINE OF temp3.
    temp2 = `$` && client->_bind_edit( mv_value ).
    INSERT temp2 INTO TABLE temp3.
    page->button( text  = `EVENT_MODEL_VALUE`
                  press = client->_event( val = `EVENT_MODEL_VALUE` t_arg = temp3 ) ).


    DATA temp5 TYPE string_table.
    CLEAR temp5.
    INSERT `${$source>/text}` INTO TABLE temp5.
    page->button( text  = `SOURCE_PROPERTY_TEXT`
                  press = client->_event( val = `SOURCE_PROPERTY_TEXT` t_arg = temp5 ) ).

    DATA temp7 TYPE string_table.
    CLEAR temp7.
    INSERT `${$parameters>/value}` INTO TABLE temp7.
    page->input(
        description = `make an input and press enter - `
        submit      = client->_event( val = `EVENT_PROPERTY_VALUE` t_arg = temp7 ) ).

    DATA temp9 TYPE string_table.
    CLEAR temp9.
    INSERT `$event.oSource.oParent.sId` INTO TABLE temp9.
    page->button( text  = `PARENT_PROPERTY_ID`
                  press = client->_event( val = `PARENT_PROPERTY_ID` t_arg = temp9 ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      mv_value = `my value`.
      set_view( ).
    ENDIF.

    DATA lt_arg TYPE string_table.
    lt_arg = client->get( )-t_event_arg.
    CASE client->get( )-event.
      WHEN `EVENT_FIX_VAL` OR `EVENT_MODEL_VALUE` OR 'SOURCE_PROPERTY_TEXT' OR 'EVENT_PROPERTY_VALUE' OR 'PARENT_PROPERTY_ID'.
        DATA temp11 LIKE LINE OF lt_arg.
        DATA temp12 LIKE sy-tabix.
        temp12 = sy-tabix.
        READ TABLE lt_arg INDEX 1 INTO temp11.
        sy-tabix = temp12.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        client->message_box_display( `backend event :` && temp11 ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    client->view_model_update( ).

  ENDMETHOD.
ENDCLASS.

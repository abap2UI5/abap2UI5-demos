CLASS z2ui5_cl_demo_app_155 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS ui5_display.
    METHODS ui5_event.
    METHODS ui5_callback.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_155 IMPLEMENTATION.


  METHOD ui5_event.

    CASE client->get( )-event.

      WHEN 'POPUP'.
        DATA lo_app TYPE REF TO z2ui5_cl_pop_textedit.
        lo_app = z2ui5_cl_pop_textedit=>factory( `this is a text` ).
        client->nav_app_call( lo_app ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD ui5_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Popup To Text Edit'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1
           )->button(
            text  = 'Open Popup...'
            press = client->_event( 'POPUP' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.
      ui5_display( ).
      ui5_callback( ).
      RETURN.
    ENDIF.

    ui5_event( ).

  ENDMETHOD.

  METHOD ui5_callback.

    TRY.
        DATA lo_prev TYPE REF TO z2ui5_if_app.
        lo_prev = client->get_app( client->get( )-s_draft-id_prev_app ).
        DATA temp1 TYPE REF TO z2ui5_cl_pop_textedit.
        temp1 ?= lo_prev.
        DATA lv_text TYPE z2ui5_cl_pop_textedit=>ty_s_result-text.
        lv_text = temp1->result( )-text.
        client->message_box_display( `the result is ` && lv_text ).
      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

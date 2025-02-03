CLASS z2ui5_cl_demo_app_096 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA mo_view_parent TYPE REF TO z2ui5_cl_xml_view.
    DATA mv_descr       TYPE string.

    DATA mv_init TYPE abap_bool.
    METHODS on_init.
    METHODS on_event.

    DATA mr_data TYPE REF TO data.

    METHODS display_view
      CHANGING xml TYPE REF TO z2ui5_cl_xml_view OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS Z2UI5_CL_DEMO_APP_096 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    me->client = client.

    IF mv_init = abap_false.
      mv_init = abap_true.
      on_init( ).
      RETURN.
    ENDIF.

    on_event( ).

  ENDMETHOD.

  METHOD on_init.

    mv_descr = `data sub app`.
    display_view( ).

  ENDMETHOD.

  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'MESSAGE_SUB'.
        client->message_box_display( `event sub app` ).

    ENDCASE.

  ENDMETHOD.

  METHOD display_view.

    IF mo_view_parent IS NOT BOUND.

      DATA page TYPE REF TO z2ui5_cl_xml_view.
      page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page( title = 'Main View' ).

      mo_view_parent = page->grid( 'L6 M12 S12'
          )->content( 'layout' ).

      page->footer( )->overflow_toolbar(
                 )->toolbar_spacer(
                 )->button( text  = `event sub app`
                            press = client->_event( 'BUTTON_SAVE' )
                            type  = 'Success' ).

    ENDIF.

    mo_view_parent->input( value = client->_bind_edit( mv_descr ) ).
    mo_view_parent->button( text  = `event sub app`
                            press = client->_event( `MESSAGE_SUB` ) ).

  ENDMETHOD.
ENDCLASS.

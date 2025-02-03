CLASS z2ui5_cl_demo_app_324 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_serializable_object .
    INTERFACES z2ui5_if_app .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS call_dynpro.
ENDCLASS.


CLASS z2ui5_cl_demo_app_324 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->client = client.

    TRY.
        IF client->check_on_init( ) IS NOT INITIAL.
          client->view_display( z2ui5_cl_xml_view=>factory(
                                    )->page( shownavbutton = abap_true
                                             navbuttonpress = client->_event( 'BACK' )
                                    )->button( text = 'Call dynpro'
                                               press = client->_event( 'PRESS' )
                                    )->stringify( ) ).
        ENDIF.

        CASE client->get( )-event.
          WHEN 'BACK'.
            client->nav_app_leave( ).
          WHEN 'PRESS'.
            call_dynpro( ).
        ENDCASE.

        DATA x TYPE REF TO cx_root.
      CATCH cx_root INTO x.
        client->nav_app_call( z2ui5_cl_pop_error=>factory( x ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD call_dynpro.

    " of course this makes no sense in abap2UI5.
    " It's just to provoke "Sending of dynpro SAPLSPO1 0500 not possible" error.
    DATA fm TYPE c LENGTH 16.
    fm = 'POPUP_TO_CONFIRM'.
    CALL FUNCTION fm
      EXPORTING
        text_question  = 'Test'
      EXCEPTIONS
        text_not_found = 1
        OTHERS         = 2.

  ENDMETHOD.

ENDCLASS.

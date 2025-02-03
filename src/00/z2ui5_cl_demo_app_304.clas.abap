CLASS z2ui5_cl_demo_app_304 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    DATA magic_key TYPE string.
    DATA: BEGIN OF message,
            text TYPE string VALUE IS INITIAL,
            type TYPE string VALUE 'None',
          END OF message.
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    METHODS view_display.
    METHODS on_event.

ENDCLASS.


CLASS z2ui5_cl_demo_app_304 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ) IS NOT INITIAL.
      view_display( ).
    ENDIF.

    on_event( ).

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    " Note, these are demo sounds and are part of the abap2UI5 sample repo.
    " They are NOT meant to use in production.
    view->_generic( name = `script`
                    ns   = `html` )->_cc_plain_xml(
                        |function playSuccess() \{ new Audio("/SAP/PUBLIC/BC/ABAP/mime_demo/z2ui5_demo_success.mp3").play(); \}|
                     && |function playError() \{ new Audio("/SAP/PUBLIC/BC/ABAP/mime_demo/z2ui5_demo_error.mp3").play(); \}| ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = view->page( title = `Play success and error sounds` )->vbox( class = `sapUiSmallMargin` ).
    vbox->message_strip(
        text    = client->_bind( message-text )
        type    = client->_bind( message-type )
        visible = `{= !!$` && client->_bind( message-text ) && ` }` ).
    vbox->text( text = `The magic key is: abap2UI5` ).
    vbox->input( id          = `inputApp`
                 value       = client->_bind_edit( magic_key )
                 placeholder = `Enter magic key`
                 submit      = client->_event( 'enter' ) ).
    vbox->button( text  = `submit`
                  type  = `accept`
                  press = client->_event( 'enter' ) ).

    view->_z2ui5( )->focus( focusid = `inputApp` ).
    client->view_display( view->stringify( ) ).
  ENDMETHOD.


  METHOD on_event.

    IF client->get( )-event = 'enter'.
      IF magic_key = `abap2UI5`.
        client->follow_up_action( val = `playSuccess()` ).
        message-type = 'Success'.
        message-text = 'Hooray!'.
      ELSE.
        client->follow_up_action( val = `playError()` ).
        message-type = 'Error'.
        message-text = `That wasn't the magic key`.
      ENDIF.
      CLEAR magic_key.
      client->view_model_update( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

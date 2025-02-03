CLASS z2ui5_cl_demo_app_133 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.
    DATA field_01  TYPE string.
    DATA field_02 TYPE string.
    DATA focus_id TYPE string.
    DATA selstart TYPE string.
    DATA selend TYPE string.
    DATA update_focus TYPE abap_bool.

  PROTECTED SECTION.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS init
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_133 IMPLEMENTATION.


  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( view->shell(
      )->page(
                  title          = 'abap2UI5 - Focus'
                  navbuttonpress = client->_event( val = 'BACK' )
                  shownavbutton  = temp1
                        )->_z2ui5( )->focus(
                              focusid          = client->_bind_edit( focus_id )
                                selectionstart = client->_bind_edit( selstart )
                                selectionend   = client->_bind_edit( selend )
                                setupdate      = client->_bind_edit( update_focus )
              )->simple_form( title    = 'Focus & Cursor'
                              editable = abap_true
                  )->content( 'form'
                      )->title( 'Input'
                      )->label( 'Sel_Start'
                      )->input( value = client->_bind_edit( selstart )
                      )->label( 'Sel_End'
                      )->input( value = client->_bind_edit( selend )
                      )->label( 'field_01'
                      )->input( value = client->_bind_edit( field_01 )
                                id    = 'BUTTON01'
                      )->button( text  = 'focus here'
                                 press = client->_event( val = 'BUTTON01' )
                      )->label( `field_02`
                      )->input( value = client->_bind_edit( field_02 )
                                id    = 'BUTTON02'
                      )->button( text  = 'focus here'
                                 press = client->_event( val = 'BUTTON02' )
           )->stringify( ) ).

  ENDMETHOD.


  METHOD init.

    field_01 = `this is a text`.
    field_02 = `this is another text`.
    selstart = `3`.
    selend = `7`.
    display_view( client ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      init( client ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

      WHEN 'BUTTON01' OR 'BUTTON02'.
        update_focus = abap_true.
        focus_id = client->get( )-event.
        client->view_model_update( ).
        client->message_toast_display( |focus changed| ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.

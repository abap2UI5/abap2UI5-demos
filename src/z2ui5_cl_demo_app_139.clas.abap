CLASS z2ui5_cl_demo_app_139 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA search  TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS display_view.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_139 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      search = client->get( )-s_config-search && `my_search_string`.
      display_view( ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'SET_VIEW'.
        display_view( ).
        client->message_toast_display( |{ search } - title changed| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.

  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA tmp TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    tmp = view->_z2ui5( )->history( client->_bind_edit( search )
         )->shell(
         )->page(
                 title          = 'abap2UI5 - Change URL History'
                 navbuttonpress = client->_event( val = 'BACK' )
                 shownavbutton  = temp1
             )->simple_form( title    = 'Form Title'
                             editable = abap_true
                 )->content( 'form'
                     )->title( 'Input'
                     )->label( 'search'
                     )->input( client->_bind_edit( search ) ).

    client->view_display( tmp->stringify( ) ).

  ENDMETHOD.

ENDCLASS.

CLASS z2ui5_cl_demo_app_189 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES
      z2ui5_if_app.

    DATA:
      one         TYPE string,
      two         TYPE string,
      three       TYPE string,
      focus_field TYPE string.

  PRIVATE SECTION.
    DATA initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS render.
    METHODS dispatch.

ENDCLASS.


CLASS z2ui5_cl_demo_app_189 IMPLEMENTATION.

  METHOD dispatch.

    CASE client->get( )-event.
      WHEN 'one_enter'.
        focus_field = 'IdTwo'.
      WHEN 'two_enter'.
        focus_field = 'IdThree'.
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.
    client->view_model_update( ).

  ENDMETHOD.


  METHOD render.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
          )->page(
              title          = 'abap2UI5 - Focus II'
              navbuttonpress = client->_event( 'BACK' )
              shownavbutton  = temp1 ).

    page->simple_form(
       )->content( ns = 'form'
       )->label( 'One (Press Enter)' )->input( id     = 'IdOne'
                                               value  = client->_bind_edit( one )
                                               submit = client->_event( 'one_enter' )
       )->label( 'Two' )->input( id     = 'IdTwo'
                                 value  = client->_bind_edit( two )
                                 submit = client->_event( 'two_enter' )
       )->label( 'Three' )->input( id    = 'IdThree'
                                   value = client->_bind_edit( three ) ).

    page->_z2ui5( )->focus( focusid = client->_bind( focus_field ) ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF initialized = abap_false.
      initialized = abap_true.
      focus_field = 'IdOne'.
      render( ).
    ENDIF.

    dispatch( ).

  ENDMETHOD.
ENDCLASS.


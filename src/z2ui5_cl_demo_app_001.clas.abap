CLASS z2ui5_cl_demo_app_001 DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA product  TYPE string.
    DATA quantity TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS z2ui5_set_data.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_001 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->client = client.


    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
      z2ui5_set_data( ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.


  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( val = view->shell(
           )->page(
                   title          = 'abap2UI5 - First Example'
                   navbuttonpress = client->_event( 'BACK' )
                   shownavbutton  = temp1
        )->simple_form( title = 'Form Title' editable = abap_true
                   )->content( 'form'
                       )->title( 'Input'
                       )->label( 'quantity'
                       )->input( client->_bind_edit( quantity )
                       )->label( `product`
                       )->input( value = product enabled = abap_false
                       )->button(
                           text  = 'post'
                           press = client->_event( val = 'BUTTON_POST' )
            )->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->message_toast_display( text = |{ product } { quantity } - send to the server| ).
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_set_data.

    product  = 'products'.
    quantity = '500'.

  ENDMETHOD.
ENDCLASS.

CLASS z2ui5_cl_demo_app_005 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA value1 TYPE int4.
    DATA value2 TYPE int4.
    DATA initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_005 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF initialized = abap_false.
      initialized = abap_true.
      value1 = 10.
      value2 = 90.
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'SLIDER_CHANGE'.

        client->message_toast_display( |Range Slider { cl_abap_char_utilities=>newline }value1 { value1 } { cl_abap_char_utilities=>newline }value2 { value2 }| ).

    ENDCASE.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Range Slider Example'
                navbuttonpress = client->_event( 'BACK' )
                 shownavbutton = temp1 ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L12 M12 S12' )->content( 'layout' ).

    grid->simple_form( title    = 'More Controls'
                       editable = abap_true )->content( 'form'
        )->label( 'Range Slider'
        )->range_slider(
            max           = '100'
            min           = '0'
            step          = '10'
            startvalue    = '10'
            endvalue      = '20'
            showtickmarks = abap_true
            labelinterval = '2'
            width         = '80%'
            class         = 'sapUiTinyMargin'
            value         = client->_bind_edit( value1 )
            value2        = client->_bind_edit( value2 )
            change        = client->_event( 'SLIDER_CHANGE' ) ).
    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.

CLASS z2ui5_cl_demo_app_050 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA product  TYPE string.
    DATA quantity TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_050 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      product  = 'tomato'.
      quantity = '500'.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->message_toast_display( |{ product } { quantity } - send to the server| ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
    ENDCASE.

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'abap2UI5 - Changed CSS'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp1
            )->_generic( ns   = `html`
                         name = `style` )->_cc_plain_xml(
                    `.sapMInput {` && |\n| &&
                         `    height: 80px !important;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `input {` && |\n| &&
                         `    height: 80% !important;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `input[role="textbox"] {` && |\n| &&
                         `    height: 80px !important;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `input[role="text"] {` && |\n| &&
                         `    height: 80px !important;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `.sapUiSearchField {` && |\n| &&
                         `    height: 35px;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `.sapUiTfCombo:hover {` && |\n| &&
                         `    height: 2rem;` && |\n| &&
                         `    font-size: 2.5rem !important;` && |\n| &&
                         `}` && |\n| &&
                         |\n| &&
                         `.sapMInputBaseInner::placeholder {` && |\n| &&
                         `    font-size: 1.4rem !important;` && |\n| &&
                         `}`
            )->get_parent(
            )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
                        class = `mySuperRedButton`
            )->input( value = client->_bind( quantity )
            )->simple_form( title    = 'Form Title'
                            editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'quantity'
                    )->input( value = client->_bind( quantity )
                    )->label( 'product'
                    )->input(
                        value   = product
                        enabled = abap_false
                    )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ).

  ENDMETHOD.
ENDCLASS.

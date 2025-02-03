CLASS z2ui5_cl_demo_app_208 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_208 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Radio Button Group`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox( class = `sapUiSmallMargin`
                          )->label( labelfor = `rbg1`
                                    text     = `An example with 'matrix' layout`
                          )->radio_button_group( id      = `rbg1`
                                                 columns = `3`
                                                 width   = `100%`
                                                 class   = `sapUiMediumMarginBottom`
                              )->radio_button( id   = `RB1-1`
                                               text = `Long Option Number 1` )->get_parent(
                              )->radio_button( id      = `RB1-2`
                                               text    = `Option 2`
                                               enabled = abap_false )->get_parent(
                              )->radio_button( id       = `RB1-3`
                                               text     = `Nr. 3`
                                               editable = abap_false )->get_parent(
                              )->radio_button( id   = `RB1-4`
                                               text = `Long Option 4` )->get_parent(
                              )->radio_button( id   = `RB1-5`
                                               text = `Option 5` )->get_parent(
                              )->radio_button( id   = `RB1-6`
                                               text = `Nr. 6` )->get_parent( )->get_parent(
                          )->label( labelfor = `rbg2`
                                    text     = `An example with 3 buttons and 2 columns`
                          )->radio_button_group( id            = `rbg2`
                                                 columns       = `2`
                                                 selectedindex = `2`
                                                 class         = `sapUiMediumMarginBottom`
                              )->radio_button( id   = `RB2-1`
                                               text = `Option 1` )->get_parent(
                              )->radio_button( id       = `RB2-2`
                                               text     = `Option 2`
                                               editable = abap_false )->get_parent(
                              )->radio_button( id   = `RB2-3`
                                               text = `Option 3` )->get_parent( )->get_parent(
                          )->label( labelfor = `rbg3`
                                    text     = `If the number of columns is equal to or exceeds the number of radio buttons they align horizontally`
                          )->radio_button_group( id         = `rbg3`
                                                 columns    = `5`
                                                 valuestate = `Error`
                                                 class      = `sapUiMediumMarginBottom`
                              )->radio_button( id   = `RB3-1`
                                               text = `Option 1` )->get_parent(
                              )->radio_button( id   = `RB3-2`
                                               text = `Option 2` )->get_parent(
                              )->radio_button( id   = `RB3-3`
                                               text = `Option 3` )->get_parent( )->get_parent(
                          )->label( labelfor = `rbg4`
                                    text     = `An example of a group in warning state`
                          )->radio_button_group( id         = `rbg4`
                                                 valuestate = `Warning`
                              )->radio_button( id   = `RB4-1`
                                               text = `Option 1` )->get_parent(
                              )->radio_button( id   = `RB4-2`
                                               text = `Option 2` )->get_parent( ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

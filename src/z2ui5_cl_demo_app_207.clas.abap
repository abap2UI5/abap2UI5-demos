CLASS z2ui5_cl_demo_app_207 DEFINITION
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



CLASS Z2UI5_CL_DEMO_APP_207 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Radio Button`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox( class = `sapUiSmallMargin`
                          )->label( text     = `Default RadioButton use`
                                    labelfor = `GroupA`
                          )->radio_button_group( id = `GroupA`
                              )->radio_button( text     = `Option 1`
                                               selected = abap_true )->get_parent(
                              )->radio_button( text = `Option 2` )->get_parent(
                              )->radio_button( text = `Option 3` )->get_parent(
                              )->radio_button( text = `Option 4` )->get_parent(
                              )->radio_button( text = `Option 5` )->get_parent( )->get_parent( )->get_parent(
                      )->vbox( class = `sapUiSmallMargin`
                          )->label( text = `RadioButton in various ValueState variants`
                          )->hbox( class = `sapUiTinyMarginTopBottom`
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Success`
                                            labelfor = `GroupB`
                                  )->radio_button_group( id         = `GroupB`
                                                         valuestate = `Success`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Error`
                                            labelfor = `GroupC`
                                  )->radio_button_group( id         = `GroupC`
                                                         valuestate = `Error`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Warning`
                                            labelfor = `GroupD`
                                  )->radio_button_group( id         = `GroupD`
                                                         valuestate = `Warning`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Information`
                                            labelfor = `GroupE`
                                  )->radio_button_group( id         = `GroupE`
                                                         valuestate = `Information`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( ).

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

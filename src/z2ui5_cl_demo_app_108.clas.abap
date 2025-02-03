CLASS z2ui5_cl_demo_app_108 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA:
      BEGIN OF screen,
        input1 TYPE string,
        input2 TYPE string,
        input3 TYPE string,
      END OF screen .
    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS z2ui5_on_rendering
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_init.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_108 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      z2ui5_on_rendering( client ).
    ENDIF.

    z2ui5_on_event( client ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'BUTTON_SEND'.
        client->message_box_display( 'success - values send to the server' ).
      WHEN 'BUTTON_CLEAR'.
        CLEAR screen.
        client->message_toast_display( 'View initialized' ).
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

  ENDMETHOD.


  METHOD z2ui5_on_rendering.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title           = 'abap2UI5 - Side Panel Example'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true ).

    page->header_content(
         )->link(
         )->get_parent( ).

    DATA side_panel TYPE REF TO z2ui5_cl_xml_view.
    side_panel = page->side_panel( sidepanelposition = `Left`
      )->main_content(
        )->button( text = `Button 1`
        )->button( text = `Button 2`
        )->vbox(
          )->label( text = `Switch 1`
          )->switch(
          )->get_parent(
        )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut` &&
                        `labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris` &&
                        `nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse` &&
                        `cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui` &&
                        `officia deserunt mollit anim id est laborum`
                        )->get_parent(
          )->items( ns = `f`
            )->side_panel_item( icon = `sap-icon://physical-activity`
                                text = `Run`
              )->vbox(
                )->text( text  = `Static Content`
                         class = `sapUiSmallMarginBottom`
                )->switch(
                )->button( text = `Press Me`
              )->get_parent(
             )->get_parent(
           )->side_panel_item( icon = `sap-icon://addresses`
                               text = `Go Home`
            )->vbox(
              )->text( text  = `Static Content`
                       class = `sapUiSmallMarginBottom`
              )->button( text = `Press Me`
              )->button( text = `Hit Me`
            )->get_parent(
           )->get_parent(
          )->side_panel_item( icon = `sap-icon://flight`
                              text = `Fly abroad` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.

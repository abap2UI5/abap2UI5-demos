CLASS z2ui5_cl_demo_app_224 DEFINITION
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



CLASS z2ui5_cl_demo_app_224 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'Sample: Icon Tab Bar - Text Only'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->icon_tab_bar( id       = `idIconTabBarNoIcons`
                                       expanded = `{device>/isNoPhone}`
                                       class    = `sapUiResponsiveContentPadding`
                          )->items(
                              )->icon_tab_filter( text = `Info`
                                                  key  = `info`
                                                  )->text( text = `Info content goes here ...` )->get_parent(
                              )->icon_tab_filter( text = `Attachments`
                                                  key  = `attachments`
                                                  )->text( text = `Attachments go here ...` )->get_parent(
                              )->icon_tab_filter( text = `Notes`
                                                  key  = `notes`
                                                  )->text( text = `Notes go here ...` )->get_parent(
                              )->icon_tab_filter( text = `People`
                                                  key  = `people`
                                                  )->text( text = `People content goes here ...` ).

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

CLASS z2ui5_cl_demo_app_239 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_239 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Check Box'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `hint_icon`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'POPOVER' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.CheckBox/sample/sap.m.sample.CheckBox' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox(
                          )->checkbox( text     = `Option a`
                                       selected = abap_true
                          )->checkbox( text = `Option b`
                          )->checkbox( text     = `Option c`
                                       selected = abap_true
                          )->checkbox( text = `Option d`
                          )->checkbox( text    = `Option e`
                                       enabled = abap_false
                          )->checkbox( text              = `Option partially selected`
                                       selected          = abap_true
                                       partiallyselected = abap_true
                          )->checkbox( text     = `Required option`
                                       required = abap_true
                          )->checkbox( text       = `Warning`
                                       valuestate = `Warning`
                          )->checkbox( text       = `Warning disabled`
                                       valuestate = `Warning`
                                       enabled    = abap_false
                                       selected   = abap_true
                          )->checkbox( text       = `Error`
                                       valuestate = `Error`
                          )->checkbox( text       = `Error disabled`
                                       valuestate = `Error`
                                       enabled    = abap_false
                                       selected   = abap_true
                          )->checkbox( text       = `Information`
                                       valuestate = `Information`
                          )->checkbox( text       = `Information disabled`
                                       valuestate = `Information`
                                       enabled    = abap_false
                                       selected   = abap_true
                          )->checkbox( text     = `Checkbox with wrapping='true' and long text`
                                       wrapping = abap_true
                                       width    = `150px` ).
    layout->simple_form(
             editable   = abap_true
             layout     = `ResponsiveGridLayout`
             labelspanl = `4`
             labelspanm = `4`
             )->content( ns = `form`
                 )->label( text = `Clearing with Customer`
                 )->checkbox( text = `Option`
                 )->checkbox( text     = `Option 2`
                              selected = abap_true )->get(
                     )->layout_data(
                         )->grid_data( linebreak = abap_true
                                       indentl   = `4`
                                       indentm   = `4` )->get_parent( )->get_parent(
                 )->checkbox( id   = `focusMe`
                              text = `Option 3` )->get(
                     )->layout_data(
                         )->grid_data( linebreak = abap_true
                                       indentl   = `4`
                                       indentm   = `4` )->get_parent( )->get_parent(
                 )->checkbox( text     = `Checkbox with wrapping='true' and long text placed in a form`
                              wrapping = abap_true
                              width    = `200px` )->get(
                     )->layout_data(
                         )->grid_data( linebreak = abap_true
                                       indentl   = `4`
                                       indentm   = `4` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'POPOVER'.
        z2ui5_display_popover( `hint_icon` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Checkboxes allow users to select a subset of options. If you want to offer an off/on setting you should use the Switch control instead.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

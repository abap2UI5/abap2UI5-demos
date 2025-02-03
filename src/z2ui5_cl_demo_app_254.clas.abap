CLASS z2ui5_cl_demo_app_254 DEFINITION
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



CLASS z2ui5_cl_demo_app_254 IMPLEMENTATION.


  METHOD display_view.

    DATA css TYPE string.
    css = `.nestedFlexboxes .item1 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #d1dbbd;` &&
                `}`                              &&
                `.nestedFlexboxes .item2 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #7D8A2E;` &&
                `}`                              &&
                `.nestedFlexboxes .item3 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #C9D787;` &&
                `}`                              &&
                `.nestedFlexboxes .item4 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #FFFFFF;` &&
                `}`                              &&
                `.nestedFlexboxes .item5 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #FFC0A9;` &&
                `}`                              &&
                `.nestedFlexboxes .item6 {`      &&
                `    padding: 1rem;`             &&
                `    background-color: #FF8598;` &&
                `}`                              &&
      `.nestedFlexboxes h2 {`          &&
                `    color: #32363a;`            &&
                `}`.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( name = `style`
                    ns   = `html` )->_cc_plain_xml( css )->get_parent( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
         )->page(
            title          = `abap2UI5 - Sample: Flex Box - Nested`
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.FlexBox/sample/sap.m.sample.FlexBoxNested' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->hbox(
                          fitcontainer = `abap_true`
                          alignitems   = `Stretch`
                          class        = `sapUiSmallMargin nestedFlexboxes`
                          )->html( content = `<h2>1</h2>`
                              )->layout_data( ns = `core`
                                  )->flex_item_data( growfactor = `2`
                                                     styleclass = `item1` )->get_parent( )->get_parent(
                          )->html( content = `<h2>2</h2>`
                              )->layout_data( ns = `core`
                                  )->flex_item_data( growfactor = `3`
                                                     styleclass = `item2` )->get_parent( )->get_parent(
      )->vbox( fitcontainer = abap_false
                              )->layout_data(
                                  )->flex_item_data( growfactor = `7` )->get_parent(
      )->html( content = `<h2>3</h2>`
                                  )->layout_data( ns = `core`
                                      )->flex_item_data( growfactor = `5`
                                                         styleclass = `item3` )->get_parent( )->get_parent(
      )->hbox( fitcontainer = `abap_true`
               alignitems   = `Stretch`
                                  )->layout_data(
                                      )->flex_item_data( growfactor = `3` )->get_parent(
      )->html( content = `<h2>4</h2>`
                                          )->layout_data( ns = `core`
                                              )->flex_item_data( growfactor = `1`
                                                                 styleclass = `item4` )->get_parent( )->get_parent(
                                      )->html( content = `<h2>5</h2>`
                                          )->layout_data( ns = `core`
                                              )->flex_item_data( growfactor = `1`
                                                                 styleclass = `item5` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->html( content = `<h2>6</h2>`
                              )->layout_data( ns = `core`
                                  )->flex_item_data( growfactor = `5`
                                                     styleclass = `item6` )->get_parent( )->get_parent( ).

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
                                  description = `Flex Boxes can be nested. Remember also that HBox and VBox are 'convenience' controls based on the Flex Box control.` ).

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

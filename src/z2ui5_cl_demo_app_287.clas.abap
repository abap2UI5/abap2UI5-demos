CLASS z2ui5_cl_demo_app_287 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_name,
        title         TYPE string,
        desc          TYPE string,
        icon          TYPE string,
        highlight     TYPE string,
        info          TYPE string,
        wrapcharlimit TYPE i,
      END OF ty_name .

    TYPES temp1_96506d4817 TYPE TABLE OF ty_name.
DATA lt_o_model TYPE temp1_96506d4817.
    DATA check_initialized TYPE abap_bool.

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



CLASS z2ui5_cl_demo_app_287 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Standard List Item - Wrapping'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.StandardListItem/sample/sap.m.sample.StandardListItemWrapping' ).

    page->list(
           id         = `myList`
           mode       = `MultiSelect`
           headertext = `Wrapping texts`
           items      = client->_bind( lt_o_model )
           )->items(
               )->standard_list_item(
                   title         = '{TITLE}'
                   description   = '{DESC}'
                   icon          = '{ICON}'
                   iconinset     = abap_false
                   highlight     = '{HIGHLIGHT}'
                   info          = '{INFO}'
                   infostate     = '{HIGHLIGHT}'
                   type          = `Detail`
                   wrapping      = abap_true
                   wrapcharlimit = '{WRAPCHARLIMIT}' ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This sample demonstrates the wrapping behavior of the title text and the description text. ` &&
                                                `In desktop mode, the character limit is set to 300 characters, whereas in the phone mode, the character limit is set to 100 characters.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).

      DATA temp1 LIKE lt_o_model.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = `wrapCharLimit is set to Default. Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
`At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`.
      temp2-desc = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
`At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`.
      temp2-icon = `sap-icon://favorite`.
      temp2-highlight = `Success`.
      temp2-info = `Completed`.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = `wrapCharLimit is set to 100. Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
`At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.`.
      temp2-desc = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.`.
      temp2-icon = `sap-icon://employee`.
      temp2-highlight = `Error`.
      temp2-info = `Incomplete`.
      temp2-wrapcharlimit = 100.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = `Title text`.
      temp2-desc = `Description text`.
      temp2-icon = `sap-icon://accept`.
      temp2-highlight = `Information`.
      temp2-info = `Information`.
      temp2-wrapcharlimit = 10.
      INSERT temp2 INTO TABLE temp1.
      lt_o_model = temp1.
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

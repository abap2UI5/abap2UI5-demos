CLASS z2ui5_cl_demo_app_291 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.
    DATA lv_default TYPE string.
    DATA lv_error   TYPE string.
    DATA lv_warning TYPE string.
    DATA lv_success TYPE string.

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



CLASS z2ui5_cl_demo_app_291 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Message Strip with enableFormattedText'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.MessageStrip/sample/sap.m.sample.MessageStripWithEnableFormattedText' ).

    page->vertical_layout(
           class = `sapUiContentPadding`
           width = `100%`
           )->content( ns = `layout`
      )->message_strip(
                  text                = client->_bind( lv_default )
                  enableformattedtext = abap_true
                  showicon            = abap_true
                  showclosebutton     = abap_true
                  class               = `sapUiMediumMarginBottom`
      )->message_strip(
                  text                = client->_bind( lv_error )
                  type                = `Error`
                  enableformattedtext = abap_true
                  showicon            = abap_true
                  showclosebutton     = abap_true
                  class               = `sapUiMediumMarginBottom`
      )->message_strip(
                  text                = client->_bind( lv_warning )
                  type                = `Warning`
                  enableformattedtext = abap_true
                  showicon            = abap_true
                  showclosebutton     = abap_true
                  class               = `sapUiMediumMarginBottom`
      )->message_strip(
                  text                = client->_bind( lv_success )
                  type                = `Success`
                  enableformattedtext = abap_true
                  showicon            = abap_true
                  showclosebutton     = abap_true
                  class               = `sapUiMediumMarginBottom` ).

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
                                  description = `A sample MessageStrip that shows status messages with additional formatting.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).

      lv_default = `Default <em>(Information)</em> with default icon and <strong>close button</strong>:`.
      lv_error   = `<strong>Error</strong> with link to ` && `<a target="_blank" href="http://www.sap.com">SAP Homepage</a> <em>(For more info)</em>`.
      lv_warning = `<strong>Warning</strong> with default icon and close button:`.
      lv_success = `<strong>Success</strong> with default icon and close button:`.

    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

CLASS z2ui5_cl_demo_app_272 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

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



CLASS z2ui5_cl_demo_app_272 IMPLEMENTATION.


  METHOD display_view.

    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Object Header - with Circle-shaped Image'
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
           href   = base_url && 'sdk/#/entity/sap.m.ObjectHeader/sample/sap.m.sample.ObjectHeaderCircleImage' ).

    page->object_header(
           icon             = base_url && `test-resources/sap/m/images/Woman_04.png`
           icondensityaware = abap_false
           iconalt          = `Denise Smith`
           imageshape       = `Circle`
           responsive       = abap_true
           title            = `Denise Smith`
           intro            = `Senior Developer`
           class            = `sapUiResponsivePadding--header`
             )->object_attribute( title  = `Email address`
                                  text   = `DeniseSmith@sap.com`
                                  active = abap_true
             )->object_attribute( title = `Office Phone`
                                  text  = `+33 6 453 564`
             )->object_attribute( title = `Functional Area`
                                  text  = `Development` ).

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
                                  description = `An Object Header can set shape of the image by using 'imageShape' property.`                      &&
                                                `The shapes could be Square (by default) and Circle.`                                              &&
                                                `Note: This example shows the image inside ObjectHeader with the responsive property set to true.` &&
                                                `On phone in portrait mode, the image is hidden.` ).

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

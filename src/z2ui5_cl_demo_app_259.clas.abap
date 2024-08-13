class z2ui5_cl_demo_app_259 definition
  public
  create public .

public section.

  interfaces Z2UI5_IF_APP .

  data CHECK_INITIALIZED type ABAP_BOOL .
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



CLASS z2ui5_cl_demo_app_259 IMPLEMENTATION.


  METHOD DISPLAY_VIEW.

    DATA(page_01) = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Button`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    page_01->header_content(
       )->button( id = `hint_icon`
           icon = `sap-icon://hint`
           tooltip = `Sample information`
           press = client->_event( 'POPOVER' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/#/entity/sap.m.Button/sample/sap.m.sample.Button' ).


    page_01->_generic_property( VALUE #( n = `core:require` v = `{ MessageToast: 'sap/m/MessageToast' }` ) ).

    DATA(page_02) = page_01->page(
                             title = `Page`
                             class = `sapUiContentPadding`
                             )->custom_header(
                                 )->toolbar(
                                     )->button( type = `Back` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                     )->toolbar_spacer(
                                     )->title( text = `Title` level = `H2`
                                     )->toolbar_spacer(
                                     )->button( icon = `sap-icon://edit` type = `Transparent` press = `MessageToast.show( ${$source>/id} + ' Pressed' )` arialabelledby = `editButtonLabel` )->get_parent( )->get_parent(

                             )->sub_header(
                                 )->toolbar(
                                     )->toolbar_spacer(
                                     )->button( text = `Default` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                     )->button( type = `Reject` text = `Reject` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                     )->button( icon = `sap-icon://action` type = `Transparent` press = `MessageToast.show( ${$source>/id} + ' Pressed' )` ariaLabelledBy = `actionButtonLabel`
                                     )->toolbar_spacer(  )->get_parent( )->get_parent(

                             )->content(
                                 )->hbox(
                                     )->button( text = `Default`
                                                press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                                ariadescribedby = `defaultButtonDescription genericButtonDescription` )->get(
                                         )->layout_data(
                                             )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                     )->button( type = `Accept`
                                                text = `Accept`
                                                press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                                ariadescribedby = `acceptButtonDescription genericButtonDescription` )->get(
                                         )->layout_data(
                                             )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                     )->button( type = `Reject`
                                                text = `Reject`
                                                press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                                ariadescribedby = `rejectButtonDescription genericButtonDescription` )->get(
                                         )->layout_data(
                                             )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                     )->button( text = `Coming Soon`
                                                press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                                ariadescribedby = `comingSoonButtonDescription genericButtonDescription`
                                                enabled = abap_false )->get(
                                         )->layout_data(
                                             )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent( )->get_parent(

                                 " Collection of labels (some of which are invisible) used to provide ARIA descriptions for the buttons
                                 )->label( id = `genericButtonDescription` text = `Note: The buttons in this sample display MessageToast when pressed.`

                                 )->invisible_text( ns = `core` id = `defaultButtonDescription` text = `Description of default button goes here.` )->get_parent(
                                 )->invisible_text( ns = `core` id = `acceptButtonDescription` text = `Description of accept button goes here.` )->get_parent(
                                 )->invisible_text( ns = `core` id = `rejectButtonDescription` text = `Description of reject button goes here.` )->get_parent(
                                 )->invisible_text( ns = `core` id = `comingSoonButtonDescription` text = `This feature is not active just now.` )->get_parent(
                                 " These labels exist only to provide targets for the ARIA label on the Edit and Action buttons
                                 )->invisible_text( ns = `core` id = `editButtonLabel` text = `Edit Button Label` )->get_parent(
                                 )->invisible_text( ns = `core` id = `actionButtonLabel` text = `Action Button Label` )->get_parent( )->get_parent(

                             )->footer(
                                 )->toolbar(
                                     )->toolbar_spacer(
                                     )->button( type = `Emphasized` text = `Emphasized` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                     )->button( text = `Default` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                                     )->button( icon = `sap-icon://action` type = `Transparent` press = `MessageToast.show( ${$source>/id} + ' Pressed' )`
                    ).

    client->view_display( page_02->stringify( ) ).

  ENDMETHOD.


  METHOD ON_EVENT.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'POPOVER'.
        z2ui5_display_popover( `hint_icon` ).
    ENDCASE.

  ENDMETHOD.


  METHOD Z2UI5_DISPLAY_POPOVER.

    DATA(view) = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom` width = `auto`
              )->quick_view_page( pageid = `sampleInformationId`
                                  header = `Sample information`
                                  description = `Buttons trigger user actions and come in a variety of shapes and colors. Placing a button on a page header or footer changes its appearance.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id
    ).

  ENDMETHOD.


  METHOD Z2UI5_IF_APP~MAIN.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

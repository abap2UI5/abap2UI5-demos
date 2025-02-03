CLASS z2ui5_cl_demo_app_250 DEFINITION
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



CLASS z2ui5_cl_demo_app_250 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: OverflowToolbar - Alignment'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page_01->header_content(
       )->button( id = `hint_icon`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'POPOVER' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.OverflowToolbar/sample/sap.m.sample.ToolbarAlignment' ).

    DATA page_02 TYPE REF TO z2ui5_cl_xml_view.
    page_02 = page_01->page(
                         )->invisible_text( ns   = `core`
                                            id   = `inputLabel`
                                            text = `Input label` )->get_parent(
          )->message_strip( text  = `Left and Right aligned content.`
                            class = `sapUiTinyMargin`
                         )->overflow_toolbar( class = `sapUiMediumMarginTop`
                             )->button( text = `Reject`
                                        type = `Reject`
                             )->toolbar_spacer(
                             )->button( text = `Accept`
                                        type = `Accept` )->get_parent(
          )->message_strip( text  = `Centered content.`
                            class = `sapUiTinyMargin`
                             )->overflow_toolbar( class = `sapUiMediumMarginTop`
                                 )->toolbar_spacer(
                                 )->button( text = `Centered content`
                                            type = `Accept`
                                 )->toolbar_spacer( )->get_parent(
          )->message_strip( text  = `Right aligned content.`
                            class = `sapUiTinyMargin`
                         )->overflow_toolbar( class = `sapUiMediumMarginTop`
                             )->toolbar_spacer(
                             )->button( text = `Right aligned content`
                                        type = `Accept` )->get_parent(
          )->message_strip( text  = `You can have as many sections as you want with ToolbarSpacer.`
                            class = `sapUiTinyMargin`
                             )->overflow_toolbar( class = `sapUiMediumMarginTop`
                                 )->button( text = `Accept`
                                            type = `Accept`
                                 )->toolbar_spacer(
                                 )->checkbox( text = `CheckBox`
                                 )->toolbar_spacer(
                                 )->button( tooltip = `Dropdown`
                                            icon    = `sap-icon://drop-down-list`
                                 )->toolbar_spacer(
                                 )->radio_button( text = `RadioButton` )->get_parent(
                                 )->toolbar_spacer(
                                 )->button( text = `Reject`
                                            type = `Reject` )->get_parent(
          )->message_strip( text  = `Flexible Toolbar Spacers share the free horizontal space equally, thus content centering is not as precise as in Bar.`
                            class = `sapUiTinyMargin`
                             )->overflow_toolbar( class = `sapUiMediumMarginTop`
                                 )->button( text = `This is a very long button text. This is a very long button text.`
                                 )->toolbar_spacer(
                                 )->button( text = `Centered Button`
                                 )->toolbar_spacer(
                                 )->button( text = `Short Button` )->get_parent(
          )->message_strip( text  = `ToolbarSpacer does not have to be flexible, a fixed width can be specified too.`
                            class = `sapUiTinyMargin`
                         )->overflow_toolbar( class = `sapUiMediumMarginTop`
                             )->input( arialabelledby = `inputLabel`
                                       width          = `100px`
                                       placeholder    = `First Name`
                             )->input( arialabelledby = `inputLabel`
                                       width          = `100px`
                                       placeholder    = `Last Name`
                             )->toolbar_spacer( width = `40px`
                             )->input( arialabelledby = `inputLabel`
                                       type           = `Email`
                                       width          = `100px`
                                       placeholder    = `Email`
                             )->input( arialabelledby = `inputLabel`
                                       type           = `Number`
                                       width          = `80px`
                                       placeholder    = `Age`
                             )->toolbar_spacer(
                             )->button( text = `Submit`
                                        type = `Accept` )->get_parent( ).

    client->view_display( page_02->stringify( ) ).

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
                                  description = `OverflowToolbar and Toolbar are often used for left/right alignment. This is easily achieved with ToolbarSpacer.` ).

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

CLASS z2ui5_cl_demo_app_262 DEFINITION
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



CLASS z2ui5_cl_demo_app_262 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Numeric Content of Different Colors'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.NumericContent/sample/sap.m.sample.NumericContentDifColors' ).

    page->numeric_content( value           = `888.8`
                           scale           = `MM`
                           class           = `sapUiSmallMargin`
                             press         = client->_event( 'press' )
                           truncatevalueto = `4` ).
    page->numeric_content( value        = `65.5`
                           scale        = `MM`
                             valuecolor = `Good`
                           indicator    = `Up`
                           class        = `sapUiSmallMargin`
                             press      = client->_event( 'press' ) ).
    page->numeric_content( value        = `6666`
                           scale        = `MM`
                             valuecolor = `Critical`
                           indicator    = `Up`
                           class        = `sapUiSmallMargin`
                             press      = client->_event( 'press' ) ).
    page->numeric_content( value        = `65.5`
                           scale        = `MMill`
                             valuecolor = `Error`
                           indicator    = `Down`
                           class        = `sapUiSmallMargin`
                             press      = client->_event( 'press' ) ).
    page->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header    = `Country-Specific Profit Margin`
                        subheader = `Expenses`
                        press     = client->_event( 'press' )
             )->tile_content( unit   = `EUR`
                              footer = `Current Quarter`
                 )->numeric_content( scale      = `M`
                                     value      = `1.96`
                                     valuecolor = `Error`
                                     indicator  = `Up`
                                     withmargin = abap_false ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'press'.
        client->message_toast_display( `The numeric content is pressed.` ).
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
                                  description = `Shows NumericContent including numbers, units of measurement, and status arrows indicating a trend. ` &&
                                                `The numbers can be colored according to their meaning.` ).

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

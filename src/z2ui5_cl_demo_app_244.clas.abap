CLASS z2ui5_cl_demo_app_244 DEFINITION
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



CLASS z2ui5_cl_demo_app_244 IMPLEMENTATION.


  METHOD display_view.


    DATA css TYPE string.
    css = `.sapUiDemoFlexBoxSizeAdjustments .sapMFlexItem {`               &&
                `    border: 1px dashed #000;`                                   &&
                `    margin: 0.1875rem;`                                         &&
                `    padding: 0.1875rem;`                                        &&
                `}`                                                              &&
      `.sapUiDemoFlexBoxSizeAdjustmentsZeroWidthItems .sapMFlexItem {` &&
                `    width: 0;`                                                  &&
                `}`                                                              &&
      `.sapMFlexItem {`                                                &&
                `    position: relative;`                                        &&
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
            title          = `abap2UI5 - Sample: Flex Box - Size Adjustments`
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.FlexBox/sample/sap.m.sample.FlexBoxSizeAdjustments' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox(
                          )->panel( headertext = `Equal flexibility and content`
                                    class      = `sapUiDemoFlexBoxSizeAdjustments`
                              )->flex_box( alignitems = `Start`
                                  )->button( text  = `1`
                                             width = `100%`
                                             type  = `Emphasized`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             width = `100%`
                                             type  = `Reject`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                         )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             width = `100%`
                                             type  = `Accept` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->panel( headertext = `Different flexibility, equal content`
                class      = `sapUiDemoFlexBoxSizeAdjustments`
                              )->flex_box( alignitems = `Start`
                                  )->button( text  = `1`
                                             width = `100%`
                                             type  = `Emphasized`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             width = `100%`
                                             type  = `Reject`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                         )->flex_item_data( growfactor = `2` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             width = `100%`
                                             type  = `Accept` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `3` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->panel( headertext = `Equal flexibility, different content`
                class      = `sapUiDemoFlexBoxSizeAdjustments`
                              )->flex_box( alignitems = `Start`
                                  )->button( text  = `1`
                                             width = `50px`
                                             type  = `Emphasized`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             width = `100px`
                                             type  = `Reject`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                         )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             width = `150px`
                                             type  = `Accept` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->panel( headertext = `Equal flexibility, different content, width 0`
                class      = `sapUiDemoFlexBoxSizeAdjustments`
                              )->flex_box( alignitems = `Start`
                                           class      = `sapUiDemoFlexBoxSizeAdjustmentsZeroWidthItems`
                                  )->button( text  = `1`
                                             width = `100%`
                                             type  = `Emphasized`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             width = `100%`
                                             type  = `Reject`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                         )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             width = `100%`
                                             type  = `Accept` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->panel( headertext = `Different flexibility and content, width 0`
                class      = `sapUiDemoFlexBoxSizeAdjustments`
                              )->flex_box( alignitems = `Start`
                                           class      = `sapUiDemoFlexBoxSizeAdjustmentsZeroWidthItems`
                                  )->button( text  = `1`
                                             width = `50px`
                                             type  = `Emphasized`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             width = `100px`
                                             type  = `Reject`
                                             class = `sapUiSmallMarginEnd` )->get(
                                      )->layout_data(
                                         )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             width = `150px`
                                             type  = `Accept` )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1` )->get_parent( ).

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
                                  description = `Automatic size adjustments can be achieved for Flex Items with the use of Flex Item Data settings on the contained controls.` ).

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

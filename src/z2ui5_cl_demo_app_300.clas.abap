CLASS z2ui5_cl_demo_app_300 DEFINITION
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



CLASS z2ui5_cl_demo_app_300 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Object Status`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page_01->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.ObjectStatus/sample/sap.m.sample.ObjectStatus' ).

    page_01->vertical_layout(
              width = `100%`
               )->block_layout( background = `transparent`
                   )->block_layout_row(
                       )->block_layout_cell(
                           )->vertical_layout( class = `sapUiContentPadding`
                                               width = `100%`
                               )->label( text     = `ObjectStatus with different value states`
                                         design   = `Bold`
                                         wrapping = abap_true
                                         class    = `sapUiSmallMarginTop`
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Unknown`
                                   state = `None` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Currently closed`
                                   icon  = `sap-icon://information`
                                   state = `Information` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Product Shipped`
                                   icon  = `sap-icon://sys-enter-2`
                                   state = `Success` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Product Missing`
                                   icon  = `sap-icon://alert`
                                   state = `Warning` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Product Damaged`
                                   icon  = `sap-icon://error`
                                   state = `Error` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Product Damaged`
                                   state = `Error` )->get_parent(
                               )->object_status(
                                   class  = `sapUiSmallMarginBottom`
                                   title  = `Product status`
                                   text   = `Damaged`
                                   active = abap_true
                                   state  = `Error`
                                   press  = client->_event( `handleStatusPressed` )
                                   icon   = `sap-icon://error` )->get_parent(
                               )->object_status(
                                   class  = `sapUiSmallMarginBottom`
                                   title  = `Test`
                                   active = abap_true
                                   state  = `Error`
                                   icon   = `sap-icon://error` )->get_parent(
                           )->get_parent(
                       )->get_parent(
                       )->block_layout_cell(
                           )->vertical_layout( class = `sapUiContentPadding`
                                               width = `100%`
                               )->label( text     = `Inverted ObjectStatus with different value states.`
                                         design   = `Bold`
                                         wrapping = abap_true
                                         class    = `sapUiSmallMarginTop`
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Unknown`
                                   inverted = abap_true
                                   state    = `None` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Currently closed (click)`
                                   inverted = abap_true
                                   active   = abap_true
                                   icon     = `sap-icon://information`
                                   state    = `Information` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Product Shipped`
                                   inverted = abap_true
                                   icon     = `sap-icon://sys-enter-2`
                                   state    = `Success` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Product Missing`
                                   inverted = abap_true
                                   icon     = `sap-icon://alert`
                                   state    = `Warning` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Product Damaged`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Error`
                                   icon     = `sap-icon://error` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Error`
                                   icon     = `sap-icon://error` )->get_parent(
                           )->get_parent(
                       )->get_parent(
                   )->get_parent(
               )->get_parent( ).
    page_01->vertical_layout( class = `sapUiContentPadding`
                              width = `100%`
               )->block_layout( background = `transparent`
                   )->block_layout_row(
                       )->block_layout_cell(
                           )->label( text     = `ObjectStatus with different indication states.`
                                     design   = `Bold`
                                     wrapping = abap_true
                                     class    = `sapUiSmallMarginBottom`
                           )->vertical_layout( width = `100%`
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 1`
                                   state = `Indication01` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 2`
                                   state = `Indication02` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 3`
                                   state = `Indication03` )->get_parent(
                               )->object_status(
                                   class  = `sapUiSmallMarginBottom`
                                   text   = `Indication 4 active`
                                   active = abap_true
                                   state  = `Indication04` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 5`
                                   state = `Indication05` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 6`
                                   state = `Indication06` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 7`
                                   state = `Indication07` )->get_parent(
                               )->object_status(
                                   class = `sapUiSmallMarginBottom`
                                   text  = `Indication 8`
                                   state = `Indication08` )->get_parent(
                           )->get_parent(
                       )->get_parent(
                       )->block_layout_cell(
                           )->label( text     = `Inverted ObjectStatus with different indication states.`
                                     design   = `Bold`
                                     wrapping = abap_true
                                     class    = `sapUiSmallMarginBottom`
                           )->vertical_layout( width = `100%`
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication1`
                                   inverted = abap_true
                                   state    = `Indication01` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication2`
                                   inverted = abap_true
                                   state    = `Indication02` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication3 active`
                                   inverted = abap_true
                                   active   = abap_true
                                   state    = `Indication03` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication4`
                                   inverted = abap_true
                                   state    = `Indication04` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication5 active`
                                   inverted = abap_true
                                   active   = abap_true
                                   state    = `Indication05` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication6 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   icon     = `sap-icon://attachment`
                                   state    = `Indication06` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication7 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication07` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication8 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication08` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication9 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication09` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication10`
                                   inverted = abap_true
                                   state    = `Indication10` )->get_parent(
                           )->get_parent(
                       )->get_parent(
                       )->block_layout_cell(
                           )->vertical_layout( width = `100%`
                           )->label( text     = `Inverted ObjectStatus with different indication states.`
                                     design   = `Bold`
                                     wrapping = abap_true
                                     class    = `sapUiSmallMarginBottom`
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication11`
                                   inverted = abap_true
                                   state    = `Indication11` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication12 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication12` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication13 active`
                                   inverted = abap_true
                                   active   = abap_true
                                   state    = `Indication13` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication14 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   icon     = `sap-icon://notes`
                                   state    = `Indication14` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication15 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication15` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication16`
                                   inverted = abap_true
                                   state    = `Indication16` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication17 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication17` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication18`
                                   inverted = abap_true
                                   state    = `Indication18` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication19 active`
                                   active   = abap_true
                                   inverted = abap_true
                                   state    = `Indication19` )->get_parent(
                               )->object_status(
                                   class    = `sapUiSmallMarginBottom`
                                   text     = `Inverted Indication20`
                                   inverted = abap_true
                                   state    = `Indication20` )->get_parent(
                           )->get_parent(
                       )->get_parent(
                   )->get_parent(
               )->get_parent( ).
    page_01->vertical_layout(
              class = `sapUiContentPadding`
              width = `100%`
              )->label( text     = `ObjectStatus with style sapMObjectStatusLarge applied`
                        design   = `Bold`
                        wrapping = abap_true
                        class    = `sapUiSmallMarginTop`
              )->object_status(
                  class = `sapMObjectStatusLarge`
                  title = `Product status`
                  text  = `Shipped`
                  state = `Success`
                  icon  = `sap-icon://sys-enter-2` )->get_parent(
              )->object_status(
                  class    = `sapMObjectStatusLarge`
                  text     = `Shipped`
                  state    = `Success`
                  inverted = abap_true
                  icon     = `sap-icon://sys-enter-2` )->get_parent( ).

    page_01->vertical_layout(
              class = `sapUiContentPadding`
              width = `100%`
              )->label( text     = `ObjectStatus with and without sapMObjectStatusLongText CSS class`
                        design   = `Bold`
                        wrapping = abap_true
                        class    = `sapUiSmallMarginTop`
              )->table(
                  )->columns(
                      )->column(
                          )->text( text = `ObjectStatus with default text wrapping` )->get_parent(
                      )->column(
                          )->text( text = `ObjectStatus with enhanced text wrapping via 'sapMObjectStatusLongText' CSS class` )->get_parent(
                      )->get_parent(
                  )->column_list_item(
                      )->cells(
                          )->object_status(
                              class = ``
                              title = `Product status`
                              text  = `VeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrapping` )->get_parent(
      )->object_status(
                              class = `sapMObjectStatusLongText`
                              title = `Product status`
                              text  = `VeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrappingVeryLongTextToDemonstrateWrapping` )->get_parent(
                      )->get_parent(
                  )->get_parent(
              )->get_parent( ).
    client->view_display( page_01->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'handleStatusPressed'.
        DATA temp1 TYPE string_table.
        CLEAR temp1.
        INSERT `OK ` INTO TABLE temp1.
        client->message_box_display( title   = `Error description`
                                     type    = ``  "Keep this empty to use the custom title instead of the default message type as title
                                     text    = `Product was damaged along transportation.`
                                     actions = temp1 ). "Add space after 'OK' to prevent the button type from being 'Emphasized'
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `The object status is a small building block representing a status with a semantic color.` ).

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

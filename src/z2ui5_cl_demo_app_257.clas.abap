CLASS z2ui5_cl_demo_app_257 DEFINITION
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



CLASS z2ui5_cl_demo_app_257 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Generic Tag with Different Configurations'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.GenericTag/sample/sap.m.sample.GenericTag' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout(
                          class = `sapUiContentPadding`
                          width = `100%`
                          )->grid( class        = `sapUiSmallMarginBottom`
                                   hspacing     = `0`
                                   vspacing     = `0`
                                   default_span = `L4 M6 S12`
                                   width        = `100%`
                              )->flex_box( class          = `sapUiTinyMarginBottom`
                                           direction      = `Column`
                                           fitcontainer   = abap_true
                                           alignitems     = `Start`
                                           justifycontent = `Start`
                                  )->text( text  = `Generic Tag - KPI`
                                           class = `sapUiSmallMarginBottom`
                                  )->generic_tag( text   = `Project Cost`
                                                  design = `StatusIconHidden`
                                                  status = `Error`
                                                  class  = `sapUiSmallMarginBottom`
                                      )->object_number( state      = `Error`
                                                        emphasized = abap_false
                                                        number     = `3.5M`
                                                        unit       = `EUR` )->get_parent(
      )->generic_tag( text   = `Project Cost`
                      design = `StatusIconHidden`
                      status = `Warning`
                      class  = `sapUiSmallMarginBottom`
                                      )->object_number( state      = `Warning`
                                                        emphasized = abap_false
                                                        number     = `2.4M`
                                                        unit       = `EUR` )->get_parent(
      )->generic_tag( text   = `Project Cost`
                      design = `StatusIconHidden`
                      status = `Success`
                      class  = `sapUiSmallMarginBottom`
                                      )->object_number( state      = `Success`
                                                        emphasized = abap_false
                                                        number     = `1.6M`
                                                        unit       = `EUR` )->get_parent(
      )->generic_tag( text   = `PC`
                      design = `StatusIconHidden`
                      status = `Error`
                      class  = `sapUiSmallMarginBottom`
                                      )->object_number( state      = `Error`
                                                        emphasized = `false`
                                                        number     = `35`
                                                        unit       = `%` )->get_parent(
      )->generic_tag( text   = `PC`
                      design = `StatusIconHidden`
                      status = `Warning`
                      class  = `sapUiSmallMarginBottom`
                                       )->object_number( state      = `Warning`
                                                         emphasized = abap_false
                                                         number     = `71`
                                                         unit       = `%` )->get_parent(
      )->generic_tag( text   = `PC`
                      design = `StatusIconHidden`
                      status = `Success`
                      class  = `sapUiSmallMarginBottom`
                                      )->object_number( state      = `Success`
                                                        emphasized = abap_false
                                                        number     = `96`
                                                        unit       = `%` )->get_parent( )->get_parent(
                              )->flex_box( direction      = `Column`
                                           fitcontainer   = `true`
                                           alignitems     = `Start`
                                           justifycontent = `Start`
                                  )->text( text  = `Generic Tag - KPI (error handling)`
                                           class = `sapUiSmallMarginBottom`
                                  )->generic_tag( text       = `Project Cost`
                                                  design     = `StatusIconHidden`
                                                  status     = `Error`
                                                  valuestate = `Error`
                                                  class      = `sapUiSmallMarginBottom` )->get_parent( )->get_parent(
                              )->flex_box( direction      = `Column`
                                           fitcontainer   = abap_true
                                           alignitems     = `Start`
                                           justifycontent = `Start`
                                  )->text( text  = `Generic Tag - Situation`
                                           class = `sapUiSmallMarginBottom`
                                  )->generic_tag( text   = `Shortage Expected`
                                                  status = `Warning`
                                                  class  = `sapUiSmallMarginBottom` )->get_parent(
                                  )->generic_tag( text   = `Material Shortage`
                                                  status = `Warning`
                                                  class  = `sapUiSmallMarginBottom` )->get_parent( )->get_parent(
                              )->flex_box( direction      = `Column`
                                           fitcontainer   = abap_true
                                           alignitems     = `Start`
                                           justifycontent = `Start`
                                  )->text( text  = `Generic Tag with label`
                                           id    = `genericTagLabel`
                                           class = `sapUiSmallMarginBottom`
                                  )->generic_tag( arialabelledby = `genericTagLabel`
                                                  text           = `Project Cost`
                                                  design         = `StatusIconHidden`
                                                  status         = `Error`
                                                  class          = `sapUiSmallMarginBottom`
                                  )->object_number( state      = `Error`
                                                    emphasized = `false`
                                                    number     = `3.5M`
                                                    unit       = `EUR` ).

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
                                  description = `Previews of the GenericTag control based on combinations of different sets of properties.` ).

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

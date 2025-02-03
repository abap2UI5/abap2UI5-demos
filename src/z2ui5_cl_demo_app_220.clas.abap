CLASS z2ui5_cl_demo_app_220 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_220 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Rating Indicator'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding` ).
    layout->label( text     = `Rating Indicator default size`
                   labelfor = `RI_default` ).
    layout->rating_indicator( id       = `RI_default`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator with size L`
                   labelfor = `RI_L` ).
    layout->rating_indicator( id       = `RI_L`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              iconsize = `32px`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator with size M`
                   labelfor = `RI_M` ).
    layout->rating_indicator( id       = `RI_M`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              iconsize = `22px`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator with size S`
                   labelfor = `RI_S` ).
    layout->rating_indicator( id       = `RI_S`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              iconsize = `16px`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator with size XS`
                   labelfor = `RI_XS` ).
    layout->rating_indicator( id       = `RI_XS`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              iconsize = `12px`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator with non active state`
                   labelfor = `RI_EnabledFalse` ).
    layout->rating_indicator( id       = `RI_EnabledFalse`
                              maxvalue = `5`
                              enabled  = `false`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              iconsize = `12px`
                              tooltip  = `Rating Tooltip` ).

    layout->label( text     = `Rating Indicator display only`
                   labelfor = `RI_display_only` ).
    layout->rating_indicator( id          = `RI_display_only`
                              maxvalue    = `5`
                              class       = `sapUiSmallMarginBottom`
                              value       = `4`
                              tooltip     = `Rating Tooltip`
                              displayonly = abap_true ).

    layout->label( text     = `Rating Indicator readonly mode`
                   labelfor = `RI_read_only` ).
    layout->rating_indicator( id       = `RI_read_only`
                              maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              tooltip  = `Rating Tooltip`
                              editable = `false` ).

    layout->label( text     = `Rating Indicator with different maxValue`
                   labelfor = `RI_maxValue` ).
    layout->rating_indicator( id       = `RI_maxValue`
                              maxvalue = `8`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              tooltip  = `Rating Tooltip` ).
    layout->rating_indicator( maxvalue = `7`
                              class    = `sapUiSmallMarginBottom`
                              value    = `4`
                              tooltip  = `Rating Tooltip` ).
    layout->rating_indicator( maxvalue = `6`
                              class    = `sapUiSmallMarginBottom`
                              value    = `3`
                              tooltip  = `Rating Tooltip` ).
    layout->rating_indicator( maxvalue = `5`
                              class    = `sapUiSmallMarginBottom`
                              value    = `2` ).
    layout->rating_indicator( maxvalue = `4`
                              class    = `sapUiSmallMarginBottom`
                              value    = `2` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

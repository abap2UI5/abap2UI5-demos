CLASS z2ui5_cl_demo_app_209 DEFINITION
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



CLASS Z2UI5_CL_DEMO_APP_209 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: InfoLabel'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->scroll_container( vertical = abap_true
                                           height   = `100%`
                   )->flex_box( direction  = `Column`
                                alignitems = `Start`
                                class      = `sapUiMediumMargin`
                   )->flex_box( direction  = `Row`
                                alignitems = `Start`
                                class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 1`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il1`
                                  text        = `2`
                                  rendermode  = `Narrow`
                                  colorscheme = `1` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 2`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il2`
                                  text        = `5`
                                  rendermode  = `Narrow`
                                  colorscheme = `2` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 3`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il3`
                                  text        = `12.5`
                                  rendermode  = `Narrow`
                                  colorscheme = `3` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 4`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il4`
                                  text        = `2K`
                                  rendermode  = `Narrow`
                                  colorscheme = `4` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 5`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il5`
                                  text        = `text info label`
                                  rendermode  = `Loose`
                                  colorscheme = `5` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 6`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il6`
                                  text        = `just a long info label`
                                  colorscheme = `6`
                                  width       = `140px` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 7`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il7`
                                  text        = `label shorter than width`
                                  colorscheme = `7`
                                  width       = `250px` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 8`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il8`
                                  text        = `with icon`
                                  colorscheme = `8`
                                  icon        = `sap-icon://home-share` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Color Scheme 9`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il9`
                                  text        = `in warehouse`
                                  colorscheme = `9` )->get_parent( )->get_parent(
      )->flex_box( direction  = `Row`
                   alignitems = `Start`
                   class      = `sapUiTinyMarginBottom`
                   )->text( text  = `Any Color Scheme in Display Only Mode`
                            class = `sapUiTinyMarginEnd`
                   )->info_label( id          = `il10`
                                  text        = `display only in form`
                                  colorscheme = `1`
                                  displayonly = abap_true ).

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

CLASS z2ui5_cl_demo_app_235 DEFINITION
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



CLASS z2ui5_cl_demo_app_235 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Toolbar vs Bar vs OverflowToolbar'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA page_02 TYPE REF TO z2ui5_cl_xml_view.
    page_02 = page_01->page(
                         title         = `Bar can center a Title.`
                         titlelevel    = `H2`
                         class         = `sapUiContentPadding`
                         shownavbutton = abap_true
                         )->header_content(
                             )->button( icon = `sap-icon://action` )->get_parent(
                         )->sub_header(
                             )->toolbar(
                                 )->button( type    = `Back`
                                            tooltip = `Back`
                                 )->toolbar_spacer(
                                 )->title( text  = `Toolbar center`
                                           level = `H3`
                                 )->toolbar_spacer( )->get_parent( )->get_parent(
                         )->content(
                             )->message_strip( text  = `A Toolbar's centering technique will be slightly off the center if there is a button on the left.`
                                               class = `sapUiTinyMargin`
                             )->toolbar(
                                 )->label( text = `Toolbar can shrink content in case of overflow.`
                                     )->layout_data(
                                         )->toolbar_layout_data( shrinkable = abap_false )->get_parent( )->get_parent(
                                 )->button( text = `Accept`
                                            type = `Accept`
                                     )->layout_data(
                                         )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent(
                                 )->label( text = `This is a long non-shrinkable label.`
                                     )->layout_data(
                                         )->toolbar_layout_data( shrinkable = abap_false )->get_parent( )->get_parent(
                                 )->button( text = `Reject`
                                            type = `Reject`
                                     )->layout_data(
                                         )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent(
                                 )->button( text = `Big Big Big Big Big Big Big Big Button`
                                     )->layout_data(
                                         )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent( )->get_parent(
          )->label(
                                 )->bar(
                                     )->content_left(
                                         )->label( text = `Bar cannot really handle overflow it just cuts the content.` )->get_parent(
                                     )->content_middle(
                                         )->button( text = `Accept`
                                                    type = `Accept`
                                         )->label( text = `This is a long non-shrinkable label.`
                                         )->button( text = `Reject`
                                                    type = `Reject`
                                         )->button( text = `Edit`
                                         )->button( text = `Big Big Big Big Big Big Big Big Button` )->get_parent( )->get_parent(
          )->label(
                                 )->overflow_toolbar(
                                     )->label( text = `OverflowToolbar provides a See more (...) button for overflow.`
                                         )->layout_data(
                                             )->toolbar_layout_data( shrinkable = abap_false )->get_parent( )->get_parent(
                                     )->button( text = `Accept`
                                                type = `Accept`
                                         )->layout_data(
                                             )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent(
                                     )->label( text = `This is a long non-shrinkable label.`
                                         )->layout_data(
                                             )->toolbar_layout_data( shrinkable = abap_false )->get_parent( )->get_parent(
                                     )->button( text = `Reject`
                                                type = `Reject`
                                         )->layout_data(
                                             )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent(
                                     )->button( text = `Big Big Big Big Big Big Big Big Button`
                                         )->layout_data(
                                             )->toolbar_layout_data( shrinkable = abap_true )->get_parent( )->get_parent( )->get_parent( )->get_parent(
          )->footer(
                             )->toolbar( ).

    client->view_display( page_02->stringify( ) ).

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

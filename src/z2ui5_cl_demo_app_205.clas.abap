CLASS z2ui5_cl_demo_app_205 DEFINITION
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



CLASS z2ui5_cl_demo_app_205 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Flex Box - Basic Alignment`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox(
                   )->panel( headertext = `Upper left`
                   )->flex_box( height         = `100px`
                                alignitems     = `Start`
                                justifycontent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Upper center`
                   )->flex_box( height         = `100px`
                                alignitems     = `Start`
                                justifycontent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Upper right`
                   )->flex_box( height         = `100px`
                                alignitems     = `Start`
                                justifycontent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle left`
                   )->flex_box( height         = `100px`
                                alignitems     = `Center`
                                justifycontent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle center`
                   )->flex_box( height         = `100px`
                                alignitems     = `Center`
                                justifycontent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle right`
                   )->flex_box( height         = `100px`
                                alignitems     = `Center`
                                justifycontent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower left`
                   )->flex_box( height         = `100px`
                                alignitems     = `End`
                                justifycontent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower center`
                   )->flex_box( height         = `100px`
                                alignitems     = `End`
                                justifycontent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower right`
                   )->flex_box( height         = `100px`
                                alignitems     = `End`
                                justifycontent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` ).

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

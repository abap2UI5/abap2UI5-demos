CLASS z2ui5_cl_demo_app_062 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_062 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Generic Tag Example'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).
    layout->generic_tag(
            arialabelledby = 'genericTagLabel'
            text           = 'Project Cost'
            design         = 'StatusIconHidden'
            status         = 'Error'
            class          = 'sapUiSmallMarginBottom'
        )->object_number(
            state      = 'Error'
            emphasized = 'false'
            number     = '3.5M'
            unit       = 'EUR' ).

    layout->generic_tag(
        arialabelledby = 'genericTagLabel'
        text           = 'Project Cost'
        design         = 'StatusIconHidden'
        status         = 'Success'
        class          = 'sapUiSmallMarginBottom'
        )->object_number(
            state      = 'Success'
            emphasized = 'false'
            number     = '3.5M'
            unit       = 'EUR' ).

    layout->generic_tag(
        arialabelledby = 'genericTagLabel'
        text           = 'Input'
        design         = 'StatusIconHidden'
        class          = 'sapUiSmallMarginBottom'
        )->object_number(
            emphasized = 'true'
            number     = '3.5M'
            unit       = 'EUR' ).

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

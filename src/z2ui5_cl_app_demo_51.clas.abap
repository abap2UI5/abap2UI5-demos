CLASS z2ui5_cl_app_demo_51 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF screen,
        input1 TYPE string,
        input2 TYPE string,
        input3 TYPE string,
      END OF screen.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.

    METHODS z2ui5_on_rendering
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_init.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_app_demo_51 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z2UI5_CL_APP_DEMO_02->Z2UI5_IF_APP~MAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      z2ui5_on_rendering( client ).
    ENDIF.

    z2ui5_on_event( client ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_02->Z2UI5_ON_EVENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'BUTTON_SEND'.
        client->message_box_display( 'success - values send to the server' ).
      WHEN 'BUTTON_CLEAR'.
        CLEAR screen.
        client->message_toast_display( 'View initialized' ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_02->Z2UI5_ON_INIT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_init.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_02->Z2UI5_ON_RENDERING
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_rendering.

    DATA(page) = z2ui5_cl_xml_view=>factory( client )->shell(
         )->page(
            title          = 'abap2UI5 - Label Example'
            navbuttonpress = client->_event( 'BACK' )
              shownavbutton = abap_true ).

    page->header_content(
         )->link( text = 'Source_Code'  target = '_blank' href = page->hlp_get_source_code_url(  )
         )->get_parent( ).

    DATA(layout) = page->vertical_layout( class  = `sapUiContentPadding` width = `100%` ).
    layout->label( text = 'Input mandantory' labelfor = `input1` ).
    layout->input(
                id              = `input1`
                required        = abap_true
*                value           = client->_bind_edit( screen-input1 )
                ).


    layout->label( text = 'Input bold' labelfor = `input2` design = `Bold` ).
    layout->input(
                id              = `input2`
                value           = client->_bind_edit( screen-input2 ) ).

    layout->label( text = 'Input normal' labelfor = `input3` ).
    layout->input(
                id              = `input3`
                value           = client->_bind_edit( screen-input2 ) ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.

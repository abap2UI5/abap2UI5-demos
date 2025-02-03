CLASS z2ui5_cl_demo_app_264 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_a_data,
           label       TYPE string,
           value_state TYPE string,
         END OF ty_a_data .

    TYPES temp1_389dcc5619 TYPE STANDARD TABLE OF ty_a_data.
DATA
      lt_a_data TYPE temp1_389dcc5619 .
    DATA ls_a_data TYPE ty_a_data .
    DATA s_text TYPE string .
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



CLASS z2ui5_cl_demo_app_264 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Step Input - Value States'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.StepInput/sample/sap.m.sample.StepInputValueState' ).

    page->flex_box( items     = client->_bind( lt_a_data )
                    direction = `Column`
              )->vbox( class = `sapUiTinyMargin`
                  )->label( text     = '{LABEL}'
                            labelfor = `SI`
                  )->step_input(
                      id         = `SI`
                      width      = `100%`
                      value      = `5`
                      valuestate = '{VALUE_STATE}' ).

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
                                  description = `This example shows different StepInput value states.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    FIELD-SYMBOLS <fs_a_data> TYPE ty_a_data.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).

      s_text = 'StepInput with valueState '.

      DATA temp1 LIKE lt_a_data.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-value_state = 'None'.
      INSERT temp2 INTO TABLE temp1.
      temp2-value_state = 'Information'.
      INSERT temp2 INTO TABLE temp1.
      temp2-value_state = 'Success'.
      INSERT temp2 INTO TABLE temp1.
      temp2-value_state = 'Warning'.
      INSERT temp2 INTO TABLE temp1.
      temp2-value_state = 'Error'.
      INSERT temp2 INTO TABLE temp1.
      lt_a_data = temp1.

      " Use field symbols to concatenate the string and store it in the label column


      LOOP AT lt_a_data ASSIGNING <fs_a_data>.
        <fs_a_data>-label = s_text && ` ` && <fs_a_data>-value_state.
      ENDLOOP.
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.

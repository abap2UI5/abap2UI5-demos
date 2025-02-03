CLASS z2ui5_cl_demo_app_294 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_a_data,
        label            TYPE string,
        value_state      TYPE string,
        value_state_text TYPE string,
      END OF ty_a_data.

    TYPES temp1_2fb714d2bc TYPE STANDARD TABLE OF ty_a_data.
DATA lt_a_data TYPE temp1_2fb714d2bc.
    DATA s_text TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS z2ui5_set_data.
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



CLASS z2ui5_cl_demo_app_294 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Date Picker - Value States'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.DatePicker/sample/sap.m.sample.DatePickerValueState' ).

    page->flex_box( items     = client->_bind( lt_a_data )
                    direction = `Column`
             )->vbox( class = `sapUiTinyMargin`
                 )->label( text     = '{LABEL}'
                           labelfor = `SI`
                 )->date_picker(
                     id             = `DP`
                     width          = `100%`
                     valuestate     = '{VALUE_STATE}'
                     valuestatetext = '{VALUE_STATE_TEXT}' )->get_parent(
             )->get_parent( ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This example shows different DatePicker value states.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
      z2ui5_set_data( ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.


  METHOD z2ui5_set_data.

    CLEAR s_text.
    CLEAR lt_a_data.

    s_text = 'DatePicker with valueState '.

    " Append entries to the internal table
    DATA temp1 TYPE z2ui5_cl_demo_app_294=>ty_a_data.
    CLEAR temp1.
    temp1-label = s_text && 'None'.
    temp1-value_state = 'None'.
    APPEND temp1 TO lt_a_data.

    DATA temp2 TYPE z2ui5_cl_demo_app_294=>ty_a_data.
    CLEAR temp2.
    temp2-label = s_text && 'Information'.
    temp2-value_state = 'Information'.
    APPEND temp2 TO lt_a_data.

    DATA temp3 TYPE z2ui5_cl_demo_app_294=>ty_a_data.
    CLEAR temp3.
    temp3-label = s_text && 'Success'.
    temp3-value_state = 'Success'.
    APPEND temp3 TO lt_a_data.

    DATA temp4 TYPE z2ui5_cl_demo_app_294=>ty_a_data.
    CLEAR temp4.
    temp4-label = s_text && 'Warning and long valueStateText'.
    temp4-value_state = 'Warning'.
    temp4-value_state_text = 'Warning message. This is an extra long text used as a warning message. ' && 'It illustrates how the text wraps into two or more lines without truncation to show the full length of the message.'.
    APPEND temp4 TO lt_a_data.

    DATA temp5 TYPE z2ui5_cl_demo_app_294=>ty_a_data.
    CLEAR temp5.
    temp5-label = s_text && 'Error'.
    temp5-value_state = 'Error'.
    APPEND temp5 TO lt_a_data.
  ENDMETHOD.
ENDCLASS.

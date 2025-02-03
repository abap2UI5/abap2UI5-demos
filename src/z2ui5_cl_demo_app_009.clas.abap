CLASS z2ui5_cl_demo_app_009 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF screen,
        color_01 TYPE string,
        color_02 TYPE string,
        color_03 TYPE string,
        city     TYPE string,
        name     TYPE string,
        lastname TYPE string,
        quantity TYPE string,
        unit     TYPE string,
      END OF screen.

    TYPES:
      BEGIN OF s_suggestion_items,
        selkz TYPE abap_bool,
        value TYPE string,
        descr TYPE string,
      END OF s_suggestion_items.
    TYPES temp1_eec7b95dcf TYPE STANDARD TABLE OF s_suggestion_items WITH DEFAULT KEY.
DATA mt_suggestion TYPE temp1_eec7b95dcf.
    TYPES temp2_eec7b95dcf TYPE STANDARD TABLE OF s_suggestion_items WITH DEFAULT KEY.
DATA mt_suggestion_sel TYPE temp2_eec7b95dcf.

    TYPES:
      BEGIN OF s_suggestion_items_city,
        value TYPE string,
        descr TYPE string,
      END OF s_suggestion_items_city.
    TYPES temp3_eec7b95dcf TYPE STANDARD TABLE OF s_suggestion_items_city WITH DEFAULT KEY.
DATA mt_suggestion_city TYPE temp3_eec7b95dcf.

    TYPES:
      BEGIN OF s_employee,
        selkz    TYPE abap_bool,
        city     TYPE string,
        nr       TYPE string,
        name     TYPE string,
        lastname TYPE string,
      END OF s_employee.
    TYPES temp4_eec7b95dcf TYPE STANDARD TABLE OF s_employee WITH DEFAULT KEY.
DATA mt_employees_sel TYPE temp4_eec7b95dcf.
    TYPES temp5_eec7b95dcf TYPE STANDARD TABLE OF s_employee WITH DEFAULT KEY.
DATA mt_employees TYPE temp5_eec7b95dcf.
    DATA check_initialized TYPE abap_bool.


    DATA mv_view_popup TYPE string.
    METHODS popup_f4_table
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS popup_f4_table_custom
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
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



CLASS Z2UI5_CL_DEMO_APP_009 IMPLEMENTATION.


  METHOD popup_f4_table.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup( ).

    popup->dialog( 'abap2UI5 - F4 Value Help'
      )->table(
            mode  = 'SingleSelectLeft'
            items = client->_bind_edit( mt_suggestion_sel )
        )->columns(
            )->column( '20rem'
                )->text( 'Color' )->get_parent(
            )->column(
                )->text( 'Description'
        )->get_parent( )->get_parent(
        )->items(
            )->column_list_item( selected = '{SELKZ}'
                )->cells(
                    )->text( '{VALUE}'
                    )->text( '{DESCR}'
      )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->buttons(
            )->button(
                text  = 'continue'
                press = client->_event( 'POPUP_TABLE_F4_CONTINUE' )
                type  = 'Emphasized' ).
    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD popup_f4_table_custom.

    DATA popup2 TYPE REF TO z2ui5_cl_xml_view.
    popup2 = z2ui5_cl_xml_view=>factory_popup( ).

    popup2 = popup2->dialog( 'abap2UI5 - F4 Value Help' ).

    popup2->simple_form(
        )->label( 'Location'
        )->input(
                value           = client->_bind_edit( screen-city )
                suggestionitems = client->_bind( mt_suggestion_city )
                showsuggestion  = abap_true )->get(
            )->suggestion_items( )->get(
                )->list_item(
                    text           = '{VALUE}'
                    additionaltext = '{DESCR}'
        )->get_parent( )->get_parent(
        )->button(
            text  = 'search...'
            press = client->_event( 'SEARCH' ) ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = popup2->table(
        headertext = 'Employees'
        mode       = 'SingleSelectLeft'
        items      = client->_bind_edit( mt_employees_sel ) ).

    tab->columns(
        )->column( '10rem'
            )->text( 'City' )->get_parent(
        )->column( '10rem'
            )->text( 'Nr' )->get_parent(
        )->column( '15rem'
            )->text( 'Name' )->get_parent(
        )->column( '30rem'
            )->text( 'Lastname' )->get_parent( ).

    tab->items( )->column_list_item( selected = '{SELKZ}'
        )->cells(
            )->text( '{CITY}'
            )->text( '{NR}'
            )->text( '{NAME}'
            )->text( '{LASTNAME}' ).

    popup2->buttons(
                )->button(
                    text  = 'continue'
                    press = client->_event( 'POPUP_TABLE_F4_CUSTOM_CONTINUE' )
                    type  = 'Emphasized' ).
    client->popup_display( popup2->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    CLEAR mv_view_popup.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
    ENDIF.
    z2ui5_on_event( client ).

    z2ui5_on_rendering( client ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'POPUP_TABLE_F4'.
        mt_suggestion_sel = mt_suggestion.
        popup_f4_table( client ).

      WHEN 'POPUP_TABLE_F4_CUSTOM'.
        DATA temp1 LIKE mt_employees_sel.
        CLEAR temp1.
        mt_employees_sel = temp1.
        DATA temp2 LIKE mt_employees_sel.
        CLEAR temp2.
        mt_employees_sel = temp2.
        popup_f4_table_custom( client ).

      WHEN 'SEARCH'.
        mt_employees_sel = mt_employees.
        IF screen-city IS NOT INITIAL.
          DELETE mt_employees_sel WHERE city <> screen-city.
        ENDIF.
        popup_f4_table_custom( client ).

      WHEN 'POPUP_TABLE_F4_CUSTOM_CONTINUE'.
        DELETE mt_employees_sel WHERE selkz = abap_false.
        IF lines( mt_employees_sel ) = 1.
          DATA temp3 LIKE LINE OF mt_employees_sel.
          DATA temp4 LIKE sy-tabix.
          temp4 = sy-tabix.
          READ TABLE mt_employees_sel INDEX 1 INTO temp3.
          sy-tabix = temp4.
          IF sy-subrc <> 0.
            ASSERT 1 = 0.
          ENDIF.
          screen-name = temp3-name.
          DATA temp5 LIKE LINE OF mt_employees_sel.
          DATA temp6 LIKE sy-tabix.
          temp6 = sy-tabix.
          READ TABLE mt_employees_sel INDEX 1 INTO temp5.
          sy-tabix = temp6.
          IF sy-subrc <> 0.
            ASSERT 1 = 0.
          ENDIF.
          screen-lastname = temp5-lastname.
          client->message_toast_display( 'f4 value selected' ).
          client->popup_destroy( ).
        ENDIF.

      WHEN 'POPUP_TABLE_F4_CONTINUE'.
        DELETE mt_suggestion_sel WHERE selkz = abap_false.
        IF lines( mt_suggestion_sel ) = 1.
          DATA temp7 LIKE LINE OF mt_suggestion_sel.
          DATA temp8 LIKE sy-tabix.
          temp8 = sy-tabix.
          READ TABLE mt_suggestion_sel INDEX 1 INTO temp7.
          sy-tabix = temp8.
          IF sy-subrc <> 0.
            ASSERT 1 = 0.
          ENDIF.
          screen-color_02 = temp7-value.
          client->message_toast_display( 'f4 value selected' ).
          client->popup_destroy( ).
        ENDIF.

      WHEN 'BUTTON_SEND'.
        client->message_box_display( 'success - values send to the server' ).
      WHEN 'BUTTON_CLEAR'.
        CLEAR screen.
        client->message_box_display( 'View initialized' ).
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    DATA temp9 LIKE mt_suggestion.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-descr = 'this is the color Green'.
    temp10-value = 'GREEN'.
    INSERT temp10 INTO TABLE temp9.
    temp10-descr = 'this is the color Blue'.
    temp10-value = 'BLUE'.
    INSERT temp10 INTO TABLE temp9.
    temp10-descr = 'this is the color Black'.
    temp10-value = 'BLACK'.
    INSERT temp10 INTO TABLE temp9.
    temp10-descr = 'this is the color Grey'.
    temp10-value = 'GREY'.
    INSERT temp10 INTO TABLE temp9.
    temp10-descr = 'this is the color Blue2'.
    temp10-value = 'BLUE2'.
    INSERT temp10 INTO TABLE temp9.
    temp10-descr = 'this is the color Blue3'.
    temp10-value = 'BLUE3'.
    INSERT temp10 INTO TABLE temp9.
    mt_suggestion = temp9.

    DATA temp11 LIKE mt_suggestion_city.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-value = 'London'.
    temp12-descr = 'London'.
    INSERT temp12 INTO TABLE temp11.
    temp12-value = 'Paris'.
    temp12-descr = 'Paris'.
    INSERT temp12 INTO TABLE temp11.
    temp12-value = 'Rome'.
    temp12-descr = 'Rome'.
    INSERT temp12 INTO TABLE temp11.
    mt_suggestion_city = temp11.

    DATA temp13 LIKE mt_employees.
    CLEAR temp13.
    DATA temp14 LIKE LINE OF temp13.
    temp14-city = 'London'.
    temp14-name = 'Tom'.
    temp14-lastname = 'lastname1'.
    temp14-nr = '00001'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'London'.
    temp14-name = 'Tom2'.
    temp14-lastname = 'lastname2'.
    temp14-nr = '00002'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'London'.
    temp14-name = 'Tom3'.
    temp14-lastname = 'lastname3'.
    temp14-nr = '00003'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'London'.
    temp14-name = 'Tom4'.
    temp14-lastname = 'lastname4'.
    temp14-nr = '00004'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Rome'.
    temp14-name = 'Michaela1'.
    temp14-lastname = 'lastname5'.
    temp14-nr = '00005'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Rome'.
    temp14-name = 'Michaela2'.
    temp14-lastname = 'lastname6'.
    temp14-nr = '00006'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Rome'.
    temp14-name = 'Michaela3'.
    temp14-lastname = 'lastname7'.
    temp14-nr = '00007'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Rome'.
    temp14-name = 'Michaela4'.
    temp14-lastname = 'lastname8'.
    temp14-nr = '00008'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine1'.
    temp14-lastname = 'lastname9'.
    temp14-nr = '00009'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine2'.
    temp14-lastname = 'lastname10'.
    temp14-nr = '00010'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    temp14-city = 'Paris'.
    temp14-name = 'Hermine3'.
    temp14-lastname = 'lastname11'.
    temp14-nr = '00011'.
    INSERT temp14 INTO TABLE temp13.
    mt_employees = temp13.

  ENDMETHOD.


  METHOD z2ui5_on_rendering.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
            title          = 'abap2UI5 - Value Help Examples'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA form TYPE REF TO z2ui5_cl_xml_view.
    form = page->grid( 'L7 M7 S7'
        )->content( 'layout'
            )->simple_form( 'Input with Value Help'
                )->content( 'form' ).

    form->label( 'Input with sugestion items'
        )->input(
            value           = client->_bind_edit( screen-color_01 )
            placeholder     = 'fill in your favorite colour'
            suggestionitems = client->_bind( mt_suggestion )
            showsuggestion  = abap_true )->get(
            )->suggestion_items( )->get(
                )->list_item(
                    text           = '{VALUE}'
                    additionaltext = '{DESCR}' ).

    form->label( 'Input only numbers allowed'
        )->input(
            value       = client->_bind_edit( screen-quantity )
            type        = 'Number'
            placeholder = 'quantity' ).

    form->label( 'Input with F4'
        )->input(
            value            = client->_bind_edit( screen-color_02 )
            placeholder      = 'fill in your favorite colour'
            showvaluehelp    = abap_true
            valuehelprequest = client->_event( 'POPUP_TABLE_F4' ) ).

    form->label( 'Custom F4 Popup'
        )->input(
            value            = client->_bind_edit( screen-name )
            placeholder      = 'name'
            showvaluehelp    = abap_true
            valuehelprequest = client->_event( 'POPUP_TABLE_F4_CUSTOM' )
        )->input(
            value            = client->_bind_edit( screen-lastname )
            placeholder      = 'lastname'
            showvaluehelp    = abap_true
            valuehelprequest = client->_event( 'POPUP_TABLE_F4_CUSTOM' ) ).

    page->footer(
        )->overflow_toolbar(
            )->toolbar_spacer(
            )->button(
                text    = 'Clear'
                press   = client->_event( 'BUTTON_CLEAR' )
                type    = 'Reject'
                enabled = abap_false
                icon    = 'sap-icon://delete'
            )->button(
                text    = 'Send to Server'
                press   = client->_event( 'BUTTON_SEND' )
                enabled = abap_false
                type    = 'Success' ).



    CASE mv_view_popup.

      WHEN 'POPUP_TABLE_F4'.

        popup_f4_table( client ).

      WHEN 'POPUP_TABLE_F4_CUSTOM'.

        popup_f4_table_custom( client ).

    ENDCASE.

    client->view_display( page->stringify( ) ).


  ENDMETHOD.
ENDCLASS.

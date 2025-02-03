CLASS z2ui5_cl_demo_app_174 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        zzselkz TYPE abap_bool,
        title   TYPE string,
        value   TYPE string,
        descr   TYPE string,
      END OF ty_row.
    TYPES ty_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.

    DATA mt_tab TYPE ty_tab.
    DATA mv_multiselect TYPE abap_bool.
    DATA mv_preselect TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS z2ui5_cl_demo_app_174 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ) IS NOT INITIAL.

      client->view_display(
        z2ui5_cl_xml_view=>factory( )->shell(
        )->page(
            title          = 'abap2UI5 - Popup To Select'
            navbuttonpress = client->_event( val = 'BACK' )
            shownavbutton  = client->check_app_prev_stack( )
        )->hbox(
        )->text( text  = 'Multiselect: '
                 class = 'sapUiTinyMargin'
        )->switch( state  = client->_bind_edit( mv_multiselect )
                   change = client->_event( `MULTISELECT_TOGGLE` )
        )->get_parent(
        )->hbox(
        )->text( text  = 'Preselect all entries: '
                 class = 'sapUiTinyMargin'
        )->switch( state   = client->_bind_edit( mv_preselect )
                   enabled = client->_bind_edit( mv_multiselect )
        )->get_parent(
        )->button(
        text  = 'Open Popup...'
        press = client->_event( 'POPUP' ) )->stringify( ) ).

      RETURN.
    ENDIF.

    CASE client->get( )-event.

      WHEN 'POPUP'.
        DATA temp1 TYPE z2ui5_cl_demo_app_174=>ty_tab.
        CLEAR temp1.
        DATA temp2 LIKE LINE OF temp1.
        temp2-descr = 'this is a description'.
        temp2-zzselkz = mv_preselect.
        temp2-title = 'title_01'.
        temp2-value = 'value_01'.
        INSERT temp2 INTO TABLE temp1.
        temp2-zzselkz = mv_preselect.
        temp2-title = 'title_02'.
        temp2-value = 'value_02'.
        INSERT temp2 INTO TABLE temp1.
        temp2-zzselkz = mv_preselect.
        temp2-title = 'title_03'.
        temp2-value = 'value_03'.
        INSERT temp2 INTO TABLE temp1.
        temp2-zzselkz = mv_preselect.
        temp2-title = 'title_04'.
        temp2-value = 'value_04'.
        INSERT temp2 INTO TABLE temp1.
        temp2-zzselkz = mv_preselect.
        temp2-title = 'title_05'.
        temp2-value = 'value_05'.
        INSERT temp2 INTO TABLE temp1.
        mt_tab = temp1.

        client->nav_app_call( z2ui5_cl_pop_to_select=>factory(
                           i_tab             = mt_tab
                           i_multiselect     = mv_multiselect
                           i_event_confirmed = 'POPUP_CONFIRMED'
                           i_event_canceled  = 'POPUP_CANCEL'
          ) ).

      WHEN 'POPUP_CANCELED'.
        client->message_box_display( `Popup was cancelled` ).

      WHEN 'POPUP_CONFIRMED'.
        DATA lr TYPE REF TO data.
        lr = client->get( )-r_event_data.
        FIELD-SYMBOLS <t> TYPE data.
        ASSIGN lr->* TO <t>.
        DATA temp3 TYPE ty_tab.
        temp3 = <t>.
        DATA lt3 LIKE temp3.
        lt3 = temp3.
        IF mv_multiselect = abap_false.
          DATA temp4 LIKE LINE OF lt3.
          DATA temp5 LIKE sy-tabix.
          temp5 = sy-tabix.
          READ TABLE lt3 INDEX 1 INTO temp4.
          sy-tabix = temp5.
          IF sy-subrc <> 0.
            ASSERT 1 = 0.
          ENDIF.
          client->message_box_display( `callback after popup to select: ` && temp4-title ).
        ELSE.
          client->nav_app_call( z2ui5_cl_pop_table=>factory( i_tab   = lt3
                                                             i_title = 'Selected rows' ) ).
        ENDIF.

      WHEN 'MULTISELECT_TOGGLE'.
        DATA temp6 TYPE abap_bool.
        IF mv_multiselect = abap_false.
          temp6 = abap_false.
        ELSE.
          temp6 = mv_preselect.
        ENDIF.
        mv_preselect = temp6.
        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.

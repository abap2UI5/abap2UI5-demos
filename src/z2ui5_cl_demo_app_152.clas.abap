CLASS z2ui5_cl_demo_app_152 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.

    TYPES:
      BEGIN OF ty_row,
        zzselkz TYPE abap_bool,
        title   TYPE string,
        value   TYPE string,
        descr   TYPE string,
      END OF ty_row.
    TYPES temp1_eeb45a0adc TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA mt_tab TYPE temp1_eeb45a0adc.

    DATA mv_check_initialized TYPE abap_bool.
    DATA mv_multiselect TYPE abap_bool.
    DATA mv_preselect TYPE abap_bool.
    METHODS ui5_display.
    METHODS ui5_event.
    METHODS ui5_callback.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS z2ui5_cl_demo_app_152 IMPLEMENTATION.


  METHOD ui5_event.

    CASE client->get( )-event.

      WHEN 'POPUP'.

        DATA temp1 LIKE mt_tab.
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

        DATA temp3 TYPE string.
        IF mv_multiselect = abap_true.
          temp3 = `Multi select`.
        ELSE.
          temp3 = `Single select`.
        ENDIF.
        DATA lo_app TYPE REF TO z2ui5_cl_pop_to_select.
        lo_app = z2ui5_cl_pop_to_select=>factory(
                           i_tab         = mt_tab
                           i_multiselect = mv_multiselect
                           i_title       = temp3 ).
        client->nav_app_call( lo_app ).


      WHEN 'MULTISELECT_TOGGLE'.

        DATA temp4 TYPE abap_bool.
        IF mv_multiselect = abap_false.
          temp4 = abap_false.
        ELSE.
          temp4 = mv_preselect.
        ENDIF.
        mv_preselect = temp4.

        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD ui5_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Popup To Select'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1
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
            press = client->_event( 'POPUP' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.
      IF mv_check_initialized = abap_false.
        mv_check_initialized = abap_true.
        ui5_display( ).
      ELSE.
        ui5_callback( ).
      ENDIF.
      RETURN.
    ENDIF.

    ui5_event( ).

  ENDMETHOD.

  METHOD ui5_callback.
    FIELD-SYMBOLS <row> TYPE ty_row.

    TRY.
        DATA lo_prev TYPE REF TO z2ui5_if_app.
        lo_prev = client->get_app( client->get( )-s_draft-id_prev_app ).
        DATA temp5 TYPE REF TO z2ui5_cl_pop_to_select.
        temp5 ?= lo_prev.
        DATA ls_result TYPE z2ui5_cl_pop_to_select=>ty_s_result.
        ls_result = temp5->result( ).

        IF ls_result-check_confirmed = abap_false.
          client->message_box_display( `Popup was cancelled` ).
          RETURN.
        ENDIF.

        IF mv_multiselect = abap_false.


          ASSIGN ls_result-row->* TO <row>.
          client->message_box_display( `callback after popup to select: ` && <row>-title ).

        ELSE.

          FIELD-SYMBOLS <table> TYPE data.
          ASSIGN ls_result-table->* TO <table>.
          client->nav_app_call( z2ui5_cl_pop_table=>factory(
                                    i_tab   = <table>
                                    i_title = 'Selected rows' ) ).

        ENDIF.

      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

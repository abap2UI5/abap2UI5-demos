CLASS z2ui5_cl_demo_app_160 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF s_output,
        index          TYPE i,
        set_sk         TYPE c LENGTH 10,
        matnr          TYPE matnr,
        description    TYPE c LENGTH 50,
        is_total       TYPE i,
        pl_total       TYPE i,
        per_cent_total TYPE p LENGTH 2 DECIMALS 1,
        is_01_prev     TYPE i,
        pl_01          TYPE i,
        per_cent_01    TYPE p LENGTH 2 DECIMALS 1,
        is_02_prev     TYPE i,
        pl_02          TYPE p LENGTH 2 DECIMALS 1,
        per_cent_02    TYPE p LENGTH 2 DECIMALS 1,
        is_03_prev     TYPE i,
        pl_03          TYPE i,
        per_cent_03    TYPE p LENGTH 2 DECIMALS 1,
        is_q01_prev    TYPE i,
        pl_q01         TYPE i,
        per_cent_q01   TYPE p LENGTH 2 DECIMALS 1,
        is_q02_prev    TYPE i,
        pl_q02         TYPE i,
        per_cent_q02   TYPE p LENGTH 2 DECIMALS 1,
        is_q03_prev    TYPE i,
        pl_q03         TYPE i,
        per_cent_q03   TYPE p LENGTH 2 DECIMALS 1,
        is_q04_prev    TYPE i,
        pl_q04         TYPE i,
        per_cent_q04   TYPE p LENGTH 2 DECIMALS 1,
      END OF s_output .

    DATA check_initialized TYPE abap_bool .
    TYPES temp1_d2eb35b09b TYPE STANDARD TABLE OF s_output.
DATA mt_output TYPE temp1_d2eb35b09b.
    DATA client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS load_output_table .
    METHODS on_event.
    METHODS render_main_screen.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_160 IMPLEMENTATION.


  METHOD load_output_table.

    DATA ls_output TYPE s_output.
    CLEAR mt_output.

    DO 10 TIMES.
      ls_output-index = sy-index.
      ls_output-set_sk = 'Test'.
      ls_output-matnr  = '1234567'.
      ls_output-description = 'Test'.
      ls_output-pl_01 = 0.
      ls_output-pl_02 = 0.


      APPEND ls_output TO mt_output.

    ENDDO.

  ENDMETHOD.


  METHOD on_event.

    DATA lt_event_arguments TYPE string_table.

    CASE client->get( )-event.

      WHEN 'PL_TOTAL_CHANGE'.

        lt_event_arguments = client->get( )-t_event_arg.
        DATA lv_id_event LIKE LINE OF lt_event_arguments.
        DATA temp1 LIKE LINE OF lt_event_arguments.
        DATA temp2 LIKE sy-tabix.
        temp2 = sy-tabix.
        READ TABLE lt_event_arguments INDEX 1 INTO temp1.
        sy-tabix = temp2.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        lv_id_event = temp1.

        DATA lv_tab_index LIKE LINE OF lt_event_arguments.
        DATA temp3 LIKE LINE OF lt_event_arguments.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE lt_event_arguments INDEX 2 INTO temp3.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        lv_tab_index = temp3.
        DATA ls_row_submit LIKE LINE OF mt_output.
        DATA temp5 LIKE LINE OF mt_output.
        DATA temp6 LIKE sy-tabix.
        temp6 = sy-tabix.
        READ TABLE mt_output INDEX lv_tab_index INTO temp5.
        sy-tabix = temp6.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        ls_row_submit = temp5.

        DATA lv_id_parent LIKE LINE OF lt_event_arguments.
        DATA temp7 LIKE LINE OF lt_event_arguments.
        DATA temp8 LIKE sy-tabix.
        temp8 = sy-tabix.
        READ TABLE lt_event_arguments INDEX 3 INTO temp7.
        sy-tabix = temp8.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        lv_id_parent = temp7.

        client->message_box_display( lv_tab_index && lv_id_event && lv_id_parent ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    client->view_model_update( ).

  ENDMETHOD.


  METHOD render_main_screen.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
      )->page(
        title           = 'abap2UI5 - Event on cell level'
        navbuttonpress  = client->_event( 'BACK' )
          shownavbutton = temp2
        )->header_content(
            )->link(
      )->get_parent( ).


    DATA table TYPE REF TO z2ui5_cl_xml_view.
    table = page->flex_box( height = '85vh' )->ui_table( alternaterowcolors  = 'true'
                                                               visiblerowcountmode = 'Auto'
                                                               fixedrowcount       = '1'
                                                               selectionmode       = 'None'
                                                               rows                = client->_bind_edit( val = mt_output
*        compress_mode = z2ui5_if_client=>cs_compress_mode-none
      ) ).
    DATA columns TYPE REF TO z2ui5_cl_xml_view.
    columns = table->ui_columns( ).

    columns->ui_column( width          = '5.2rem'
                        sortproperty   = 'SET_SK'
                        filterproperty = 'SET_SK' )->text( text = 'Column 1' )->ui_template( )->text( text = `{SET_SK}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'MATNR'
                        filterproperty = 'MATNR' )->text( text = 'Column 2' )->ui_template( )->text( text = `{MATNR}` ).
    columns->ui_column( width          = '20rem'
                        sortproperty   = 'DESCRIPTION'
                        filterproperty = 'DESCRIPTION' )->text( text = 'Column 3' )->ui_template( )->text( text = `{DESCRIPTION}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_TOTAL'
                        filterproperty = 'IS_TOTAL' )->text( text = 'Column 4' )->ui_template( )->text( text = `{IS_TOTAL}` ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/id}` INTO TABLE temp1.
    INSERT `${INDEX}` INTO TABLE temp1.
    INSERT `$event.oSource.oParent.sId` INTO TABLE temp1.
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_TOTAL'
                        filterproperty = 'PL_TOTAL' )->text( text = 'Column 5' )->ui_template( )->input(
      value           = `{PL_TOTAL}`
      submit          = client->_event( val = 'PL_TOTAL_CHANGE' t_arg = temp1 ) editable = abap_true
      type            = 'Number' ).

    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_total'
                        filterproperty = 'per_cent_total' )->text( text = 'Column 6' )->ui_template( )->text( text = `{per_cent_total} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_01_PREV'
                        filterproperty = 'IS_01_PREV' )->text( text = 'Column 7' )->ui_template( )->text( text = `{IS_01_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_01'
                        filterproperty = 'PL_01' )->text( text = 'Column 8' )->ui_template( )->input( value    = `{PL_01}`
                                                                                                      editable = abap_true
                                                                                                      type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_01'
                        filterproperty = 'per_cent_01' )->text( text = 'Column 9' )->ui_template( )->text( text = `{per_cent_01} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_02_PREV'
                        filterproperty = 'IS_02_PREV' )->text( text = 'Column 10' )->ui_template( )->text( text = `{IS_02_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_02'
                        filterproperty = 'PL_02' )->text( text = 'Column 11' )->ui_template( )->input( value    = `{PL_02}`
                                                                                                       editable = abap_true
                                                                                                       type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_02'
                        filterproperty = 'per_cent_02' )->text( text = 'Column 12' )->ui_template( )->text( text = `{per_cent_02} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_03_PREV'
                        filterproperty = 'IS_03_PREV' )->text( text = 'Column 13' )->ui_template( )->text( text = `{IS_03_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_03'
                        filterproperty = 'PL_03' )->text( text = 'Column 14' )->ui_template( )->input( value    = `{PL_03}`
                                                                                                       editable = abap_true
                                                                                                       type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_03'
                        filterproperty = 'per_cent_03' )->text( text = 'Column 15' )->ui_template( )->text( text = `{per_cent_03} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_Q01_PREV'
                        filterproperty = 'IS_Q01_PREV' )->text( text = 'Column 16' )->ui_template( )->text( text = `{IS_Q01_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_Q01'
                        filterproperty = 'PL_Q01' )->text( text = 'Column 17' )->ui_template( )->text( text = `{PL_Q01}` ). "Nicht editierbar, da im Detail geplant
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_q01'
                        filterproperty = 'per_cent_q01' )->text( text = 'Column 18' )->ui_template( )->text( text = `{per_cent_q01} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_Q02_PREV'
                        filterproperty = 'IS_Q02_PREV' )->text( text = 'Column 19' )->ui_template( )->text( text = `{IS_Q02_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_Q02'
                        filterproperty = 'PL_Q02' )->text( text = 'Column 20' )->ui_template( )->input( value    = `{PL_Q02}`
                                                                                                        editable = abap_true
                                                                                                        type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_q02'
                        filterproperty = 'per_cent_q02' )->text( text = 'Column 21' )->ui_template( )->text( text = `{per_cent_q02} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_Q03_PREV'
                        filterproperty = 'IS_Q03_PREV' )->text( text = 'Column 22' )->ui_template( )->text( text = `{IS_Q03_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_Q03'
                        filterproperty = 'PL_Q03' )->text( text = 'Column 23' )->ui_template( )->input( value    = `{PL_Q03}`
                                                                                                        editable = abap_true
                                                                                                        type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_q03'
                        filterproperty = 'per_cent_q03' )->text( text = 'Column 24' )->ui_template( )->text( text = `{per_cent_q03} %` ).

    columns->ui_column( width          = '5rem'
                        sortproperty   = 'IS_Q04_PREV'
                        filterproperty = 'IS_Q04_PREV' )->text( text = 'Column 25' )->ui_template( )->text( text = `{IS_Q04_PREV}` ).
    columns->ui_column( width          = '5rem'
                        sortproperty   = 'PL_Q04'
                        filterproperty = 'PL_Q04' )->text( text = 'Column 26' )->ui_template( )->input( value    = `{PL_Q04}`
                                                                                                        editable = abap_true
                                                                                                        type     = 'Number' ).
    columns->ui_column( width          = '4rem'
                        sortproperty   = 'per_cent_q04'
                        filterproperty = 'per_cent_q04' )->text( text = 'Column 27' )->ui_template( )->text( text = `{per_cent_q04} %` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      load_output_table( ).
      render_main_screen( ).
      RETURN.
    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.

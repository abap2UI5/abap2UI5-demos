CLASS z2ui5_cl_demo_app_045 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        count    TYPE i,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        checkbox TYPE abap_bool,
      END OF ty_row.

    TYPES temp1_850264c07c TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_850264c07c.
    DATA check_initialized TYPE abap_bool.
    DATA mv_info_filter TYPE string.
    METHODS refresh_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_045 IMPLEMENTATION.


  METHOD refresh_data.

    DO 1000 TIMES.
      DATA temp1 TYPE ty_row.
      CLEAR temp1.
      temp1-count = sy-index.
      temp1-value = 'red'.
      DATA temp2 TYPE z2ui5_cl_demo_app_045=>ty_row-info.
      IF sy-index < 50.
        temp2 = 'completed'.
      ELSE.
        temp2 = 'uncompleted'.
      ENDIF.
      temp1-info = temp2.
      temp1-descr = 'this is a description'.
      temp1-checkbox = abap_true.
      DATA ls_row LIKE temp1.
      ls_row = temp1.
      INSERT ls_row INTO TABLE t_tab.
    ENDDO.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      refresh_data( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'FLTER_INFO'.
        refresh_data( ).
        IF mv_info_filter <> ''.
          DELETE t_tab WHERE info <> mv_info_filter.
        ENDIF.

      WHEN 'BUTTON_POST'.
        client->message_box_display( 'button post was pressed' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.


    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
        )->page(
            title          = 'abap2UI5 - Scroll Container with Table and Toolbar'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1
            )->header_content(
                )->link(
      )->get_parent( ).

    page->simple_form( title    = 'Form Title'
                       editable = abap_true
                )->content( 'form'
                    )->title( 'Filter'
                    )->label( 'info'
                    )->input( client->_bind( mv_info_filter )
                    )->button(
                        text  = 'filter'
                        press = client->_event( 'FLTER_INFO' ) ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->scroll_container( height   = '70%'
                                        vertical = abap_true
        )->table(
            growing             = abap_true
            growingthreshold    = '20'
            growingscrolltoload = abap_true
            items               = client->_bind( t_tab )
            sticky              = 'ColumnHeaders,HeaderToolbar' ).

    tab->header_toolbar(
        )->overflow_toolbar(
            )->toolbar_spacer( ).

    tab->columns(
        )->column(
            )->text( 'Color' )->get_parent(
        )->column(
            )->text( 'Info' )->get_parent(
        )->column(
            )->text( 'Description' )->get_parent(
        )->column(
            )->text( 'Checkbox' )->get_parent(
         )->column(
            )->text( 'Counter' ).

    tab->items( )->column_list_item( )->cells(
       )->text( '{VALUE}'
       )->text( '{INFO}'
       )->text( '{DESCR}'
       )->checkbox( selected = '{CHECKBOX}'
                    enabled  = abap_false
       )->text( '{COUNT}' ).

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.
ENDCLASS.

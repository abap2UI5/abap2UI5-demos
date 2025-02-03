CLASS z2ui5_cl_demo_app_190 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_view_display TYPE abap_bool.
    DATA mo_parent_view  TYPE REF TO z2ui5_cl_xml_view.

    DATA mv_table        TYPE string.
    DATA mt_table        TYPE REF TO data.
    DATA mt_table_tmp    TYPE REF TO data.

    DATA mt_comp         TYPE abap_component_tab.
    DATA ms_fixval       TYPE REF TO data.

    METHODS set_app_data
      IMPORTING !count TYPE string
                !table TYPE string.

  PROTECTED SECTION.
    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS on_init.
    METHODS on_event.

    METHODS render_main.

  PRIVATE SECTION.
    METHODS get_data.

    METHODS get_comp
      RETURNING VALUE(result) TYPE abap_component_tab.

    METHODS get_fixval.
ENDCLASS.

CLASS z2ui5_cl_demo_app_190 IMPLEMENTATION.

  METHOD on_event.

    FIELD-SYMBOLS <row> TYPE any.

    CASE client->get( )-event.

      WHEN 'BACK'.

        client->nav_app_leave( ).

    ENDCASE.
  ENDMETHOD.

  METHOD on_init.
    get_data( ).
    render_main( ).
  ENDMETHOD.

  METHOD render_main.
    FIELD-SYMBOLS <tab> TYPE data.

    IF mo_parent_view IS INITIAL.
      DATA page TYPE REF TO z2ui5_cl_xml_view.
      page = z2ui5_cl_xml_view=>factory( ).
    ELSE.
      page = mo_parent_view->get( `Page` ).
    ENDIF.


    ASSIGN mt_table->* TO <tab>.

    DATA table TYPE REF TO z2ui5_cl_xml_view.
    table = page->table( growing = 'true'
                               width   = 'auto'
                               items   = client->_bind( <tab> )
*                               headertext = mv_table
                               ).

    DATA columns TYPE REF TO z2ui5_cl_xml_view.
    columns = table->columns( ).

    DATA comp LIKE LINE OF mt_comp.
    LOOP AT mt_comp INTO comp.

      columns->column( )->text( comp-name ).

    ENDLOOP.

    DATA cells TYPE REF TO z2ui5_cl_xml_view.
    cells = columns->get_parent( )->items(
                                       )->column_list_item( valign = 'Middle'
                                                            type   = 'Navigation'
                                       )->cells( ).

    LOOP AT mt_comp INTO comp.
      cells->object_identifier( text = '{' && comp-name && '}' ).
    ENDLOOP.

    page->footer( )->overflow_toolbar(
                         )->toolbar_spacer(
                         )->button( text  = 'Save'
                                    press = client->_event( 'BUTTON' )
                                    type  = 'Success' ).

    IF mo_parent_view IS INITIAL.

      client->view_display( page->get_root( )->xml_get( ) ).

    ELSE.

      mv_view_display = abap_true.

    ENDIF.
  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      on_init( ).

    ENDIF.

    on_event( ).
  ENDMETHOD.

  METHOD set_app_data.
    " TODO: parameter COUNT is never used (ABAP cleaner)

    mv_table = table.
  ENDMETHOD.

  METHOD get_data.

    FIELD-SYMBOLS <table>     TYPE STANDARD TABLE.
    FIELD-SYMBOLS <table_tmp> TYPE STANDARD TABLE.

    mt_comp = get_comp( ).

    TRY.

        DATA new_struct_desc TYPE REF TO cl_abap_structdescr.
        new_struct_desc = cl_abap_structdescr=>create( mt_comp ).

        DATA new_table_desc TYPE REF TO cl_abap_tabledescr.
        new_table_desc = cl_abap_tabledescr=>create( p_line_type  = new_struct_desc
                                                           p_table_kind = cl_abap_tabledescr=>tablekind_std ).

        CREATE DATA mt_table     TYPE HANDLE new_table_desc.

        CREATE DATA mt_table_tmp TYPE HANDLE new_table_desc.


        ASSIGN mt_table->* TO <table>.

        SELECT *
          FROM (mv_table)
          INTO CORRESPONDING FIELDS OF TABLE <table>
          UP TO 100 ROWS.

      CATCH cx_root.

    ENDTRY.

    ASSIGN mt_table_tmp->* TO <table_tmp>.

    <table_tmp> = <table>.
    get_fixval( ).

  ENDMETHOD.

  METHOD get_fixval.

    TYPES:
      BEGIN OF fixvalue,
        low        TYPE string,
        high       TYPE string,
        option     TYPE string,
        ddlanguage TYPE string,
        ddtext     TYPE string,
      END OF fixvalue.
    TYPES fixvalues TYPE STANDARD TABLE OF fixvalue WITH DEFAULT KEY.

    DATA comp        TYPE cl_abap_structdescr=>component_table.
    DATA structdescr TYPE REF TO cl_abap_structdescr.
    DATA lt_fixval   TYPE fixvalues.

    DATA temp1 LIKE LINE OF mt_comp.
    DATA dfies LIKE REF TO temp1.
    LOOP AT mt_comp REFERENCE INTO dfies.

      DATA temp2 TYPE cl_abap_structdescr=>component_table.
      CLEAR temp2.
      temp2 = comp.
      DATA temp3 LIKE LINE OF temp2.
      temp3-name = dfies->name.
      DATA temp4 TYPE REF TO cl_abap_datadescr.
      temp4 ?= cl_abap_datadescr=>describe_by_data( lt_fixval ).
      temp3-type = temp4.
      INSERT temp3 INTO TABLE temp2.
      comp = temp2.
    ENDLOOP.

    structdescr = cl_abap_structdescr=>create( comp ).

    CREATE DATA ms_fixval TYPE HANDLE structdescr.


  ENDMETHOD.

  METHOD get_comp.
    DATA index TYPE int4.
    TRY.



        TRY.

            DATA typedesc TYPE REF TO cl_abap_typedescr.
            cl_abap_typedescr=>describe_by_name( EXPORTING  p_name         = mv_table
                                                 RECEIVING p_descr_ref     = typedesc
                                                 EXCEPTIONS type_not_found = 1
                                                            OTHERS         = 2 ).

            DATA temp4 TYPE REF TO cl_abap_structdescr.
            temp4 ?= typedesc.
            DATA structdesc LIKE temp4.
            structdesc = temp4.
            DATA comp TYPE abap_component_tab.
            comp = structdesc->get_components( ).

            DATA com LIKE LINE OF comp.
            LOOP AT comp INTO com.
              IF com-as_include = abap_false.
                APPEND com TO result.
              ENDIF.
            ENDLOOP.

          CATCH cx_root.

        ENDTRY.

        DATA temp5 TYPE cl_abap_structdescr=>component_table.
        CLEAR temp5.
        DATA temp6 LIKE LINE OF temp5.
        temp6-name = 'ROW_ID'.
        DATA temp7 TYPE REF TO cl_abap_datadescr.
        temp7 ?= cl_abap_datadescr=>describe_by_data( index ).
        temp6-type = temp7.
        INSERT temp6 INTO TABLE temp5.
        DATA component LIKE temp5.
        component = temp5.

        APPEND LINES OF component TO result.

      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

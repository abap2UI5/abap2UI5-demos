CLASS z2ui5_cl_demo_app_132 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_view_display TYPE abap_bool.
    DATA mo_parent_view  TYPE REF TO z2ui5_cl_xml_view.
    DATA mv_perc         TYPE string.

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
    METHODS get_comp
      RETURNING VALUE(result) TYPE abap_component_tab.
ENDCLASS.

CLASS z2ui5_cl_demo_app_132 IMPLEMENTATION.

  METHOD get_comp.
    DATA index TYPE int4.
    TRY.



        TRY.

            DATA typedesc TYPE REF TO cl_abap_typedescr.
            cl_abap_typedescr=>describe_by_name( EXPORTING  p_name         = 'Z2UI5_T_UTIL_01'
                                                 RECEIVING p_descr_ref     = typedesc
                                                 EXCEPTIONS type_not_found = 1
                                                            OTHERS         = 2 ).

            DATA temp1 TYPE REF TO cl_abap_structdescr.
            temp1 ?= typedesc.
            DATA structdesc LIKE temp1.
            structdesc = temp1.

            DATA comp TYPE abap_component_tab.
            comp = structdesc->get_components( ).

            DATA com LIKE LINE OF comp.
            LOOP AT comp INTO com.

              IF com-as_include = abap_false.

                APPEND com TO result.

              ENDIF.

            ENDLOOP.

            DATA root TYPE REF TO cx_root.
          CATCH cx_root INTO root. " TODO: variable is assigned but never used (ABAP cleaner)

        ENDTRY.

        DATA temp2 TYPE cl_abap_structdescr=>component_table.
        CLEAR temp2.
        DATA temp3 LIKE LINE OF temp2.
        temp3-name = 'ROW_ID'.
        DATA temp4 TYPE REF TO cl_abap_datadescr.
        temp4 ?= cl_abap_datadescr=>describe_by_data( index ).
        temp3-type = temp4.
        INSERT temp3 INTO TABLE temp2.
        DATA component LIKE temp2.
        component = temp2.

        APPEND LINES OF component TO result.

      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.

  METHOD on_event.
    CASE client->get( )-event.

      WHEN 'BACK'.

        client->nav_app_leave( ).

    ENDCASE.
  ENDMETHOD.

  METHOD on_init.

    render_main( ).
  ENDMETHOD.

  METHOD render_main.
    IF mo_parent_view IS INITIAL.

      DATA page TYPE REF TO z2ui5_cl_xml_view.
      page = z2ui5_cl_xml_view=>factory( ).

    ELSE.

      page = mo_parent_view->get( `Page` ).

    ENDIF.

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).
    layout->label( 'ProgressIndicator'
        )->progress_indicator( percentvalue = mv_perc
                               displayvalue = '0,44GB of 32GB used'
                               showvalue    = abap_true
                               state        = 'Success' ).

    IF mo_parent_view IS INITIAL.

      client->view_display( page->get_root( )->xml_get( ) ).

    ELSE.

      mv_view_display = abap_true.

    ENDIF.
  ENDMETHOD.

  METHOD set_app_data.
    " TODO: parameter TABLE is never used (ABAP cleaner)

    mv_perc = count.

  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      on_init( ).

    ENDIF.

    on_event( ).
  ENDMETHOD.

ENDCLASS.

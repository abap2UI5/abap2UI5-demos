CLASS z2ui5_cl_demo_app_104 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA mo_app_sub TYPE REF TO object .
    DATA classname TYPE string.

    TYPES:
      BEGIN OF ty_row,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        selected TYPE abap_bool,
        checkbox TYPE abap_bool,
      END OF ty_row .

    DATA
      t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY .
    DATA
      t_tab2 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY .
    DATA mv_layout TYPE string .
    DATA mv_title TYPE string .
    DATA check_initialized TYPE abap_bool .
    DATA mv_check_enabled_01 TYPE abap_bool VALUE abap_true.
    DATA mv_check_enabled_02 TYPE abap_bool .
    DATA mo_grid_sub TYPE REF TO z2ui5_cl_xml_view .
    DATA lo_view_nested TYPE REF TO z2ui5_cl_xml_view.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS view_display_master.
    METHODS view_display_detail.
    METHODS on_event_sub.
    METHODS on_init_sub.

  PRIVATE SECTION.

ENDCLASS.



CLASS z2ui5_cl_demo_app_104 IMPLEMENTATION.


  METHOD on_event_sub.

    IF mo_app_sub IS BOUND.

      FIELD-SYMBOLS <fs> TYPE any.
      ASSIGN mo_app_sub->('MO_VIEW_PARENT') TO <fs>.
      <fs> = mo_grid_sub.
      CALL METHOD mo_app_sub->('Z2UI5_IF_APP~MAIN') EXPORTING client = client.

    ENDIF.
  ENDMETHOD.


  METHOD on_init_sub.

    classname = to_upper( classname ).
    CREATE OBJECT mo_app_sub TYPE (classname).

    FIELD-SYMBOLS <fs> TYPE any.
    ASSIGN mo_app_sub->('MO_VIEW_PARENT') TO <fs>.
    <fs> = mo_grid_sub.
    CALL METHOD mo_app_sub->('Z2UI5_IF_APP~MAIN') EXPORTING client = client.

  ENDMETHOD.


  METHOD view_display_detail.

    lo_view_nested = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = lo_view_nested->page( title = `Nested View` ).
    mo_grid_sub = page->grid( 'L12 M12 S12'
        )->content( 'layout' ).

  ENDMETHOD.


  METHOD view_display_master.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory(
       )->page(
          title           = 'abap2UI5 - Master Detail Page with Nested View'
          navbuttonpress  = client->_event( 'BACK' )
            shownavbutton = abap_true ).

    page->header_content(
             )->link( text   = 'Demo'
                      target = '_blank'
                      href   = `https://twitter.com/abap2UI5/status/1628701535222865922`
             )->link(
         )->get_parent( ).

    DATA col_layout TYPE REF TO z2ui5_cl_xml_view.
    col_layout = page->flexible_column_layout( layout = client->_bind_edit( mv_layout )
                                                     id     ='test' ).

    DATA lr_master TYPE REF TO z2ui5_cl_xml_view.
    lr_master = col_layout->begin_column_pages( ).

    DATA lr_list TYPE REF TO z2ui5_cl_xml_view.
    lr_list = lr_master->list(
          headertext      = 'List Ouput'
          items           = client->_bind_edit( val = t_tab view = client->cs_view-main )
          mode            = `SingleSelectMaster`
          selectionchange = client->_event( val = 'SELCHANGE' )
          )->standard_list_item(
              title       = '{TITLE}'
              description = '{DESCR}'
              icon        = '{ICON}'
              info        = '{INFO}'
              press       = client->_event( 'TEST' )
              selected    = `{SELECTED}` ).

    client->view_display( lr_list->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp1 LIKE t_tab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = 'Class 1'.
      temp2-info = 'z2ui5_cl_demo_app_105'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'Class 2'.
      temp2-info = 'z2ui5_cl_demo_app_112'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      t_tab = temp1.

      mv_layout = `OneColumn`.
      view_display_master( ).
      view_display_detail( ).

    ENDIF.

    CASE client->get( )-event.

      WHEN `SELCHANGE`.

        DATA lt_sel LIKE t_tab.
        lt_sel = t_tab.
        DELETE lt_sel WHERE selected = abap_false.

        DATA ls_sel TYPE z2ui5_cl_demo_app_104=>ty_row.
        READ TABLE lt_sel INTO ls_sel INDEX 1.
        APPEND ls_sel TO t_tab2.

        IF classname IS NOT INITIAL.
          view_display_master( ).
        ENDIF.
        classname = ls_sel-info.

        mv_layout = `TwoColumnsMidExpanded`.
        client->view_model_update( ).
        view_display_detail( ).
        on_init_sub( ).

        client->nest_view_display(
          val            = lo_view_nested->stringify( )
          id             = `test`
          method_insert  = 'addMidColumnPage'
          method_destroy = 'removeAllMidColumnPages' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    on_event_sub( ).

  ENDMETHOD.
ENDCLASS.

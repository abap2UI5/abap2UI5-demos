CLASS z2ui5_cl_demo_app_199 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mt_table   TYPE REF TO data.
    DATA mv_counter TYPE string.
    DATA mt_comp    TYPE abap_component_tab.

  PROTECTED SECTION.
    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS on_init.
    METHODS on_event.
    METHODS render_main.

  PRIVATE SECTION.
    METHODS refresh_data.
    METHODS add_data.

ENDCLASS.

CLASS z2ui5_cl_demo_app_199 IMPLEMENTATION.

  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'CLEAR'.
        refresh_data( ).
        client->view_model_update( ).

      WHEN 'ADD'.
        add_data( ).
        client->view_model_update( ).

    ENDCASE.
  ENDMETHOD.

  METHOD on_init.
    refresh_data( ).
    render_main( ).
  ENDMETHOD.

  METHOD render_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    FIELD-SYMBOLS <tab> TYPE data.
    ASSIGN mt_table->* TO <tab>.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page( id             = `page_main`
                             title          = 'Refresh'
                             navbuttonpress = client->_event( 'BACK' )
                             shownavbutton  = temp1
                             class          = 'sapUiContentPadding' ).
    DATA table TYPE REF TO z2ui5_cl_xml_view.
    table = page->table( growing = 'true'
                               width   = 'auto'
                               items   = client->_bind_edit( <tab> ) ).

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

    page->button( text  = 'Clear'
                  press = client->_event( 'CLEAR' )
                  )->button( text  = 'Add'
                             press = client->_event( 'ADD' ) ).

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    FIELD-SYMBOLS <tab> TYPE STANDARD TABLE.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      on_init( ).
    ENDIF.


    ASSIGN mt_table->* TO <tab>.
    IF mv_counter <> lines( <tab> ) AND mv_counter IS NOT INITIAL.
      client->message_box_display( text = 'Frontend Lines <> Backend!'
                                   type = 'error' ).
    ENDIF.

    on_event( ).
    mv_counter = lines( <tab> ).

  ENDMETHOD.

  METHOD refresh_data.
    FIELD-SYMBOLS <table> TYPE STANDARD TABLE.
    TYPES ty_t_01 TYPE STANDARD TABLE OF z2ui5_t_01.

    TRY.



        CREATE DATA mt_table TYPE ty_t_01.
        ASSIGN mt_table->* TO <table>.
        mt_comp = z2ui5_cl_util=>rtti_get_t_attri_by_any( <table> ).

        SELECT id id_prev FROM z2ui5_t_01
          INTO CORRESPONDING FIELDS OF TABLE <table>
          UP TO 2 ROWS.

      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.

  METHOD add_data.

    FIELD-SYMBOLS <tab> TYPE STANDARD TABLE.
    ASSIGN mt_table->* TO <tab>.
    APPEND LINES OF <tab> TO <tab>.

  ENDMETHOD.

ENDCLASS.

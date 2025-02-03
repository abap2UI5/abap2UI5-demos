CLASS z2ui5_cl_demo_app_131 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_t002,
        id    TYPE string,
        count TYPE string,
        table TYPE string,
        class TYPE string,
      END OF ty_s_t002.
    TYPES ty_t_t002 TYPE STANDARD TABLE OF ty_s_t002 WITH DEFAULT KEY.

    DATA mv_selectedkey     TYPE string.
    DATA mv_selectedkey_tmp TYPE string.
    DATA mt_t002            TYPE ty_t_t002.
    DATA mo_app             TYPE REF TO object.

  PROTECTED SECTION.
    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.
    DATA mo_main_page      TYPE REF TO z2ui5_cl_xml_view.

    METHODS on_init.
    METHODS on_event.
    METHODS render_main.

    METHODS render_sub_app.

  PRIVATE SECTION.

ENDCLASS.

CLASS z2ui5_cl_demo_app_131 IMPLEMENTATION.

  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'ONSELECTICONTABBAR'.

        CASE mv_selectedkey.

          WHEN space.

          WHEN OTHERS.

        ENDCASE.

      WHEN 'BACK'.

    ENDCASE.

  ENDMETHOD.

  METHOD on_init.

    DATA temp1 TYPE z2ui5_cl_demo_app_131=>ty_t_t002.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-id = '1'.
    temp2-class = 'Z2UI5_CL_DEMO_APP_132'.
    temp2-count = '12'.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = '2'.
    temp2-class = 'Z2UI5_CL_DEMO_APP_132'.
    temp2-count = '80'.
    INSERT temp2 INTO TABLE temp1.
    mt_t002 = temp1.

    mv_selectedkey = '1'.

  ENDMETHOD.

  METHOD render_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( )->shell( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page( id             = `page_main`
                             title          = 'Main App calling Subapps'
                             navbuttonpress = client->_event( 'BACK' )
                             shownavbutton  = temp1
                             class          = 'sapUiContentPadding' ).

    DATA lo_items TYPE REF TO z2ui5_cl_xml_view.
    lo_items = page->icon_tab_bar( class       = 'sapUiResponsiveContentPadding'
                                         selectedkey = client->_bind_edit( mv_selectedkey )
                                         select      = client->_event( val = 'ONSELECTICONTABBAR' )
                                                       )->items( ).

    DATA temp3 LIKE LINE OF mt_t002.
    DATA line LIKE REF TO temp3.
    LOOP AT mt_t002 REFERENCE INTO line.
      lo_items->icon_tab_filter( text  = line->class
                                 count = line->count
                                 key   = line->id ).
      lo_items->icon_tab_separator( ).
    ENDLOOP.

    mo_main_page = lo_items.

  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      on_init( ).
      render_main( ).
    ENDIF.

    on_event( ).
    render_sub_app( ).

  ENDMETHOD.

  METHOD render_sub_app.
    FIELD-SYMBOLS <view_display> TYPE any.


    DATA t002 TYPE REF TO z2ui5_cl_demo_app_131=>ty_s_t002.
    READ TABLE mt_t002 REFERENCE INTO t002
         WITH KEY id = mv_selectedkey.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    CASE mv_selectedkey.

      WHEN OTHERS.

        IF mv_selectedkey <> mv_selectedkey_tmp.
          CREATE OBJECT mo_app TYPE (t002->class).
        ENDIF.
        TRY.

            CALL METHOD mo_app->('SET_APP_DATA')
              EXPORTING
                count = t002->count
                table = t002->table.

            render_main( ).

            FIELD-SYMBOLS <view> TYPE any.
            ASSIGN mo_app->('MO_PARENT_VIEW') TO <view>.
            IF <view> IS ASSIGNED.
              <view> = mo_main_page.
            ENDIF.

            CALL METHOD mo_app->('Z2UI5_IF_APP~MAIN')
              EXPORTING
                client = client.

          CATCH cx_root.
            RETURN.
        ENDTRY.

    ENDCASE.

    client->view_model_update( ).


    ASSIGN mo_app->('MV_VIEW_DISPLAY') TO <view_display>.

    IF <view_display> = abap_true.
      <view_display> = abap_false.
      client->view_display( mo_main_page->stringify( ) ).
    ENDIF.

    IF mv_selectedkey <> mv_selectedkey_tmp.

      client->view_display( mo_main_page->stringify( ) ).
      mv_selectedkey_tmp = mv_selectedkey.

    ENDIF.
  ENDMETHOD.

ENDCLASS.

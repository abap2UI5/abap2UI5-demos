CLASS z2ui5_cl_demo_app_211 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_t002,
        id    TYPE string,
        icon  TYPE string,
        count TYPE string,
        table TYPE string,
        descr TYPE string,
        class TYPE string,
      END OF ty_s_t002.
    TYPES ty_t_t002 TYPE STANDARD TABLE OF ty_s_t002 WITH DEFAULT KEY.

    DATA mv_selectedkey     TYPE string.
    DATA mv_selectedkey_tmp TYPE string.
    DATA mt_t002            TYPE ty_t_t002.
    DATA mo_app             TYPE REF TO object.

  PROTECTED SECTION.
    DATA mo_main_page      TYPE REF TO z2ui5_cl_xml_view.

    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS on_init.
    METHODS on_event.
    METHODS render_main.



    METHODS render_sub_app.

  PRIVATE SECTION.

ENDCLASS.


CLASS z2ui5_cl_demo_app_211 IMPLEMENTATION.


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

    DATA temp1 TYPE z2ui5_cl_demo_app_211=>ty_t_t002.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-class = 'Z2UI5_CL_DEMO_APP_212'.
    temp2-id = '1'.
    temp2-count = '5'.
    temp2-table = 'Z2UI5_T003'.
    temp2-descr = 'Table 01'.
    temp2-icon = 'sap-icon://add'.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = '3'.
    temp2-count = '15'.
    temp2-table = 'Z2UI5_T004'.
    temp2-descr = 'Table 02'.
    temp2-icon = 'sap-icon://accept'.
    INSERT temp2 INTO TABLE temp1.
    mt_t002 = temp1.

    mv_selectedkey = '1'.

  ENDMETHOD.

  METHOD render_main.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( )->shell( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->page( id             = `page_main`
                             title          = 'Customizing'
                             navbuttonpress = client->_event( 'BACK' )
                             shownavbutton  = abap_true
                             class          = 'sapUiContentPadding' ).

    DATA lo_items TYPE REF TO z2ui5_cl_xml_view.
    lo_items = page->icon_tab_bar( class       = 'sapUiResponsiveContentPadding'
                                         selectedkey = client->_bind_edit( mv_selectedkey )
                                         select      = client->_event( val = 'ONSELECTICONTABBAR' )
                                                       )->items( ).

    DATA temp3 LIKE LINE OF mt_t002.
    DATA line LIKE REF TO temp3.
    LOOP AT mt_t002 REFERENCE INTO line.

      DATA text LIKE line->descr.
      text = line->descr.
      DATA with_icon LIKE line->icon.
      with_icon = line->icon.

      lo_items->icon_tab_filter( icon      = line->icon
                                 iconcolor = 'Positive'
                                 count     = line->count
                                 text      = text
                                 key       = line->id
                                 showall   = with_icon ).

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

    DATA t002 TYPE REF TO z2ui5_cl_demo_app_211=>ty_s_t002.
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
              EXPORTING table = t002->table.

            render_main( ).

            FIELD-SYMBOLS <view> TYPE any.
            ASSIGN mo_app->('MO_PARENT_VIEW') TO <view>.
            IF <view> IS ASSIGNED.
              <view> = mo_main_page.
            ENDIF.

            CALL METHOD mo_app->('Z2UI5_IF_APP~MAIN')
              EXPORTING client = client.

          CATCH cx_root.
            RETURN.
        ENDTRY.

    ENDCASE.

    FIELD-SYMBOLS <view_display> TYPE any.
    ASSIGN mo_app->('MV_VIEW_DISPLAY') TO <view_display>.

    IF <view_display> = abap_true.
      <view_display> = abap_false.
      client->view_display( mo_main_page->stringify( ) ).
    ENDIF.

    FIELD-SYMBOLS <view_update> TYPE any.
    ASSIGN mo_app->('MV_VIEW_MODEL_UPDATE') TO <view_update>.

    IF <view_update> = abap_true.
      <view_update> = abap_false.
      client->view_model_update( ).
    ENDIF.

    IF mv_selectedkey <> mv_selectedkey_tmp.

      client->view_display( mo_main_page->stringify( ) ).

      mv_selectedkey_tmp = mv_selectedkey.

    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS z2ui5_cl_demo_app_307 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES: BEGIN OF ty_item,
             busy               TYPE abap_bool,
             busyindicatordelay TYPE i,
             busyindicatorsize  TYPE string,
             counter            TYPE i,
             fieldgroupids      TYPE string,
             highlight          TYPE string,
             highlighttext      TYPE string,
             navigated          TYPE abap_bool,
             selected           TYPE abap_bool,
             type               TYPE string,
             unread             TYPE abap_bool,
             visiple            TYPE abap_bool,
             title              TYPE string,
             subtitle           TYPE string,
           END OF ty_item.
    TYPES ty_items TYPE STANDARD TABLE OF ty_item WITH DEFAULT KEY.

    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.
    DATA items             TYPE ty_items.

    METHODS initialization.

    METHODS display_view
      IMPORTING !client TYPE REF TO z2ui5_if_client.

    METHODS on_event
      IMPORTING !client TYPE REF TO z2ui5_if_client.

ENDCLASS.


CLASS z2ui5_cl_demo_app_307 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      initialization( ).
      display_view( client ).
    ENDIF.

    on_event( client ).
  ENDMETHOD.

  METHOD initialization.
    DATA temp1 TYPE z2ui5_cl_demo_app_307=>ty_items.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-title = `Box title 1`.
    temp2-subtitle = `Subtitle 1`.
    temp2-counter = 5.
    temp2-highlight = `Error`.
    temp2-unread = abap_true.
    temp2-type = `Active`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 2`.
    temp2-subtitle = `Subtitle 2`.
    temp2-counter = 15.
    temp2-highlight = `Warning`.
    temp2-type = `Active`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 3`.
    temp2-subtitle = `Subtitle 3`.
    temp2-counter = 15734.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    temp2-busy = abap_true.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 4`.
    temp2-subtitle = `Subtitle 4`.
    temp2-counter = 2.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 5`.
    temp2-subtitle = `Subtitle 5`.
    temp2-counter = 1.
    temp2-highlight = `Warning`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 6 Box title Box title Box title Box title Box title`.
    temp2-subtitle = `Subtitle 6`.
    temp2-counter = 5.
    temp2-highlight = `None`.
    temp2-type = `Active`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Very long Box title that should wrap 7`.
    temp2-subtitle = `This is a long subtitle 7`.
    temp2-counter = 5.
    temp2-highlight = `Error`.
    temp2-type = `DetailAndActive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 8`.
    temp2-subtitle = `Subtitle 8`.
    temp2-counter = 0.
    temp2-highlight = `None`.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 9 Box title B  Box title B 9 Box title B 9Box title B 9title B 9 Box title B 9Box title B`.
    temp2-subtitle = `Subtitle 9`.
    temp2-highlight = `Success`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 10`.
    temp2-subtitle = `Subtitle 10`.
    temp2-highlight = `None`.
    temp2-type = `Active`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 11`.
    temp2-subtitle = `Subtitle 11`.
    temp2-highlight = `None`.
    temp2-type = `Active`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 12`.
    temp2-subtitle = `Subtitle 12`.
    temp2-highlight = `Information`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 13`.
    temp2-subtitle = `Subtitle 13`.
    temp2-counter = 5.
    temp2-highlight = `None`.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 14`.
    temp2-subtitle = `Subtitle 14`.
    temp2-highlight = `Success`.
    temp2-type = `DetailAndActive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 15`.
    temp2-subtitle = `Subtitle 15`.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 16`.
    temp2-subtitle = `Subtitle 16`.
    temp2-counter = 37412578.
    temp2-highlight = `None`.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 17`.
    temp2-subtitle = `Subtitle 17`.
    temp2-highlight = `Information`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title 18`.
    temp2-subtitle = `Subtitle 18`.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Very long Box title that should wrap 19`.
    temp2-subtitle = `This is a long subtitle 19`.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 20`.
    temp2-subtitle = `Subtitle 20`.
    temp2-counter = 1.
    temp2-busy = abap_true.
    temp2-highlight = `Success`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 21`.
    temp2-subtitle = `Subtitle 21`.
    temp2-highlight = `None`.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 22`.
    temp2-subtitle = `Subtitle 22`.
    temp2-counter = 5.
    temp2-highlight = `None`.
    temp2-unread = abap_true.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 23`.
    temp2-subtitle = `Subtitle 23`.
    temp2-counter = 3.
    temp2-highlight = `None`.
    temp2-unread = abap_true.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 24`.
    temp2-subtitle = `Subtitle 24`.
    temp2-counter = 5.
    temp2-highlight = `Error`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 21`.
    temp2-subtitle = `Subtitle 21`.
    temp2-highlight = `None`.
    temp2-type = `Inactive`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 22`.
    temp2-subtitle = `Subtitle 22`.
    temp2-highlight = `None`.
    temp2-unread = abap_true.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `Box title B 23`.
    temp2-subtitle = `Subtitle 23`.
    temp2-highlight = `None`.
    temp2-type = `Navigation`.
    INSERT temp2 INTO TABLE temp1.
    items = temp1.
  ENDMETHOD.

  METHOD display_view.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    view->_z2ui5( )->title( `Grid List with Drag and Drop` ).

    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$parameters>/draggedControl/oParent}.indexOfItem(${$parameters>/draggedControl})` INTO TABLE temp3.
    INSERT `${$parameters>/droppedControl/oParent}.indexOfItem(${$parameters>/droppedControl})` INTO TABLE temp3.
    INSERT `${$parameters>/dropPosition}` INTO TABLE temp3.
    view->panel( id               = `panelForGridList`
                 backgrounddesign = `Transparent`
        )->header_toolbar(
            )->toolbar( height = `3rem`
                )->title( text = `Grid List with Drag and Drop`
            )->get_parent(
        )->get_parent(
        )->grid_list( id         = `gridList`
                      headertext = `GridList header`
                      items      = client->_bind_edit( items )
            )->drag_drop_config(
                )->drag_info( sourceaggregation = `items`
                )->grid_drop_info(
                    targetaggregation = `items`
                    dropposition      = `Between`
                    droplayout        = `Horizontal`
                    drop              = client->_event(
                        val   = 'onDrop'
                        t_arg = temp3 )
            )->get_parent(
            )->custom_layout( ns = 'f'
                )->grid_box_layout( boxminwidth = `17rem`
            )->get_parent(
            )->grid_list_item( counter   = '{COUNTER}'
                               highlight = '{HIGHLIGHT}'
                               type      = '{TYPE}'
                               unread    = '{UNREAD}'
                )->vbox( height = `100%`
                    )->vbox( class = `sapUiSmallMargin`
                        )->layout_data(
                            )->flex_item_data( growfactor   = `1`
                                               shrinkfactor = `0`
                        )->get_parent(
                        )->title( text     = '{TITLE}'
                                  wrapping = abap_true
                        )->label( text     = '{SUBTITLE}'
                                  wrapping = abap_true ).

    client->view_display( view->stringify( ) ).
  ENDMETHOD.

  METHOD on_event.
    CASE client->get( )-event.
      WHEN 'onDrop'.
        DATA ondropparameters TYPE string_table.
        ondropparameters = client->get( )-t_event_arg.
        TRY.
            DATA temp5 TYPE i.
            DATA temp1 LIKE LINE OF ondropparameters.
            DATA temp2 LIKE sy-tabix.
            temp2 = sy-tabix.
            READ TABLE ondropparameters INDEX 1 INTO temp1.
            sy-tabix = temp2.
            IF sy-subrc <> 0.
              ASSERT 1 = 0.
            ENDIF.
            temp5 = temp1.
            DATA drag_position TYPE i.
            drag_position = temp5 + 1.
            DATA temp6 TYPE i.
            DATA temp3 LIKE LINE OF ondropparameters.
            DATA temp4 LIKE sy-tabix.
            temp4 = sy-tabix.
            READ TABLE ondropparameters INDEX 2 INTO temp3.
            sy-tabix = temp4.
            IF sy-subrc <> 0.
              ASSERT 1 = 0.
            ENDIF.
            temp6 = temp3.
            DATA drop_position TYPE i.
            drop_position = temp6 + 1.
            DATA insert_position LIKE LINE OF ondropparameters.
            DATA temp7 LIKE LINE OF ondropparameters.
            DATA temp8 LIKE sy-tabix.
            temp8 = sy-tabix.
            READ TABLE ondropparameters INDEX 3 INTO temp7.
            sy-tabix = temp8.
            IF sy-subrc <> 0.
              ASSERT 1 = 0.
            ENDIF.
            insert_position = temp7.
            DATA item LIKE LINE OF items.
            DATA temp9 LIKE LINE OF items.
            DATA temp10 LIKE sy-tabix.
            temp10 = sy-tabix.
            READ TABLE items INDEX drag_position INTO temp9.
            sy-tabix = temp10.
            IF sy-subrc <> 0.
              ASSERT 1 = 0.
            ENDIF.
            item = temp9.
          CATCH cx_root.
            RETURN.
        ENDTRY.

        DELETE items INDEX drag_position.

        IF drag_position < drop_position.
          drop_position = drop_position - 1.
        ENDIF.

        IF insert_position = `Before`.
          INSERT item INTO items INDEX drop_position.
        ELSE.
          INSERT item INTO items INDEX drop_position + 1.
        ENDIF.

    ENDCASE.
    client->view_model_update( ).
  ENDMETHOD.
ENDCLASS.

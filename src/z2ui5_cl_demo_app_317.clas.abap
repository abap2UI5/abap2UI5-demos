CLASS z2ui5_cl_demo_app_317 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_node4,
        id   TYPE string,
        text TYPE string,
*        nodes TYPE STANDARD TABLE OF ty_node5 WITH DEFAULT KEY,
      END OF ty_node4,
      BEGIN OF ty_node3,
        id    TYPE string,
        text  TYPE string,
        nodes TYPE STANDARD TABLE OF ty_node4 WITH DEFAULT KEY,
      END OF ty_node3,
      BEGIN OF ty_node2,
        id    TYPE string,
        text  TYPE string,
        nodes TYPE STANDARD TABLE OF ty_node3 WITH DEFAULT KEY,
      END OF ty_node2,
      BEGIN OF ty_node1,
        id    TYPE string,
        text  TYPE string,
        nodes TYPE STANDARD TABLE OF ty_node2 WITH DEFAULT KEY,
      END OF ty_node1,
      ty_tree TYPE STANDARD TABLE OF ty_node1 WITH DEFAULT KEY.
    DATA mt_tree    TYPE ty_tree.

    TYPES:
      BEGIN OF ty_S_node,
        id        TYPE string,
        id_parent TYPE string,
        text      TYPE string,
      END OF ty_S_node.
    DATA mt_node TYPE STANDARD TABLE OF ty_S_node WITH DEFAULT KEY.

  PROTECTED SECTION.
    METHODS build_tree.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

ENDCLASS.

CLASS z2ui5_cl_demo_app_317 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ) IS NOT INITIAL.

      DATA temp1 LIKE mt_node.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-id = '01'.
      temp2-id_parent = ''.
      temp2-text = 'Machines'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '03'.
      temp2-id_parent = '01'.
      temp2-text = 'Pumps'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '04'.
      temp2-id_parent = '03'.
      temp2-text = 'Pump 001'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '05'.
      temp2-id_parent = '03'.
      temp2-text = 'Pump 002'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '02'.
      temp2-id_parent = ''.
      temp2-text = 'Paints'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '06'.
      temp2-id_parent = '02'.
      temp2-text = 'Gloss paints'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '07'.
      temp2-id_parent = '06'.
      temp2-text = 'Paint 001'.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = '08'.
      temp2-id_parent = '06'.
      temp2-text = 'Paint 002'.
      INSERT temp2 INTO TABLE temp1.
      mt_node = temp1.

      build_tree( ).
      display_view( client ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'expand'.
        client->follow_up_action( `debugger; z2ui5.oView.byId( 'tree' ).expandToLevel(10);`).

      WHEN 'onDrop'.
        FIELD-SYMBOLS <temp3> LIKE LINE OF mt_node.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE mt_node WITH KEY id = client->get_event_arg( 1 ) ASSIGNING <temp3>.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        <temp3>-id_parent = client->get_event_arg( 2 ).
        build_tree( ).
        display_view( client ).
    ENDCASE.


  ENDMETHOD.

  METHOD build_tree.

    CLEAR mt_tree.
    DATA ls_node LIKE LINE OF mt_node.
    LOOP AT mt_node INTO ls_node WHERE id_parent IS INITIAL.

      DATA temp5 TYPE ty_node1.
      CLEAR temp5.
      MOVE-CORRESPONDING ls_node TO temp5.
      DATA ls_root LIKE temp5.
      ls_root = temp5.
      INSERT ls_root INTO TABLE mt_tree.

    ENDLOOP.


    DATA temp6 LIKE LINE OF mt_tree.
    DATA lr_node LIKE REF TO temp6.
    LOOP AT mt_tree REFERENCE INTO lr_node.

      LOOP AT mt_node INTO ls_node WHERE id_parent = lr_node->id.
        DATA temp7 TYPE ty_node2.
        CLEAR temp7.
        MOVE-CORRESPONDING ls_node TO temp7.
        DATA ls_root2 LIKE temp7.
        ls_root2 = temp7.
        INSERT ls_root2 INTO TABLE lr_node->nodes.
      ENDLOOP.

    ENDLOOP.


    LOOP AT mt_tree REFERENCE INTO lr_node.
      DATA temp8 LIKE LINE OF lr_node->nodes.
      DATA lr_node2 LIKE REF TO temp8.
      LOOP AT lr_node->nodes REFERENCE INTO lr_node2.

        LOOP AT mt_node INTO ls_node WHERE id_parent = lr_node2->id.
          DATA temp9 TYPE ty_node3.
          CLEAR temp9.
          MOVE-CORRESPONDING ls_node TO temp9.
          DATA ls_root3 LIKE temp9.
          ls_root3 = temp9.
          INSERT ls_root3 INTO TABLE lr_node2->nodes.
        ENDLOOP.

      ENDLOOP.
    ENDLOOP.


    LOOP AT mt_tree REFERENCE INTO lr_node.
      LOOP AT lr_node->nodes REFERENCE INTO lr_node2.
        DATA temp10 LIKE LINE OF lr_node2->nodes.
        DATA lr_node3 LIKE REF TO temp10.
        LOOP AT lr_node2->nodes REFERENCE INTO lr_node3.

          LOOP AT mt_node INTO ls_node WHERE id_parent = lr_node3->id.
            DATA temp11 TYPE ty_node4.
            CLEAR temp11.
            MOVE-CORRESPONDING ls_node TO temp11.
            DATA ls_root4 LIKE temp11.
            ls_root4 = temp11.
            INSERT ls_root4 INTO TABLE lr_node3->nodes.
          ENDLOOP.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( )->page( ).

    page->_generic( name = `script` ns = `html`
        )->_cc_plain_xml(
          |function myFunction() \{ z2ui5.oView.byId('tree').expandToLevel(5); \}|
        ).

    DATA tree TYPE REF TO z2ui5_cl_xml_view.
    tree = page->tree( items = client->_bind( mt_tree ) id = `tree` ).
    tree->items(
        )->standard_tree_item( title = '{TEXT}'
        )->get(
          )->custom_data(
              )->core_custom_data( key   = 'ID' value = '{ID}').

    DATA temp12 TYPE string_table.
    CLEAR temp12.
    INSERT `${$parameters>/draggedControl/mAggregations/customData/0/mProperties/value}` INTO TABLE temp12.
    INSERT `${$parameters>/droppedControl/mAggregations/customData/0/mProperties/value}` INTO TABLE temp12.
    tree->drag_drop_config( ns = `` )->Drag_Drop_Info(
      sourceAggregation = `items`
      targetAggregation = `items`
      dragStart         = `Horizontal`
      drop              = client->_event(
                              val   = 'onDrop'
                              t_arg = temp12 ) ).

    client->follow_up_action( `myFunction()` ).
    client->view_display( page->stringify( ) ).

  ENDMETHOD.

ENDCLASS.

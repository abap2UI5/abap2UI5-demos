CLASS z2ui5_cl_demo_app_116 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_prodh_node_level3,
        is_selected TYPE abap_bool,
        text        TYPE string,
        counter     TYPE i,
        prodh       TYPE string,
      END OF ty_prodh_node_level3 .
    TYPES:
      BEGIN OF ty_prodh_node_level2,
        is_selected TYPE abap_bool,
        text        TYPE string,
        counter     TYPE i,
        prodh       TYPE string,
        nodes       TYPE STANDARD TABLE OF ty_prodh_node_level3 WITH DEFAULT KEY,
      END OF ty_prodh_node_level2 .
    TYPES:
      BEGIN OF ty_prodh_node_level1,
        is_selected TYPE abap_bool,
        text        TYPE string,
        counter     TYPE i,
        prodh       TYPE string,
        nodes       TYPE STANDARD TABLE OF ty_prodh_node_level2 WITH DEFAULT KEY,
      END OF ty_prodh_node_level1 .
    TYPES
      ty_prodh_nodes TYPE STANDARD TABLE OF ty_prodh_node_level1 WITH DEFAULT KEY .
    TYPES
      ty_prin_nodes TYPE STANDARD TABLE OF ty_prodh_node_level2 WITH DEFAULT KEY.

    DATA prodh_nodes TYPE ty_prodh_nodes .
    DATA is_initialized TYPE abap_bool .
    DATA gv_user TYPE uname.
    DATA gv_date TYPE d.

    DATA mv_run_js TYPE abap_bool VALUE abap_false.

    METHODS ui5_display_view .
    METHODS ui5_display_popover
      IMPORTING
        !id TYPE string .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    METHODS ui5_initialize.
    METHODS add_node
      IMPORTING p_prodh TYPE string.


  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_116 IMPLEMENTATION.


  METHOD add_node.
    FIELD-SYMBOLS <fs1> LIKE LINE OF prodh_nodes.
    LOOP AT prodh_nodes ASSIGNING <fs1>.
      IF <fs1>-prodh = p_prodh.
        <fs1>-counter = <fs1>-counter + 1.
        EXIT.
      ELSE.
        FIELD-SYMBOLS <fs2> LIKE LINE OF <fs1>-nodes.
        LOOP AT <fs1>-nodes ASSIGNING <fs2>.
          IF <fs2>-prodh = p_prodh.
            <fs2>-counter = <fs2>-counter + 1.
            EXIT.
          ELSE.
            FIELD-SYMBOLS <fs3> LIKE LINE OF <fs2>-nodes.
            LOOP AT <fs2>-nodes ASSIGNING <fs3>.
              IF <fs3>-prodh = p_prodh.
                <fs3>-counter = <fs3>-counter + 1.
                EXIT.

              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD ui5_display_popover.
    DATA lo_popover TYPE REF TO z2ui5_cl_xml_view.
    lo_popover = z2ui5_cl_xml_view=>factory_popup( ).
    lo_popover->popover( placement = `Right`
                         title     = 'SS' "text-028 "`Stock - Details:`
                                                         "&& '-' && gv_matnr  "contentwidth = `32%`
            )->footer(
             )->overflow_toolbar(
                )->toolbar_spacer(
                )->button(
                    text  = 'OK'
                    press = client->_event( 'POPOVER_OK' )
                    type  = 'Emphasized'
           )->get_parent( )->get_parent(
           )->text( 'TEST' ).

    client->popover_display( xml   = lo_popover->stringify( )
                             by_id = id ).
  ENDMETHOD.


  METHOD ui5_display_view.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).



    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->object_page_layout(
            showtitleinheadercontent = abap_true
            uppercaseanchorbar       = abap_false ).

    DATA header_title TYPE REF TO z2ui5_cl_xml_view.
    header_title = page->header_title( )->object_page_dyn_header_title( ).
    header_title->expanded_heading(
            )->hbox(
                )->title( text = 'PriceList' ).

    DATA header_content TYPE REF TO z2ui5_cl_xml_view.
    header_content = page->header_content( ns = 'uxap').
    header_content->block_layout(
      )->block_layout_row(
      )->block_layout_cell( backgroundcolorset   = 'ColorSet10'
                            backgroundcolorshade = 'ShadeE'
      )->flex_box( justifycontent = 'SpaceBetween'
      )->hbox(
      )->vertical_layout( class = 'sapUiSmallMarginBeginEnd'
          )->label( design = 'Bold'
                    text   = 'Something:'
      )->get_parent(
      )->vertical_layout( class = 'sapUiSmallMarginBeginEnd'
        )->text( text = 'Other'
      )->get_parent( )->get_parent(
      )->hbox( justifycontent = 'End'
        )->vertical_layout( class = 'sapUiSmallMarginBeginEnd'
          )->label( design = 'Bold'
                    text   = 'User:'
          )->label( design = 'Bold'
                    text   = 'Date:'
        )->get_parent(
      )->vertical_layout( class = 'sapUiSmallMarginBeginEnd'
        )->text( text = client->_bind( gv_user )
        )->text( text = client->_bind( gv_date ) ).


    DATA sections TYPE REF TO z2ui5_cl_xml_view.
    sections = page->sections( ).



    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/id}` INTO TABLE temp1.
    DATA temp2 TYPE string_table.
    CLEAR temp2.
    INSERT `${PRODH}` INTO TABLE temp2.
    DATA cont TYPE REF TO z2ui5_cl_xml_view.
    cont = sections->object_page_section( titleuppercase = abap_false
                                                id             = 'Sets'
                                                title          = 'Sets'
        )->heading( ns = `uxap`
        )->get_parent(
        )->sub_sections(
            )->object_page_sub_section( id    = 'SETS'
                                        title = 'Sets'
                )->scroll_container( vertical = abap_true
                 )->vbox(
                      )->tree_table( id  = 'treeTable'
                         rows            = `{path:'` && client->_bind( val = prodh_nodes path = abap_true ) && `', parameters: {arrayNames:['NODES']}}`
                         toggleopenstate = `saveState()`
                         )->tree_columns(
                          )->tree_column( label = 'Label'
                          )->tree_template(
                           )->text( text = `{####}`
                          )->get_parent( )->get_parent(
                          )->tree_column( label = 'PRODH'
                          )->tree_template(
                           )->text( text = `{PRODH}`
                          )->get_parent( )->get_parent(
                          )->tree_column( label = 'Counter'
                          )->tree_template(
                           )->link( text    = `{COUNTER}`
                                      press = client->_event( val = 'POPOVER' t_arg = temp1 )
      )->get_parent( )->get_parent(
                          )->tree_column( label = 'ADD'
                          )->tree_template(
                           )->button( icon = 'sap-icon://add'
                                 press     = client->_event( val = 'ROW_ADD' t_arg = temp2 )
                                 tooltip   = 'ADD'
                          )->get_parent( )->get_parent( ).
    client->view_display( page->get_root( )->xml_get( ) ).
  ENDMETHOD.


  METHOD ui5_initialize.
    DATA temp3 TYPE z2ui5_cl_demo_app_116=>ty_prodh_nodes.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-text = 'Machines'.
    temp4-prodh = '00100'.
    DATA temp5 TYPE z2ui5_cl_demo_app_116=>ty_prodh_node_level1-nodes.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-text = 'Pumps'.
    temp6-prodh = '0010000100'.
    DATA temp1 TYPE z2ui5_cl_demo_app_116=>ty_prodh_node_level2-nodes.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-text = 'Pump 001'.
    temp2-prodh = '001000010000000100'.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = 'Pump 002'.
    temp2-prodh = '001000010000000105'.
    INSERT temp2 INTO TABLE temp1.
    temp6-nodes = temp1.
    INSERT temp6 INTO TABLE temp5.
    temp4-nodes = temp5.
    INSERT temp4 INTO TABLE temp3.
    temp4-text = 'Paints'.
    temp4-prodh = '00110'.
    DATA temp7 TYPE z2ui5_cl_demo_app_116=>ty_prodh_node_level1-nodes.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-text = 'Gloss paints'.
    temp8-prodh = '0011000105'.
    DATA temp9 TYPE z2ui5_cl_demo_app_116=>ty_prodh_node_level2-nodes.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-text = 'Paint 001'.
    temp10-prodh = '001100010500000100'.
    INSERT temp10 INTO TABLE temp9.
    temp10-text = 'Paint 002'.
    temp10-prodh = '001100010500000105'.
    INSERT temp10 INTO TABLE temp9.
    temp8-nodes = temp9.
    INSERT temp8 INTO TABLE temp7.
    temp4-nodes = temp7.
    INSERT temp4 INTO TABLE temp3.
    prodh_nodes =
      temp3.

    gv_user = sy-uname.
    gv_date = sy-datum.
  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    DATA lt_event_arg TYPE string_table.

    me->client = client.

    IF is_initialized = abap_false.
      is_initialized = abap_true.
      ui5_initialize( ).

      DATA lv_save_state_js TYPE string.
      lv_save_state_js = `function saveState() {debugger;` && |\n| &&
                         `  var treeTable = sap.z2ui5.oView.byId("treeTable");` && |\n| &&
                         `  sap.z2ui5.treeState = treeTable.getBinding('rows').getCurrentTreeState();` && |\n| &&
                         ` }; `.

      DATA lv_reset_state_js TYPE string.
      lv_reset_state_js = `function setState() {debugger;` && |\n| &&
                                ` var treeTable = sap.z2ui5.oView.byId("treeTable");` && |\n| &&
                                ` if( sap.z2ui5.treeState == undefined ) {` && |\n| &&
                                `     sap.z2ui5.treeState = treeTable.getBinding('rows').getCurrentTreeState();` && |\n| &&
                                ` } else {` && |\n| &&
                                `     treeTable.getBinding("rows").setTreeState(sap.z2ui5.treeState);` && |\n| &&
                                `     treeTable.getBinding("rows").refresh();` && |\n| &&
                                `     sap.z2ui5.treeState = treeTable.getBinding('rows').getCurrentTreeState();` && |\n| &&
                                ` };` && |\n| &&
                                `};`.

      client->view_display( z2ui5_cl_xml_view=>factory(
        )->_z2ui5( )->timer( client->_event( `START` )
          )->_generic( ns   = `html`
                       name = `script` )->_cc_plain_xml( lv_save_state_js )->get_parent(
          )->_generic( ns   = `html`
                       name = `script` )->_cc_plain_xml( lv_reset_state_js
          )->stringify( ) ).
    ENDIF.


    lt_event_arg = client->get( )-t_event_arg.
    CASE client->get( )-event.

      WHEN 'START'.
        ui5_display_view( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'CONTINUE'.
        client->popup_destroy( ).

      WHEN 'CANCEL'.
        client->popup_destroy( ).
      WHEN 'POPOVER'.
        lt_event_arg = client->get( )-t_event_arg.
        DATA lv_open_by_id LIKE LINE OF lt_event_arg.
        DATA temp9 LIKE LINE OF lt_event_arg.
        DATA temp10 LIKE sy-tabix.
        temp10 = sy-tabix.
        READ TABLE lt_event_arg INDEX 1 INTO temp9.
        sy-tabix = temp10.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        lv_open_by_id = temp9.
        ui5_display_popover( lv_open_by_id ).

      WHEN 'ROW_ADD'.
        DATA temp5 LIKE LINE OF lt_event_arg.
        DATA temp6 LIKE sy-tabix.
        temp6 = sy-tabix.
        READ TABLE lt_event_arg INDEX 1 INTO temp5.
        sy-tabix = temp6.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        add_node( temp5 ).

        mv_run_js = abap_true.

        client->view_model_update( ).

        client->follow_up_action( val = `setState();` ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.

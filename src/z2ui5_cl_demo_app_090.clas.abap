CLASS z2ui5_cl_demo_app_090 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES: BEGIN OF t_items2,
             columnkey TYPE string,
             text      TYPE string,
             visible   TYPE abap_bool,
             index     TYPE i,
           END OF t_items2.
    TYPES tt_items2 TYPE STANDARD TABLE OF t_items2 WITH DEFAULT KEY.

    TYPES: BEGIN OF t_items3,
             columnkey     TYPE string,
             operation     TYPE string,
             showifgrouped TYPE abap_bool,
             key           TYPE string,
             text          TYPE string,
           END OF t_items3.
    TYPES tt_items3 TYPE STANDARD TABLE OF t_items3 WITH DEFAULT KEY.

    DATA mt_columns TYPE tt_items2.
    DATA mt_columns1 TYPE tt_items2.
    DATA mt_groups TYPE tt_items3.

    "P13N
    TYPES: BEGIN OF t_items22,
             visible TYPE abap_bool,
             name    TYPE string,
             label   TYPE string,
           END OF t_items22.
    TYPES tt_items22 TYPE STANDARD TABLE OF t_items22 WITH DEFAULT KEY.

    TYPES: BEGIN OF t_items32,
             sorted     TYPE abap_bool,
             name       TYPE string,
             label      TYPE string,
             descending TYPE abap_bool,
           END OF t_items32.
    TYPES tt_items32 TYPE STANDARD TABLE OF t_items32 WITH DEFAULT KEY.

    TYPES: BEGIN OF t_items33,
             grouped TYPE abap_bool,
             name    TYPE string,
             label   TYPE string,
           END OF t_items33.
    TYPES tt_items33 TYPE STANDARD TABLE OF t_items33 WITH DEFAULT KEY.

    DATA mt_columns_p13n TYPE tt_items22.
    DATA mt_sort_p13n TYPE tt_items32.
    DATA mt_groups_p13n TYPE tt_items33.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.
    DATA check_cc_loaded TYPE abap_bool.

    METHODS z2ui5_view_display.
    METHODS z2ui5_view_p13n.
    METHODS z2ui5_view_p13n_popup.
    METHODS z2ui5_on_event.
    METHODS init_data_set.
    METHODS get_custom_js
      RETURNING
        VALUE(result) TYPE string.


  PRIVATE SECTION.
    DATA mv_page TYPE string.

ENDCLASS.



CLASS z2ui5_cl_demo_app_090 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.

    IF check_cc_loaded = abap_false.
      check_cc_loaded = abap_true.
      init_data_set( ).
      client->nav_app_call( z2ui5_cl_pop_js_loader=>factory( get_custom_js( ) ) ).
      RETURN.
    ELSEIF check_initialized = abap_false.
      check_initialized = abap_true.
      init_data_set( ).
      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'P13N_OPEN'.
        z2ui5_view_p13n( ).

      WHEN 'P13N_POPUP'.
        z2ui5_view_p13n_popup( ).

      WHEN 'OK' OR 'CANCEL'.
        client->popup_destroy( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_view_display.

    client->_bind_edit( val           = mt_columns_p13n
                        custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ).
    client->_bind_edit( val           = mt_sort_p13n
                        custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ).
    client->_bind_edit( val           = mt_groups_p13n
                        custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( ).

    DATA temp11 TYPE xsdboolean.
    temp11 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = page->shell( )->page(
        title          = 'abap2UI5 - P13N Dialog'
        navbuttonpress = client->_event( 'BACK' )
        shownavbutton  = temp11
        class          = 'sapUiContentPadding' ).

    page = page->vbox( ).

    DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-n = `title`.
    temp2-v = `My Custom View Settings`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `close`.
    temp2-v = `sap.z2ui5.updateData(${$parameters>/reason})`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `id`.
    temp2-v = `p13nPopup`.
    INSERT temp2 INTO TABLE temp1.
    DATA temp3 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-n = `id`.
    temp4-v = `columnsPanel`.
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `title`.
    temp4-v = `Columns`.
    INSERT temp4 INTO TABLE temp3.
    DATA temp5 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-n = `id`.
    temp6-v = `sortPanel`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `title`.
    temp6-v = `Sort`.
    INSERT temp6 INTO TABLE temp5.
    DATA temp7 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-n = `id`.
    temp8-v = `filterPanel`.
    INSERT temp8 INTO TABLE temp7.
    temp8-n = `title`.
    temp8-v = `Filter`.
    INSERT temp8 INTO TABLE temp7.
    DATA temp9 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-n = `id`.
    temp10-v = `groupPanel`.
    INSERT temp10 INTO TABLE temp9.
    temp10-n = `title`.
    temp10-v = `Group`.
    INSERT temp10 INTO TABLE temp9.
    page->_generic( name         = `Popup`
                    ns           = `p13n`
                          t_prop = temp1
                         )->_generic( name = `panels`
                                      ns   = `p13n`
                           )->_generic( name   = `SelectionPanel`
                                        ns     = `p13n`
                                        t_prop = temp3 )->get_parent(
                          )->_generic( name   = `SortPanel`
                                       ns     = `p13n`
                                       t_prop = temp5
                                                    )->get_parent(
                          )->_generic( name   = `P13nFilterPanel`
                                       ns     = ``
                                       t_prop = temp7
                                                    )->get_parent(
                         )->_generic( name   = `GroupPanel`
                                      ns     = `p13n`
                                      t_prop = temp9
                                      )->get_parent( )->get_parent( )->get_parent(
      )->get_parent( )->get_parent( ).

    page->button( text  = `Open P13N Dialog`
                  press = client->_event( 'P13N_OPEN' )
                  class = `sapUiTinyMarginBeginEnd`
      )->button( text  = `Open P13N.POPUP`
                 press = `sap.z2ui5.setInitialData()` )->get_parent( )->get_parent( ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_view_p13n.

    DATA p13n_dialog TYPE REF TO z2ui5_cl_xml_view.
    p13n_dialog = z2ui5_cl_xml_view=>factory_popup( ).

    DATA temp3 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-n = `ok`.
    temp4-v = client->_event( `OK` ).
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `cancel`.
    temp4-v = client->_event( `CANCEL` ).
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `reset`.
    temp4-v = client->_event( `RESET` ).
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `showReset`.
    temp4-v = `true`.
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `initialVisiblePanelType`.
    temp4-v = `sort`.
    INSERT temp4 INTO TABLE temp3.
    DATA temp5 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-n = `items`.
    temp6-v = `{path:'` && client->_bind_edit( val = mt_columns path = abap_true custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ) && `'}`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `columnsItems`.
    temp6-v = `{path:'` && client->_bind_edit( val = mt_columns1 path = abap_true custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ) && `'}`.
    INSERT temp6 INTO TABLE temp5.
    DATA temp7 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-n = `columnKey`.
    temp8-v = `{columnkey}`.
    INSERT temp8 INTO TABLE temp7.
    temp8-n = `text`.
    temp8-v = `{text}`.
    INSERT temp8 INTO TABLE temp7.
    DATA temp9 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-n = `columnKey`.
    temp10-v = `{columnkey}`.
    INSERT temp10 INTO TABLE temp9.
    temp10-n = `visible`.
    temp10-v = `{visible}`.
    INSERT temp10 INTO TABLE temp9.
    temp10-n = `index`.
    temp10-v = `{index}`.
    INSERT temp10 INTO TABLE temp9.
    DATA temp11 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-n = `groupItems`.
    temp12-v = `{path:'` && client->_bind_edit( val = mt_groups path = abap_true custom_mapper = z2ui5_cl_ajson_mapping=>create_lower_case( ) ) && `'}`.
    INSERT temp12 INTO TABLE temp11.
    DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-n = `columnKey`.
    temp2-v = `{columnkey}`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `text`.
    temp2-v = `{text}`.
    INSERT temp2 INTO TABLE temp1.
    DATA temp13 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp13.
    DATA temp14 LIKE LINE OF temp13.
    temp14-n = `columnKey`.
    temp14-v = `{columnkey}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `operation`.
    temp14-v = `{operation}`.
    INSERT temp14 INTO TABLE temp13.
    temp14-n = `showIfGrouped`.
    temp14-v = `{showifgrouped}`.
    INSERT temp14 INTO TABLE temp13.
    DATA p13n TYPE REF TO z2ui5_cl_xml_view.
    p13n = p13n_dialog->_generic( name = `P13nDialog`
      t_prop                                 = temp3
      )->_generic( name = `panels`
      )->_generic( name = `P13nColumnsPanel`
      t_prop            = temp5
      )->items(
         )->_generic( name = `P13nItem`
           t_prop          = temp7 )->get_parent( )->get_parent(
      )->_generic( name = `columnsItems`
           )->_generic( name = `P13nColumnsItem`
               t_prop        = temp9 )->get_parent( )->get_parent( )->get_parent(
      )->_generic( name = `P13nGroupPanel`
           t_prop       = temp11
      )->items(
      )->_generic( name = `P13nItem`
           t_prop       = temp1 )->get_parent( )->get_parent(
      )->_generic( name = `groupItems`
        )->_generic( name = `P13nGroupItem`
            t_prop        = temp13 ).

    client->popup_display( p13n->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_view_p13n_popup.

    DATA p13n_popup TYPE REF TO z2ui5_cl_xml_view.
    p13n_popup = z2ui5_cl_xml_view=>factory( ).

    DATA temp5 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-n = `title`.
    temp6-v = `My Custom View Settings`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `id`.
    temp6-v = `p13nPopup`.
    INSERT temp6 INTO TABLE temp5.
    DATA temp7 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-n = `id`.
    temp8-v = `columnsPanel`.
    INSERT temp8 INTO TABLE temp7.
    temp8-n = `title`.
    temp8-v = `Columns`.
    INSERT temp8 INTO TABLE temp7.
    DATA temp9 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-n = `id`.
    temp10-v = `sortPanel`.
    INSERT temp10 INTO TABLE temp9.
    temp10-n = `title`.
    temp10-v = `Sort`.
    INSERT temp10 INTO TABLE temp9.
    DATA temp11 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-n = `id`.
    temp12-v = `groupPanel`.
    INSERT temp12 INTO TABLE temp11.
    temp12-n = `title`.
    temp12-v = `Group`.
    INSERT temp12 INTO TABLE temp11.
    p13n_popup->_generic( name       = `Popup`
                          ns         = `p13n`
                              t_prop = temp5
                             )->_generic( name = `panels`
                                          ns   = `p13n`
                               )->_generic( name   = `SelectionPanel`
                                            ns     = `p13n`
                                            t_prop = temp7 )->get_parent(
                              )->_generic( name   = `SortPanel`
                                           ns     = `p13n`
                                           t_prop = temp9
                                                        )->get_parent(
                             )->_generic( name   = `GroupPanel`
                                          ns     = `p13n`
                                          t_prop = temp11
                                          )->get_parent( )->get_parent( )->get_parent( ).

    client->view_display( p13n_popup->stringify( ) ).

  ENDMETHOD.

  METHOD init_data_set.

    DATA temp7 TYPE z2ui5_cl_demo_app_090=>tt_items2.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-columnkey = `productId`.
    temp8-text = `Product ID`.
    INSERT temp8 INTO TABLE temp7.
    temp8-columnkey = `name`.
    temp8-text = `Name`.
    INSERT temp8 INTO TABLE temp7.
    temp8-columnkey = `category`.
    temp8-text = `Category`.
    INSERT temp8 INTO TABLE temp7.
    temp8-columnkey = `supplierName`.
    temp8-text = `Supplier Name`.
    INSERT temp8 INTO TABLE temp7.
    mt_columns = temp7.
    DATA temp9 TYPE z2ui5_cl_demo_app_090=>tt_items2.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-columnkey = `name`.
    temp10-visible = abap_true.
    temp10-index = 0.
    INSERT temp10 INTO TABLE temp9.
    temp10-columnkey = `category`.
    temp10-visible = abap_true.
    temp10-index = 1.
    INSERT temp10 INTO TABLE temp9.
    temp10-columnkey = `productId`.
    temp10-visible = abap_false.
    INSERT temp10 INTO TABLE temp9.
    temp10-columnkey = `supplierName`.
    temp10-visible = abap_false.
    INSERT temp10 INTO TABLE temp9.
    mt_columns1 = temp9.

    DATA temp11 TYPE z2ui5_cl_demo_app_090=>tt_items3.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-columnkey = `name`.
    temp12-text = `Name`.
    temp12-showifgrouped = abap_true.
    INSERT temp12 INTO TABLE temp11.
    temp12-columnkey = `category`.
    temp12-text = `Category`.
    temp12-showifgrouped = abap_true.
    INSERT temp12 INTO TABLE temp11.
    temp12-columnkey = `productId`.
    temp12-showifgrouped = abap_false.
    INSERT temp12 INTO TABLE temp11.
    temp12-columnkey = `supplierName`.
    temp12-showifgrouped = abap_false.
    INSERT temp12 INTO TABLE temp11.
    mt_groups = temp11.

    DATA temp13 TYPE z2ui5_cl_demo_app_090=>tt_items22.
    CLEAR temp13.
    DATA temp14 LIKE LINE OF temp13.
    temp14-visible = `true`.
    temp14-name = `key1`.
    temp14-label = `City`.
    INSERT temp14 INTO TABLE temp13.
    temp14-visible = `false`.
    temp14-name = `key2`.
    temp14-label = `Country`.
    INSERT temp14 INTO TABLE temp13.
    temp14-visible = `false`.
    temp14-name = `key2`.
    temp14-label = `Region`.
    INSERT temp14 INTO TABLE temp13.
    mt_columns_p13n = temp13.

    DATA temp15 TYPE z2ui5_cl_demo_app_090=>tt_items32.
    CLEAR temp15.
    DATA temp16 LIKE LINE OF temp15.
    temp16-sorted = `true`.
    temp16-name = `key1`.
    temp16-label = `City`.
    temp16-descending = `true`.
    INSERT temp16 INTO TABLE temp15.
    temp16-sorted = `false`.
    temp16-name = `key2`.
    temp16-label = `Country`.
    temp16-descending = `false`.
    INSERT temp16 INTO TABLE temp15.
    temp16-sorted = `false`.
    temp16-name = `key2`.
    temp16-label = `Region`.
    temp16-descending = `false`.
    INSERT temp16 INTO TABLE temp15.
    mt_sort_p13n = temp15.

    DATA temp17 TYPE z2ui5_cl_demo_app_090=>tt_items33.
    CLEAR temp17.
    DATA temp18 LIKE LINE OF temp17.
    temp18-grouped = `true`.
    temp18-name = `key1`.
    temp18-label = `City`.
    INSERT temp18 INTO TABLE temp17.
    temp18-grouped = `false`.
    temp18-name = `key2`.
    temp18-label = `Country`.
    INSERT temp18 INTO TABLE temp17.
    temp18-grouped = `false`.
    temp18-name = `key2`.
    temp18-label = `Region`.
    INSERT temp18 INTO TABLE temp17.
    mt_groups_p13n = temp17.

  ENDMETHOD.


  METHOD get_custom_js.

    result  = `sap.z2ui5.setInitialData = () => {` && |\n| &&
                    `    var oView = sap.z2ui5.oView` && |\n| &&
                    `    var oSelectionPanel = oView.byId("columnsPanel");` && |\n| &&
                    `    var oSortPanel = oView.byId("sortPanel");` && |\n| &&
                    `    var oGroupPanel = oView.byId("groupPanel");` && |\n| &&
                    `    oSelectionPanel.setP13nData(oView.getModel().oData.EDIT.MT_COLUMNS_P13N);` && |\n| &&
                    `    oSortPanel.setP13nData(oView.getModel().oData.EDIT.MT_SORT_P13N);` && |\n| &&
                    `    oGroupPanel.setP13nData(oView.getModel().oData.EDIT.MT_GROUPS_P13N);` && |\n| &&
                    `    var oPopup = oView.byId("p13nPopup");` && |\n| &&
                    `    oPopup.open();` && |\n| &&
                    `};` && |\n| &&
                    `sap.z2ui5.updateData = (oReason) => {` && |\n| &&
                    `  if( oReason === "Ok" ) {` && |\n| &&
                    `    var oView = sap.z2ui5.oView` && |\n| &&
                    `    var oSelectionPanel = oView.byId("columnsPanel");` && |\n| &&
                    `    var oSortPanel = oView.byId("sortPanel");` && |\n| &&
                    `    var oGroupPanel = oView.byId("groupPanel");` && |\n| &&
                    `    oView.getModel().oData.EDIT.MT_COLUMNS_P13N = oSelectionPanel.getP13nData();` && |\n| &&
                    `    oView.getModel().oData.EDIT.MT_SORT_P13N = oSortPanel.getP13nData();` && |\n| &&
                    `    oView.getModel().oData.EDIT.MT_GROUPS_P13N = oGroupPanel.getP13nData();` && |\n| &&
                    `  };` && |\n| &&
                    `};`.

  ENDMETHOD.

ENDCLASS.

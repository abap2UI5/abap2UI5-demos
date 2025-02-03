CLASS z2ui5_cl_demo_app_173 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_data,
        name TYPE string,
        date TYPE string,
        age  TYPE string,
      END OF ty_s_data,
      ty_t_data TYPE STANDARD TABLE OF ty_s_data WITH DEFAULT KEY.

    TYPES:
      BEGIN OF ty_s_layout,
        fname   TYPE string,
        merge   TYPE string,
        visible TYPE string,
      END OF ty_s_layout,
      ty_t_layout TYPE STANDARD TABLE OF ty_s_layout WITH DEFAULT KEY.

    DATA mv_flag TYPE abap_bool. " VALUE abap_true.
    DATA mv_initialized TYPE abap_bool.

    DATA mt_layout TYPE ty_t_layout.
    DATA mt_data   TYPE ty_t_data.

    METHODS view_display.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_173 IMPLEMENTATION.


  METHOD view_display.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view = view->shell( )->page( id    = `page_main`
                                 class = `sapUiContentPadding`
             title                     = 'abap2UI5 - Sample Templating I'
             navbuttonpress            = client->_event( 'BACK' )
             shownavbutton             = temp1 ).

    view->table( items = client->_bind( mt_data )
      )->columns(
        )->template_repeat( list = `{template>/MT_LAYOUT}`
                            var  = `L0`
          )->column( mergeduplicates = `{L0>MERGE}`
                     visible         = `{L0>VISIBLE}` )->text( text = `{L0>FNAME}` )->get_parent(
        )->get_parent( )->get_parent(
        )->items(
          )->column_list_item(
            )->cells(
              )->template_repeat( list = `{template>/MT_LAYOUT}`
                                  var  = `L1`
                )->object_identifier( text = `{= '{' + ${L1>FNAME} + '}' }` ).


    view->label( text = `IF Template (with re-rendering)` ).
    view->switch( state  = client->_bind_edit( mv_flag )
                  change = client->_event( `CHANGE_FLAG` ) ).
    view = view->vbox( ).

    view->template_if( test = `{template>/XX/MV_FLAG}`
      )->template_then(
        )->icon( src   = `sap-icon://accept`
                 color = `green` )->get_parent(
      )->template_else(
        )->icon( src   = `sap-icon://decline`
                 color = `red` ).


    client->view_display( view->stringify( ) ).
  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_initialized = abap_false.
      mv_initialized = abap_true.

      client->_bind( mt_layout ).

      DATA temp1 TYPE z2ui5_cl_demo_app_173=>ty_t_data.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-name = 'Theo'.
      temp2-date = '01.01.2000'.
      temp2-age = '5'.
      INSERT temp2 INTO TABLE temp1.
      temp2-name = 'Lore'.
      temp2-date = '01.01.2000'.
      temp2-age = '1'.
      INSERT temp2 INTO TABLE temp1.
      mt_data = temp1.

      DATA temp3 TYPE z2ui5_cl_demo_app_173=>ty_t_layout.
      CLEAR temp3.
      DATA temp4 LIKE LINE OF temp3.
      temp4-fname = 'NAME'.
      temp4-merge = 'false'.
      temp4-visible = 'true'.
      INSERT temp4 INTO TABLE temp3.
      temp4-fname = 'DATE'.
      temp4-merge = 'false'.
      temp4-visible = 'true'.
      INSERT temp4 INTO TABLE temp3.
      temp4-fname = 'AGE'.
      temp4-merge = 'false'.
      temp4-visible = 'false'.
      INSERT temp4 INTO TABLE temp3.
      mt_layout = temp3.


      view_display( ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'CHANGE_FLAG'.

        view_display( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.
    ENDCASE.


  ENDMETHOD.
ENDCLASS.

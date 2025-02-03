CLASS z2ui5_cl_demo_app_153 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.
    TYPES:
      BEGIN OF ty_dataset2,
        label                TYPE string,
*        type               TYPE string,
        data                 TYPE string_table,
        border_width         TYPE i,
*        border_color       TYPE string,
        border_radius        TYPE i,
        border_skipped       TYPE abap_bool,
        border_skipped_xfeld TYPE xfeld,
      END OF ty_dataset2.

    TYPES:
      BEGIN OF ty_dataset,
        label          TYPE string,
        type           TYPE string,
        data           TYPE string_table,
        border_width   TYPE i,
        border_color   TYPE string,
        border_radius  TYPE i,
        border_skipped TYPE abap_bool,
        show_line      TYPE abap_bool,
        lvl2           TYPE ty_dataset2,
      END OF ty_dataset.

    TYPES ty_datasets TYPE STANDARD TABLE OF ty_dataset WITH DEFAULT KEY.

    TYPES:
      BEGIN OF ty_data,
        labels   TYPE string_table,
        datasets TYPE ty_datasets,
      END OF ty_data .

    TYPES:
      BEGIN OF ty_chart,
        data TYPE ty_data,
      END OF ty_chart .


    DATA ms_struc TYPE ty_chart.
    DATA ms_struc2 TYPE ty_chart.


    METHODS ui5_display.
    METHODS ui5_event.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_153 IMPLEMENTATION.


  METHOD ui5_display.

    client->_bind_edit(
        val                = ms_struc
        custom_mapper      = z2ui5_cl_ajson_mapping=>create_camel_case( iv_first_json_upper = abap_false )
        custom_mapper_back = z2ui5_cl_ajson_mapping=>create_to_snake_case( ) ).

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Binding'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1
           )->button(
            text  = 'Rountrip...'
            press = client->_event( 'POPUP' )
*           )->input( value = client->_bind_edit( mv_long_long_long_long_value ) width = `10%`
*           )->input( value = client->_bind_edit( mv_long_long_long_long_value ) width = `10%`
             ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_event.

    CASE client->get( )-event.

      WHEN 'POPUP'.

        IF ms_struc <> ms_struc2.
          client->message_box_display( `structure changed error` ).
          RETURN.
        ENDIF.



        client->message_toast_display( `everything works as expected` ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    DATA ls_dataset TYPE ty_dataset.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.

      DATA temp1 TYPE string_table.
      CLEAR temp1.
      INSERT `Jan` INTO TABLE temp1.
      INSERT `Feb` INTO TABLE temp1.
      INSERT `Mar` INTO TABLE temp1.
      INSERT `Apr` INTO TABLE temp1.
      INSERT `May` INTO TABLE temp1.
      INSERT `Jun` INTO TABLE temp1.
      ms_struc-data-labels = temp1.

      CLEAR ls_dataset.
      ls_dataset-label = 'Fully Rounded'.
      ls_dataset-border_width = 2.
      ls_dataset-border_radius = 200.

      DATA temp3 TYPE string_table.
      CLEAR temp3.
      INSERT `1` INTO TABLE temp3.
      INSERT `-12` INTO TABLE temp3.
      INSERT `19` INTO TABLE temp3.
      INSERT `3` INTO TABLE temp3.
      INSERT `5` INTO TABLE temp3.
      INSERT `-2` INTO TABLE temp3.
      INSERT `3` INTO TABLE temp3.
      ls_dataset-data = temp3.



      APPEND ls_dataset TO ms_struc-data-datasets.



      ms_struc2 = ms_struc.



      ui5_display( ).
      RETURN.
    ENDIF.

    ui5_event( ).

  ENDMETHOD.
ENDCLASS.

CLASS z2ui5_cl_demo_app_130 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_s_token,
        key      TYPE string,
        text     TYPE string,
        visible  TYPE abap_bool,
        selkz    TYPE abap_bool,
        editable TYPE abap_bool,
      END OF ty_s_token .
    TYPES
      ty_t_token TYPE STANDARD TABLE OF ty_s_token WITH DEFAULT KEY .
    TYPES
      ty_t_range    TYPE RANGE OF string .
    TYPES
      ty_s_range    TYPE LINE OF ty_t_range .
    TYPES:
      BEGIN OF ty_s_filter_pop,
        option TYPE string,
        low    TYPE string,
        high   TYPE string,
        key    TYPE string,
      END OF ty_s_filter_pop .
    TYPES
      ty_t_filter_pop TYPE STANDARD TABLE OF ty_s_filter_pop WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_s_fieldsdb,
        screen_name TYPE char10,
        field       TYPE char10,
        field_doma  TYPE char10,
      END OF ty_s_fieldsdb .
    TYPES
      ty_t_fieldsdb TYPE STANDARD TABLE OF ty_s_fieldsdb WITH DEFAULT KEY .
    TYPES
      BEGIN OF ty_s_fields.
        INCLUDE TYPE ty_s_fieldsdb.
    TYPES: t_token  TYPE ty_t_token,
          t_filter TYPE ty_t_filter_pop,
          END OF ty_s_fields .
    TYPES:
      BEGIN OF ty_s_var_val,
        screen_name TYPE char10,
        var         TYPE     char10,
        field       TYPE     char10,
        guid        TYPE     string,
        sign        TYPE char1,
        opt         TYPE char2,
        low         TYPE char255,
        high        TYPE char255,
      END OF ty_s_var_val .
    TYPES
      ty_t_var_val TYPE STANDARD TABLE OF ty_s_var_val WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_s_variants,
        screen_name TYPE char10,
        var         TYPE char10,
        descr       TYPE string,
      END OF ty_s_variants .
    TYPES
      ty_t_variants TYPE STANDARD TABLE OF ty_s_variants WITH DEFAULT KEY .
    TYPES
      BEGIN OF ty_s_var_pop.
        INCLUDE TYPE ty_s_variants.
    TYPES: selkz TYPE xfeld,
          END OF ty_s_var_pop .
    TYPES:
      BEGIN OF ty_s_screens,
        screen_name TYPE char10,
        descr       TYPE string,
      END OF ty_s_screens .

    TYPES temp1_279441b868 TYPE STANDARD TABLE OF ty_s_filter_pop WITH DEFAULT KEY.
DATA
      mt_filter       TYPE temp1_279441b868 .
    DATA mt_mapping TYPE z2ui5_if_types=>ty_t_name_value .
    TYPES temp2_279441b868 TYPE STANDARD TABLE OF ty_s_screens WITH DEFAULT KEY.
DATA
      mt_screens      TYPE temp2_279441b868 .
    TYPES temp3_279441b868 TYPE STANDARD TABLE OF ty_s_variants WITH DEFAULT KEY.
DATA
      mt_variants     TYPE temp3_279441b868 .
    TYPES temp4_279441b868 TYPE STANDARD TABLE OF ty_s_var_pop WITH DEFAULT KEY.
DATA
      mt_variants_pop TYPE temp4_279441b868 .
    DATA mv_activ_elemnt TYPE string .
    DATA mv_screen TYPE string .
    DATA mv_button_active TYPE abap_bool .
    DATA mv_description TYPE string .
    DATA mv_screen_descr TYPE string .
    DATA mv_variant TYPE string .
    DATA mv_description_copy TYPE string .
    DATA mv_variant_copy TYPE string .
    DATA mo_parent_view TYPE REF TO z2ui5_cl_xml_view .
  PROTECTED SECTION.

    METHODS on_init.

    METHODS on_event.

    METHODS render_main.

    METHODS render_popup_filter.

    METHODS get_fields.

    METHODS get_values.

    METHODS popup_filter_ok.

    METHODS render_pop_copy.

    METHODS get_variants.

    METHODS render_popup_varaint
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS popup_copy_save.

    METHODS set_token
      CHANGING
        field TYPE REF TO ty_s_fields.

    METHODS get_txt
      IMPORTING
                roll          TYPE string
                type          TYPE char1 OPTIONAL
      RETURNING VALUE(result) TYPE string.

    METHODS get_txt_l
      IMPORTING
                roll          TYPE string
      RETURNING VALUE(result) TYPE string.

    METHODS varaint_page.

  PRIVATE SECTION.

    DATA client            TYPE REF TO z2ui5_if_client.
    TYPES temp5_279441b868 TYPE STANDARD TABLE OF ty_s_fields WITH DEFAULT KEY.
DATA mt_fields         TYPE temp5_279441b868.
    DATA check_initialized TYPE abap_bool.

ENDCLASS.



CLASS z2ui5_cl_demo_app_130 IMPLEMENTATION.


  METHOD get_fields.

    DATA temp1 TYPE ty_t_fieldsdb.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-screen_name = 'INV'.
    temp2-field = 'LGNUM'.
    temp2-field_doma = '/SCWM/LGNUM'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'LAGP'.
    temp2-field = 'LGNUM'.
    temp2-field_doma = '/SCWM/LGNUM'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'LAGP'.
    temp2-field = 'LGPLA'.
    temp2-field_doma = '/SCWM/DE_LGPLA'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'LAGP'.
    temp2-field = 'LGTYP'.
    temp2-field_doma = '/SCWM/DE_LGTYP'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'QUAN'.
    temp2-field = 'LGNUM'.
    temp2-field_doma = '/SCWM/LGNUM'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'QUAN'.
    temp2-field = 'LGPLA'.
    temp2-field_doma = '/SCWM/DE_LGPLA'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'QUAN'.
    temp2-field = 'MATNR'.
    temp2-field_doma = '/SCWM/DE_MATNR'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'QUAN'.
    temp2-field = 'OWNER'.
    temp2-field_doma = '/SCWM/DE_OWNER'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'TO'.
    temp2-field = 'LGNUM'.
    temp2-field_doma = '/SCWM/LGNUM'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'TO'.
    temp2-field = 'MATNR'.
    temp2-field_doma = '/SCWM/DE_MATNR'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'TO'.
    temp2-field = 'PROCTY'.
    temp2-field_doma = '/SCWM/DE_PROCTY'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'TO'.
    temp2-field = 'TOSTAT'.
    temp2-field_doma = '/SCWM/DE_TOSTAT'.
    INSERT temp2 INTO TABLE temp1.
    temp2-screen_name = 'TO'.
    temp2-field = 'VLPLA'.
    temp2-field_doma = '/SCWM/LTAP_VLPLA'.
    INSERT temp2 INTO TABLE temp1.
    DATA db_fields LIKE temp1.
    db_fields = temp1.

    CLEAR mt_fields.
    DATA temp3 LIKE LINE OF db_fields.
    DATA lr_fields LIKE REF TO temp3.
    LOOP AT db_fields REFERENCE INTO lr_fields WHERE screen_name = mv_screen.

      DATA field TYPE REF TO z2ui5_cl_demo_app_130=>ty_s_fields.
      APPEND INITIAL LINE TO mt_fields REFERENCE INTO field.
      MOVE-CORRESPONDING lr_fields->* TO field->*.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_txt.

    result = 'Text'.

  ENDMETHOD.


  METHOD get_txt_l.

    result = 'Text'.

  ENDMETHOD.


  METHOD get_values.

    DATA temp4 TYPE ty_t_variants.
    CLEAR temp4.
    DATA temp5 LIKE LINE OF temp4.
    temp5-screen_name = 'QUAN'.
    temp5-var = 'E001 - ALL'.
    temp5-descr = '123'.
    INSERT temp5 INTO TABLE temp4.
    temp5-screen_name = 'TO'.
    temp5-var = 'E001'.
    temp5-descr = '123'.
    INSERT temp5 INTO TABLE temp4.
    temp5-screen_name = 'TO'.
    temp5-var = 'E001 - All'.
    temp5-descr = '123'.
    INSERT temp5 INTO TABLE temp4.
    DATA l_variants LIKE temp4.
    l_variants = temp4.

    DATA var TYPE ty_t_variants.
    DATA var_val TYPE ty_t_var_val.
    DATA a LIKE LINE OF l_variants.
    LOOP AT l_variants INTO a  WHERE screen_name = mv_screen
                                     AND var         = mv_variant.

      APPEND a TO var.
      mv_description = a-descr.
    ENDLOOP.

    DATA temp6 TYPE ty_t_var_val.
    CLEAR temp6.
    DATA temp7 LIKE LINE OF temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E001 - All'.
    temp7-field = 'LGNUM'.
    temp7-guid = '663192E9D70C1EEE8CC06B0F98CD81A3'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E001 - All'.
    temp7-field = 'MATNR'.
    temp7-guid = '663192E9D70C1EEE8CD4E9389CB11403'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E001 - All'.
    temp7-field = 'TOSTAT'.
    temp7-guid = '663192E9D70C1EEE8CC06BC66AD581A3'.
    temp7-sign = 'I'.
    temp7-opt = 'NE'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E002 - All'.
    temp7-field = 'LGNUM'.
    temp7-guid = '663192E9D70C1EEE8CC06B0F98CD81A3'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E002 - All'.
    temp7-field = 'MATNR'.
    temp7-guid = '663192E9D70C1EEE8CD4E9389CB11403'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'LTAP'.
    temp7-var = 'E002 - All'.
    temp7-field = 'TOSTAT'.
    temp7-guid = '663192E9D70C1EEE8CC06BC66AD581A3'.
    temp7-sign = 'I'.
    temp7-opt = 'NE'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'QUAN'.
    temp7-var = 'E001 - ALL'.
    temp7-field = 'LGNUM'.
    temp7-guid = '663192E9D70C1EEE90CEE2FA658C51EE'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'QUAN'.
    temp7-var = 'E001 - ALL'.
    temp7-field = 'LGPLA'.
    temp7-guid = '663192E9D70C1EEE90CEEF4750FD91EE'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'TO'.
    temp7-var = 'E001      '.
    temp7-field = 'LGNUM'.
    temp7-guid = '663192E9D70C1EEE8E87DE5FF8CC512A'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'TO'.
    temp7-var = 'E001      '.
    temp7-field = 'PROCTY'.
    temp7-guid = '663192E9D70C1EEE8E87DD8D1EB8C7F5'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    temp7-screen_name = 'TO'.
    temp7-var = 'E001 - All'.
    temp7-field = 'LGNUM'.
    temp7-guid = '663192E9D70C1EEE8E86552847635198'.
    temp7-sign = 'I'.
    temp7-opt = 'EQ'.
    INSERT temp7 INTO TABLE temp6.
    DATA var_vall_all LIKE temp6.
    var_vall_all = temp6.



    DATA b LIKE LINE OF var_vall_all.
    LOOP AT var_vall_all INTO b WHERE screen_name = mv_screen
        AND var         = mv_variant.

      APPEND b TO var_val.
    ENDLOOP.

    DATA temp8 LIKE LINE OF mt_fields.
    DATA field LIKE REF TO temp8.
    LOOP AT mt_fields REFERENCE INTO field.

      CLEAR field->t_filter.
      CLEAR field->t_token.

      DATA temp9 LIKE LINE OF var_val.
      DATA val LIKE REF TO temp9.
      LOOP AT var_val REFERENCE INTO val
          WHERE field = field->field.

        DATA temp10 TYPE ty_s_filter_pop.
        CLEAR temp10.
        temp10-key = val->guid.
        temp10-option = val->opt.
        temp10-low = val->low.
        temp10-high = val->high.
        DATA filter LIKE temp10.
        filter = temp10.

        APPEND filter TO field->t_filter.

        set_token( CHANGING field = field ).

      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_variants.

    DATA temp11 LIKE mt_variants.
    CLEAR temp11.
    DATA temp12 LIKE LINE OF temp11.
    temp12-screen_name = 'QUAN'.
    temp12-var = 'E001 - ALL'.
    temp12-descr = '123'.
    INSERT temp12 INTO TABLE temp11.
    temp12-screen_name = 'TO'.
    temp12-var = 'E001'.
    temp12-descr = '123'.
    INSERT temp12 INTO TABLE temp11.
    temp12-screen_name = 'TO'.
    temp12-var = 'E001 - All'.
    temp12-descr = '123'.
    INSERT temp12 INTO TABLE temp11.
    mt_variants = temp11.

  ENDMETHOD.

  METHOD on_event.

    varaint_page( ).

  ENDMETHOD.


  METHOD on_init.

    DATA temp13 LIKE mt_screens.
    CLEAR temp13.
    DATA temp14 LIKE LINE OF temp13.
    temp14-screen_name = 'INV'.
    temp14-descr = '123'.
    INSERT temp14 INTO TABLE temp13.
    temp14-screen_name = 'LAGP'.
    temp14-descr = '123'.
    INSERT temp14 INTO TABLE temp13.
    temp14-screen_name = 'PO'.
    temp14-descr = '123'.
    INSERT temp14 INTO TABLE temp13.
    temp14-screen_name = 'QUAN'.
    temp14-descr = '123'.
    INSERT temp14 INTO TABLE temp13.
    temp14-screen_name = 'TO'.
    temp14-descr = '123'.
    INSERT temp14 INTO TABLE temp13.
    mt_screens = temp13.

    render_main( ).

    DATA temp15 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp15.
    DATA temp16 LIKE LINE OF temp15.
    temp16-n = `EQ`.
    temp16-v = `={LOW}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `LT`.
    temp16-v = `<{LOW}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `LE`.
    temp16-v = `<={LOW}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `GT`.
    temp16-v = `>{LOW}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `GE`.
    temp16-v = `>={LOW}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `CP`.
    temp16-v = `*{LOW}*`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `BT`.
    temp16-v = `{LOW}...{HIGH}`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `NE`.
    temp16-v = `!(={LOW})`.
    INSERT temp16 INTO TABLE temp15.
    temp16-n = `<leer>`.
    temp16-v = `<leer>`.
    INSERT temp16 INTO TABLE temp15.
    mt_mapping = temp15.



  ENDMETHOD.


  METHOD popup_copy_save.

    mv_variant     = mv_variant_copy.
    mv_description = mv_description_copy.



  ENDMETHOD.


  METHOD popup_filter_ok.

    DATA lr_field TYPE REF TO z2ui5_cl_demo_app_130=>ty_s_fields.
    READ TABLE mt_fields REFERENCE INTO lr_field
      WITH KEY field = mv_activ_elemnt.

    IF sy-subrc = 0.

      DELETE mt_filter WHERE option IS INITIAL.

      lr_field->t_filter = mt_filter.

      CLEAR lr_field->t_token.

      set_token( CHANGING field = lr_field ).

      client->popup_destroy( ).

      render_main( ).

    ENDIF.

  ENDMETHOD.


  METHOD render_main.


    IF mo_parent_view IS INITIAL.

      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).

      DATA page TYPE REF TO z2ui5_cl_xml_view.
      page = z2ui5_cl_xml_view=>factory( )->shell(
               )->page(
                  title          = get_txt( '/SCWM/DE_TW_COND_CHECK_SELECT' )
                  navbuttonpress = client->_event( 'BACK' )
                  shownavbutton  = abap_true ).

    ELSE.

      page = mo_parent_view->get( `Page` ).

    ENDIF.



    page->header_content(
       )->get_parent( ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L6 M12 S12'
        )->content( 'layout' ).

    grid->simple_form( get_txt( 'BU_DYNID' )
        )->content( 'form'
            )->label( text = get_txt( 'BU_DYNID' )
             )->combobox(
             change      = client->_event( val = 'INPUT_SCREEN_CHANGE' )
             items       = client->_bind_edit( mt_screens )
             selectedkey = client->_bind_edit( mv_screen )
                 )->item(
                     key  = '{SCREEN_NAME}'
                     text = '{SCREEN_NAME} - {DESCR}'
         )->get_parent( )->label( text = get_txt( 'DESCR_40' )
            )->input(
            value         = client->_bind_edit( mv_screen_descr )
            showvaluehelp = abap_false
*            editable         = abap_false
            enabled       = abap_false ).


    grid->simple_form( get_txt( '/SCWM/WB_VARIANT' )
            )->content( 'form'
                )->label( text = get_txt( '/SCWM/WB_VARIANT' )
            )->input(
            value            = client->_bind_edit( mv_variant )
            showvaluehelp    = abap_true
            valuehelprequest = client->_event( 'CALL_POPUP_VARIANT' )
            submit           = client->_event( 'INPUT_VARIANT_CHANGE' )
            )->label( text = get_txt( 'DESCR_40' )
            )->input(
            value         = client->_bind_edit( mv_description )
            showvaluehelp = abap_false ).

    DATA content TYPE REF TO z2ui5_cl_xml_view.
    content = grid->simple_form( get_txt( 'CLASSFEL' )
         )->content( 'form' ).

    IF mt_fields IS NOT INITIAL.

      DATA temp17 LIKE LINE OF mt_fields.
      DATA lr_tab LIKE REF TO temp17.
      LOOP AT mt_fields REFERENCE INTO lr_tab.

        DATA temp18 TYPE string.
        temp18 = lr_tab->field_doma.
        DATA scrtext TYPE string.
        scrtext = get_txt( temp18 ).

        DATA temp19 TYPE string_table.
        CLEAR temp19.
        DATA temp1 TYPE string.
        temp1 = lr_tab->field.
        INSERT temp1 INTO TABLE temp19.
        content->label( text = scrtext
          )->multi_input(
                   tokens           = client->_bind_local( lr_tab->t_token )
                   showclearicon    = abap_true
                   id               = lr_tab->field
                   valuehelprequest = client->_event( val = 'CALL_POPUP_FILTER' t_arg = temp19 )
               )->item(
                       key  = `{KEY}`
                       text = `{TEXT}`
               )->tokens(
                   )->token(
                       key      = `{KEY}`
                       text     = `{TEXT}`
                       visible  = `{VISIBLE}`
                       selected = `{SELKZ}`
                       editable = `{EDITABLE}` ).

      ENDLOOP.

    ENDIF.

    page->footer( )->overflow_toolbar(
                 )->toolbar_spacer(
                 )->button(
                     text    = get_txt( '/SCWM/DE_HUDEL' )
                     press   = client->_event( 'BUTTON_DELETE' )
                     type    = 'Reject'
                     icon    = 'sap-icon://delete'
                     enabled = mv_button_active
                 )->button(
                     text    = get_txt( 'B_KOPIE' )
                     press   = client->_event( 'BUTTON_COPY' )
                     type    = 'Default'
                     enabled = mv_button_active
                  )->button(
                     text    = get_txt( '/SCWM/DE_LM_LOGSAVE' )
                     press   = client->_event( 'BUTTON_SAVE' )
                     type    = 'Success'
                     enabled = mv_button_active ).

    IF mo_parent_view IS INITIAL.

      client->view_display( page->get_root( )->xml_get( ) ).

    ENDIF.

  ENDMETHOD.


  METHOD render_popup_filter.

    DATA lo_popup TYPE REF TO z2ui5_cl_xml_view.
    lo_popup = z2ui5_cl_xml_view=>factory_popup( ).

    lo_popup = lo_popup->dialog(
      contentheight = `50%`
      contentwidth  = `50%`
      title         = get_txt_l( '/SCWM/DE_TW_COND_CHECK_COND' ) ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = lo_popup->vbox( height         = `100%`
                                 justifycontent = 'SpaceBetween' ).

    DATA item TYPE REF TO z2ui5_cl_xml_view.
    item = vbox->list(
      nodata          = get_txt( '/SCWM/DE_IND_BIN_EMPTY' )
      items           = client->_bind_edit( mt_filter )
      selectionchange = client->_event( 'SELCHANGE' )
                        )->custom_list_item( ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = item->grid( ).

    DATA temp21 TYPE string_table.
    CLEAR temp21.
    INSERT `${KEY}` INTO TABLE temp21.
    grid->combobox(
                 selectedkey = `{OPTION}`
                 items       = client->_bind_edit( mt_mapping )
             )->item(
                     key  = '{N}'
                     text = '{N}'
             )->get_parent(
             )->input( value = `{LOW}`
             )->input( value   = `{HIGH}`
                       visible = `{= ${OPTION} === 'BT' }`
             )->button( icon = 'sap-icon://decline'
             type            = `Transparent`
             press           = client->_event( val = `POPUP_FILTER_DELETE`
             t_arg                                 = temp21 ) ).

    lo_popup->footer( )->overflow_toolbar(
        )->button( text = get_txt( 'FC_DELALL' )
                  icon  = 'sap-icon://delete'
                  type  = `Transparent`
                  press = client->_event( val = `POPUP_FILTER_DELETE_ALL` )
        )->button( text  = get_txt( 'RSLPO_GUI_ADDPART' )
                   icon  = `sap-icon://add`
                   press = client->_event( val = `POPUP_FILTER_ADD` )
        )->toolbar_spacer(
        )->button(
            text  = get_txt( 'MSSRCF_ACTION' )
            press = client->_event( 'POPUP_FILTER_OK' )
            type  = 'Emphasized' ).

    client->popup_display( lo_popup->stringify( ) ).

  ENDMETHOD.


  METHOD render_popup_varaint.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup( ).

    popup->dialog( title        = get_txt( '/SCWM/WB_VARIANT' )
                   contentwidth = '30%'
      )->table(
            mode  = 'SingleSelectLeft'
            items = client->_bind_edit( mt_variants_pop )
        )->columns(
            )->column( '20rem'
                )->text( get_txt( '/SCWM/WB_VARIANT' ) )->get_parent(
            )->column(
                )->text( get_txt( 'DESCR_40' )
        )->get_parent( )->get_parent(
        )->items(
            )->column_list_item( selected = '{SELKZ}'
                )->cells(
                    )->text( '{VAR}'
                    )->text( '{DESCR}'
      )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->footer(
        )->overflow_toolbar(
            )->toolbar_spacer(
            )->button(
                text  = get_txt( 'MSSRCF_ACTION' )
                press = client->_event( 'POPUP_VARIANT_CLOSE' )
                type  = 'Emphasized' ).
    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD render_pop_copy.

    DATA lo_popup TYPE REF TO z2ui5_cl_xml_view.
    lo_popup = z2ui5_cl_xml_view=>factory_popup( ).

    lo_popup = lo_popup->dialog(
      contentheight = `50%`
      contentwidth  = `50%`
      title         = get_txt( '/SCWM/DE_COPY_NUMBER' ) ).

    lo_popup->simple_form( get_txt( '/SCWM/WB_VARIANT' )
               )->content( 'form'
                   )->label( text = get_txt( '/SCWM/WB_VARIANT' )
               )->input(
               value         = client->_bind_edit( mv_variant_copy )
               showvaluehelp = abap_false
               )->label( text = get_txt( 'DESCR_40' )
               )->input(
               value         = client->_bind_edit( mv_description_copy )
               showvaluehelp = abap_false ).

    lo_popup->footer( )->overflow_toolbar(
        )->toolbar_spacer(
        )->button(
            text  = get_txt( 'XEXIT' )
            press = client->_event( 'POPUP_COPY_EXIT' )
            type  = 'Reject'
       )->button(
            text    = get_txt( '/SCWM/DE_LM_LOGSAVE' )
            press   = client->_event( 'POPUP_COPY_SAVE' )
            type    = 'Emphasized'
            enabled = `{= ${MV_VARIANT_COPY} !== "" }`
       ).

    client->popup_display( lo_popup->stringify( ) ).

  ENDMETHOD.


  METHOD set_token.

    DATA temp23 LIKE LINE OF field->t_filter.
    DATA lr_filter LIKE REF TO temp23.
    LOOP AT field->t_filter REFERENCE INTO lr_filter.

      DATA lv_value TYPE z2ui5_if_types=>ty_s_name_value-v.
      DATA temp2 LIKE LINE OF mt_mapping.
      DATA temp3 LIKE sy-tabix.
      temp3 = sy-tabix.
      READ TABLE mt_mapping WITH KEY n = lr_filter->option INTO temp2.
      sy-tabix = temp3.
      IF sy-subrc <> 0.
        ASSERT 1 = 0.
      ENDIF.
      lv_value = temp2-v.
      REPLACE `{LOW}`  IN lv_value WITH lr_filter->low.
      REPLACE `{HIGH}` IN lv_value WITH lr_filter->high.

      DATA temp24 TYPE z2ui5_cl_demo_app_130=>ty_s_token.
      CLEAR temp24.
      temp24-key = lv_value.
      temp24-text = lv_value.
      temp24-visible = abap_true.
      temp24-editable = abap_false.
      INSERT temp24 INTO TABLE field->t_token.

    ENDLOOP.

  ENDMETHOD.


  METHOD varaint_page.


    CASE client->get( )-event.

      WHEN `INPUT_SCREEN_CHANGE`.

        DATA temp25 TYPE string.
        CLEAR temp25.
        DATA temp26 TYPE z2ui5_cl_demo_app_130=>ty_s_screens.
        READ TABLE mt_screens INTO temp26 WITH KEY screen_name = mv_screen.
        IF sy-subrc = 0.
          temp25 = temp26-descr.
        ENDIF.
        mv_screen_descr = temp25.

        get_fields( ).

        CLEAR mv_variant.
        CLEAR mv_description.

        get_variants( ).

        render_main( ).

      WHEN `INPUT_VARIANT_CHANGE`.

        get_values( ).

        render_main( ).

      WHEN `POPUP_FILTER_OK`.

        popup_filter_ok( ).

      WHEN `POPUP_FILTER_ADD`.

        DATA temp27 TYPE z2ui5_cl_demo_app_130=>ty_s_filter_pop.
        CLEAR temp27.
        temp27-key = z2ui5_cl_util=>uuid_get_c32( ).
        INSERT temp27 INTO TABLE mt_filter.

        client->popup_model_update( ).

      WHEN `POPUP_FILTER_DELETE`.

        DATA lt_item TYPE string_table.
        lt_item = client->get( )-t_event_arg.

        DATA temp28 LIKE LINE OF lt_item.
        DATA temp29 LIKE sy-tabix.
        temp29 = sy-tabix.
        READ TABLE lt_item INDEX 1 INTO temp28.
        sy-tabix = temp29.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        DELETE mt_filter WHERE key = temp28.

        client->popup_model_update( ).

      WHEN `POPUP_FILTER_DELETE_ALL`.

        DATA temp30 LIKE mt_filter.
        CLEAR temp30.
        mt_filter = temp30.

        client->popup_model_update( ).

      WHEN `CALL_POPUP_FILTER`.

        DATA arg TYPE string_table.
        arg = client->get( )-t_event_arg.
        DATA temp31 TYPE string.
        CLEAR temp31.
        DATA temp32 TYPE string.
        READ TABLE arg INTO temp32 INDEX 1.
        IF sy-subrc = 0.
          temp31 = temp32.
        ENDIF.
        mv_activ_elemnt = temp31.

        DATA lr_field TYPE REF TO z2ui5_cl_demo_app_130=>ty_s_fields.
        READ TABLE mt_fields REFERENCE INTO lr_field
          WITH KEY field = mv_activ_elemnt.

        " vorhanden werte übertragen
        mt_filter = lr_field->t_filter.

        render_popup_filter( ).

      WHEN 'CALL_POPUP_VARIANT'.

        DATA temp33 LIKE LINE OF mt_variants.
        DATA lr_fields LIKE REF TO temp33.
        LOOP AT mt_variants REFERENCE INTO lr_fields.
          DATA field TYPE REF TO z2ui5_cl_demo_app_130=>ty_s_var_pop.
          APPEND INITIAL LINE TO mt_variants_pop REFERENCE INTO field.
          MOVE-CORRESPONDING lr_fields->* TO field->*.
        ENDLOOP.

        render_popup_varaint( client ).

      WHEN 'POPUP_VARIANT_CLOSE'.

        DATA temp34 TYPE string.
        CLEAR temp34.
        DATA temp35 TYPE z2ui5_cl_demo_app_130=>ty_s_var_pop.
        READ TABLE mt_variants_pop INTO temp35 WITH KEY selkz = abap_true.
        IF sy-subrc = 0.
          temp34 = temp35-var.
        ENDIF.
        mv_variant = temp34.

        client->popup_destroy( ).

        get_values( ).

        render_main( ).

      WHEN 'BACK'.

        client->nav_app_leave( ).

      WHEN 'BUTTON_SAVE'.


      WHEN 'BUTTON_DELETE'.

        render_main( ).

      WHEN 'BUTTON_COPY'.

        render_pop_copy( ).

        render_main( ).

      WHEN 'POPUP_COPY_EXIT'.

        client->popup_destroy( ).

      WHEN 'POPUP_COPY_SAVE'.

        popup_copy_save( ).

        client->popup_destroy( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      on_init( ).

      RETURN.

    ENDIF.

    on_event( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( mv_screen IS NOT INITIAL AND mv_variant IS NOT INITIAL ).
    mv_button_active = temp1.

    client->view_model_update( ).

  ENDMETHOD.
ENDCLASS.

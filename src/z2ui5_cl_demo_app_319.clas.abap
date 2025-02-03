CLASS z2ui5_cl_demo_app_319 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF t_token,
        key  TYPE string,
        text TYPE string,
      END OF t_token,
      t_tokens TYPE STANDARD TABLE OF t_token WITH DEFAULT KEY.
    TYPES:
      BEGIN OF t_range,
        exclude   TYPE boole_d,
        operation TYPE string,
        value1    TYPE string,
        value2    TYPE string,
        keyField  TYPE string,
        tokenText TYPE string,
        tokenLongKey type string,
      END OF t_range,
      t_ranges TYPE STANDARD TABLE OF t_range WITH DEFAULT KEY.
    DATA:
      BEGIN OF m_selection,
        BEGIN OF product_type,
          tokens_added   TYPE t_tokens,
          tokens_removed TYPE t_tokens,
          ranges         TYPE t_ranges,
        END OF product_type,
      END OF m_selection.
  PROTECTED SECTION.
    DATA m_client TYPE REF TO z2ui5_if_client.
    METHODS on_init.
    METHODS on_event.
ENDCLASS.

CLASS z2ui5_cl_demo_app_319 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    m_client = client.

    IF m_client->check_on_init( ) IS NOT INITIAL.
      on_init( ).
      RETURN.
    ENDIF.

    on_event( ).

  ENDMETHOD.

  METHOD on_init.

    DATA l_view TYPE REF TO z2ui5_cl_xml_view.
    l_view = z2ui5_cl_xml_view=>factory( ).

    DATA l_page TYPE REF TO z2ui5_cl_xml_view.
    l_page = l_view->shell( )->page( title          = 'SearchPage'
                                       navbuttonpress = m_client->_event( 'BACK' )
                                       shownavbutton  = m_client->check_app_prev_stack( ) ).

    l_page->_z2ui5( )->smartmultiinput_ext(
                          addedtokens   = m_client->_bind_edit( val = m_selection-product_type-tokens_added switch_default_model = abap_true )
                          removedtokens = m_client->_bind_edit( val = m_selection-product_type-tokens_removed switch_default_model = abap_true )
                          rangeData = m_client->_bind_edit( val = m_selection-product_type-ranges switch_default_model = abap_true )
                          change   = m_client->_event( 'PRODTYPE_CHANGED' )
                          multiinputid  = `ProductTypeMultiInput` ).

    l_page->smart_multi_input(
      id                = 'ProductTypeMultiInput'
*     value             = '{ProductType}'
      value             = '{CurrencyCode}'
      entityset         = 'Booking'
      supportranges     = 'true'
      enableodataselect = 'true' ).

    m_client->view_display( val                       = l_page->stringify( )
*       switch_default_model_path = `/sap/opu/odata/sap/UI_PRODUCTLIST`
       switch_default_model_path = `/sap/opu/odata/DMO/UI_TRAVEL_A_D_O2`
*       switchdefaultmodelannouri = `/sap/opu/odata/IWFND/CATALOGSERVICE;v=2/Annotations(TechnicalName='UI_PRODUCTLIST_VAN',Version='0001')/$value`
       switch_default_model_anno_uri = `/sap/opu/odata/IWFND/CATALOGSERVICE;v=2/Annotations(TechnicalName='%2FDMO%2FUI_TRAVEL_A_D_O2_VAN',Version='0001')/$value`
     ).

  ENDMETHOD.

  METHOD on_event.

    CASE m_client->get( )-event.
      WHEN 'BACK'.
        m_client->nav_app_leave( ).
      WHEN 'PRODTYPE_CHANGED'.
        DATA temp1 TYPE z2ui5_cl_demo_app_319=>t_range.
        CLEAR temp1.
        temp1-operation = 'EQ'.
        temp1-value1 = 'EUR'.
        temp1-keyField = 'CurrencyCode'.
        temp1-tokenText = 'Euro (auto added line)'.
        INSERT temp1 INTO TABLE m_selection-product_type-ranges.
        m_client->view_model_update( ).
        TRY.
            m_client->message_box_display(
              text  = z2ui5_cl_ajson=>new( )->set( iv_path = '/' iv_val = m_selection-product_type-ranges )->stringify( )
              title = 'range content' ).
            DATA lx_ajson TYPE REF TO z2ui5_cx_ajson_error.
          CATCH z2ui5_cx_ajson_error INTO lx_ajson.
            m_client->message_toast_display( lx_ajson->get_text( ) ).
        ENDTRY.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.

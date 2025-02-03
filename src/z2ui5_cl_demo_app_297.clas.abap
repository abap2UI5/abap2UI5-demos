CLASS z2ui5_cl_demo_app_297 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_product_collection,
        product_id TYPE string,
        name       TYPE string,
        icon       TYPE string,
      END OF ty_product_collection.

    DATA check_initialized TYPE abap_bool.
    TYPES temp1_c88952cc1a TYPE TABLE OF ty_product_collection.
DATA lt_product_collection  TYPE temp1_c88952cc1a.
    DATA selected_product TYPE string.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS z2ui5_set_data.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_297 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Select - with icons`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page_01->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Select/sample/sap.m.sample.SelectWithIcons' ).

    page_01->page(
                showheader = abap_false
                class      = `sapUiContentPadding`
                )->content(
                      )->select(
                          forceselection = abap_false
                          selectedkey    = client->_bind( selected_product )
                          items          = client->_bind( lt_product_collection )
                          )->item(
                          )->list_item( key  = '{PRODUCT_ID}'
                                        text = '{NAME}'
                                        icon = '{ICON}'
                        )->get_parent(
                    )->get_parent(
                )->get_parent( ).

    client->view_display( page_01->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Illustrates the usage of a Select with icons` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
      z2ui5_set_data( ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.


  METHOD z2ui5_set_data.

    CLEAR selected_product.
    CLEAR lt_product_collection.

    selected_product  = `HT-1001`.

    " Populate the internal table
    DATA temp1 LIKE lt_product_collection.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-product_id = 'HT-1001'.
    temp2-name = 'Notebook Basic 17'.
    temp2-icon = 'sap-icon://paper-plane'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1002'.
    temp2-name = 'Notebook Basic 18'.
    temp2-icon = 'sap-icon://add-document'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1003'.
    temp2-name = 'Notebook Basic 19'.
    temp2-icon = 'sap-icon://doctor'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1007'.
    temp2-name = 'ITelO Vault'.
    temp2-icon = 'sap-icon://sys-find-next'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1010'.
    temp2-name = 'Notebook Professional 15'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1011'.
    temp2-name = 'Notebook Professional 17'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1020'.
    temp2-name = 'ITelO Vault Net'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1021'.
    temp2-name = 'ITelO Vault SAT'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1022'.
    temp2-name = 'Comfort Easy'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1023'.
    temp2-name = 'Comfort Senior'.
    temp2-icon = 'sap-icon://add-product'.
    INSERT temp2 INTO TABLE temp1.
    lt_product_collection = temp1.
    SORT lt_product_collection BY name.

  ENDMETHOD.
ENDCLASS.

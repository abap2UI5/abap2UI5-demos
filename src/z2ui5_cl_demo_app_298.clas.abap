CLASS z2ui5_cl_demo_app_298 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_product_collection,
        product_id TYPE string,
        name       TYPE string,
      END OF ty_product_collection.

    DATA check_initialized TYPE abap_bool.
    TYPES temp1_aa49f476de TYPE TABLE OF ty_product_collection.
DATA lt_a_products TYPE temp1_aa49f476de.
    DATA selectedproducterrorcollection TYPE string.
    DATA selectedproductwrnngcollection TYPE string.
    DATA selectedproductsccsscollection TYPE string.
    DATA selectedproductinforcollection TYPE string.

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



CLASS z2ui5_cl_demo_app_298 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Select - Validation states`
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Select/sample/sap.m.sample.SelectValueState' ).

    page_01->page( showheader = abap_false
              )->content(
                  )->hbox( class = `sapUiMediumMarginBottom`
                      )->label( text = `Error state`
                          labelfor   = `errorSelect`
                          class      = `sapUiTinyMarginEnd sapUiTinyMarginTop`
                      )->select(
                          id             = `errorSelect`
                          forceselection = abap_true
                          selectedkey    = client->_bind( selectedproducterrorcollection )
                          valuestate     = `Error`
                          valuestatetext = `error value state text`
                          items          = client->_bind( lt_a_products )
                          )->item( key  = '{PRODUCT_ID}'
                                   text = '{NAME}'
                      )->get_parent(
                  )->get_parent(
                  )->hbox( class = `sapUiMediumMarginBottom`
                      )->label( text = `Warning state`
                          labelfor   = `warningSelect`
                          class      = `sapUiTinyMarginEnd sapUiTinyMarginTop`
                      )->select(
                          id             = `warningSelect`
                          forceselection = abap_true
                          selectedkey    = client->_bind( selectedproductwrnngcollection )
                          valuestate     = `Warning`
                          valuestatetext = `This is a Level 1 explanation. The items Lorem and Ipsum are not recommended from the system.`
                          items          = client->_bind( lt_a_products )
                          )->item( key  = '{PRODUCT_ID}'
                                   text = '{NAME}'
                      )->get_parent(
                  )->get_parent(
                  )->hbox( class = `sapUiMediumMarginBottom`
                      )->label( text = `Success state`
                          labelfor   = `successSelect`
                          class      = `sapUiTinyMarginEnd sapUiTinyMarginTop`
                      )->select(
                          id             = `successSelect`
                          forceselection = abap_true
                          selectedkey    = client->_bind( selectedproductsccsscollection )
                          valuestate     = `Success`
                          valuestatetext = `success value state text`
                          items          = client->_bind( lt_a_products )
                          )->item( key  = '{PRODUCT_ID}'
                                   text = '{NAME}'
                      )->get_parent(
                  )->get_parent(
                  )->hbox( class = `sapUiMediumMarginBottom`
                      )->label( text = `Information state`
                          labelfor   = `informationSelect`
                          class      = `sapUiTinyMarginEnd sapUiTinyMarginTop`
                      )->select(
                          id             = `informationSelect`
                          forceselection = abap_true
                          selectedkey    = client->_bind( selectedproductinforcollection )
                          valuestate     = `Information`
                          valuestatetext = `information value state text`
                          items          = client->_bind( lt_a_products )
                          )->item( key  = '{PRODUCT_ID}'
                                   text = '{NAME}'
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
                                  description = `Visualizes the validation state of the control, for example, Error, Warning and Success.` ).

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
    CLEAR selectedproducterrorcollection.
    CLEAR selectedproductwrnngcollection.
    CLEAR selectedproductsccsscollection.
    CLEAR selectedproductinforcollection.
    CLEAR lt_a_products.

    selectedproducterrorcollection  = `HT-998`.
    selectedproductwrnngcollection  = `HT-999`.
    selectedproductsccsscollection  = `HT-1000`.
    selectedproductinforcollection  = `HT-1007`.

    " Populate the internal table
    DATA temp1 LIKE lt_a_products.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-product_id = 'HT-998'.
    temp2-name = 'Notebook Basic 11'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-999'.
    temp2-name = 'Notebook Basic 13'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1000'.
    temp2-name = 'Notebook Basic 15'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1001'.
    temp2-name = 'Notebook Basic 17'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1002'.
    temp2-name = 'Notebook Basic 18'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1003'.
    temp2-name = 'Notebook Basic 19'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1007'.
    temp2-name = 'ITelO Vault'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1008'.
    temp2-name = 'Notebook Professional 11'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1009'.
    temp2-name = 'Notebook Professional 13'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1010'.
    temp2-name = 'Notebook Professional 15'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1011'.
    temp2-name = 'Notebook Professional 17'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1012'.
    temp2-name = 'Notebook Professional 19'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1020'.
    temp2-name = 'ITelO Vault Net'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1021'.
    temp2-name = 'ITelO Vault SAT'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1022'.
    temp2-name = 'Comfort Easy'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1023'.
    temp2-name = 'Comfort Senior'.
    INSERT temp2 INTO TABLE temp1.
    lt_a_products = temp1.
    SORT lt_a_products BY name.

  ENDMETHOD.
ENDCLASS.

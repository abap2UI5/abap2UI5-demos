CLASS z2ui5_cl_demo_app_181 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA mv_initialized TYPE abap_bool .
    DATA mv_url TYPE string .

    TYPES:
      BEGIN OF ty_cities,
        text TYPE string,
        key  TYPE string,
      END OF ty_cities.

    TYPES t_cities TYPE STANDARD TABLE OF ty_cities WITH DEFAULT KEY.

    TYPES:
      BEGIN OF ty_product_items,
        title         TYPE string,
        subtitle      TYPE string,
        revenue       TYPE string,
        status        TYPE string,
        status_schema TYPE string,
      END OF ty_product_items.

    TYPES t_product_items TYPE STANDARD TABLE OF ty_product_items WITH DEFAULT KEY.


    METHODS on_event .
    METHODS view_display .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_181 IMPLEMENTATION.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BOOK'.
        client->message_toast_display( 'BOOKED !!! ENJOY' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.
    ENDCASE.

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp7 TYPE xsdboolean.
    temp7 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell( )->page(
        title          = `Cards Demo`
        class          = `sapUiContentPadding`
        navbuttonpress = client->_event( 'BACK' )
        shownavbutton  = temp7 ).

    DATA temp1 TYPE t_cities.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-text = `Berlin`.
    temp2-key = `BR`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `London`.
    temp2-key = `LN`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `Madrid`.
    temp2-key = `MD`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `Prague`.
    temp2-key = `PR`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `Paris`.
    temp2-key = `PS`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `Sofia`.
    temp2-key = `SF`.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = `Vienna`.
    temp2-key = `VN`.
    INSERT temp2 INTO TABLE temp1.
    DATA temp5 TYPE t_cities.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-text = `Berlin`.
    temp6-key = `BR`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `London`.
    temp6-key = `LN`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `Madrid`.
    temp6-key = `MD`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `Prague`.
    temp6-key = `PR`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `Paris`.
    temp6-key = `PS`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `Sofia`.
    temp6-key = `SF`.
    INSERT temp6 INTO TABLE temp5.
    temp6-text = `Vienna`.
    temp6-key = `VN`.
    INSERT temp6 INTO TABLE temp5.
    DATA card_1 TYPE REF TO z2ui5_cl_xml_view.
    card_1 = page->card( width = `300px`
                               class = `sapUiMediumMargin`
      )->header( ns = `f`
        )->card_header( title    = `Buy bus ticket on-line`
                        subtitle = `Buy a single-ride ticket for a date`
                        iconsrc  = `sap-icon://bus-public-transport`
                      )->get_parent( )->get_parent(
                    )->content( ns = `f`
                      )->vbox( height         = `110px`
                               class          = `sapUiSmallMargin`
                               justifycontent = `SpaceBetween`
                        )->hbox( justifycontent = `SpaceBetween`
                          )->combobox( width       = `120px`
                                       placeholder = `From City`
                                       items       = `{path:'` && client->_bind_local( val                   = temp1 path = abap_true ) && `', sorter: { path: 'TEXT' } }`
                                       )->get( )->item( key  = `{KEY}`
                                                        text = `{TEXT}` )->get_parent(
                          )->combobox( width       = `120px`
                                       placeholder = `To City`
                                       items       = `{path:'` && client->_bind_local( val                   = temp5 path = abap_true ) && `', sorter: { path: 'TEXT' } }`
                                       )->get( )->item( key  = `{KEY}`
                                                        text = `{TEXT}` )->get_parent(
                      )->get_parent(
                   )->hbox( rendertype     = `Bare`
                            justifycontent = `SpaceBetween`
                    )->date_picker( width       = `200px`
                                    placeholder = `Choose Date ...`
                    )->button( text  = `Book`
                               type  = `Emphasized`
                               press = client->_event( `BOOK` )
                               class = `sapUiTinyMarginBegin` ).


    DATA temp3 TYPE t_product_items.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-title = `Notebook HT`.
    temp4-subtitle = `ID23452256-D44`.
    temp4-revenue = `27.25K EUR`.
    temp4-status = `success`.
    temp4-status_schema = `Success`.
    INSERT temp4 INTO TABLE temp3.
    temp4-title = `Notebook XT`.
    temp4-subtitle = `ID27852256-D47`.
    temp4-revenue = `7.35K EUR`.
    temp4-status = `exceeded`.
    temp4-status_schema = `Error`.
    INSERT temp4 INTO TABLE temp3.
    temp4-title = `Notebook ST`.
    temp4-subtitle = `ID123555587-I05`.
    temp4-revenue = `22.89K EUR`.
    temp4-status = `warning`.
    temp4-status_schema = `Warning`.
    INSERT temp4 INTO TABLE temp3.
    DATA card_2 TYPE REF TO z2ui5_cl_xml_view.
    card_2 = page->card( width = `300px`
                               class = `sapUiMediumMargin`
                     )->header( ns = `f`
                       )->card_header( title    = `Project Cloud Transformation`
                                       subtitle = `Revenue per Product | EUR`
                                     )->get_parent( )->get_parent(
                                   )->content( ns = `f`
                                    )->list( class          = `sapUiSmallMarginBottom`
                                             showseparators = `None`
                                             items          = client->_bind_local( temp3 )
                                       )->custom_list_item(
                                        )->hbox( alignitems     = `Center`
                                                 justifycontent = `SpaceBetween`
                                          )->vbox( class = `sapUiSmallMarginBegin sapUiSmallMarginTopBottom`
                                            )->title( text       = `{TITLE}`
                                                      titlestyle = `H3`
                                            )->text( text = `{SUBTITLE}`
                                          )->get_parent(
                                          )->object_status( class = `sapUiTinyMargin sapUiSmallMarginEnd`
                                                            text  = `{REVENUE}`
                                                            state = `{STATUS_SCHEMA}` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_initialized = abap_false.
      mv_initialized = abap_true.

      view_display( ).

    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.

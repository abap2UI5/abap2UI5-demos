CLASS z2ui5_cl_demo_app_123 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_spot,
        tooltip       TYPE string,
        type          TYPE string,
        pos           TYPE string,
        scale         TYPE string,
        contentoffset TYPE string,
        key           TYPE string,
        icon          TYPE string,
      END OF ty_spot.
    TYPES temp1_d73221ca3a TYPE TABLE OF ty_spot.
DATA mt_spot TYPE temp1_d73221ca3a.

    DATA check_initialized TYPE abap_bool.

    TYPES:
      BEGIN OF ty_route,
        position    TYPE string,
        routetype   TYPE string,
        linedash    TYPE string,
        color       TYPE string,
        colorborder TYPE string,
        linewidth   TYPE string,
      END OF ty_route .

    TYPES temp2_d73221ca3a TYPE TABLE OF ty_route.
DATA
      mt_route TYPE temp2_d73221ca3a .

    TYPES: BEGIN OF ty_s_legend,
             text  TYPE string,
             color TYPE string,
           END OF ty_s_legend.
    TYPES temp3_d73221ca3a TYPE TABLE OF ty_s_legend.
DATA mt_legend TYPE temp3_d73221ca3a.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_123 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.


    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp1 LIKE mt_spot.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-pos = `9.98336;53.55024;0`.
      temp2-contentoffset = `0;-6`.
      temp2-scale = `1;1;1`.
      temp2-key = `Hamburg`.
      temp2-tooltip = `Hamburg`.
      temp2-type = `Default`.
      temp2-icon = `factory`.
      INSERT temp2 INTO TABLE temp1.
      temp2-pos = `11.5820;48.1351;0`.
      temp2-contentoffset = `0;-5`.
      temp2-scale = `1;1;1`.
      temp2-key = `Munich`.
      temp2-tooltip = `Munich`.
      temp2-type = `Default`.
      temp2-icon = `factory`.
      INSERT temp2 INTO TABLE temp1.
      temp2-pos = `8.683340000;50.112000000;0`.
      temp2-contentoffset = `0;-6`.
      temp2-scale = `1;1;1`.
      temp2-key = `Frankfurt`.
      temp2-tooltip = `Frankfurt`.
      temp2-type = `Default`.
      temp2-icon = `factory`.
      INSERT temp2 INTO TABLE temp1.
      mt_spot = temp1.

      DATA temp3 LIKE mt_route.
      CLEAR temp3.
      DATA temp4 LIKE LINE OF temp3.
      temp4-position = '2.3522219;48.856614;0; -74.0059731;40.7143528;0'.
      temp4-routetype = 'Geodesic'.
      temp4-linedash = '10;5'.
      temp4-color = '92,186,230'.
      temp4-colorborder = 'rgb(255,255,255)'.
      temp4-linewidth = '25'.
      INSERT temp4 INTO TABLE temp3.
      mt_route = temp3.


      DATA temp5 LIKE mt_legend.
      CLEAR temp5.
      DATA temp6 LIKE LINE OF temp5.
      temp6-text = 'Dashed flight route'.
      temp6-color = 'rgb(92,186,230)'.
      INSERT temp6 INTO TABLE temp5.
      temp6-text = 'Flight route'.
      temp6-color = 'rgb(92,186,35)'.
      INSERT temp6 INTO TABLE temp5.
      mt_legend = temp5.
    ENDIF.


    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
        RETURN.

    ENDCASE.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp7 TYPE xsdboolean.
    temp7 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
            )->page(
                    title          = 'abap2UI5 - Map Container'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton  = temp7 ).

    DATA map TYPE REF TO z2ui5_cl_xml_view.
    map = page->map_container( autoadjustheight = abap_true
         )->content( ns = `vk`
             )->container_content(
               title = `Analytic Map`
               icon  = `sap-icon://geographic-bubble-chart`
                 )->content( ns = `vk`
                     )->analytic_map(
                       initialposition = `9.933573;50;0`
                       initialzoom     = `6` ).



    map->vos(
      )->spots( client->_bind( mt_spot )
      )->spot(
        position      = `{POS}`
        contentoffset = `{CONTENTOFFSET}`
        type          = `{TYPE}`
        scale         = `{SCALE}`
        tooltip       = `{TOOLTIP}` ).


    map->routes( client->_bind( mt_route ) )->route(
      position      = `{POSITION}`
        routetype   = `{ROUTETYPE}`
        linedash    = '{LINEDASH}'
        color       = '{COLOR}'
        colorborder = '{COLORBORDER}'
      linewidth     = '{LINEWIDTH}'
*      RECEIVING
*        result    =
      ).


    map->legend_area( )->legend(
*      EXPORTING
*        id      =
        items   = client->_bind( mt_legend )
        caption = 'Legend'
*      RECEIVING
*        result  =
      )->legenditem(
      text    = '{TEXT}'
        color = '{COLOR}'
*      RECEIVING
*        result =
      ).
    client->view_display( page->stringify( ) ).


  ENDMETHOD.
ENDCLASS.

CLASS z2ui5_cl_demo_app_196 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA is_initialized TYPE abap_bool .
    DATA mv_slider_value TYPE i .

    TYPES: BEGIN OF ty_shape,
       id TYPE string,
      END OF ty_shape.

    TYPES temp1_0d13b3c262 TYPE TABLE OF ty_shape.
DATA mt_shapes TYPE temp1_0d13b3c262.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA client TYPE REF TO z2ui5_if_client .

    METHODS initialize .
    METHODS on_event .
    METHODS render_screen .
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_196 IMPLEMENTATION.


  METHOD initialize.

    mv_slider_value = 0.

    DATA temp1 LIKE mt_shapes.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-id = `arrow_down`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `arrow_left`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `arrow_right`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `arrow_up`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `attention_1`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `attention_2`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `building`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `bulb`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `bull`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `calendar`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `car`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `cart`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `cereals`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `circle`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `clock`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `cloud`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `conveyor`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `desk`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `document`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `documents`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `dollar`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `donut`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `drop`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `envelope`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `euro`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `factory`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `female`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `fish`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `flag`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `folder_1`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `folder_2`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `gear`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `heart`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `honey`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `house`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `information`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `letter`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `lung`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `machine`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `male`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `pen`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `person`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `pin`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `plane`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `printer`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `progress`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `question`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `robot`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `sandclock`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `speed`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `stomach`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `success`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `tank_diesel`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `tank_lpg`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `thermo`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `tool`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `transfusion`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `travel`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `turnip`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_construction`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_tank`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_tractor`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_truck_1`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_truck_2`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `vehicle_truck_3`.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `warehouse`.
    INSERT temp2 INTO TABLE temp1.
    mt_shapes = temp1.

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD render_screen.

    DATA lv_script TYPE string.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( ns   = `html`
                    name = `style` )->_cc_plain_xml( `.SICursorStyle:hover {` &&
                                                                 `  cursor: pointer;` &&
                                                                 `}` &&
                                                                 `.SIBorderStyle {` &&
                                                                 `  border: 1px solid #cccccc;` &&
                                                                 `}` &&
                                                                 `.SIPanelStyle .sapMPanelContent{` &&
                                                                 `  overflow: visible;` &&
                                                                 `}` ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( abap_false = client->get( )-check_launchpad_active ).
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
         )->page(
            showheader     = temp1
            title          = 'abap2UI5 - Status Indicators Library'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp2 ).

    DATA panel TYPE REF TO z2ui5_cl_xml_view.
    panel = page->panel( class = `sapUiResponsiveMargin SIPanelStyle`
                               width = `95%` ).
    panel->text( text = `Use the slider for adjusting the fill` ).
    panel->slider( class           = `sapUiLargeMarginBottom`
                   enabletickmarks = abap_true
               value               = client->_bind_edit( mv_slider_value ) )->get(
       )->responsive_scale( tickmarksbetweenlabels = `10` ).

    DATA fb TYPE REF TO z2ui5_cl_xml_view.
    fb = panel->flex_box( wrap  = `Wrap`
                                items = client->_bind( mt_shapes ) ).
    fb->items(
      )->flex_box( direction = `Column`
                   class     = `sapUiTinyMargin SIBorderStyle`
        )->items(
          )->status_indicator( value  = client->_bind_edit( mv_slider_value )
                               width  = `120px`
                               height = `120px`
                               class  = `sapUiTinyMargin SICursorStyle`
            )->property_thresholds(
              )->property_threshold( fillcolor = `Error`
                                     tovalue   = `25` )->get_parent(
              )->property_threshold( fillcolor = `Critical`
                                     tovalue   = `60` )->get_parent(
              )->property_threshold( fillcolor = `Good`
                                     tovalue   = `100` )->get_parent(
               )->get_parent(
             )->shape_group(
              )->library_shape( shapeid = `{ID}` ).


    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF is_initialized = abap_false.

      initialize( ).
      render_screen( ).
      is_initialized = abap_true.

    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.

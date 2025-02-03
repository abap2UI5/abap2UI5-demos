CLASS z2ui5_cl_demo_app_320 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA viewPortPercentWidth TYPE i VALUE 100.

    TYPES: BEGIN OF ty_item,
             id           TYPE string,
             initials     TYPE char2,
             fallbackicon TYPE string,
             src          TYPE string,
             name         TYPE string,
             tooltip      TYPE string,
             jobposition  TYPE string,
             mobile       TYPE string,
             phone        TYPE string,
             email        TYPE string,
           END OF ty_item.
    TYPES ty_items TYPE STANDARD TABLE OF ty_item WITH DEFAULT KEY.

    DATA item           TYPE ty_item.
    DATA items          TYPE ty_items.
    DATA group_items    TYPE ty_items.
    DATA content_height TYPE string.
    DATA content_width  TYPE string.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS display_avatar_group_view.

    METHODS display_individual_popover
      IMPORTING !id TYPE string.

    METHODS display_group_popover
      IMPORTING !id TYPE string.

    METHODS on_event.

  PRIVATE SECTION.
    METHODS calculate_content_height
      IMPORTING !lines        TYPE i
      RETURNING VALUE(result) TYPE string.

ENDCLASS.


CLASS z2ui5_cl_demo_app_320 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    me->client = client.

    IF client->check_on_init( ) IS NOT INITIAL.

      DATA temp1 TYPE z2ui5_cl_demo_app_320=>ty_items.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-mobile = `+89181818181`.
      temp2-phone = `+2828282828`.
      temp2-email = `blabla@blabla`.
      temp2-id = `1`.
      temp2-initials = `JD`.
      temp2-name = `John Doe`.
      temp2-tooltip = `1`.
      temp2-jobPosition = `Marketing Manager`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `2`.
      temp2-initials = `SP`.
      temp2-name = `Sarah Parker`.
      temp2-tooltip = `2`.
      temp2-jobPosition = `Visual Designer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `3`.
      temp2-initials = `JG`.
      temp2-name = `Jason Goldwell`.
      temp2-tooltip = `3`.
      temp2-jobPosition = `Software Developer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `4`.
      temp2-name = `Christian Bow`.
      temp2-jobPosition = `Marketing Manager`.
      temp2-tooltip = `4`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `5`.
      temp2-src = `https://sapui5.hana.ondemand.com/test-resources/sap/f/images/Woman_avatar_01.png`.
      temp2-tooltip = `5`.
      temp2-name = `Jessica Parker`.
      temp2-jobPosition = `Visual Designer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `6`.
      temp2-initials = `JB`.
      temp2-name = `Jonathan Bale`.
      temp2-jobPosition = `Software Developer`.
      temp2-tooltip = `6`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `7`.
      temp2-initials = `GS`.
      temp2-name = `Gordon Smith`.
      temp2-jobPosition = `Marketing Manager`.
      temp2-tooltip = `7`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `8`.
      temp2-fallbackIcon = `sap-icon =//person-placeholder`.
      temp2-name = `Simon Jason`.
      temp2-tooltip = `8`.
      temp2-jobPosition = `Visual Designer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `9`.
      temp2-initials = `JS`.
      temp2-name = `Jason Swan`.
      temp2-jobPosition = `Software Developer`.
      temp2-tooltip = `9`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `10`.
      temp2-initials = `JC`.
      temp2-name = `John Carter`.
      temp2-jobPosition = `Marketing Manager`.
      temp2-tooltip = `10`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `11`.
      temp2-src = `https://sapui5.hana.ondemand.com/test-resources/sap/f/images/Woman_avatar_02.png`.
      temp2-name = `Whitney Parker`.
      temp2-tooltip = `11`.
      temp2-jobPosition = `Visual Designer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `12`.
      temp2-fallbackIcon = `sap-icon =//person-placeholder`.
      temp2-name = `Jason Goldwell`.
      temp2-tooltip = `12`.
      temp2-jobPosition = `Software Developer`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `13`.
      temp2-initials = `CD`.
      temp2-name = `Chris Doe`.
      temp2-jobPosition = `Marketing Manager`.
      temp2-tooltip = `13`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `14`.
      temp2-initials = `SS`.
      temp2-name = `Sarah Smith`.
      temp2-jobPosition = `Visual Designer`.
      temp2-tooltip = `14`.
      INSERT temp2 INTO TABLE temp1.
      temp2-id = `15`.
      temp2-initials = `DC`.
      temp2-name = `David Copper`.
      temp2-jobPosition = `Software Developer`.
      temp2-tooltip = `15`.
      INSERT temp2 INTO TABLE temp1.
      items = temp1.
      display_avatar_group_view( ).
    ENDIF.

    on_event( ).
  ENDMETHOD.

  METHOD display_avatar_group_view.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_z2ui5( )->title( `Avatar Group Sample` ).
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$source>/id}` INTO TABLE temp3.
    INSERT `${$parameters>/groupType}` INTO TABLE temp3.
    INSERT `${$parameters>/overflowButtonPressed}` INTO TABLE temp3.
    INSERT `${$parameters>/avatarsDisplayed}` INTO TABLE temp3.
    INSERT `$event.getParameter("eventSource").getId()` INTO TABLE temp3.
    INSERT `$event.oSource.indexOfItem($event.getParameter("eventSource"))` INTO TABLE temp3.
    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/id}` INTO TABLE temp1.
    INSERT `${$parameters>/groupType}` INTO TABLE temp1.
    INSERT `${$parameters>/overflowButtonPressed}` INTO TABLE temp1.
    INSERT `${$parameters>/avatarsDisplayed}` INTO TABLE temp1.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->page( title          = 'abap2UI5 - Sample: Avatar Group'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp2
        )->slider( value = client->_bind_edit( viewPortPercentWidth )
            )->vertical_layout( id    = `vl1`
                                width = |{ client->_bind_edit( viewPortPercentWidth ) }%|
                                class = `sapUiContentPadding`
                )->label( text  = `AvatarGroup control in Individual mode`
                          class = `sapUiSmallMarginBottom sapUiMediumMarginTop`
                )->avatar_group(
                    id                = `avatarGroup1`
                    groupType         = `Individual`
                    avatarDisplaySize = `S`
                    press             = client->_event(
                                            val   = `onIndividualPress`
                                            t_arg = temp3 )

                    items             = client->_bind( items )
                    )->avatar_group_item( initials     = `{INITIALS}`
                                          fallbackIcon = `{FALLBACKICON}`
                                          src          = `{SRC}`
                                          tooltip      = `{NAME}`

                )->get_parent(

                )->label( text  = `AvatarGroup control in Group mode`
                          class = `sapUiSmallMarginBottom sapUiMediumMarginTop`
                )->avatar_group( id                = `avatarGroup2`
                                 groupType         = `Group`
                                 tooltip           = `Avatar Group`
                                 avatarDisplaySize = `M`
                                 press             = client->_event( val   = `onGroupPress`
                                                                     t_arg = temp1 )
                                 items             = client->_bind( items )
                    )->avatar_group_item( initials     = `{INITIALS}`
                                          fallbackIcon = `{FALLBACKICON}`
                                          src          = `{SRC}` ).
    client->view_display( view->stringify( ) ).
  ENDMETHOD.

  METHOD display_individual_popover.
    DATA individual_popover TYPE REF TO z2ui5_cl_xml_view.
    individual_popover = z2ui5_cl_xml_view=>factory_popup( ).
    individual_popover->popover( id             = `individualPopover`
                                 class          = `sapFAvatarGroupPopover`
                                 title          = `Business card`
                                 titleAlignment = `Center`
                                 placement      = `Bottom`
                                 contentWidth   = `250px`
                                 contentHeight  = `332px`
        )->card(
            )->content( ns = `f`
                )->vertical_layout( class = `sapUiContentPadding`
                    )->HBox( alignItems = `Center`
                        )->Avatar( src          = client->_bind( item-src )
                                   initials     = client->_bind( item-initials )
                                   badgetooltip = client->_bind( item-tooltip )
                                   fallbackIcon = client->_bind( item-fallbackicon )
                        )->vbox( class = `sapUiTinyMarginBegin`
                            )->Title( text = client->_bind_local( item-name )
                            )->Text( text = client->_bind_local( item-jobposition )
                        )->get_parent(
                    )->get_parent(
                    )->Title( text = `Contact Details`
                    )->Label( text = `Mobile`
                    )->Text( text = client->_bind( item-mobile )
                    )->Label( text = `Phone`
                    )->Text( text = client->_bind( item-phone )
                    )->Label( text = `Email`
                    )->Text( text = client->_bind( item-email ) ).

    client->popover_display( xml   = individual_popover->stringify( )
                             by_id = id ).
  ENDMETHOD.

  METHOD display_group_popover.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).

    DATA nav_container TYPE REF TO z2ui5_cl_xml_view.
    nav_container = view->popover( id            = `groupPopover`
                                         class         = `sapFAvatarGroupPopover`
                                         showheader    = abap_false
                                         contentWidth  = client->_bind( content_width )
                                         contentHeight = client->_bind( content_height )
                                         placement     = `Bottom`
        )->nav_container( id = `navContainer` ).

    DATA temp5 TYPE string_table.
    CLEAR temp5.
    INSERT `${ID}` INTO TABLE temp5.
    nav_container->page( id             = `main`
                         titleAlignment = `Center`
                         title          = |Team Members ({ lines( group_items ) })|
                )->vertical_layout( class = `sapUiTinyMarginTop`
                                    width = `100%`
                    )->grid( default_Span = `XL6 L6 M6 S12`
                             content      = client->_bind( group_items )

                        )->hbox( alignItems = `Center`
                            )->vbox(
                                )->avatar( class           = `sapUiTinyMarginEnd`
                                           initials        = `{INITIALS}`
                                           fallbackIcon    = `{FALLBACKICON}`
                                           src             = `{SRC}`
                                           badgetooltip    = `{NAME}`
                                           backgroundcolor = `{BACKGROUNDCOLOR}`
                                           press           = client->_event( val   = `onAvatarPress`
                                                                             t_arg = temp5 )
                            )->get_parent(
                            )->vbox(
                                )->Text( text = `{NAME}`
                                )->Text( text = `{JOBPOSITION}` ).

    nav_container->page( id             = `detail`
                         showNavButton  = abap_true
                         navButtonPress = client->_event( val = `onNavBack` )
                         titleAlignment = `Center`
                         title          = |Team Members ({ lines( group_items ) })|
        )->card(
            )->content( ns = `f`
                )->vertical_layout( class = `sapUiContentPadding`
                    )->HBox( alignItems = `Center`
                        )->Avatar( src          = client->_bind( item-src )
                                   initials     = client->_bind( item-initials )
                                   badgetooltip = client->_bind( item-tooltip )
                                   fallbackIcon = client->_bind( item-fallbackicon )
                        )->vbox( class = `sapUiTinyMarginBegin`
                            )->Title( text = client->_bind( item-name )
                            )->Text( text = client->_bind( item-jobposition )
                        )->get_parent(
                    )->get_parent(
                    )->Title( text = `Contact Details`
                    )->Label( text = `Mobile`
                    )->Text( text = client->_bind( item-mobile )
                    )->Label( text = `Phone`
                    )->Text( text = client->_bind( item-phone )
                    )->Label( text = `Email`
                    )->Text( text = client->_bind( item-email ) ).

    client->popover_display( xml   = view->stringify( )
                             by_id = id ).
  ENDMETHOD.

  METHOD on_event.
    DATA lt_arg TYPE string_table.
    lt_arg = client->get( )-t_event_arg.
    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN `onGroupPress`.
        DATA group_id LIKE LINE OF lt_arg.
        DATA temp3 LIKE LINE OF lt_arg.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE lt_arg INDEX 1 INTO temp3.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        group_id = temp3.
        group_items = items.
        content_height = calculate_content_height( lines( group_items ) ).
        content_width = '450px'.

        display_group_popover( id = group_id ).
        client->popover_destroy( ).

      WHEN `onIndividualPress`.
        DATA overflow_button_pressed LIKE LINE OF lt_arg.
        DATA temp5 LIKE LINE OF lt_arg.
        DATA temp6 LIKE sy-tabix.
        temp6 = sy-tabix.
        READ TABLE lt_arg INDEX 3 INTO temp5.
        sy-tabix = temp6.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        overflow_button_pressed = temp5.
        DATA items_displayed LIKE LINE OF lt_arg.
        DATA temp8 LIKE LINE OF lt_arg.
        DATA temp14 LIKE sy-tabix.
        temp14 = sy-tabix.
        READ TABLE lt_arg INDEX 4 INTO temp8.
        sy-tabix = temp14.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        items_displayed = temp8.
        DATA item_id LIKE LINE OF lt_arg.
        DATA temp16 LIKE LINE OF lt_arg.
        DATA temp17 LIKE sy-tabix.
        temp17 = sy-tabix.
        READ TABLE lt_arg INDEX 5 INTO temp16.
        sy-tabix = temp17.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        item_id = temp16.
        DATA item_table_index LIKE LINE OF lt_arg.
        DATA temp18 LIKE LINE OF lt_arg.
        DATA temp19 LIKE sy-tabix.
        temp19 = sy-tabix.
        READ TABLE lt_arg INDEX 6 INTO temp18.
        sy-tabix = temp19.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        item_table_index = temp18.

        DATA temp7 TYPE ty_items.
        CLEAR temp7.
        DATA itm LIKE LINE OF items.
        LOOP AT items INTO itm FROM items_displayed + 1.
          INSERT itm INTO TABLE temp7.
        ENDLOOP.
        group_items = temp7.
        content_height = calculate_content_height( lines( group_items ) ).
        content_width = '450px'.

        IF overflow_button_pressed = abap_true.
          display_group_popover( id = item_id ).
        ELSE.
          DATA temp9 TYPE z2ui5_cl_demo_app_320=>ty_item.
          CLEAR temp9.
          DATA temp10 TYPE z2ui5_cl_demo_app_320=>ty_item.
          READ TABLE items INTO temp10 INDEX item_table_index + 1.
          IF sy-subrc = 0.
            temp9 = temp10.
          ENDIF.
          item = temp9.
          display_individual_popover( id = item_id ).
        ENDIF.
        client->popover_destroy( ).

      WHEN `onAvatarPress`.
        DATA id LIKE LINE OF lt_arg.
        DATA temp20 LIKE LINE OF lt_arg.
        DATA temp21 LIKE sy-tabix.
        temp21 = sy-tabix.
        READ TABLE lt_arg INDEX 1 INTO temp20.
        sy-tabix = temp21.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        id = temp20.
        DATA temp11 TYPE z2ui5_cl_demo_app_320=>ty_item.
        CLEAR temp11.
        DATA temp12 TYPE z2ui5_cl_demo_app_320=>ty_item.
        READ TABLE items INTO temp12 WITH KEY id = id.
        IF sy-subrc = 0.
          temp11 = temp12.
        ENDIF.
        item = temp11.
        content_height = `370px`.
        content_width = `250px`.

        client->popover_model_update( ).
        DATA temp13 TYPE string_table.
        CLEAR temp13.
        INSERT `navContainer` INTO TABLE temp13.
        INSERT `detail` INTO TABLE temp13.
        client->follow_up_action( client->_event_client( val   = `POPOVER_NAV_CONTAINER_TO`
                                                         t_arg = temp13 ) ).
      WHEN `onNavBack`.
        content_height = calculate_content_height( lines( group_items ) ).
        content_width = `450px`.

        client->popover_model_update( ).
        DATA temp15 TYPE string_table.
        CLEAR temp15.
        INSERT `navContainer` INTO TABLE temp15.
        INSERT `main` INTO TABLE temp15.
        client->follow_up_action( client->_event_client( val   = `POPOVER_NAV_CONTAINER_TO`
                                                         t_arg = temp15 ) ).
    ENDCASE.
  ENDMETHOD.

  METHOD calculate_content_height.
    DATA temp17 TYPE i.
    temp17 = floor( ( lines / 2 ) ) * 68 + 48.
    result = |{ condense( temp17 ) }px|.
  ENDMETHOD.
ENDCLASS.

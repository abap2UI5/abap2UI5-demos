CLASS z2ui5_cl_demo_app_000 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF ms_check_expanded,
        basics          TYPE abap_bool,
        more            TYPE abap_bool,
        features        TYPE abap_bool,
        extensions      TYPE abap_bool,
        demos           TYPE abap_bool,
        custom_controls TYPE abap_bool,
        input           TYPE abap_bool,
        popups          TYPE abap_bool,
        version         TYPE abap_bool,
        built_in        TYPE abap_bool,
      END OF ms_check_expanded.

    DATA mt_scroll     TYPE z2ui5_if_types=>ty_t_name_value.
    DATA mv_set_scroll TYPE abap_bool.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS expand_all.

ENDCLASS.


CLASS z2ui5_cl_demo_app_000 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    CONSTANTS c_title TYPE string VALUE ` abap2UI5 - Samples`.

    IF client->get( )-check_on_navigated = abap_true.
      IF mt_scroll IS INITIAL.
        DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
        CLEAR temp1.
        DATA temp2 LIKE LINE OF temp1.
        temp2-n = `page`.
        INSERT temp2 INTO TABLE temp1.
        mt_scroll = temp1.
      ENDIF.
      mv_set_scroll = abap_true.
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'expand-all'.
        expand_all( ).
      WHEN 'collapse-all'.
        CLEAR ms_check_expanded.
      WHEN OTHERS.
        TRY.
            DATA lv_classname TYPE string.
            lv_classname = to_upper( client->get( )-event ).
            DATA li_app TYPE REF TO z2ui5_if_app.
            CREATE OBJECT li_app TYPE (lv_classname).
            client->nav_app_call( li_app ).
            RETURN.
          CATCH cx_root.
        ENDTRY.
    ENDCASE.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp3 TYPE xsdboolean.
    temp3 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory(
        )->shell( )->page( id             = `page`
                           title          = c_title
                           navbuttonpress = client->_event( val = 'BACK'  )
                           shownavbutton  = temp3
        )->header_content(
            )->toolbar_spacer(
            )->link( text   = 'Install with abapGit from GitHub'
                     target = '_blank'
                     href   = 'https://github.com/abap2UI5/samples'
        )->get_parent( ).

    IF client->get( )-check_launchpad_active = abap_true.
      page->_z2ui5( )->lp_title( c_title ).
    ENDIF.

    page->_z2ui5( )->scrolling( setupdate = client->_bind_edit( mv_set_scroll )
                                items     = client->_bind_edit( mt_scroll ) ).

    page = page->grid( 'L12 M12 S12'
         )->content( 'layout' ).

        page->formatted_text(
  `<p><strong>Explore and copy code samples!</strong> All samples are abap2UI5 implementations of the <a href="https://sapui5.hana.ondemand.com/#/controls" style="color:blue; font-weight:600;">SAP UI5 sample page.</a> If you miss a control or find a b` &&
  `ug please create an ` &&
  `<a href="https://github.com/abap2UI5/abap2UI5/issues" style="color:blue; font-weight:600;">issue</a> or send a <a href="https://github.com/abap2UI5/abap2UI5-samples/pulls" style="color:blue; font-weight:600;">PR</a>` &&
  `.</p>`  &&
    `<p>Always press CTRL+F12 to see code samples and classname of the app.</p>`
  ).

    page->hbox(
       )->button( press = client->_event( 'expand-all' )
                  icon  = 'sap-icon://expand-all'
       )->button( press = client->_event( 'collapse-all' )
                  icon  = 'sap-icon://collapse-all' ).

    DATA page2 LIKE page.
    page2 = page.

    page = page->panel( expandable = abap_true
                        expanded   = client->_bind_edit( ms_check_expanded-basics )
                        headertext = `General` ).

    DATA panel TYPE REF TO z2ui5_cl_xml_view.
    panel = page->panel( expandable = abap_false
                               expanded   = abap_true
                               headertext = `Binding`
    ).

    panel->generic_tile( header    = 'Binding I'
                         subheader = 'Simple - Send values to the backend'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_001' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Binding II'
                         subheader = 'Structure Component Level'
                         press     = client->_event( 'z2ui5_cl_demo_app_166' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Binding III'
                         subheader = 'Table Cell Level'
                         press     = client->_event( 'z2ui5_cl_demo_app_144' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel->generic_tile( header = 'setSizeLimit'
*                         subheader = 'Table Cell Level'
                         press  = client->_event( 'z2ui5_cl_demo_app_071' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Events`
    ).

    panel->generic_tile( header    = 'Event I'
                         subheader = 'Handle events & change the view'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_004' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel->generic_tile( header    = 'Event II'
                         subheader = 'Call other apps & exchange data'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_024' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel->generic_tile( header    = 'Event III'
                         subheader = 'Additional Infos with t_args'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_167' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel->generic_tile( header    = 'Event IV'
                         subheader = `Facet Filter - T_arg with Objects`
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_197' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Follow Up Action'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_180' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Features`
    ).

    panel->generic_tile( header    = 'Timer I'
                         subheader = 'Wait n MS and call again the server'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_028' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Timer II'
                         subheader = 'Set Loading Indicator while Server Request'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_064' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header    = 'New Tab'
                         subheader = 'Open an URL in a new tab'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_073' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Focus I'
                         press  = client->_event( 'z2ui5_cl_demo_app_133' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Focus II'
                         press  = client->_event( 'z2ui5_cl_demo_app_189' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Scrolling'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_134' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'History'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_139' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = `Data Loss Protection`
                         press  = client->_event( 'z2ui5_cl_demo_app_279' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header = 'Tab Title'
                         press  = client->_event( 'z2ui5_cl_demo_app_125' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Session Stickyness I'
                         subheader = 'Stateful mode'
                         press     = client->_event( 'z2ui5_cl_demo_app_137' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Session Stickyness II'
                         subheader = 'Use Locks'
                         press     = client->_event( 'z2ui5_cl_demo_app_135' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Messages`
    ).

    panel->generic_tile( header    = 'Basic'
                         subheader = 'Toast, Box & Strip'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_008' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Message Box'
                         subheader = 'sy, bapiret, cx_root'
                         press     = client->_event( 'z2ui5_cl_demo_app_187' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Popup'
                         subheader = 'Messages & Exception'
                         press     = client->_event( 'z2ui5_cl_demo_app_154' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header    = 'Message View'
                         " TODO: check spelling: Ouput (typo) -> Output (ABAP cleaner)
                         subheader = 'Custom Popup, Popover & Ouput'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_038' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).


    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `File API`
     ).

    panel->generic_tile( header    = 'Download CSV'
                         subheader = 'Export Table as CSV'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_057' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Upload CSV'
                         subheader = 'Import CSV as internal Table'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_074' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header    = 'File Uploader'
                         subheader = 'Upload files to the Backend'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_075' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'File Download'
                         subheader = 'Download files to the Frontend'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_186' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `S-RTTI - Dynamic Typing`
            ).

    panel->generic_tile( header    = 'Dynamic Types'
                         subheader = 'Use S-RTTI to send tables to the frontend'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_061' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Dynamic Objects I'
                         subheader = 'Use S-RTTI to render different Subapps'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_131' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Dynamic Objects II'
                         subheader = 'User Generic Data Refs in Subapps'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_117' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Dynamic Objects III'
                         subheader = 'User Generic Data Refs in Subapps'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_185' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Device Capabilities`
       ).

    panel->generic_tile( header    = 'Geolocation'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_120' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Frontend Infos'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_122' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Camera'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_306' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

*        panel->generic_tile(
*           header    = 'Camera & Picture'
*           press     =  client->_event( 'z2ui5_cl_demo_app_137' )
*           mode      = 'LineMode'
*           class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*       ).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-input )
                         headertext = `Input & Output` ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Output`
      ).

    panel->generic_tile( header = 'Label'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_051' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header = 'Progress Indicator'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_022' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header    = 'PDF Viewer'
                         subheader = 'Display PDFs via iframe'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_079' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Formatted Text'
                         subheader = 'Display HTML'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_015' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Text'
                         subheader = 'Max Lines'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_206' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'InfoLabel'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_209' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Busy Indicator'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_215' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Object Header'
                         subheader = 'with Circle-shaped Image'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_272' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Object Page Header'
                         subheader = 'with Header Container'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_303' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Object Marker in a table'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_289' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Link'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_293' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Object Status'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_300' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Object Attribute inside Table'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_302' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = 'Input'
   ).

    panel->generic_tile( header = 'Step Input'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_041' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile( header = 'Range Slider'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_005' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile( header = 'Text Area'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_021' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Code Editor'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_035' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header = 'Rich Text Editor'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_106' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header = 'Feed Input'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_101' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Radio Button'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_207' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Radio Button Group'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_208' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Input'
                         subheader = 'Types'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_210' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Input'
                         subheader = 'Password'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_213' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Rating Indicator'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_220' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'ComboBox'
                         subheader = 'Suggestions wrapping'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_229' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Segmented Button in Input List Item'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_230' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Date Range Selection'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_231' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Multi Input'
                         subheader = 'Suggestions wrapping'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_232' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Multi Combo Box'
                         subheader = 'Suggestions wrapping'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_233' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Text Area'
                         subheader = 'Value States'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_234' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Text Area'
                         subheader = 'Growing'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_236' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Slider'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_237' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Checkbox'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_239' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Switch'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_240' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'HTML'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_242' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Input'
                         subheader = 'Suggestions wrapping'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_246' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Input'
                         subheader = 'Description'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_251' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Button'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_259' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Step Input'
                         subheader = 'Value States'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_264' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile( header = 'Code Editor'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_265' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile( header = 'Toggle Button'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_266' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Multi Input'
                         subheader = 'Value States'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_267' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Icon'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_268' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'InvisibleText'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_282' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Feed Input 2'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_283' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Select'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_288' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Date Picker'
                         subheader = 'Value States'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_294' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Date Range Selection'
                         subheader = 'Value States'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_295' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Select'
                         subheader = 'with icons'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_297' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Select'
                         subheader = 'Validation states'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_298' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Select'
                         subheader = 'Wrapping text'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_299' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Expandable Text'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_301' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = 'Interaction'
   ).

    panel->generic_tile( header    = 'Search Field I'
                         subheader = 'Filter with enter'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_053' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile( header    = 'Search Field II'
                         subheader = 'Filter with Live Change Event'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_059' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Input with Suggestion'
                         subheader = 'Create Suggestion Table on the Server'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_060' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Multi Input'
                         subheader = 'Token & Range Handling'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_078' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header = 'Color Picker'
*                         subheader = 'Token & Range Handling'
                         press  = client->_event( 'z2ui5_cl_demo_app_270' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Breadcrumbs'
                         subheader = 'sample with current page link'
                         press     = client->_event( 'z2ui5_cl_demo_app_292' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Search Field'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_296' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Sound'
                         subheader = 'Play success and error sounds'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_304' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'URL Helper'
                         subheader = `Trigger a phone's native apps like Email, Telephone and SMS`
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_316' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = 'Formatting & Calculations'
   ).

    panel->generic_tile( header    = 'Data Types'
                         subheader = 'Use of Integer, Decimals, Dates & Time'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_047' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Formatting'
                         subheader = 'Currencies'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_067' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header    = 'Mask Input'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_110' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Expression Binding'
                         subheader = 'Use calculations & more functions directly in views'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_027' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = 'Tiles'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Numeric Content Without Margins'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_228' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Tile Content'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_241' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'News Content'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_261' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Numeric Content of Different Colors'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_262' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Numeric Content with Icon'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_263' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Image Content'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_271' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Feed Content'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_275' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Monitor Tile'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_276' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'KPI Tile'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_277' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Feed and News Tile'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_278' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tile'
                         subheader = 'Statuses'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_281' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-more )
                         headertext = `Tables & Trees`
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Table`
     ).

    panel->generic_tile( header    = 'Toolbar'
                         subheader = 'Add a container & toolbar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_006' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Selection Modes'
                         subheader = 'Single Select & Multi Select'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_019' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Editable'
                         subheader = 'Set columns editable'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_011' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Visualization'
                         subheader = 'Object Number, Object States & Tab Filter'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_072' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Column Menu'
                         press  = client->_event( 'z2ui5_cl_demo_app_183' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Cell Coloring'
                         press  = client->_event( 'z2ui5_cl_demo_app_305' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'ui.Table I'
                         subheader = 'Simple example'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_070' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'ui.Table II'
                         subheader = 'Events on Cell Level'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_160' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'ui.Table III'
                         subheader = 'Focus Handling'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_172' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Grid List'
                         subheader = 'with Drag&Drop'
                         press     = client->_event( 'z2ui5_cl_demo_app_307' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom' ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Lists`
      ).

    panel->generic_tile( header    = 'List I'
                         subheader = 'Basic'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_003' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'List II'
                         subheader = 'Events & Visualization'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_048' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Action List Item'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_216' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Input List Item'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_219' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Standard List Item'
                         subheader = 'Info State Inverted'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_286' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Standard List Item'
                         subheader = 'Wrapping'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_287' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Object List Item'
                         subheader = 'markers aggregation'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_290' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Trees`
      ).

    panel->generic_tile( header    = 'Tree Table I'
                         subheader = 'Popup Select Entry'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_068' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tree Table II'
                         subheader = 'Keep expanded state popup'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_178' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tree Table III'
                         subheader = 'Keep expanded state normal'
                         press     = client->_event( 'z2ui5_cl_demo_app_116' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Tree Table IV'
                         subheader = 'Drag & Drop'
                         press     = client->_event( 'z2ui5_cl_demo_app_116' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-popups )
                         headertext = `Popups & Popovers` ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Popups`
        ).

    panel->generic_tile( header    = 'Flow Logic'
                         subheader = 'Different ways of calling Popups'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_012' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Call Popup in Popup'
                         subheader = 'Backend Popup Stack Handling'
                         press     = client->_event( 'z2ui5_cl_demo_app_161' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'F4-Value-Help'
                         subheader = 'Popup for value help'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_009' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile( header = 'LightBox'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_273' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Popovers`
          ).

    panel->generic_tile( header    = 'Popover'
                         subheader = 'Simple Example'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_026' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Popover Item Level'
                         subheader = 'Create a Popover for a specific entry of a table'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_052' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Popover with List'
                         subheader = 'List to select in Popover'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_081' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Popover with Quick View'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_109' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Popover with Action Sheet'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_163' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Built-in Popups`
          ).

    panel->generic_tile( header = 'Popup to Inform'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_151' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Popup to Confirm'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_150' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

*        panel->generic_tile(
*               header    = 'Popup to Error'
*               press     =  client->_event( 'z2ui5_cl_demo_app_165' )
*               mode      = 'LineMode'
*               class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*           ).

    panel->generic_tile( header = 'Popup to Select'
                         press  = client->_event( 'z2ui5_cl_demo_app_174' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

*        panel->generic_tile(
*               header    = 'Popup Messages'
*               press     =  client->_event( 'Z2UI5_CL_DEMO_APP_154' )
*               mode      = 'LineMode'
*               class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*           ).

    panel->generic_tile( header = 'Popup Textedit'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_155' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Popup Input Value'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_156' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Popup File Upload'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_157' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Popup Display PDF'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_158' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Popup Get Range'
                         subheader = 'Create Select-Options in Multi Inputs'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_056' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Popup Get Range Multi'
                         subheader = 'Create Select-Options for Structures & Tables'
                         press     = client->_event( 'z2ui5_cl_demo_app_162' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Popup Display Table'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_164' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Popup Display Download'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_168' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Popup Display HTML'
                         subheader = ''
                         press     = client->_event( 'z2ui5_cl_demo_app_149' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-features )
                         headertext = `More Controls`
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Visualization`
     ).

    panel->generic_tile( header = 'Planning Calendar'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_080' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Wizard Control I'
                         press  = client->_event( 'z2ui5_cl_demo_app_175' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Wizard Control II'
                         subheader = 'Next step & SubSequentStep'
                         press     = client->_event( 'z2ui5_cl_demo_app_202' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header = 'Cards'
                         press  = client->_event( 'z2ui5_cl_demo_app_181' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Layouts`
      ).

    panel->generic_tile( header    = 'Header, Footer, Grid'
                         subheader = 'Split view in different areas'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_010' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header    = 'Dynamic Page'
                         subheader = 'Display items'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_030' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Flexible Column Layout'
                         subheader = 'Master details with tree'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_069' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Splitting Container'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_103' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Basic Alignment'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_205' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Icon Tab Header'
                         subheader = 'Standalone Icon Tab Header'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_214' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Overflow Toolbar'
                         subheader = 'Placing a Title in OverflowToolbar/Toolbar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_217' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Opposing Alignment'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_218' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Standard Margins'
                         subheader = 'Negative Margins'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_243' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Size Adjustments'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_244' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Direction & Order'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_245' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Splitter Layout'
                         subheader = '2 areas'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_247' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Splitter Layout'
                         subheader = '2 non-resizable areas'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_248' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Splitter Layout'
                         subheader = '3 areas'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_249' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'OverflowToolbar'
                         subheader = 'Alignment'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_250' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Render Type'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_252' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Equal Height Cols'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_253' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Nested'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_254' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Flex Box'
                         subheader = 'Navigation Examples'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_255' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Fix Flex'
                         subheader = 'Fix container size'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_256' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Generic Tag with Different Configurations'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_257' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Nested Splitter Layouts'
                         subheader = '7 Areas'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_260' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Shell Bar'
                         subheader = 'title mega menu'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_269' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Slide Tile'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_274' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Nested Views`
          ).

    panel->generic_tile( header    = 'Nested Views I'
                         subheader = 'Basic Example'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_065' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Nested Views II'
                         subheader = 'Head & Item Table'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_097' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Nested Views III'
                         subheader = 'Head & Item Table & Detail'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_098' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Nested Views IV'
                         subheader = 'Sub-App'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_104' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Navigation Container`
          ).

    panel->generic_tile( header = 'Nav Container I'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_088' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Icons Only'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_221' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Text and Count'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_222' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Inline Mode'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_223' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Text Only'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_224' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Separator'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_225' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Icon Tab Bar'
                         subheader = 'Sub tabs'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_226' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Bar'
                         subheader = 'Page, Toolbar & Bar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_227' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Bar'
                         subheader = 'Toolbar vs Bar vs OverflowToolbar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_235' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Message Strip'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_238' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Header Container'
                         subheader = 'Vertical Mode'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_280' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Page'
                         subheader = 'Flexible sizing - Toolbar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_284' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Page'
                         subheader = 'Flexible sizing - Icon Tab Bar'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_285' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Message Strip'
                         subheader = 'with enableFormattedText'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_291' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Templating`
          ).

    panel->generic_tile( header    = 'Templating I'
                         subheader = 'Basic Example'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_173' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Templating II'
                         subheader = 'Nested Views'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_176' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-extensions )
                         headertext = `Custom Extensions`
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `JS`
          ).

   panel->generic_tile( header    = 'Follow Up Action with JS Function'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_309' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `CSS`
      ).

   panel->generic_tile( header    = 'Messages with Styles I'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_310' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

       panel->generic_tile( header    =  'Messages with Styles II'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_311' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).


    panel->generic_tile( header    = 'Messages with Styles III'
                         subheader = 'More...'
                         press     = client->_event( 'z2ui5_cl_demo_app_084' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `General`
          ).

    panel->generic_tile( header    = 'Import View'
                         subheader = 'Copy & paste views of the UI5 Documentation'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_031' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Custom Control'
                         subheader = 'Integrate your own JS Custom Control'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_037' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Change CSS'
                         subheader = 'Send your own CSS to the frontend'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_050' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'HTML, JS, CSS'
                         subheader = 'Display normal HTML without UI5'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_032' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Canvas & SVG'
                         subheader = 'Integrate more HTML5 functionalities'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_036' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Ext. Library'
                         subheader = 'Load external JS libraries'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_040' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header    = 'Custom Function'
                         subheader = 'Call imported function'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_093' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Apps with add. Javascript`
      ).

    panel->generic_tile( header    = 'p13n Dialog'
                         subheader = 'Popup for F4 Helps'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_090' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Upload Set'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_107' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile( header    = 'Smart Variant Management'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_111' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-demos )
                         headertext = `Demos`
     ).

    page->generic_tile( header    = 'Selection Screen'
                        subheader = 'Explore Input Controls'
                        press     = client->_event( 'Z2UI5_CL_DEMO_APP_002' )
                        mode      = 'LineMode'
                        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    page->generic_tile(
        header    = 'Sample App'
        subheader = 'Nested View, Object Page, App Navigation, Tables, Lists, Images, Progress & Rating Indicator'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_085' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    page = page2->panel( expandable = abap_true
                         expanded   = client->_bind_edit( ms_check_expanded-version )
                         headertext = `UI5 Version Specific & WIP`
     ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `UI5-Only`
     ).

    panel->message_strip( `Not working with OpenUI5...` ).

    panel->generic_tile( header = 'Table with RadialMicroChart'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_177' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Donut Chart'
*                         subheader = 'Use RTTI to send tables to the frontend'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_013' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile( header = 'Line Chart'
*                         subheader = 'sap.ui.Table'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_014' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Bar Chart'
*                         subheader = 'sap.ui.Table'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_016' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Radial Chart'
*subheader = 'sap.ui.Table'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_029' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Gantt Chart'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_076' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header = 'Harvey Chart'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_308' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile( header = 'Process Flow'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_091' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Map Container'
                         press  = client->_event( 'z2ui5_cl_demo_app_123' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Timeline'
                         press  = client->_event( 'Z2UI5_CL_DEMO_APP_113' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header = 'Network Graph'
                         press  = client->_event( 'z2ui5_cl_demo_app_182' )
                         mode   = 'LineMode'
                         class  = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Status Indicator Library'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_196' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'VizFrame Charts'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_312' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Higher-Releases-Only`
).

    panel->message_strip( `Only for newer UI5 releases....` ).

    panel->generic_tile( header    = 'Generic Tag'
                         subheader = 'Since 1.70'
                         press     = client->_event( 'z2ui5_cl_demo_app_062' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Object Page with Avatar'
                         subheader = 'Since 1.73'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_017' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile( header    = 'Badge'
                         subheader = 'Since 1.80'
                         press     = client->_event( 'z2ui5_cl_demo_app_063' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Illustrated Message'
                         subheader = 'Since 1.98'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_033' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile( header    = 'Barcode Scanner'
                         subheader = 'Since 1.102'
                         press     = client->_event( 'z2ui5_cl_demo_app_124' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Side Panel'
                         subheader = `Since 1.107`
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_108' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

*        panel->generic_tile(
*      header = `Messaging`
*       subheader    = 'Since 1.118'
*       press     = client->_event( 'Z2UI5_CL_DEMO_APP_135' )
*       mode      = 'LineMode'
*       class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*    ).
*
*        panel->generic_tile(
*      header = `Messaging & Nested Views`
*       subheader    = 'Since 1.118'
*       press     = client->_event( 'Z2UI5_CL_DEMO_APP_071' )
*       mode      = 'LineMode'
*       class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*    ).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `For Testing only...`
).

    panel->generic_tile( header    = 'Model I'
                         subheader = 'RTTI Data'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_191' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Model II'
                         subheader = 'RTTI Data'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_195' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Model III'
                         subheader = 'RTTI Data'
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_199' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Date Format Error in internal table'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_118' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile( header    = 'Catch exceptions and display popup'
                         subheader = ''
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_324' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel( expandable = abap_false
                         expanded   = abap_true
                         headertext = `Work in Progress`
).
    panel->message_strip( `Give it a try....` ).

    panel->generic_tile( header    = 'Gantt Chart with Relationships'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_179' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

     panel->generic_tile( header    = 'Table with OData, HTTP Model and Device Model'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_314' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).


     panel->generic_tile( header    = 'Table with different OData Models'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_315' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).


       panel->generic_tile( header    = 'Smart Multi Input'
                         subheader = ``
                         press     = client->_event( 'z2ui5_cl_demo_app_319' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

      panel->generic_tile( header    = 'Smart Controls with Variants'
                         subheader = ``
                         press     = client->_event( 'Z2UI5_CL_DEMO_APP_313' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

       panel->generic_tile( header    = 'Avatar Group'
                         subheader = ``
                         press     = client->_event( 'z2ui5_cl_demo_app_320' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

        panel->generic_tile( header    = 'App State'
                         subheader = ``
                         press     = client->_event( 'z2ui5_cl_demo_app_321' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

        panel->generic_tile( header    = 'Share Button'
                         subheader = ``
                         press     = client->_event( 'z2ui5_cl_demo_app_323' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

        panel->generic_tile( header    = 'History'
                         subheader = ``
                         press     = client->_event( 'z2ui5_cl_demo_app_322' )
                         mode      = 'LineMode'
                         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.

  METHOD expand_all.

    DO.
      FIELD-SYMBOLS <check> TYPE any.
      ASSIGN COMPONENT sy-index OF STRUCTURE ms_check_expanded TO <check>.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      <check> = abap_true.
    ENDDO.

  ENDMETHOD.

ENDCLASS.

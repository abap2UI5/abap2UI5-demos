CLASS z2ui5_cl_demo_app_303 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.
ENDCLASS.


CLASS z2ui5_cl_demo_app_303 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA object_page_layout TYPE REF TO z2ui5_cl_xml_view.
    object_page_layout = view->object_page_layout( showtitleinheadercontent = `Title`
                                                         uppercaseanchorbar       = abap_false ).

    DATA header_title TYPE REF TO z2ui5_cl_xml_view.
    header_title = object_page_layout->header_title(
        )->object_page_dyn_header_title( ).

    header_title->expanded_heading(
        )->title( text     = `Object Page Header with Header Container`
                  wrapping = abap_true ).

    header_title->snapped_heading(
        )->hbox(
            )->vbox(
                )->avatar( src   = `https://sapui5.hana.ondemand.com/test-resources/sap/uxap/images/imageID_275314.png`
                           class = `sapUiSmallMarginEnd`
            )->vbox(
                )->title( text     = `Object Page Header with Header Container`
                          wrapping = abap_true
                )->label( text = `Example of an ObjectPage with header facet` ).

    header_title->expanded_content( ns = `uxap`
        )->label( text = `Example of an ObjectPage with header facet` ).

    header_title->snapped_title_on_mobile(
        )->title( text = `Object Page Header with Header Container` ).

    header_title->actions( 'uxap'
        )->button( text = `Edit`
                   type = `Emphasized`
        )->button( text = `Delete`
        )->button( text = `Copy`
        )->overflow_toolbar_button( icon    = `sap-icon://action`
                                    type    = `Transparent`
                                    text    = `Share`
                                    tooltip = `action` ).

    DATA header_content TYPE REF TO z2ui5_cl_xml_view.
    header_content = object_page_layout->header_content( ns = 'uxap'
        )->header_container_control( id           = `headerContainer`
                                     scrollstep   = `200`
                                     showdividers = abap_false ).

    header_content->hbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->avatar( src         = `https://sapui5.hana.ondemand.com/test-resources/sap/uxap/images/imageID_275314.png`
                   class       = `sapUiMediumMarginEnd sapUiSmallMarginBottom`
                   displaysize = `L`
        )->vbox( class = `sapUiSmallMarginBottom`
            )->title( class = `sapUiTinyMarginBottom` )->get(
                )->link( text = `Order Details`
                )->get_parent(
            )->hbox( class      = `sapUiTinyMarginBottom`
                     rendertype = `Bare`
                )->label( text  = `Manufacturer:`
                          class = `sapUiTinyMarginEnd`
                )->text( text = `Robotech`
                )->get_parent(
            )->hbox( class      = `sapUiTinyMarginBottom`
                     rendertype = `Bare`
                )->label( text  = `Factory:`
                          class = `sapUiTinyMarginEnd`
                )->text( text = `Florida, OL`
                )->get_parent(
            )->hbox( class      = `sapUiTinyMarginBottom`
                     rendertype = `Bare`
                )->label( text  = `Supplier:`
                          class = `sapUiTinyMarginEnd`
                )->text( text = `Robotech (234242343)`
                )->get_parent(
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( text  = `Contact Information`
                  class = `sapUiTinyMarginBottom`
        )->hbox( class = `sapUiTinyMarginBottom`
            )->icon( src = `sap-icon://account`
            )->link( text  = `John Miller`
                     class = `sapUiSmallMarginBegin`
            )->get_parent(
        )->hbox( class = `sapUiTinyMarginBottom`
            )->icon( src = `sap-icon://outgoing-call`
            )->link( text  = `+1 234 5678`
                     class = `sapUiSmallMarginBegin`
            )->get_parent(
        )->hbox( class = `sapUiTinyMarginBottom`
            )->icon( src = `sap-icon://email`
            )->link( text  = `john.miller@company.com`
                     class = `sapUiSmallMarginBegin`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->hbox( class = `sapUiTinyMarginBottom`
            )->label( text  = `Created By:`
                      class = `sapUiSmallMarginEnd`
            )->link( text = `Julie Armstrong`
            )->get_parent(
        )->hbox( class      = `sapUiTinyMarginBottom`
                 rendertype = `Bare`
            )->label( text  = `Created On:`
                      class = `sapUiSmallMarginEnd`
            )->text( text = `February 20, 2020`
            )->get_parent(
        )->hbox( class = `sapUiTinyMarginBottom`
            )->label( text  = `Changed By:`
                      class = `sapUiSmallMarginEnd`
            )->link( text = `John Mille`
            )->get_parent(
        )->hbox( class = `sapUiTinyMarginBottom`
            )->label( text  = `Changed On:`
                      class = `sapUiSmallMarginEnd`
            )->text( text = `February 20, 2020`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( text  = `Product Description`
                  class = `sapUiTinyMarginBottom`
        )->text(
            width = `320px`
            text  = |Top-design high-quality coffee mug - ideal for a comforting moment; Pack: 6; material: | &&
            |Porcelain - durable dishwasher and microwave-safe porcelain that cleans easily and is ideal for everyday service. Comes in two bright colors.|
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( class = `sapUiTinyMarginBottom` )->get(
            )->link( text = `Status`
            )->get_parent(
        )->object_status( text  = `Delivery`
                          state = `Success`
                          class = `sapMObjectStatusLarge`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( text  = `Delivery Time`
                  class = `sapUiTinyMarginBottom`
        )->object_status( text  = `12 Days`
                          icon  = `sap-icon://shipping-status`
                          class = `sapMObjectStatusLarge`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( text  = `Assembly Option`
                  class = `sapUiTinyMarginBottom`
        )->object_status( text  = `To Be Selected`
                          state = `Error`
                          class = `sapMObjectStatusLarge`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( text  = `Price`
                  class = `sapUiTinyMarginBottom`
        )->object_status( text  = `579 EUR`
                          class = `sapMObjectStatusLarge`
            )->get_parent(
        )->get_parent(
      )->vbox( class = `sapUiSmallMarginEnd sapUiSmallMarginBottom`
        )->title( class = `sapUiTinyMarginBottom` )->get(
            )->link( text = `Average User Rating`
            )->get_parent(
        )->label( text = `6 Reviews`
        )->rating_indicator( value    = `4`
                             iconsize = `16px`
                             )->get_parent(
        )->vbox( alignitems = `End`
            )->text( text = `4.1 out of 5` ).

    DATA section TYPE REF TO z2ui5_cl_xml_view.
    section = object_page_layout->sections( ).

    section->object_page_section( titleuppercase = abap_false
                                  id             = `goalsSection`
                                  title          = `2014 Goals Plan`
        )->sub_sections(
            )->object_page_sub_section( id             = `goalsSectionSS1`
                                        titleuppercase = abap_false
                )->blocks(
                    )->simple_form( editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `2`
                                    columnsl   = `3`
                                    columnsxl  = `4`
                                    labelspanl = `12`
                        )->label( text = `Evangelize the UI framework across the company`
                        )->text( text = `4 days overdue Cascaded`
                        )->label( text = `Get trained in development management direction`
                        )->text( text = `Due Nov 21`
                        )->label( text = `Mentor junior developers`
                        )->text( text = `Due Dec 31 Cascaded` ).
    section->object_page_section( titleuppercase = abap_false
                                  id             = `personalSection`
                                  title          = `Personal`
                                  importance     = `Medium`
        )->sub_sections(
            )->object_page_sub_section( id             = `personalSectionSS1`
                                        titleuppercase = abap_false
                                        title          = `Connect`
                )->blocks(
                    )->simple_form( editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `2`
                                    columnsl   = `3`
                                    columnsxl  = `4`
                                    labelspanl = `12`
                        )->title( ns   = `core`
                                  text = `Phone Numbers`
                            )->label( text = `Home`
                            )->text( text = `+ 1 415-321-1234`
                            )->label( text = `Office phone`
                            )->text( text = `+ 1 415-321-5555`
                        )->get_parent(
                    )->simple_form( editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `2`
                                    columnsl   = `3`
                                    columnsxl  = `4`
                                    labelspanl = `12`
                        )->title( ns   = `core`
                                  text = `Social Accounts`
                            )->label( text = `LinkedIn`
                            )->text( text = `/DeniseSmith`
                            )->label( text = `Twitter`
                            )->text( text = `@DeniseSmith`
                        )->get_parent(
                    )->simple_form( editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `2`
                                    columnsl   = `3`
                                    columnsxl  = `4`
                                    labelspanl = `12`
                        )->title( ns   = `core`
                                  text = `Addresses`
                            )->label( text = `Home Address`
                            )->text( text = `2096 Mission Street`
                            )->label( text = `Mailing Address`
                            )->text( text = `PO Box 32114`
                        )->get_parent(
                    )->simple_form( editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `2`
                                    columnsl   = `3`
                                    columnsxl  = `4`
                                    labelspanl = `12`
                        )->title( ns   = `core`
                                  text = `Mailing Address`
                            )->label( text = `Work`
                            )->text( text = `DeniseSmith@sap.com`
                        )->get_parent(
                    )->get_parent(
                )->get_parent(
            )->object_page_sub_section( id             = `personalSectionSS2`
                                        titleuppercase = abap_false
                                        title          = `Payment Information`
                )->blocks(
                    )->simple_form( editable    = abap_false
                                    layout      = `ColumnLayout`
                                    width       = `100%`
                                    columnsm    = `1`
                                    columnsl    = `2`
                                    columnsxl   = `3`
                                    labelspans  = `12`
                                    labelspanm  = `12`
                                    labelspanl  = `12`
                                    labelspanxl = `12`
                        )->title( ns   = `core`
                                  text = `Main Payment Method`
                        )->label( text = `Bank Transfer`
                        )->text( text = `Sparkasse Heimfeld, Germany`
                        )->get_parent(
                    )->get_parent(
                )->more_blocks(
                    )->simple_form( editable    = abap_false
                                    layout      = `ColumnLayout`
                                    width       = `100%`
                                    columnsm    = `1`
                                    columnsl    = `2`
                                    columnsxl   = `3`
                                    labelspans  = `12`
                                    labelspanm  = `12`
                                    labelspanl  = `12`
                                    labelspanxl = `12`
                        )->title( ns   = `core`
                                  text = `Payment method for Expenses`
                        )->label( text = `Extra Travel Expenses`
                        )->text( text = `Cash 100 USD` ).

    section->object_page_section( titleuppercase = abap_false
                                  id             = `employmentSection`
                                  title          = `Employment`
        )->sub_sections(
            )->object_page_sub_section( id             = `employmentSectionSS1`
                                        titleuppercase = abap_false
                                        title          = `Job information`
                )->blocks(
                    )->simple_form( id          = `jobinfopart1`
                                    editable    = abap_false
                                    layout      = `ColumnLayout`
                                    width       = `100%`
                                    columnsm    = `2`
                                    columnsl    = `3`
                                    columnsxl   = `4`
                                    labelspans  = `12`
                                    labelspanm  = `12`
                                    labelspanl  = `12`
                                    labelspanxl = `12`
                        )->label( text = `Job classification`
                        )->text( text = `Senior Ui Developer (UIDEV-SR)`
                        )->label( text = `Pay Grade`
                        )->text( text = `Salary Grade 18 (GR-14)`
                        )->label( text = `Job title`
                        )->text( text = `Developer`
                        )->get_parent(
                    )->simple_form( id          = `jobinfopart2`
                                    editable    = abap_false
                                    layout      = `ColumnLayout`
                                    width       = `100%`
                                    columnsm    = `2`
                                    columnsl    = `3`
                                    columnsxl   = `4`
                                    labelspans  = `12`
                                    labelspanm  = `12`
                                    labelspanl  = `12`
                                    labelspanxl = `12`
                        )->label( text = `Employee Class`
                        )->text( text = `Employee`
                        )->label( text = `FTE`
                        )->text( text = `1`
                        )->get_parent(
                    )->horizontal_layout( class = `sapUiSmallMarginTop`
                        )->vertical_layout(
                            )->label( text = `Manager`
                                )->horizontal_layout(
                                    )->content( ns = `layout`
                                    )->vertical_layout(
                                        )->text( text = `James Smith`
                                        )->text( text = `Development Manager`
                                        )->get_parent(
                                    )->get_parent(
                                )->get_parent(
                            )->get_parent(
                        )->get_parent(
                    )->get_parent(
                )->get_parent(
            )->object_page_sub_section( id             = `employmentSectionSS2`
                                        titleuppercase = abap_false
                                        title          = `Employee Details`
                )->blocks(
                    )->simple_form( id         = `empdetailpart1`
                                    editable   = abap_false
                                    layout     = `ColumnLayout`
                                    width      = `100%`
                                    columnsm   = `1`
                                    columnsl   = `1`
                                    columnsxl  = `2`
                                    labelspans = `12`
                                    labelspanl = `12`
                        )->title( ns   = `core`
                                  text = `Termination information`
                            )->label( text = `Ok to return`
                            )->text( text = `No`
                            )->label( text = `Regret Termination`
                            )->text( text = `Yes`
                        )->get_parent(
                    )->get_parent(
                )->more_blocks(
                        )->simple_form( id         = `empdetailpart2`
                                        editable   = abap_false
                                        layout     = `ColumnLayout`
                                        width      = `100%`
                                        columnsm   = `2`
                                        columnsl   = `3`
                                        columnsxl  = `4`
                                        labelspans = `12`
                                        labelspanl = `12`
                            )->label( text = `Start Date`
                            )->text( text = `Jan 01, 2001`
                            )->label( text = `End Date`
                            )->text( text = `Jun 30, 2014`
                            )->label( text = `Last Date Worked`
                            )->text( text = `Jun 01, 2014`
                            )->label( text = `Payroll End Date`
                            )->text( text = `Jun 01, 2014`
                            )->get_parent(
                        )->simple_form( id         = `empdetailpart3`
                                        editable   = abap_false
                                        layout     = `ColumnLayout`
                                        width      = `100%`
                                        columnsm   = `2`
                                        columnsl   = `3`
                                        columnsxl  = `4`
                                        labelspans = `12`
                                        labelspanl = `12`
                            )->label( text = `Payroll End Date`
                            )->text( text = `Jan 01, 2014`
                            )->label( text = `Benefits End Date`
                            )->text( text = `Jun 30, 2014`
                            )->label( text = `Stock End Date`
                            )->text( text = `Jun 01, 2014`
                            )->label( text = `Eligible for Salary Contribution`
                            )->text( text = `No` ).

    client->view_display( view->stringify( ) ).
  ENDMETHOD.
ENDCLASS.

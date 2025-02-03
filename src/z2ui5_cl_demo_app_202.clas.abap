CLASS z2ui5_cl_demo_app_202 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA av_next TYPE string VALUE 'Step22' ##NO_TEXT.
    DATA av_init TYPE abap_bool .
  PROTECTED SECTION.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_202 IMPLEMENTATION.


  METHOD display_view.

    DATA lr_view TYPE REF TO z2ui5_cl_xml_view.
    lr_view = z2ui5_cl_xml_view=>factory( ).

    lr_view->_generic( name = `script`
                       ns   = `html` )->_cc_plain_xml( `sap.z2ui5.decideNextStep = (stepId, nextStepId) => {debugger;` && |\n| &&
                                                                     ` var wiz = sap.z2ui5.oView.byId('wiz');` && |\n| &&
                                                                     ` wiz.discardProgress(sap.z2ui5.oView.byId(stepId));` && |\n| &&
                                                                     ` var step = sap.z2ui5.oView.byId(stepId);` && |\n| &&
                                                                     ` var nextStep = sap.z2ui5.oView.byId(nextStepId);` && |\n| &&
                                                                     ` step.setNextStep(nextStep);` && |\n| &&
                                                                     `}` ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    lr_view = lr_view->shell( )->page( id = `page_main`
             title                        = 'abap2UI5 - Demo Wizard Control'
             navbuttonpress               = client->_event( 'BACK' )
             shownavbutton                = temp1 ).

    DATA lr_wizard TYPE REF TO z2ui5_cl_xml_view.
    lr_wizard = lr_view->wizard( id              = `wiz`
                                       enablebranching = abap_true ).
    DATA lr_wiz_step1 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step1 = lr_wizard->wizard_step( title     = 'STEP1'
                                                 validated = abap_true
                                                 nextstep  = 'STEP2' ).
    lr_wiz_step1->message_strip( text = 'STEP1' ).


    DATA lr_wiz_step2 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step2 = lr_wizard->wizard_step( id              = 'STEP2'
                                                 title           = `STEP2`
                                                 validated       = abap_true
                                                 subsequentsteps = 'STEP22, STEP23' ).

    lr_wiz_step2->message_strip( text = `STEP2` ).
    lr_wiz_step2->button(
*      EXPORTING
        text  = `Press Step 2.2`
        press = client->_event('STEP22' ) ).
    lr_wiz_step2->button(
*      EXPORTING
        text  = `Press Step 2.3`
        press = client->_event( `STEP23` ) ).


    DATA lr_wiz_step22 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step22 = lr_wizard->wizard_step( id       = `STEP22`
                                                 title     = `STEP2.2`
                                                 validated = abap_true ).

    lr_wiz_step22->message_strip( text = 'STEP22' ).


    DATA lr_wiz_step23 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step23 = lr_wizard->wizard_step( id       = `STEP23`
                                                 title     = `STEP2.3`
                                                 validated = abap_true ).

    lr_wiz_step23->message_strip( text = 'STEP23' ).


    DATA lr_wiz_step3 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step3 = lr_wizard->wizard_step( title     = `STEP3`
                                                 validated = abap_true ).

    lr_wiz_step3->message_strip( text = 'STEP3' ).

*
    client->view_display( lr_view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF av_init = abap_false.
      display_view( client ).
      av_init = 'X'.
      RETURN.
    ENDIF.


    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'STEP22'.

        client->follow_up_action( val = 'sap.z2ui5.decideNextStep(`STEP2`,`STEP22`);' ).

      WHEN 'STEP23'.

        client->follow_up_action( val = 'sap.z2ui5.decideNextStep(`STEP2`,`STEP23`);' ).

    ENDCASE.
    client->view_model_update( ).
  ENDMETHOD.
ENDCLASS.

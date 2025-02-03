CLASS z2ui5_cl_demo_app_175 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

  PROTECTED SECTION.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_175 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    display_view( client ).

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.

  METHOD display_view.

    DATA lr_view TYPE REF TO z2ui5_cl_xml_view.
    lr_view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    lr_view = lr_view->shell( )->page( id = `page_main`
             title                        = 'abap2UI5 - Demo Wizard Control'
             navbuttonpress               = client->_event( 'BACK' )
             shownavbutton                = temp1 ).

    DATA lr_wizard TYPE REF TO z2ui5_cl_xml_view.
    lr_wizard = lr_view->wizard( ).
    DATA lr_wiz_step1 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step1 = lr_wizard->wizard_step( title     = 'Step1'
                                                 validated = abap_true ).
    lr_wiz_step1->message_strip( text = 'STEP1' ).
    DATA lr_wiz_step2 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step2 = lr_wizard->wizard_step( title     = 'Step2'
                                                 validated = abap_true ).

    lr_wiz_step2->message_strip( text = 'STEP2' ).
    DATA lr_wiz_step3 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step3 = lr_wizard->wizard_step( title     = 'Step3'
                                                 validated = abap_true ).

    lr_wiz_step3->message_strip( text = 'STEP3' ).
    DATA lr_wiz_step4 TYPE REF TO z2ui5_cl_xml_view.
    lr_wiz_step4 = lr_wizard->wizard_step( title     = 'Step4'
                                                 validated = abap_true ).

    lr_wiz_step4->message_strip( text = 'STEP4' ).

    client->view_display( lr_view->stringify( ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lcl_locking DEFINITION CREATE PRIVATE FINAL.
  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_seqg3,
        gname    TYPE c LENGTH 30,   " Elementary Lock of Lock Entry (Table Name)
        garg     TYPE c LENGTH 150,  " Argument String (=Key Fields) of Lock Entry
        gmode    TYPE c LENGTH 1,    " Lock Mode (Shared/Exclusive) of a Lock Entry
        gusr     TYPE c LENGTH 58,   " Lock Owner, ID of Logical Unit of Work (LUW)
        gusrvb   TYPE c LENGTH 58,   " Lock Owner, ID of Logical Unit of Work (LUW) / Update Task
        guse     TYPE int4,          " Cumulative Counter for Lock Entry / Dialog
        gusevb   TYPE int4,          " Cumulative Counter for Lock Entry / Update Task
        gobj     TYPE c LENGTH 16,   " Name of Lock Object in the Lock Entry
        gclient  TYPE c LENGTH 3,    " Client in the lock entry
        guname   TYPE c LENGTH 12,   " User name in lock entry
        gtarg    TYPE c LENGTH 50,   " Argument String of Lock Entry (Table Key Fields)
        gtcode   TYPE c LENGTH 20,   " Transaction Code in the Lock Entry
        gbcktype TYPE c LENGTH 1,    " Backup flag for lock entry
        gthost   TYPE c LENGTH 32,   " Host Name in the Lock Owner ID
        gtwp     TYPE n LENGTH 2,         " Work Process Number in Lock Owner ID
        gtsysnr  TYPE n LENGTH 2,         " SAP System Number in Lock Owner ID
        gtdate   TYPE d,          " Date within lock owner ID
        gttime   TYPE t,          " Time in Lock Owner ID
        gtusec   TYPE n LENGTH 6,         " Time/Microseconds Share in Lock Owner ID
        gtmark   TYPE c LENGTH 1,    " Selection Indicator of Lock Entry
        gusetxt  TYPE n LENGTH 10,        " Cumulative Counter for Lock Entry
        gusevbt  TYPE n LENGTH 10,        " Cumulative Counter for Lock Entry / Update Task
      END OF ty_seqg3.

    CLASS-METHODS acquire_lock.

    CLASS-METHODS get_lock_counter
      RETURNING
        VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_locking IMPLEMENTATION.

  METHOD acquire_lock.

    DATA lv_fm TYPE c LENGTH 15.
    lv_fm = 'ENQUEUE_E_TABLE'.
    CALL FUNCTION lv_fm
      EXPORTING
        tabname        = 'ZTEST'
        varkey         = 'Z100'
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      DATA error_text TYPE string.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO error_text.
      RAISE EXCEPTION TYPE z2ui5_cx_util_error EXPORTING val = error_text.
    ENDIF.

  ENDMETHOD.


  METHOD get_lock_counter.
    DATA enqueue_table TYPE STANDARD TABLE OF ty_seqg3.

    DATA argument TYPE c LENGTH 150.
    argument = |ZTEST                         Z100*|.

    DATA lv_fm TYPE c LENGTH 12.
    lv_fm = 'ENQUEUE_READ'.
    CALL FUNCTION lv_fm
      EXPORTING
        garg                  = argument
        guname                = sy-uname
      TABLES
        enq                   = enqueue_table
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2
        OTHERS                = 3.
    IF sy-subrc <> 0.
      DATA error_text TYPE string.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO error_text.
      RAISE EXCEPTION TYPE z2ui5_cx_util_error EXPORTING val = error_text.
    ENDIF.

    DATA temp1 TYPE i.
    CLEAR temp1.
    DATA temp2 TYPE lcl_locking=>ty_seqg3.
    READ TABLE enqueue_table INTO temp2 INDEX 1.
    IF sy-subrc = 0.
      temp1 = temp2-gusevb.
    ENDIF.
    result = temp1.

  ENDMETHOD.

ENDCLASS.

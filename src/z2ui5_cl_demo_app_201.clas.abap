CLASS z2ui5_cl_demo_app_201 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_s_currency,
        language          TYPE string,
        currency          TYPE string,
        currencyname      TYPE string,
        currencyshortname TYPE string,
      END OF ty_s_currency .

    TYPES temp1_6794b3f377 TYPE STANDARD TABLE OF ty_s_currency.
DATA
      mt_suggestion_out TYPE temp1_6794b3f377 .
    TYPES temp2_6794b3f377 TYPE STANDARD TABLE OF ty_s_currency.
DATA
      mt_suggestion TYPE temp2_6794b3f377 .
    DATA input TYPE string .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_event.
    METHODS z2ui5_view_display.
    METHODS set_data.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_201 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_DEMO_APP_201->SET_DATA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_data.

    TYPES:
      BEGIN OF ty_s_currency,
        language          TYPE string,
        currency          TYPE string,
        currencyname      TYPE string,
        currencyshortname TYPE string,
      END OF ty_s_currency.

    DATA temp1 LIKE mt_suggestion.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-language = 'E'.
    temp2-currency = 'ADP'.
    temp2-currencyname = 'Andorran Peseta --> (Old --> EUR)'.
    temp2-currencyshortname = 'Peseta'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AED'.
    temp2-currencyname = 'United Arab Emirates Dirham'.
    temp2-currencyshortname = 'Dirham'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AFA'.
    temp2-currencyname = 'Afghani (Old)'.
    temp2-currencyshortname = 'Afghani'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AFN'.
    temp2-currencyname = 'Afghani'.
    temp2-currencyshortname = 'Afghani'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ALL'.
    temp2-currencyname = 'Albanian Lek'.
    temp2-currencyshortname = 'Lek'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AMD'.
    temp2-currencyname = 'Armenian Dram'.
    temp2-currencyshortname = 'Dram'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ANG'.
    temp2-currencyname = 'West Indian Guilder'.
    temp2-currencyshortname = 'W.Ind.Guilder'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AOA'.
    temp2-currencyname = 'Angolanische Kwanza'.
    temp2-currencyshortname = 'Kwansa'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AON'.
    temp2-currencyname = 'Angolan New Kwanza (Old)'.
    temp2-currencyshortname = 'New Kwanza'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AOR'.
    temp2-currencyname = 'Angolan Kwanza Reajustado (Old)'.
    temp2-currencyshortname = 'Kwanza Reajust.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ARS'.
    temp2-currencyname = 'Argentine Peso'.
    temp2-currencyshortname = 'Arg. Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ATS'.
    temp2-currencyname = 'Austrian Schilling (Old --> EUR)'.
    temp2-currencyshortname = 'Shilling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AUD'.
    temp2-currencyname = 'Australian Dollar'.
    temp2-currencyshortname = 'Austr. Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AWG'.
    temp2-currencyname = 'Aruban Florin'.
    temp2-currencyshortname = 'Aruban Florin'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AZM'.
    temp2-currencyname = 'Azerbaijani Manat (Old)'.
    temp2-currencyshortname = 'Manat'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'AZN'.
    temp2-currencyname = 'Azerbaijani Manat'.
    temp2-currencyshortname = 'Manat'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BAM'.
    temp2-currencyname = 'Bosnia and Herzegovina Convertible Mark'.
    temp2-currencyshortname = 'Convert. Mark'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BBD'.
    temp2-currencyname = 'Barbados Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BDT'.
    temp2-currencyname = 'Bangladesh Taka'.
    temp2-currencyshortname = 'Taka'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BEF'.
    temp2-currencyname = 'Belgian Franc (Old --> EUR)'.
    temp2-currencyshortname = 'Belgian Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BGN'.
    temp2-currencyname = 'Bulgarian Lev'.
    temp2-currencyshortname = 'Lev'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BHD'.
    temp2-currencyname = 'Bahraini Dinar'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BIF'.
    temp2-currencyname = 'Burundi Franc'.
    temp2-currencyshortname = 'Burundi Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BMD'.
    temp2-currencyname = 'Bermudan Dollar'.
    temp2-currencyshortname = 'Bermudan Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BND'.
    temp2-currencyname = 'Brunei Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BOB'.
    temp2-currencyname = 'Boliviano'.
    temp2-currencyshortname = 'Boliviano'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BRL'.
    temp2-currencyname = 'Brazilian Real'.
    temp2-currencyshortname = 'Real'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BSD'.
    temp2-currencyname = 'Bahaman Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BTN'.
    temp2-currencyname = 'Bhutan Ngultrum'.
    temp2-currencyshortname = 'Ngultrum'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BWP'.
    temp2-currencyname = 'Botswana Pula'.
    temp2-currencyshortname = 'Pula'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BYB'.
    temp2-currencyname = 'Belarusian Ruble (Old)'.
    temp2-currencyshortname = 'Belarus. Ruble'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BYN'.
    temp2-currencyname = 'Belarusian Ruble (New)'.
    temp2-currencyshortname = 'Bela. Ruble N.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BYR'.
    temp2-currencyname = 'Belarusian Ruble'.
    temp2-currencyshortname = 'Ruble'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'BZD'.
    temp2-currencyname = 'Belize Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CAD'.
    temp2-currencyname = 'Canadian Dollar'.
    temp2-currencyshortname = 'Canadian Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CDF'.
    temp2-currencyname = 'Congolese Franc'.
    temp2-currencyshortname = 'test data'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CFP'.
    temp2-currencyname = 'French Franc (Pacific Islands)'.
    temp2-currencyshortname = 'Fr. Franc (Pac)'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CHF'.
    temp2-currencyname = 'Swiss Franc'.
    temp2-currencyshortname = 'Swiss Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CLP'.
    temp2-currencyname = 'Chilean Peso'.
    temp2-currencyshortname = 'Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CNY'.
    temp2-currencyname = 'Chinese Renminbi'.
    temp2-currencyshortname = 'Renminbi'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'COP'.
    temp2-currencyname = 'Colombian Peso'.
    temp2-currencyshortname = 'Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CRC'.
    temp2-currencyname = 'Costa Rica Colon'.
    temp2-currencyshortname = 'Cost.Rica Colon'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CSD'.
    temp2-currencyname = 'Serbian Dinar (Old)'.
    temp2-currencyshortname = 'Serbian Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CUC'.
    temp2-currencyname = 'Peso Convertible'.
    temp2-currencyshortname = 'Peso Convertib.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CUP'.
    temp2-currencyname = 'Cuban Peso'.
    temp2-currencyshortname = 'Cuban Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CVE'.
    temp2-currencyname = 'Cape Verde Escudo'.
    temp2-currencyshortname = 'Escudo'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CYP'.
    temp2-currencyname = 'Cyprus Pound  (Old --> EUR)'.
    temp2-currencyshortname = 'Cyprus Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'CZK'.
    temp2-currencyname = 'Czech Krona'.
    temp2-currencyshortname = 'Krona'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DEM'.
    temp2-currencyname = 'German Mark    (Old --> EUR)'.
    temp2-currencyshortname = 'German Mark'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DEM3'.
    temp2-currencyname = '(Internal) German Mark (3 dec.places)'.
    temp2-currencyshortname = '(Int.) DEM 3 DP'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DJF'.
    temp2-currencyname = 'Djibouti Franc'.
    temp2-currencyshortname = 'Djibouti Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DKK'.
    temp2-currencyname = 'Danish Krone'.
    temp2-currencyshortname = 'Danish Krone'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DOP'.
    temp2-currencyname = 'Dominican Peso'.
    temp2-currencyshortname = 'Dominican Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'DZD'.
    temp2-currencyname = 'Algerian Dinar'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ECS'.
    temp2-currencyname = 'Ecuadorian Sucre (Old --> USD)'.
    temp2-currencyshortname = 'Sucre'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'EEK'.
    temp2-currencyname = 'Estonian Krone (Old --> EUR)'.
    temp2-currencyshortname = 'Krona'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'EGP'.
    temp2-currencyname = 'Egyptian Pound'.
    temp2-currencyshortname = 'Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ERN'.
    temp2-currencyname = 'Eritrean Nafka'.
    temp2-currencyshortname = 'Nakfa'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ESP'.
    temp2-currencyname = 'Spanish Peseta (Old --> EUR)'.
    temp2-currencyshortname = 'Peseta'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ETB'.
    temp2-currencyname = 'Ethiopian Birr'.
    temp2-currencyshortname = 'Birr'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'EUR'.
    temp2-currencyname = 'European Euro'.
    temp2-currencyshortname = 'Euro'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'FIM'.
    temp2-currencyname = 'Finnish Markka (Old --> EUR)'.
    temp2-currencyshortname = 'Finnish markka'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'FJD'.
    temp2-currencyname = 'Fiji Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'FKP'.
    temp2-currencyname = 'Falkland Pound'.
    temp2-currencyshortname = 'Falkland Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'FRF'.
    temp2-currencyname = 'French Franc (Old --> EUR)'.
    temp2-currencyshortname = 'French Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GBP'.
    temp2-currencyname = 'British Pound'.
    temp2-currencyshortname = 'Pound sterling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GEL'.
    temp2-currencyname = 'Georgian Lari'.
    temp2-currencyshortname = 'Lari'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GHC'.
    temp2-currencyname = 'Ghanaian Cedi (Old)'.
    temp2-currencyshortname = 'Cedi'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GHS'.
    temp2-currencyname = 'Ghanian Cedi'.
    temp2-currencyshortname = 'Cedi'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GIP'.
    temp2-currencyname = 'Gibraltar Pound'.
    temp2-currencyshortname = 'Gibraltar Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GMD'.
    temp2-currencyname = 'Gambian Dalasi'.
    temp2-currencyshortname = 'Dalasi'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GNF'.
    temp2-currencyname = 'Guinean Franc'.
    temp2-currencyshortname = 'Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GRD'.
    temp2-currencyname = 'Greek Drachma (Old --> EUR)'.
    temp2-currencyshortname = 'Drachma'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GTQ'.
    temp2-currencyname = 'Guatemalan Quetzal'.
    temp2-currencyshortname = 'Quetzal'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GWP'.
    temp2-currencyname = 'Guinea Peso (Old --> SHP)'.
    temp2-currencyshortname = 'Guinea Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'GYD'.
    temp2-currencyname = 'Guyana Dollar'.
    temp2-currencyshortname = 'Guyana Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'HKD'.
    temp2-currencyname = 'Hong Kong Dollar'.
    temp2-currencyshortname = 'H.K.Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'HNL'.
    temp2-currencyname = 'Honduran Lempira'.
    temp2-currencyshortname = 'Lempira'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'HRK'.
    temp2-currencyname = 'Croatian Kuna'.
    temp2-currencyshortname = 'Kuna'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'HTG'.
    temp2-currencyname = 'Haitian Gourde'.
    temp2-currencyshortname = 'Gourde'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'HUF'.
    temp2-currencyname = 'Hungarian Forint'.
    temp2-currencyshortname = 'Forint'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'IDR'.
    temp2-currencyname = 'Indonesian Rupiah'.
    temp2-currencyshortname = 'Rupiah'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'IEP'.
    temp2-currencyname = 'Irish Punt (Old --> EUR)'.
    temp2-currencyshortname = 'Irish Punt'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ILS'.
    temp2-currencyname = 'Israeli Scheckel'.
    temp2-currencyshortname = 'Scheckel'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'INR'.
    temp2-currencyname = 'Indian Rupee'.
    temp2-currencyshortname = 'Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'IQD'.
    temp2-currencyname = 'Iraqui Dinar'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'IRR'.
    temp2-currencyname = 'Iranian Rial'.
    temp2-currencyshortname = 'Rial'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ISK'.
    temp2-currencyname = 'Iceland Krona'.
    temp2-currencyshortname = 'Krona'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ITL'.
    temp2-currencyname = 'Italian Lira (Old --> EUR)'.
    temp2-currencyshortname = 'Lire'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'JMD'.
    temp2-currencyname = 'Jamaican Dollar'.
    temp2-currencyshortname = 'Jamaican Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'JOD'.
    temp2-currencyname = 'Jordanian Dinar'.
    temp2-currencyshortname = 'Jordanian Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'JPY'.
    temp2-currencyname = 'Japanese Yen'.
    temp2-currencyshortname = 'Yen'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KES'.
    temp2-currencyname = 'Kenyan Shilling'.
    temp2-currencyshortname = 'Shilling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KGS'.
    temp2-currencyname = 'Kyrgyzstan Som'.
    temp2-currencyshortname = 'Som'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KHR'.
    temp2-currencyname = 'Cambodian Riel'.
    temp2-currencyshortname = 'Riel'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KMF'.
    temp2-currencyname = 'Comoros Franc'.
    temp2-currencyshortname = 'Comoros Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KPW'.
    temp2-currencyname = 'North Korean Won'.
    temp2-currencyshortname = 'N. Korean Won'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KRW'.
    temp2-currencyname = 'South Korean Won'.
    temp2-currencyshortname = 'S.Korean Won'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KWD'.
    temp2-currencyname = 'Kuwaiti Dinar'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KYD'.
    temp2-currencyname = 'Cayman Dollar'.
    temp2-currencyshortname = 'Cayman Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'KZT'.
    temp2-currencyname = 'Kazakstanian Tenge'.
    temp2-currencyshortname = 'Tenge'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LAK'.
    temp2-currencyname = 'Laotian Kip'.
    temp2-currencyshortname = 'Kip'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LBP'.
    temp2-currencyname = 'Lebanese Pound'.
    temp2-currencyshortname = 'Lebanese Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LKR'.
    temp2-currencyname = 'Sri Lankan Rupee'.
    temp2-currencyshortname = 'Sri Lanka Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LRD'.
    temp2-currencyname = 'Liberian Dollar'.
    temp2-currencyshortname = 'Liberian Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LSL'.
    temp2-currencyname = 'Lesotho Loti'.
    temp2-currencyshortname = 'Loti'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LTL'.
    temp2-currencyname = 'Lithuanian Lita'.
    temp2-currencyshortname = 'Lita'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LUF'.
    temp2-currencyname = 'Luxembourg Franc (Old --> EUR)'.
    temp2-currencyshortname = 'Lux. Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LVL'.
    temp2-currencyname = 'Latvian Lat'.
    temp2-currencyshortname = 'Lat'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'LYD'.
    temp2-currencyname = 'Libyan Dinar'.
    temp2-currencyshortname = 'Libyan Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MAD'.
    temp2-currencyname = 'Moroccan Dirham'.
    temp2-currencyshortname = 'Dirham'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MDL'.
    temp2-currencyname = 'Moldavian Leu'.
    temp2-currencyshortname = 'Leu'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MGA'.
    temp2-currencyname = 'Madagascan Ariary'.
    temp2-currencyshortname = 'Madagasc.Ariary'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MGF'.
    temp2-currencyname = 'Madagascan Franc (Old'.
    temp2-currencyshortname = 'Madagascan Fr.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MKD'.
    temp2-currencyname = 'Macedonian Denar'.
    temp2-currencyshortname = 'Maced. Denar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MMK'.
    temp2-currencyname = 'Myanmar Kyat'.
    temp2-currencyshortname = 'Kyat'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MNT'.
    temp2-currencyname = 'Mongolian Tugrik'.
    temp2-currencyshortname = 'Tugrik'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MOP'.
    temp2-currencyname = 'Macao Pataca'.
    temp2-currencyshortname = 'Pataca'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MRO'.
    temp2-currencyname = 'Mauritanian Ouguiya'.
    temp2-currencyshortname = 'Ouguiya'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MTL'.
    temp2-currencyname = 'Maltese Lira (Old --> EUR)'.
    temp2-currencyshortname = 'Lira'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MUR'.
    temp2-currencyname = 'Mauritian Rupee'.
    temp2-currencyshortname = 'Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MVR'.
    temp2-currencyname = 'Maldive Rufiyaa'.
    temp2-currencyshortname = 'Rufiyaa'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MWK'.
    temp2-currencyname = 'Malawi Kwacha'.
    temp2-currencyshortname = 'Malawi Kwacha'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MXN'.
    temp2-currencyname = 'Mexican Pesos'.
    temp2-currencyshortname = 'Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MYR'.
    temp2-currencyname = 'Malaysian Ringgit'.
    temp2-currencyshortname = 'Ringgit'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MZM'.
    temp2-currencyname = 'Mozambique Metical (Old)'.
    temp2-currencyshortname = 'Metical'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'MZN'.
    temp2-currencyname = 'Mozambique Metical'.
    temp2-currencyshortname = 'Metical'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NAD'.
    temp2-currencyname = 'Namibian Dollar'.
    temp2-currencyshortname = 'Namibian Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NGN'.
    temp2-currencyname = 'Nigerian Naira'.
    temp2-currencyshortname = 'Naira'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NIO'.
    temp2-currencyname = 'Nicaraguan Cordoba Oro'.
    temp2-currencyshortname = 'Cordoba Oro'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NLG'.
    temp2-currencyname = 'Dutch Guilder (Old --> EUR)'.
    temp2-currencyshortname = 'Guilder'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NOK'.
    temp2-currencyname = 'Norwegian Krone'.
    temp2-currencyshortname = 'Norwegian Krone'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NPR'.
    temp2-currencyname = 'Nepalese Rupee'.
    temp2-currencyshortname = 'Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'NZD'.
    temp2-currencyname = 'New Zealand Dollars'.
    temp2-currencyshortname = 'N.Zeal.Dollars'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'OMR'.
    temp2-currencyname = 'Omani Rial'.
    temp2-currencyshortname = 'Omani Rial'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PAB'.
    temp2-currencyname = 'Panamanian Balboa'.
    temp2-currencyshortname = 'Balboa'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PEN'.
    temp2-currencyname = 'Peruvian New Sol'.
    temp2-currencyshortname = 'New Sol'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PGK'.
    temp2-currencyname = 'Papua New Guinea Kina'.
    temp2-currencyshortname = 'Kina'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PHP'.
    temp2-currencyname = 'Philippine Peso'.
    temp2-currencyshortname = 'Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PKR'.
    temp2-currencyname = 'Pakistani Rupee'.
    temp2-currencyshortname = 'Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PLN'.
    temp2-currencyname = 'Polish Zloty (new)'.
    temp2-currencyshortname = 'Zloty'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PTE'.
    temp2-currencyname = 'Portuguese Escudo (Old --> EUR)'.
    temp2-currencyshortname = 'Escudo'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'PYG'.
    temp2-currencyname = 'Paraguayan Guarani'.
    temp2-currencyshortname = 'Guarani'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'QAR'.
    temp2-currencyname = 'Qatar Rial'.
    temp2-currencyshortname = 'Rial'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'RMB'.
    temp2-currencyname = 'Chinese Yuan Renminbi'.
    temp2-currencyshortname = 'Yuan Renminbi'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ROL'.
    temp2-currencyname = 'Romanian Leu (Old)'.
    temp2-currencyshortname = 'Leu (Old)'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'RON'.
    temp2-currencyname = 'Romanian Leu'.
    temp2-currencyshortname = 'Leu'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'RSD'.
    temp2-currencyname = 'Serbian Dinar'.
    temp2-currencyshortname = 'Serbian Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'RUB'.
    temp2-currencyname = 'Russian Ruble'.
    temp2-currencyshortname = 'Ruble'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'RWF'.
    temp2-currencyname = 'Rwandan Franc'.
    temp2-currencyshortname = 'Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SAR'.
    temp2-currencyname = 'Saudi Riyal'.
    temp2-currencyshortname = 'Rial'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SBD'.
    temp2-currencyname = 'Solomon Islands Dollar'.
    temp2-currencyshortname = 'Sol.Isl.Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SCR'.
    temp2-currencyname = 'Seychelles Rupee'.
    temp2-currencyshortname = 'Rupee'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SDD'.
    temp2-currencyname = 'Sudanese Dinar (Old)'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SDG'.
    temp2-currencyname = 'Sudanese Pound'.
    temp2-currencyshortname = 'Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SDP'.
    temp2-currencyname = 'Sudanese Pound (until 1992)'.
    temp2-currencyshortname = 'Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SEK'.
    temp2-currencyname = 'Swedish Krona'.
    temp2-currencyshortname = 'Swedish Krona'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SGD'.
    temp2-currencyname = 'Singapore Dollar'.
    temp2-currencyshortname = 'Sing.Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SHP'.
    temp2-currencyname = 'St.Helena Pound'.
    temp2-currencyshortname = 'St.Helena Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SIT'.
    temp2-currencyname = 'Slovenian Tolar (Old --> EUR)'.
    temp2-currencyshortname = 'Tolar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SKK'.
    temp2-currencyname = 'Slovakian Krona (Old --> EUR)'.
    temp2-currencyshortname = 'Krona'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SLL'.
    temp2-currencyname = 'Sierra Leone Leone'.
    temp2-currencyshortname = 'Leone'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SOS'.
    temp2-currencyname = 'Somalian Shilling'.
    temp2-currencyshortname = 'Shilling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SRD'.
    temp2-currencyname = 'Surinam Dollar'.
    temp2-currencyshortname = 'Surinam Doillar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SRG'.
    temp2-currencyname = 'Surinam Guilder (Old)'.
    temp2-currencyshortname = 'Surinam Guilder'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SSP'.
    temp2-currencyname = 'South Sudanese Pound'.
    temp2-currencyshortname = 'Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'STD'.
    temp2-currencyname = 'Sao Tome / Principe Dobra'.
    temp2-currencyshortname = 'Dobra'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SVC'.
    temp2-currencyname = 'El Salvador Colon'.
    temp2-currencyshortname = 'Colon'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SYP'.
    temp2-currencyname = 'Syrian Pound'.
    temp2-currencyshortname = 'Syrian Pound'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'SZL'.
    temp2-currencyname = 'Swaziland Lilangeni'.
    temp2-currencyshortname = 'Lilangeni'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'THB'.
    temp2-currencyname = 'Thailand Baht'.
    temp2-currencyshortname = 'Baht'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TJR'.
    temp2-currencyname = 'Tajikistani Ruble (Old)'.
    temp2-currencyshortname = 'Ruble'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TJS'.
    temp2-currencyname = 'Tajikistani Somoni'.
    temp2-currencyshortname = 'Somoni'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TMM'.
    temp2-currencyname = 'Turkmenistani Manat (Old)'.
    temp2-currencyshortname = 'Manat (Old)'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TMT'.
    temp2-currencyname = 'Turkmenistani Manat'.
    temp2-currencyshortname = 'Manat'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TND'.
    temp2-currencyname = 'Tunisian Dinar'.
    temp2-currencyshortname = 'Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TOP'.
    temp2-currencyname = 'Tongan Pa''anga'.
    temp2-currencyshortname = 'Pa''anga'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TPE'.
    temp2-currencyname = 'Timor Escudo --> USD'.
    temp2-currencyshortname = 'Timor Escudo'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TRL'.
    temp2-currencyname = 'Turkish Lira (Old)'.
    temp2-currencyshortname = 'Lira (Old)'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TRY'.
    temp2-currencyname = 'Turkish Lira'.
    temp2-currencyshortname = 'Lira'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TTD'.
    temp2-currencyname = 'Trinidad and Tobago Dollar'.
    temp2-currencyshortname = 'T.+ T. Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TWD'.
    temp2-currencyname = 'New Taiwan Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'TZS'.
    temp2-currencyname = 'Tanzanian Shilling'.
    temp2-currencyshortname = 'Shilling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'UAH'.
    temp2-currencyname = 'Ukraine Hryvnia'.
    temp2-currencyshortname = 'Hryvnia'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'UGX'.
    temp2-currencyname = 'Ugandan Shilling'.
    temp2-currencyshortname = 'Shilling'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'USD'.
    temp2-currencyname = 'United States Dollar'.
    temp2-currencyshortname = 'US Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'USDN'.
    temp2-currencyname = '(Internal) United States Dollar (5 Dec.)'.
    temp2-currencyshortname = 'US Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'UYU'.
    temp2-currencyname = 'Uruguayan Peso'.
    temp2-currencyshortname = 'Peso'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'UZS'.
    temp2-currencyname = 'Uzbekistan Som'.
    temp2-currencyshortname = 'Total'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'VEB'.
    temp2-currencyname = 'Venezuelan Bolivar (Old)'.
    temp2-currencyshortname = 'Bolivar (Old)'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'VEF'.
    temp2-currencyname = 'Venezuelan Bolivar'.
    temp2-currencyshortname = 'Bolivar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'VND'.
    temp2-currencyname = 'Vietnamese Dong'.
    temp2-currencyshortname = 'Dong'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'VUV'.
    temp2-currencyname = 'Vanuatu Vatu'.
    temp2-currencyshortname = 'Vatu'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'WST'.
    temp2-currencyname = 'Samoan Tala'.
    temp2-currencyshortname = 'Tala'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'XAF'.
    temp2-currencyname = 'Gabon CFA Franc BEAC'.
    temp2-currencyshortname = 'CFA Franc BEAC'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'XCD'.
    temp2-currencyname = 'East Carribean Dollar'.
    temp2-currencyshortname = 'Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'XEU'.
    temp2-currencyname = 'European Currency Unit (E.C.U.)'.
    temp2-currencyshortname = 'E.C.U.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'XOF'.
    temp2-currencyname = 'Benin CFA Franc BCEAO'.
    temp2-currencyshortname = 'CFA Franc BCEAO'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'XPF'.
    temp2-currencyname = 'CFP Franc'.
    temp2-currencyshortname = 'Franc'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'YER'.
    temp2-currencyname = 'Yemeni Ryal'.
    temp2-currencyshortname = 'Yemeni Ryal'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'YUM'.
    temp2-currencyname = 'New Yugoslavian Dinar (Old)'.
    temp2-currencyshortname = 'New Dinar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZAR'.
    temp2-currencyname = 'South African Rand'.
    temp2-currencyshortname = 'Rand'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZMK'.
    temp2-currencyname = 'Zambian Kwacha (Old)'.
    temp2-currencyshortname = 'Kwacha'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZMW'.
    temp2-currencyname = 'Zambian Kwacha (New)'.
    temp2-currencyshortname = 'Kwacha'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZRN'.
    temp2-currencyname = 'Zaire (Old)'.
    temp2-currencyshortname = 'Zaire'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZWD'.
    temp2-currencyname = 'Zimbabwean Dollar (Old)'.
    temp2-currencyshortname = 'Zimbabwe Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZWL'.
    temp2-currencyname = 'Zimbabwean Dollar (New)'.
    temp2-currencyshortname = 'Zimbabwe Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZWN'.
    temp2-currencyname = 'Zimbabwean Dollar (Old)'.
    temp2-currencyshortname = 'Zimbabwe Dollar'.
    INSERT temp2 INTO TABLE temp1.
    temp2-language = 'E'.
    temp2-currency = 'ZWR'.
    temp2-currencyname = 'Zimbabwean Dollar (Old)'.
    temp2-currencyshortname = 'Zimbabwe Dollar'.
    INSERT temp2 INTO TABLE temp1.
    mt_suggestion = temp1.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z2UI5_CL_DEMO_APP_201->Z2UI5_IF_APP~MAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.

* ---------- This script will skip the frontend suggestion filtering ------------------------------
      DATA lv_script TYPE string.
      lv_script = `   debugger;` && |\n| &&
                  `function setInputFIlter(){` && |\n| &&
                  ` var inp = sap.z2ui5.oView.byId('suggInput');` && |\n| &&
                  ` inp.setFilterFunction(function(sValue, oItem){` && |\n| &&
                  `         return true;` && |\n| &&
                  ` });` && |\n| &&
                  `}`.


      check_initialized = abap_true.
      set_data( ).

      client->view_display( z2ui5_cl_xml_view=>factory(
        )->_z2ui5( )->timer( client->_event( `START` )
         )->_generic( ns   = `html`
                      name = `script` )->_cc_plain_xml( lv_script
         )->stringify( ) ).

    ENDIF.

    IF client->get( )-event IS NOT INITIAL.
      z2ui5_on_event( ).
    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_DEMO_APP_201->Z2UI5_ON_EVENT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_event.
    TYPES temp5 TYPE RANGE OF string.
DATA lt_range TYPE temp5.

    CASE client->get( )-event.
      WHEN 'START'.
        z2ui5_view_display( ).
      WHEN 'ON_SUGGEST'.


        DATA temp3 LIKE lt_range.
        CLEAR temp3.
        DATA temp4 LIKE LINE OF temp3.
        temp4-sign = 'I'.
        temp4-option = 'CP'.
        temp4-low = `*` && input && `*`.
        INSERT temp4 INTO TABLE temp3.
        lt_range = temp3.

        CLEAR mt_suggestion_out.
        DATA ls_sugg LIKE LINE OF mt_suggestion.
        LOOP AT mt_suggestion INTO ls_sugg
            WHERE currencyname IN lt_range.
          INSERT ls_sugg INTO TABLE mt_suggestion_out.
        ENDLOOP.



        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_DEMO_APP_201->Z2UI5_VIEW_DISPLAY
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_view_display.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell( )->page(
       title          = 'abap2UI5 - Live Suggestion Event'
       navbuttonpress = client->_event( 'BACK' )
       shownavbutton  = temp1 ).


    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L6 M12 S12'
        )->content( 'layout' ).

    DATA input TYPE REF TO z2ui5_cl_xml_view.
    input = grid->simple_form( 'Input'
        )->content( 'form'
            )->label( 'Input with value help'
            )->input(
                    id                           = `suggInput`
                    value                        = client->_bind_edit( input )
                    suggest                      = client->_event( 'ON_SUGGEST' )
                    showtablesuggestionvaluehelp = abap_false
                    suggestionrows               = client->_bind( mt_suggestion_out )
                    showsuggestion               = abap_true
                    valueliveupdate              = abap_true
                    autocomplete                 = abap_false
                 )->get( ).

    input->suggestion_columns(
        )->column( )->label( text = 'Name' )->get_parent(
        )->column( )->label( text = 'Currency' ).

    input->suggestion_rows(
        )->column_list_item(
            )->label( text = '{CURRENCYNAME}'
            )->label( text = '{CURRENCY}' ).

    page->_generic( name = `script`
                    ns   = `html` )->_cc_plain_xml( `setInputFIlter()` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.

{
 var
   // Integer data types :
   Int1 : Byte;     //                        0 to 255
   Int2 : ShortInt; //                     -127 to 127
   Int3 : Word;     //                        0 to 65,535
   Int4 : SmallInt; //                  -32,768 to 32,767
   Int5 : LongWord; //                        0 to 4,294,967,295
   Int6 : Cardinal; //                        0 to 4,294,967,295
   Int7 : LongInt;  //           -2,147,483,648 to 2,147,483,647
   Int8 : Integer;  //           -2,147,483,648 to 2,147,483,647
   Int9 : Int64;  // -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
 
   // Decimal data types :
   Dec1 : Single;   //  7  significant digits, exponent   -38 to +38
   Dec2 : Currency; // 50+ significant digits, fixed 4 decimal places
   Dec3 : Double;   // 15  significant digits, exponent  -308 to +308
   Dec4 : Extended; // 19  significant digits, exponent -4932 to +4932
}
{
    function MessageDlg ( const Message : string; DialogType : TMsgDlgType; Buttons : TMsgDlgButtons; HelpContext : Longint ) : Integer;
    * 
    * DialogType
    mtWarning - Отображает символ восклицания
    mtError - Отображает красный "Х" 
    mtInformation - Отображает "i" в круге
    mtConfirmation - Отображает знак вопроса
    mtCustom - Отображает только сообщение
    * 
    * Buttons
    mbYes - Отображает кнопку "Yes"
    mbNo - Отображает кнопку "No" 
    mbOK - Отображает кнопку "OK" 
    mbCancel - Отображает кнопку "Cancel" 
    mbAbort - Отображает кнопку "Abort" 
    mbRetry - Отображает кнопку "Retry" 
    mbIgnore - Отображает кнопку "Ignore" 
    mbAll - Отображает кнопку "All" 
    mbNoToAll - Отображает кнопку "No to all" 
    mbYesToAll - Отображает кнопку "Yes to all"
    mbHelp - Отображает кнопку "Help"
}

      {#REGION }//
      {#ENDREGION }//
unit cGlobalHeader;




interface

    const
        LN  = #10#13;        

        HOME_PATH                   = '.\';
        IMAGE_HOME_PATH             = 'src\';
        NN_OUT_FOLDER               = 'out\';
        POSITIVE_LEARN_SET_PATH     = 'learn_img_+_set\';
        NEGATIVE_LEARN_SET_PATH     = 'learn_img_-_set\';
        TEST_IMAGE_SET_PATH         = 'test_img_set\';
        IMAGE_EXTENSION             = '.bmp';
        NN_EXTENSION                = '.nn';

        DEBUG_FILE_PATH             = '.\debug_log.txt';
        
        //LEARNING_MAX_LOOP_IDLING    = 20;
        //LEARN_MAX_ITER_COUNT        = 2000;

        MAX_RECEPTOR_COUNT          = 60;
        MAX_NEIRON_COUNT            = 255; // must be equal or less then receptor count. tyheorethical can be more, too

        MAX_POS_LINKS               = 4;
        MAX_NEG_LINKS               = 4;

        DEFAULT_IMAGE_WIDTH         = 6;
        DEFAULT_IMAGE_HEIGHT        = 10;
        
        MAX_CLASSNAME_LENGTH        = 10;    

    type
      //**********************************************************//
      //****** USER DEFINED TYPES ********************************//        
        tint    = integer;
        tsingle = single;
        
        typeofreceptor  = tint;
        typeofneiron    = tint;
        typeofweight    = tsingle;
        typeoflinkarray = tint;
        
        
        _receptorVecI    = array    of typeofreceptor;
        _neironVecI      = array    of typeofneiron;
        _weightVecS      = array    of Single;
        _link2DVecI      = array of array of Integer;

        neironNetwork = record
            neironCount     :Integer;
            receptorCount   :Integer;
            positiveLinks   :Integer;
            negativeLinks   :Integer;
            theta           :Single;        // theta used in learn process
            className       :String[MAX_CLASSNAME_LENGTH];
            weightW         :array    of typeofweight;    // learnt neiron weights
            xyLinkArrayS    :array of array of typeoflinkarray;    // links between neirons and receptors
        end;
        
   var
        DEFAULT_DIR:String;

implementation

BEGIN
END.

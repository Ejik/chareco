{*------------------------------------------------------------------------------

  @Author    Ejik
  @Version   2010.03.15   Ejik	Initial revision                                       
-------------------------------------------------------------------------------}


unit systemConsts;

interface

const
    NumberLength = 9;
    NumberHeight = 90;
    NumberWidth = 500;

    LettersWidth = 45;  // ширина буквы
    NumbersWidth = 58; // ширина цифер


    arrAutoLayout : array [0..NumberLength - 2] of integer = (lettersWidth, lettersWidth + numbersWidth, 45 + 58 + 58, 45 + 58 + 58 + 58, 45 + 58 + 58 + 58 + 45, 320, 378, 436);

implementation

end.

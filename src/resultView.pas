{*------------------------------------------------------------------------------
  Интрейфес для отображения результатов распознавания  
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit resultView;

interface

uses
  Forms, Classes;

type
    IResultView = interface
    ['{2987E787-AC83-4170-AE2E-8E0AA3855D3A}']
        procedure bind(owner: TComponent; data: TStringList);
        procedure show();
    end;


implementation

end.

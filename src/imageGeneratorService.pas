{*------------------------------------------------------------------------------
  ��������� ������� ��� ��������� �����������  
  ������������� �������� 
  �������� ������ �� ���������� "���������� ����������������"
  @Author    ������� ��. ��1-06 ��������� �. �.
  @Version   2010.03.23   ��������� �. �.	Initial revision                                       
-------------------------------------------------------------------------------}

unit imageGeneratorService;

interface

uses
    Graphics;

type
    IImageGeneratorService = interface
    ['{175C2A3D-984A-451B-A12E-D4050EC54147}']
        function generate(const strNumber : string) : TBitmap;
    end;

implementation

end.
 
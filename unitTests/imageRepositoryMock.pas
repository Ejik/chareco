unit imageRepositoryMock;

interface

uses
    imageRepository, Classes, Graphics;

type
    TImageRepositoryMock = class(TInterfacedObject, IImageRepository)
    private
        procedure getImagePath(const strName: string);
    public
        constructor create();
        destructor destroy(); override;
        function getImage(const strName: string) : TBitmap;
        procedure initialize();
    end;

implementation

uses SysUtils;

{ TImageRepositoryMock }

constructor TImageRepositoryMock.create;
begin

end;

destructor TImageRepositoryMock.destroy;
begin
    inherited;
end;


function TImageRepositoryMock.getImage(const strName: string): TBitmap;
begin
    result := TBitmap.create();
end;

procedure TImageRepositoryMock.getImagePath(const strName: string);
begin

end;

procedure TImageRepositoryMock.initialize;
begin

end;

end.


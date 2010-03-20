unit imageRepositoryImpl;

interface

uses
    imageRepository, Classes, Graphics, EBInjectable;

type
    TImageRepository = class(TInjectable, IImageRepository)
    private
        fImageList: TStringList;
    public
        destructor destroy(); override;

        procedure initialize();
        function getImage(const strName: string): TBitmap;
        function getImageByIndex(index : integer) : TBitmap;
        function getImageCount() : integer;
        function getImageNameByIndex(index : integer) : string;
        function getPatternsCount() : integer;
    end;

implementation

uses
    EBDependencyInjection, SysUtils, EBDIRegistry;

{ TImageRepository }


destructor TImageRepository.destroy;
begin
    freeAndNil(fImageList);
    inherited;
end;

function TImageRepository.getImage(const strName: string): TBitmap;
var
    bmp: TBitmap;
begin
    bmp := TBitmap.create();
    bmp.LoadFromFile(fImageList.Values[strName]);
    result := bmp;
end;

function TImageRepository.getImageByIndex(index: integer): TBitmap;
begin
    result := getImage(fImageList.ValueFromIndex[index]);
end;

function TImageRepository.getImageCount: integer;
begin
    result := fImageList.Count;
end;

function TImageRepository.getImageNameByIndex(index: integer): string;
begin
    result := fImageList.Names[index];
end;

function TImageRepository.getPatternsCount: integer;
begin
    result := fImageList.Count;
end;

procedure TImageRepository.initialize;
var
    i: integer;
begin
    if (fImageList = nil) then
    begin
        fImageList := TStringList.create();

        fImageList.Add('a=images\tpl_a.bmp');
        fImageList.Add('b=images\tpl_b.bmp');
        fImageList.Add('e=images\tpl_e.bmp');
        fImageList.Add('k=images\tpl_k.bmp');
        fImageList.Add('m=images\tpl_m.bmp');
        fImageList.Add('h=images\tpl_h.bmp');
        fImageList.Add('o=images\tpl_o.bmp');
        fImageList.Add('p=images\tpl_p.bmp');
        fImageList.Add('c=images\tpl_c.bmp');
        fImageList.Add('t=images\tpl_t.bmp');
        fImageList.Add('y=images\tpl_y.bmp');
        fImageList.Add('x=images\tpl_x.bmp');
        fImageList.Add('d=images\tpl_d.bmp');
        //fImageList.Add('r=images\tpl_tr.bmp');
        fImageList.Add('bl=images\tpl_blank.bmp');

        for i := 0 to 9 do
        begin
            fImageList.Add(IntToStr(i) + '=images\tpl_' + intToStr(i) + '.bmp');
        end;
    end;
end;


initialization
    GetDIRegistry.RegisterFactorySingleton(IImageRepository, TImageRepository);

end.


unit ImageGeneratorServiceImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, Graphics, Controls,
    Classes, ImageGeneratorService;

type
    TImageGeneratorService = class(TInjectable, IImageGeneratorService)
    private
        imageList: TImageList;
        sl: TStringList;

        procedure loadTemplates();
    public
        destructor destroy(); override;
        function generate(const strNumber: string): TBitmap;
    end;

implementation

uses SysUtils;

{ TImageGeneratorService }

destructor TImageGeneratorService.destroy;
begin
    FreeAndNil(sl);
end;

function TImageGeneratorService.generate(
    const strNumber: string): TBitmap;
var
    bmp: TBitmap;
    buffer: TBitmap;
    strImgPath: string;
begin
    loadTemplates();

    bmp := TBitmap.Create;
    buffer := TBitmap.Create;

    bmp.Width := 312;
    bmp.Height := 90;
    buffer.Width := 58;
    buffer.Height := bmp.Height;

    // x width = 45
    strImgPath := sl.Values[strNumber[1]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(0, 32, buffer);

    // 7 width = 58
    strImgPath := sl.Values[strNumber[2]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(45, 0, buffer);

    // 7
    strImgPath := sl.Values[strNumber[3]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(103, 0, buffer);

    // 7
    strImgPath := sl.Values[strNumber[4]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(161, 0, buffer);

    // a
    strImgPath := sl.Values[strNumber[5]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(219, 32, buffer);

    // a
    strImgPath := sl.Values[strNumber[6]];
    buffer.LoadFromFile(strImgPath);
    bmp.Canvas.Draw(264, 32, buffer);

    freeAndNil(buffer);
    result := bmp;
end;

procedure TImageGeneratorService.loadTemplates;
var
    i: integer;
    //bmp: TBitmap;
begin
    if (sl = nil) then
    begin
        sl := TStringList.create();
        sl.Add('a=images\tpl_a.bmp');
        sl.Add('b=images\tpl_b.bmp');
        sl.Add('e=images\tpl_e.bmp');
        sl.Add('k=images\tpl_k.bmp');
        sl.Add('m=images\tpl_m.bmp');
        sl.Add('h=images\tpl_h.bmp');
        sl.Add('o=images\tpl_o.bmp');
        sl.Add('c=images\tpl_c.bmp');
        sl.Add('t=images\tpl_t.bmp');
        sl.Add('y=images\tpl_y.bmp');
        sl.Add('x=images\tpl_x.bmp');
        sl.Add('d=images\tpl_d.bmp');
        sl.Add('r=images\tpl_tr.bmp');

        for i := 0 to 9 do
        begin
            sl.Add(IntToStr(i) + '=images\tpl_' + intToStr(i) + '.bmp');
        //imageList.Add(bmp, nil);
        end;
    end;
end;

initialization
    GetDIRegistry.RegisterFactory(IImageGeneratorService, TImageGeneratorService);

end.

 
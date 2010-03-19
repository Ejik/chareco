unit ImageGeneratorServiceImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, Graphics, Controls,
    Classes, ImageGeneratorService, imageRepository;

type
    TImageGeneratorService = class(TInjectable, IImageGeneratorService)
    private
        fImageRepository: IImageRepository;
    public
        constructor create(imageRepository: IImageRepository); overload;
        destructor destroy(); override;
        function generate(const strNumber: string): TBitmap;
    end;

implementation

uses SysUtils, systemConsts;

{ TImageGeneratorService }

constructor TImageGeneratorService.create(
    imageRepository: IImageRepository);
begin
    fImageRepository := imageRepository;
end;

destructor TImageGeneratorService.destroy;
begin
    inherited;
end;

function TImageGeneratorService.generate(
    const strNumber: string): TBitmap;
var
    bmp: TBitmap;
    buffer: TBitmap;
begin
    fImageRepository.initialize();

    bmp := TBitmap.Create;
    bmp.PixelFormat := pf8bit;
    //buffer := TBitmap.Create;
    bmp.PixelFormat := pf8bit;

    bmp.Width := NumberWidth;
    bmp.Height := NumberHeight;
    //buffer.Width := 58;
    //buffer.Height := bmp.Height;

    // x width = 45
    buffer := fImageRepository.getImage(strNumber[1]);
    bmp.Canvas.Draw(0, 0, buffer);
    freeAndNil(buffer);

    // 7 width = 58
    buffer := fImageRepository.getImage(strNumber[2]);
    bmp.Canvas.Draw(arrAutoLayout[0], 0, buffer);
    freeAndNil(buffer);

    // 7
    buffer := fImageRepository.getImage(strNumber[3]);
    bmp.Canvas.Draw(arrAutoLayout[1], 0, buffer);
    freeAndNil(buffer);

    // 7
    buffer := fImageRepository.getImage(strNumber[4]);
    bmp.Canvas.Draw(arrAutoLayout[2], 0, buffer);
    freeAndNil(buffer);

    // a
    buffer := fImageRepository.getImage(strNumber[5]);
    bmp.Canvas.Draw(arrAutoLayout[3], 0, buffer);
    freeAndNil(buffer);

    // a
    buffer := fImageRepository.getImage(strNumber[6]);
    bmp.Canvas.Draw(arrAutoLayout[4], 0, buffer);
    freeAndNil(buffer);

    // 1
    if (strNumber[7] = '0') then
        buffer := fImageRepository.getImage('bl')
    else
        buffer := fImageRepository.getImage(strNumber[7]);
    bmp.Canvas.Draw(arrAutoLayout[5], 0, buffer);
    freeAndNil(buffer);

    // 7
    buffer := fImageRepository.getImage(strNumber[8]);
    bmp.Canvas.Draw(arrAutoLayout[6], 0, buffer);
    freeAndNil(buffer);

    // 8
    buffer := fImageRepository.getImage(strNumber[9]);
    bmp.Canvas.Draw(arrAutoLayout[7], 0, buffer);
    freeAndNil(buffer);
    
    result := bmp;
end;

initialization
    GetDIRegistry.RegisterFactory(IImageGeneratorService, TImageGeneratorService);

end.

 
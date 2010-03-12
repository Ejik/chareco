unit imageGeneratorServiceMock;

interface

uses
  imageGeneratorService, Graphics;

type
     TImageGeneratorServiceMock = class(TInterfacedObject, IImageGeneratorService)
         function generate(const strNumber : string) : TBitmap;
     end;

implementation

{ TTImageGeneratorServiceMock }

function TImageGeneratorServiceMock.generate(
  const strNumber: string): TBitmap;
begin
    result := TBitmap.create();
end;

end.
 
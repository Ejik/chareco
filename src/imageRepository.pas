unit imageRepository;

interface

uses
  Graphics;

type
    IImageRepository = interface
        ['{F1A69272-FD1B-4E69-884E-79B84CBBDBEA}']
        function getImage(const strName: string) : TBitmap;
        function getImageNameByIndex(index : integer) : string;
        function getPatternsCount(): integer;
        procedure initialize();
    end;

implementation

end.


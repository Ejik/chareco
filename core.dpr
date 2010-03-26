library core;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  recognitionService in 'src\recognitionService.pas',
  recognitionServiceImpl in 'src\recognitionServiceImpl.pas',
  recognizer in 'src\recognizer.pas',
  recognizerBaseImpl in 'src\recognizerBaseImpl.pas',
  recognizerByAreaImpl in 'src\recognizerByAreaImpl.pas',
  recognizerByMaskImpl in 'src\recognizerByMaskImpl.pas',
  recognizerByVectorImpl in 'unitTests\recognizerByVectorImpl.pas',
  reporter in 'src\reporter.pas',
  reporterImpl in 'src\reporterImpl.pas',
  EBDependencyInjection,
  imageRepositoryImpl in 'src\imageRepositoryImpl.pas',
  imageRepository in 'src\imageRepository.pas',
  recogizerThreadImpl in 'src\recogizerThreadImpl.pas';

function getRecognitionService(): IRecognitionService; export;
begin
    result := Emballo.get(IRecognitionService) as IRecognitionService;
end;

function getImageRepository(): IImageRepository; export;
begin
    result := Emballo.get(IImageRepository) as IImageRepository;
end;

exports
    getRecognitionService,
    getImageRepository;
    
{$R *.res}

begin
end.


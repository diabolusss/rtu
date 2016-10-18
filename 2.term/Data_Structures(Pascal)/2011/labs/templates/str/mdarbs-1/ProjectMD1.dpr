program ProjectMD1;

uses
  Forms,
  UnitMD1 in 'UnitMD1.pas' {Form1};

{$R *.res}


begin

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

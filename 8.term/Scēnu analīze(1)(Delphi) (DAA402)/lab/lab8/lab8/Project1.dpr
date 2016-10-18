program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Main_menu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_menu, Main_menu);
  Application.Run;
end.

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1;

type
  TForm2 = class(TForm)
    dx: TEdit;
    dy: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected

  procedure CreateParams(var Params:TCreateParams);override;
  
  end;

var
  Form2: TForm2;
  idx, idy :Integer;

implementation

{$R *.dfm}

procedure Tform2.CreateParams;
begin
 inherited;
 Params.WndParent:= form1.Handle
end;

procedure TForm2.Button1Click(Sender: TObject);
Var i,j, ind :Integer;
    rinda: pRGBTripleArray;
begin
  Form1.Button4.Click;
  Form2.Hide;
  idx:=StrToInt(dx.Text);
  idy:=StrToInt(dy.Text);
  ind:=0;

  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres)+idx;
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0])+idy;
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

 if (idx<0) and (idy<0) then begin ind:=1; idx:=idx*(-1); idy:=idy*(-1); end;
 if (idx<0) and (idy>=0) then begin ind:=2; idx:=idx*(-1); end;
 if (idy<0) and (idx>=0) then begin ind:=3; idy:=idy*(-1); end;

  if ind=1 then
  for j:=0 to High(imgres[0])-idy do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres)-idx do
        begin
          rinda[i].rgbtRed:=imgres[i+idx,j+idy].R;
          rinda[i].rgbtGreen:=imgres[i+idx,j+idy].G;
          rinda[i].rgbtBlue:=imgres[i+idx,j+idy].B;
        end;
    end;

  if ind=0 then
  for j:=idy to High(imgres[0])+idy do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=idx to High(imgres)+idx do
        begin
          rinda[i].rgbtRed:=a1*imgres[i-idx,j-idy].R +b1;
          rinda[i].rgbtGreen:=a2*imgres[i-idx,j-idy].G +b2;
          rinda[i].rgbtBlue:=a3*imgres[i-idx,j-idy].B +b3;
        end;
    end;

  if ind=2 then
  for j:=idy to High(imgres[0])+idy do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres)-idx do
        begin
          rinda[i].rgbtRed:=a1*imgres[i+idx,j-idy].R +b1;
          rinda[i].rgbtGreen:=a2*imgres[i+idx,j-idy].G +b2;
          rinda[i].rgbtBlue:=a3*imgres[i+idx,j-idy].B +b3;
        end;
    end;

  if ind=3 then
  for j:=0 to High(imgres[0])-idy do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=idx to High(imgres)+idx do
        begin
          rinda[i].rgbtRed:=a1*imgres[i-idx,j+idy].R +b1;
          rinda[i].rgbtGreen:=a2*imgres[i-idx,j+idy].G +b2;
          rinda[i].rgbtBlue:=a3*imgres[i-idx,j+idy].B +b3;
        end;
    end;

  Form1.Image3.Refresh;
  end;
end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, JPEG;

type
  TRGB = record
    R,G,B: Byte;
  end;

  TRGBTripleArray = array[word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Open1Click(Sender: TObject);
    procedure ReadFromBMP();
    procedure imgToImage1(a:integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  img: array of array of TRGB;
  bmp: TBitmap;
  jpg: TJPEGImage;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp:=TBitmap.Create;
  jpg:=TJPEGImage.Create;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
  jpg.Free;
end;

procedure TForm1.Open1Click(Sender: TObject);
var FP: string;
begin
  if OpenDialog1.Execute then
    begin
      FP:=AnsiUpperCase(ExtractFileExt
          (OpenDialog1.Filename));

      if FP='.BMP' then
        begin
          bmp.LoadFromFile(OpenDialog1.FileName);
        end;
      if FP='.JPG' then
        begin
          jpg.LoadFromFile(OpenDialog1.FileName);
          bmp.Width:=jpg.Width;
          bmp.Height:=jpg.Height;
          bmp.Canvas.Draw(0,0,jpg);
        end;
      bmp.PixelFormat:=pf24bit;
    end;
    ReadFromBMP();
    imgToImage1(0);
end;

procedure TForm1.ReadFromBMP();
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  SetLength(img, bmp.Width, bmp.Height);

  for j:=0 to bmp.Height-1 do
    begin
      rinda:=bmp.ScanLine[j];
      for i:=0 to bmp.Width-1 do
        begin
          img[i,j].R:=rinda[i].rgbtRed;
          img[i,j].G:=rinda[i].rgbtGreen;
          img[i,j].B:=rinda[i].rgbtBlue;
        end;
    end;
end;

procedure TForm1.imgToImage1(a:integer);
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
         rinda[i].rgbtRed:=img[i,j].R;
         rinda[i].rgbtGreen:=img[i,j].G;
         rinda[i].rgbtBlue:=img[i,j].B;
        end;
    end;
  Image1.Refresh;    
end;
end.

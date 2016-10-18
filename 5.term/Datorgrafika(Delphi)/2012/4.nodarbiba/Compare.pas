unit Compare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;
{$R *.dfm}

procedure TForm3.FormActivate(Sender: TObject);
var
bitm, bitm2:TBitmap;
i,j:integer;
row: pRGBTripleArray;


begin
  Form3.DoubleBuffered:=true;
  bitm:=TBitmap.Create;
  bitm2:=TBitmap.Create;
  bitm.Width:=length(image);
  bitm.Height:=length(image[0]);
  bitm2.Width:=length(new);
  bitm2.Height:=length(new[0]);

  bitm.PixelFormat:=pf24bit;
  bitm2.PixelFormat:=pf24bit;

  for j := 0 to bitm.Height - 1 do
   begin
    row := bitm.ScanLine[j];
     for i := 0 to bitm.Width - 1 do
      begin
       row[i].rgbtRed := image[i, j].R;
       row[i].rgbtGreen := image[i, j].G;
       row[i].rgbtBlue := image[i, j].B;
      end;
   end;

   for j := 0 to bitm2.Height - 1 do
    begin
     row := bitm2.ScanLine[j];
      for i := 0 to bitm2.Width - 1 do
       begin
        row[i].rgbtRed := new[i, j].R;
        row[i].rgbtGreen := new[i, j].G;
        row[i].rgbtBlue := new[i, j].B;
       end;
    end;

  Image1.Picture.Bitmap:=bitm;
  Image2.Picture.Bitmap:=bitm2;
  bitm.Free;
  bitm2.Free;
 end;

end.

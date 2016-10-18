unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, JPEG, Math, ComCtrls;

  type
  TRGB = record
    R,G,B,I: Byte;

    end;

  type
  THSV = record
    H, S, V: Single;

    end;

  TRGBTripleArray = array[word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    ScrollBox2: TScrollBox;
    Image3: TImage;
    PageControl1: TPageControl;
    rgbhsv: TTabSheet;
    Label1: TLabel;
    Label7: TLabel;
    ScrollBar4: TScrollBar;
    Label2: TLabel;
    ScrollBar5: TScrollBar;
    Label8: TLabel;
    Label3: TLabel;
    ScrollBar6: TScrollBar;
    Label9: TLabel;
    Label4: TLabel;
    ScrollBar1: TScrollBar;
    Label10: TLabel;
    Label5: TLabel;
    ScrollBar2: TScrollBar;
    Label11: TLabel;
    Label6: TLabel;
    ScrollBar3: TScrollBar;
    Label12: TLabel;
    Label16: TLabel;
    ScrollBar7: TScrollBar;
    Label13: TLabel;
    Label17: TLabel;
    ScrollBar8: TScrollBar;
    Label14: TLabel;
    Label18: TLabel;
    ScrollBar9: TScrollBar;
    Label15: TLabel;
    Label21: TLabel;
    ScrollBar10: TScrollBar;
    Label19: TLabel;
    Label22: TLabel;
    ScrollBar11: TScrollBar;
    Label20: TLabel;
    Button4: TButton;
    Button1: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    SaveasJPG1: TMenuItem;
    SaveasBMP1: TMenuItem;
    Edit1: TMenuItem;
    Nobide1: TMenuItem;
    Rotation1: TMenuItem;
    N90deg1: TMenuItem;
    N180deg1: TMenuItem;
    Rotesana1: TMenuItem;
    N901: TMenuItem;
    N1801: TMenuItem;
    N2701: TMenuItem;
    N1: TMenuItem;
    Merogosana1: TMenuItem;
    uvkaim1: TMenuItem;
    Bilineara1: TMenuItem;
    Bikubiska1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    hist: TTabSheet;
    Image2: TImage;
    Edit2: TEdit;
    Edit3: TEdit;
    Label23: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    roksnis1: TMenuItem;
    roksnis2: TMenuItem;
    Gludinasana1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReadFromBMP();
    procedure imgToImage1();
    procedure imgToImage3();
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure ScrollBar6Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SaveasJPG1Click(Sender: TObject);
    procedure SaveasBMP1Click(Sender: TObject);
    procedure Nobide1Click(Sender: TObject);
    procedure N90deg1Click(Sender: TObject);
    procedure N180deg1Click(Sender: TObject);
    procedure N1801Click(Sender: TObject);
    procedure N901Click(Sender: TObject);
    procedure N2701Click(Sender: TObject);
    procedure uvkaim1Click(Sender: TObject);
    procedure Bilineara1Click(Sender: TObject);
    procedure Bikubiska1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ScrollBar7Change(Sender: TObject);
    procedure ScrollBar8Change(Sender: TObject);
    procedure ScrollBar9Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScrollBar10Change(Sender: TObject);
    procedure ScrollBar11Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure roksnis2Click(Sender: TObject);
    procedure Gludinasana1Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var

  Form1: TForm1;
  img, imgres, imgr, imghist: array of array of TRGB;
  imgH, imgHT :array of array of THSV;
  bmp: TBitmap;
  jpg: TJPEGImage;
  a1,a2,a3,b1,b2,b3,transform, H, S, V, xv, xs :Integer;
  histo :array[0..255] of Integer;
implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.dfm}

procedure preview();
begin
        b1:=Form1.ScrollBar1.Position;
        b2:=Form1.ScrollBar2.Position;
        b3:=Form1.ScrollBar3.Position;
        a1:=Form1.ScrollBar4.Position;
        a2:=Form1.ScrollBar5.Position;
        a3:=Form1.ScrollBar6.Position;
        Form3.Button1.Click;
        Form1.imgtoimage3();
end;

function RGBtoHSV(a:TRGB): THSV;
var
  Maximum, Minimum: Byte;
  Rc, Gc, Bc: Single;
  b:THSV;
begin
  Maximum := Max(a.R, Max(a.G, a.B));
  Minimum := Min(a.R, Min(a.G, a.B));
  b.V := Maximum;
  if Maximum <> 0 then
    b.S := MulDiv(Maximum - Minimum, 255, Maximum)
  else
    b.S := 0;
  if b.S = 0 then
    b.H := 0
  else
  begin
    Assert(Maximum <> Minimum);
    Rc := (Maximum - a.R) / (Maximum - Minimum);
    Gc := (Maximum - a.G) / (Maximum - Minimum);
    Bc := (Maximum - a.B) / (Maximum - Minimum);
    if a.R = Maximum then
      b.H := Bc - Gc
    else if a.G = Maximum then
      b.H := 2 + Rc - Bc
    else
    begin
      Assert(a.B = Maximum);
      b.H := 4 + Gc - Rc;
    end;
    b.H := b.H * 60;
    if b.H < 0 then
      b.H := b.H + 360;
    b.H := Round(b.H);
  end;
  result:=b;
end;

function HSVtoRGB(a:THSV):TRGB;
Var b:TRGB;
  sec, d, t1, t2, t3:Integer;
begin
  if a.S = 0 then
   begin
    b.R :=Round( a.V); b.G := Round(a.V); b.B :=Round( a.V);
   end
  else
   begin
    sec := Round(a.H * 6);
    d := sec mod 360;

    t1 := round(a.V * (255 - a.S) / 255);
    t2 := round(a.V * (255 - a.S * d / 360) / 255);
    t3 := round(a.V * (255 - a.S * (360 - d) / 360) / 255);

    case sec div 360 of
    0:
      begin
        b.R := Round(a.V); b.G := t3; b.B := t1;
      end;
    1:
      begin
        b.R := t2; b.G := Round(a.V); b.B := t1;
      end;
    2:
      begin
        b.R := t1; b.G := Round(a.V); b.B := t3;
      end;
    3:
      begin
        b.R := t1; b.G := t2; b.B := Round(a.V);
      end;
    4:
      begin
        b.R := t3; b.G := t1; b.B := Round(a.V);
      end;
    else
      begin
        b.R := Round(a.V); b.G := t1; b.B := t2;
      end;
    end;
   end;
  result:=b;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
  jpg.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp:=TBitmap.Create;
  jpg:=TJPEGImage.Create;
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
         // img[i,j].I:=(77*img[i,j].R +150*img[i,j].G+29*img[i,j].B) div  256;
        end;
    end;
end;

procedure TForm1.SaveasJPG1Click(Sender: TObject);
begin
If SaveDialog1.Execute then begin
  JPG.Assign(Image3.Picture.Bitmap);
  JPG.SaveToFile(SaveDialog1.FileName + '.jpg');
end;

end;

procedure TForm1.SaveasBMP1Click(Sender: TObject);
begin
If SaveDialog1.Execute then begin
  BMP.Assign(Image3.Picture.Bitmap);
  BMP.SaveToFile(SaveDialog1.FileName + '.bmp');
end;

end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
        Label10.Caption:=IntToStr(ScrollBar1.Position);
        preview();
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
        Label11.Caption:=IntToStr(ScrollBar2.Position);
        preview();
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
        Label12.Caption:=IntToStr(ScrollBar3.Position);
        preview();
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
        Label7.Caption:=IntToStr(ScrollBar4.Position);
        preview();
end;

procedure TForm1.ScrollBar5Change(Sender: TObject);
begin
        Label8.Caption:=IntToStr(ScrollBar5.Position);
        preview();
end;


procedure TForm1.ScrollBar6Change(Sender: TObject);
begin
        Label9.Caption:=IntToStr(ScrollBar6.Position);
        preview();
end;

procedure TForm1.uvkaim1Click(Sender: TObject);
begin
  transform:=1;
  Form3.Show;
end;

procedure TForm1.imgToImage1();
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

    SetLength(imgr, Length(img), Length(img[0]));

      for j:=0 to High(img[0]) do
      for i:=0 to High(img) do
        begin
          imgr[i,j]:=img[i,j];
        end;
end;

procedure TForm1.imgToImage3();
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  Image3.Picture.Bitmap.Width:=Length(imgres);
  Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Image3.Picture.Bitmap.PixelFormat:=pf24bit;


  for j:=0 to High(imgres[0]) do
    begin
      rinda:=Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          if ((a1*imgres[i,j].R + b1)>255) then rinda[i].rgbtRed:=255;
          if ((a2*imgres[i,j].G + b2)>255) then rinda[i].rgbtGreen:=255;
          if ((a3*imgres[i,j].B + b3)>255) then rinda[i].rgbtBlue:=255;
          if ((a1*imgres[i,j].R + b1)<0) then rinda[i].rgbtRed:=0;
          if ((a2*imgres[i,j].G + b2)<0) then rinda[i].rgbtGreen:=0;
          if ((a3*imgres[i,j].B + b3)<0) then rinda[i].rgbtBlue:=0;

          if ((a1*imgres[i,j].R + b1)<=255) and ((a1*imgres[i,j].R + b1)>=0) then rinda[i].rgbtRed:=a1*imgres[i,j].R + b1;
          if ((a2*imgres[i,j].G + b2)<=255) and ((a2*imgres[i,j].G + b2)>=0) then rinda[i].rgbtGreen:=a2*imgres[i,j].G + b2;
          if ((a3*imgres[i,j].B + b3)<=255) and ((a3*imgres[i,j].B + b3)>=0) then rinda[i].rgbtBlue:=a3*imgres[i,j].B + b3;
        end;
    end;
  Image3.Refresh;
end;

procedure TForm1.Nobide1Click(Sender: TObject);
begin
  Form2.Show;
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
    imgToImage1();
    Form3.Button1.Click;
end;

procedure TForm1.N90deg1Click(Sender: TObject);
 Var i, j :Integer;
  rinda: pRGBTripleArray;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres[0]) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[Length(imgres)-i].rgbtRed:=imgres[i,j].R;
          rinda[Length(imgres)-i].rgbtGreen:=imgres[i,j].G;
          rinda[Length(imgres)-i].rgbtBlue:=imgres[i,j].B;
        end;
    end;
  Form1.Image3.Refresh;

end;

procedure TForm1.N180deg1Click(Sender: TObject);
Var i, j :Integer;
  rinda: pRGBTripleArray;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres[0]) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[i].rgbtRed:=imgres[i,High(imgres[0])-j].R;
          rinda[i].rgbtGreen:=imgres[i,High(imgres[0])-j].G;
          rinda[i].rgbtBlue:=imgres[i,High(imgres[0])-j].B;
        end;
    end;
  Form1.Image3.Refresh;
end;


procedure TForm1.N1801Click(Sender: TObject);
  Var i, j :Integer;
  rinda: pRGBTripleArray;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres[0]) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[High(imgres)-i].rgbtRed:=imgres[i,High(imgres[0])-j].R;
          rinda[High(imgres)-i].rgbtGreen:=imgres[i,High(imgres[0])-j].G;
          rinda[High(imgres)-i].rgbtBlue:=imgres[i,High(imgres[0])-j].B;
        end;
    end;
  Form1.Image3.Refresh;
end;

procedure TForm1.N901Click(Sender: TObject);
   Var i, j :Integer;
  rinda: pRGBTripleArray;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres[0]) do
        begin
          rinda[i].rgbtRed:=imgres[j,High(imgres[0])-i].R;
          rinda[i].rgbtGreen:=imgres[j,High(imgres[0])-i].G;
          rinda[i].rgbtBlue:=imgres[j,High(imgres[0])-i].B;
        end;
    end;
  Form1.Image3.Refresh;
end;

procedure TForm1.N2701Click(Sender: TObject);
  Var i, j :Integer;
  rinda: pRGBTripleArray;
begin
  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres[0]) do
        begin
          rinda[i].rgbtRed:=imgres[High(imgres)-j,i].R;
          rinda[i].rgbtGreen:=imgres[High(imgres)-j,i].G;
          rinda[i].rgbtBlue:=imgres[High(imgres)-j,i].B;
        end;
    end;
  Form1.Image3.Refresh;
end;


procedure TForm1.Bilineara1Click(Sender: TObject);
begin
  transform:=2;
  Form3.Show;
end;

procedure TForm1.Bikubiska1Click(Sender: TObject);
begin
  transform:=3;
  Form3.Show;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
Form4.show;
end;

procedure TForm1.ScrollBar7Change(Sender: TObject);
begin
Label13.Caption:=IntToStr(ScrollBar7.Position);
button1.Click;
end;

procedure TForm1.ScrollBar8Change(Sender: TObject);
begin
Label14.Caption:=IntToStr(ScrollBar8.Position);
button1.Click;
end;

procedure TForm1.ScrollBar9Change(Sender: TObject);
begin
Label15.Caption:=IntToStr(ScrollBar9.Position);
button1.Click;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  H:=ScrollBar7.Position;
  S:=ScrollBar8.Position;
  V:=ScrollBar9.Position;
  xs:=ScrollBar10.Position;
  xv:=ScrollBar11.Position;

  Image3.Picture.Bitmap.Width:=Length(imgres);
  Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Image3.Picture.Bitmap.PixelFormat:=pf24bit;
  SetLength(imgH, Length(imgres), Length(imgres[0]));
  SetLength(imgHT, Length(imgres), Length(imgres[0]));

  for j:=0 to High(imgHT[0]) do
      for i:=0 to High(imgHT) do
        begin
          imgH[i,j]:=RGBtoHSV(imgr[i,j]);
          if (imgH[i,j].H+H) <= 360 then imgHT[i,j].H:=imgH[i,j].H+H else imgHT[i,j].H:=imgH[i,j].H+H-360;
          if ((xs*imgH[i,j].S+S) <= 255) and ((xs*imgH[i,j].S+S) >= 0) then imgHT[i,j].S:=xs*imgH[i,j].S+S;
          if ((xv*imgH[i,j].V+V) <= 255) and ((xv*imgH[i,j].V+V) >= 0) then imgHT[i,j].V:=xv*imgH[i,j].V+V;
          if (xs*imgH[i,j].S+S>255) then imgHT[i,j].S:=255;
          if (xv*imgH[i,j].V+V>255) then imgHT[i,j].V:=255;
          if (xv*imgH[i,j].V+V<0) then imgHT[i,j].V:=0;
          if (xs*imgH[i,j].S+S<0) then imgHT[i,j].S:=0;
        end;

  for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
          imgres[i,j]:=HSVtoRGB(imgHT[i,j]);
        end;

  for j:=0 to High(imgres[0]) do
    begin
      rinda:=Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[i].rgbtRed:=imgres[i,j].R;
          rinda[i].rgbtGreen:=imgres[i,j].G;
          rinda[i].rgbtBlue:=imgres[i,j].B;
        end;
    end;
  Image3.Refresh;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
   ScrollBar1.Position:=0;
   ScrollBar2.Position:=0;
   ScrollBar3.Position:=0;
   ScrollBar4.Position:=1;
   ScrollBar5.Position:=1;
   ScrollBar6.Position:=1;
   ScrollBar7.Position:=0;
   ScrollBar8.Position:=0;
   ScrollBar9.Position:=0;
   ScrollBar10.Position:=1;
   ScrollBar11.Position:=1;
   preview();
end;

procedure TForm1.ScrollBar10Change(Sender: TObject);
begin
Label19.Caption:=IntToStr(ScrollBar10.Position);
button1.Click;
end;

procedure TForm1.ScrollBar11Change(Sender: TObject);
begin
Label20.Caption:=IntToStr(ScrollBar11.Position);
button1.Click;
end;

procedure TForm1.Button2Click(Sender: TObject);
Var ii, i, j :Integer;
     rinda: pRGBTripleArray;
     max :Integer;
begin
      label27.Visible:=True;
      label28.Visible:=True;
      label29.Visible:=True;

      for i:=0 to 255 do histo[i]:=0;
      max:=0;
      for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
           imgres[i,j].I:=0;
        end;

      for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
         // ii:=Round(1/3*(imgres[i,j].R+imgres[i,j].G+imgres[i,j].B));
          ii:=Round(0.3*imgres[i,j].R+0.6*imgres[i,j].G+0.1*imgres[i,j].B);
          if ii<0 then ii:=0;
          if ii>255 then ii:=255;
          imgres[i,j].I:=ii;
        end;

      for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
          histo[imgres[i,j].I]:=histo[imgres[i,j].I]+1;
          if histo[imgres[i,j].I] > max then max:=histo[imgres[i,j].I];
        end;

  Image2.Picture.Bitmap.Width:=256;
  Image2.Picture.Bitmap.Height:=101;
  Image2.Picture.Bitmap.PixelFormat:=pf24bit;

    for j:=0 to 100 do
    begin
      rinda:=Image2.Picture.Bitmap.ScanLine[j];
      for i:=0 to 255 do
        begin
          rinda[i].rgbtRed:=255;
          rinda[i].rgbtGreen:=255;
          rinda[i].rgbtBlue:=255;
        end;
    end;

  Image2.Canvas.Pen.Color:= clBlack;

  for i:=0 to 255 do
  begin
    histo[i]:=Round(histo[i]*100/max);
    Image2.Canvas.MoveTo(i,100);
    Image2.Canvas.LineTo(i,100-histo[i]);
  end;
  Image2.Refresh;

end;

procedure TForm1.Button3Click(Sender: TObject);
var i, j, vns, vvs  :Integer;
    rinda: pRGBTripleArray;
begin
vns:=StrToInt(Edit2.text);
vvs:=StrToInt(Edit3.text);

  Image3.Picture.Bitmap.Width:=Length(imgres);
  Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Image3.Picture.Bitmap.PixelFormat:=pf24bit;

    for j:=0 to 100 do
    begin
      rinda:=Image2.Picture.Bitmap.ScanLine[j];
      for i:=0 to 255 do
        begin
          rinda[i].rgbtRed:=255;
          rinda[i].rgbtGreen:=255;
          rinda[i].rgbtBlue:=255;
        end;
    end;

  for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
          if (imgres[i,j].I >= vns) and (imgres[i,j].I <= vvs) then
          begin
            imgres[i,j].R:=255; imgres[i,j].G:=255; imgres[i,j].B:=255;
          end else
          begin
            imgres[i,j].R:=0; imgres[i,j].G:=0; imgres[i,j].B:=0;
          end;
        end;

  Image2.Canvas.Pen.Color:= clBlack;

  for i:=0 to 255 do
  begin
    Image2.Canvas.MoveTo(i,100);
    Image2.Canvas.LineTo(i,100-histo[i]);
  end;

  Image2.Canvas.Pen.Color:= clBlue;
  for i:=vns to vvs do
  begin
    Image2.Canvas.MoveTo(i,100);
    Image2.Canvas.LineTo(i,100-histo[i]);
  end;
  Image2.Refresh;

    for j:=0 to High(imgres[0]) do
    begin
      rinda:=Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[i].rgbtRed:=imgres[i,j].R;
          rinda[i].rgbtGreen:=imgres[i,j].G;
          rinda[i].rgbtBlue:=imgres[i,j].B;
        end;
    end;

  Image3.Refresh;

end;

procedure TForm1.Button5Click(Sender: TObject);
var i, j, k, hns, hvs  :Integer;
    rinda: pRGBTripleArray;
begin
  SetLength(imghist, Length(imgres), Length(imgres[0]));
  hns:=StrToInt(Edit4.text);
  hvs:=StrToInt(Edit5.text);

  Image3.Picture.Bitmap.Width:=Length(imgres);
  Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Image3.Picture.Bitmap.PixelFormat:=pf24bit;
  Image2.Canvas.Pen.Color:= clGreen;
  
    for j:=0 to 100 do
    begin
      rinda:=Image2.Picture.Bitmap.ScanLine[j];
      for i:=0 to 255 do
        begin
          rinda[i].rgbtRed:=255;
          rinda[i].rgbtGreen:=255;
          rinda[i].rgbtBlue:=255;
        end;
    end;

  Image2.Canvas.MoveTo(0,100-hns);
  Image2.Canvas.LineTo(255,100-hns);
  Image2.Canvas.MoveTo(0,100-hvs);
  Image2.Canvas.LineTo(255,100-hvs);

   for j:=0 to High(imghist[0]) do
     for i:=0 to High(imghist) do
       begin
         imghist[i,j].R:=0; imghist[i,j].G:=0; imghist[i,j].B:=0;
       end;

      for i:=0 to 255 do
        begin
          if (histo[i] >= hns) and (histo[i] <= hvs) then
          begin
             Image2.Canvas.Pen.Color:= clBlue;
             Image2.Canvas.MoveTo(i,100);
             Image2.Canvas.LineTo(i,100-histo[i]);
             for j:=0 to High(imghist[0]) do
               for k:=0 to High(imghist) do
                 if (imgres[k,j].I = i) then
                   begin
                     imghist[k,j].R:=255; imghist[k,j].G:=255; imghist[k,j].B:=255;
                   end;
          end else
          begin
            Image2.Canvas.Pen.Color:= clBlack;
            Image2.Canvas.MoveTo(i,100);
            Image2.Canvas.LineTo(i,100-histo[i]);
          end;
        end;
        Image2.Refresh;

    for j:=0 to High(imghist[0]) do
    begin
      rinda:=Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imghist) do
        begin
          rinda[i].rgbtRed:=imghist[i,j].R;
          rinda[i].rgbtGreen:=imghist[i,j].G;
          rinda[i].rgbtBlue:=imghist[i,j].B;
        end;
    end;

  Image3.Refresh;

end;

procedure TForm1.roksnis2Click(Sender: TObject);
begin
  Form5.left:=Form1.left+500;
  Form5.top:=Form1.top+200;
  Form5.show;
end;

procedure TForm1.Gludinasana1Click(Sender: TObject);
begin
  Form6.left:=Form1.left+500;
  Form6.top:=Form1.top+200;
  Form6.show;
end;

end.

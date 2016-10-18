unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, JPEG, StdCtrls, Math;

type
  TRGB = record
    R,G,B: Byte;
    I: Integer;
    edge:Integer;//gradienta vertiba
  end;

  THistogram = array[0..256] of record
    I: Integer; //I - number of pixels - frequency
  end;

  TRGBTripleArray = array[word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

  TMain_menu = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    dlgSave1: TSaveDialog;
    Save1: TMenuItem;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Open1Click(Sender: TObject);
    procedure ReadFromBMP();
    procedure imgToImage1(a:integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
        Y: Integer);
    procedure DrawHistogram(HRGB: THistogram);
    procedure Normalize(var Histogram: THistogram; RGBnumber, ORstart,
        ORend: Integer);
  {  procedure Normalize2(var HR, HG, HB: THistogram; RGBnumber, ORstart,
        ORend: Integer);         }
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main_menu: TMain_menu;
  img, temp: array of array of TRGB;
  bmp: TBitmap;
  jpg: TJPEGImage;
  rgbhist, HR, HG, HB: THistogram;
  Hstart,Hend, Mi6start, Mi6end: Integer; //histogram start and end values

implementation

{$R *.dfm}

procedure TMain_menu.FormCreate(Sender: TObject);
begin
  bmp:=TBitmap.Create;
  jpg:=TJPEGImage.Create;
end;

procedure TMain_menu.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label1.Caption :=IntToStr(X);
end;

procedure TMain_menu.Button1Click(Sender: TObject);
begin
  RadioGroup1.ItemIndex:=0;
  Hstart := StrToInt(edit1.text);
  Hend := StrToInt(edit2.text);
  Normalize(rgbhist, 1, Hstart, Hend);
  imgToImage1(1);
  DrawHistogram(rgbhist);
end;

procedure TMain_menu.Button2Click(Sender: TObject);
begin
  imgToImage1(2);
  ReadFromBMP;
        case Radiogroup1.itemindex of
      0: begin
           DrawHistogram(rgbhist);
         end;
      1: begin
           DrawHistogram(HR);
         end;
      2: begin
           DrawHistogram(HG);
         end;
      3: begin
           DrawHistogram(HB);
         end;
      end;
  Hstart := -1;
  Hend := 256;
end;

procedure TMain_menu.DrawHistogram(HRGB: THistogram);
var
  i,j: integer;
  row: pRGBTripleArray;
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  Bitmap.Width:=256;
  Bitmap.Height:=100;
  Bitmap.PixelFormat:=pf24bit;

  for j:=0 to Bitmap.Height-1 do
  begin
    row:=Bitmap.ScanLine[j];
    for i:=0 to Bitmap.Width-1 do
    begin
      if j<(100-round(hrgb[i].I/hrgb[256].I*100)) then
      begin
        row[i].rgbtRed:=200;
        row[i].rgbtGreen:=200;
        row[i].rgbtBlue:=200;
      end
      else
      begin
        row[i].rgbtRed:=0;
        row[i].rgbtGreen:=0;
        row[i].rgbtBlue:=0;
      end;
    end;
  end;
  Image2.Picture.Graphic := Bitmap;
  Bitmap.Free;
end;

procedure TMain_menu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
  jpg.Free;
end;

procedure TMain_menu.Open1Click(Sender: TObject);
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
    DrawHistogram(rgbhist);
end;

procedure TMain_menu.ReadFromBMP();
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  SetLength(img, bmp.Width, bmp.Height);
  SetLength(temp, bmp.Width, bmp.Height);

  for i:=0 to 256 do
  begin
    rgbhist[i].I:=0;
    HR[i].I:=0;
    HG[i].I:=0;
    HB[i].I:=0;
  end;

  for j:=0 to bmp.Height-1 do
    begin
      rinda:=bmp.ScanLine[j];
      for i:=0 to bmp.Width-1 do
        begin
          img[i,j].R:=rinda[i].rgbtRed;
          img[i,j].G:=rinda[i].rgbtGreen;
          img[i,j].B:=rinda[i].rgbtBlue;
          //intensity for every pixel
          img[i,j].I := ((77*img[i,j].R + 150*img[i,j].G +
              29*img[i,j].B) div 256);
          //HRGB
          rgbhist[img[i,j].I].I:=rgbhist[img[i,j].I].I+1;
          // Histograma katram kanalam
          HR[img[i,j].R].I:=HR[img[i,j].R].I+1;
          HG[img[i,j].G].I:=HG[img[i,j].G].I+1;
          HB[img[i,j].B].I:=HB[img[i,j].B].I+1;

          temp[i,j].R:=rinda[i].rgbtRed;
          temp[i,j].G:=rinda[i].rgbtGreen;
          temp[i,j].B:=rinda[i].rgbtBlue;
          //intensity for every pixel
          temp[i,j].I := ((77*temp[i,j].R + 150*temp[i,j].G +
              29*temp[i,j].B) div 256);
          //HRGB
          rgbhist[temp[i,j].I].I:=rgbhist[temp[i,j].I].I+1;
        end;
    end;

    for i:=0 to 256 do
    begin
      rgbhist[256].I:=Max(rgbhist[256].I, rgbhist[i].I);
      HR[256].I:=Max(HR[256].I, HR[i].I);
      HG[256].I:=Max(HG[256].I, HG[i].I);
      HB[256].I:=Max(HB[256].I, HB[i].I);
    end;
end;

procedure TMain_menu.imgToImage1(a:integer);
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
        case a of
        0: begin
         rinda[i].rgbtRed:=img[i,j].R;
         rinda[i].rgbtGreen:=img[i,j].G;
         rinda[i].rgbtBlue:=img[i,j].B;
        end;
        1: begin
         rinda[i].rgbtRed:=img[i,j].I;
         rinda[i].rgbtGreen:=img[i,j].I;
         rinda[i].rgbtBlue:=img[i,j].I;
        end;
        2: begin
         rinda[i].rgbtRed:=temp[i,j].R;
         rinda[i].rgbtGreen:=temp[i,j].G;
         rinda[i].rgbtBlue:=temp[i,j].B;
        end;
           3: begin
         rinda[i].rgbtRed:=img[i,j].edge;
         rinda[i].rgbtGreen:=img[i,j].edge;
         rinda[i].rgbtBlue:=img[i,j].edge;
        end;
         4: begin
         rinda[i].rgbtRed:=img[i,j].edge;
         rinda[i].rgbtGreen:=img[i,j].edge;
         rinda[i].rgbtBlue:=img[i,j].edge;
        end;
         5: begin
         rinda[i].rgbtRed:=img[i,j].edge;
         rinda[i].rgbtGreen:=img[i,j].edge;
         rinda[i].rgbtBlue:=img[i,j].edge;
        end;
        end;
      end;
    end;
  Image1.Refresh;
end;

procedure TMain_menu.Normalize(var Histogram: THistogram; RGBnumber, ORstart,
  ORend: Integer);
var
  OriginalRange, StretchedRange, Intensity, i,j: Integer;
  ScaleFactor: Real;
  Hir, Hib, Hig :THistogram;
begin
  repeat
    inc(ORstart);
  until Histogram[ORstart].I>0;

  repeat
    dec(ORstart);
  until Histogram[ORend].I>0;

  OriginalRange := ORend - ORstart;
  StretchedRange := 255;

  if OriginalRange=0 then OriginalRange := 1;

  ScaleFactor := StretchedRange / OriginalRange;

  for i:=0 to 256 do
  begin
    Histogram[i].I := 0;
    Hir[i].I:=0;
    Hig[i].I:=0;
    Hib[i].I:=0;
  end;

  for i:=0 to High(img) do
    for j:=0 to High(img[0]) do
    begin
      if RGBnumber=1 then // Monohroms
      begin
        Intensity := Round(ScaleFactor*(img[i,j].I - ORstart));
        if Intensity>255 then Intensity:=255;
        if Intensity<0 then Intensity:=0;
        img[i,j].I:=Intensity;
        inc(histogram[intensity].I);
      end;

      if RGBnumber=2 then //RED, BLUE, GREEN
      begin
        Intensity := Round(ScaleFactor*(img[i,j].R - ORstart));
        if Intensity>255 then Intensity:=255;
        if Intensity<0 then Intensity:=0;
        img[i,j].R:=Intensity;
        inc(Hir[intensity].I);

        Intensity := Round(ScaleFactor*(img[i,j].G - ORstart));
        if Intensity>255 then Intensity:=255;
        if Intensity<0 then Intensity:=0;
        img[i,j].G:=Intensity;
        inc(Hig[intensity].I);

        Intensity := Round(ScaleFactor*(img[i,j].B - ORstart));
        if Intensity>255 then Intensity:=255;
        if Intensity<0 then Intensity:=0;
        img[i,j].B:=Intensity;
        inc(Hib[intensity].I);

      end;

    end;

    // Kada kanala histogrammu attelot
      case Radiogroup1.itemindex of
      0: begin
          //
         end;
      1: begin
           histogram:=Hir;
         end;
      2: begin
           histogram:=Hig;
         end;
      3: begin
           histogram:=Hib;
         end;
      end;
    // Maksimalais pikselu skaits ar vienadu intensitati
      for i:= 0 to 256 do
        histogram[256].I:=Max(histogram[256].I,histogram[i].I);

end;

procedure TMain_menu.Button3Click(Sender: TObject); // algoritms krasainiem atteliem
begin
  if RadioGroup1.ItemIndex = 0 then RadioGroup1.ItemIndex:=1;
  Hstart := StrToInt(edit1.text);
  Hend := StrToInt(edit2.text);
  Normalize(rgbhist, 2, Hstart, Hend);
  imgToImage1(0);
  DrawHistogram(rgbhist);
end;

procedure TMain_menu.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mi6end:=X;    // histogramas augstas robezas noteiksana ar peles palidzibu
  Edit1.Text:=InttoStr(mi6start);
  Edit2.Text:=InttoStr(mi6end);
end;

procedure TMain_menu.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   mi6start:=X;  // histogramas zemas robezas noteiksana ar peles palidzibu
   Edit1.Text:=IntToStr(mi6start);
end;

procedure TMain_menu.Button4Click(Sender: TObject);
var i,j:integer;
begin                             //Roberts
 for i:=1 to high(img)-1 do
 for  j:=1 to high(img[0]) do
     begin
        img[i,j].edge:=round(
        Power(
        Power(img[i,j].i-img[i+1,j+1].i,2)
        +Power(img[i,j+1].i-img[i+1,j].i,2),1/2));

     end;
     imgToImage1(3);
end;

procedure TMain_menu.Button5Click(Sender: TObject);
var i,j,k,gx,gy:integer;
begin                              //  previta
k:=1;
 for i:=1 to high(img)-1 do
 for  j:=1 to high(img[0]) do
     begin

       Gx:= round(
      (1/(k+2))*((img[i+1,j+1].I + k*img[i+1,j].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+k*img[i-1,j].i+img[i-1,j-1].i)));

       Gy:= round(
        (1/(k+2))*((img[i-1,j-1].I+ k*img[i+1,j-1].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+k*img[i,j+1].i+img[i+1,j+1].i)));

       img[i,j].edge:=round( Power(Power(Gx,2)+Power(Gy,2),1/2));

     end;
     imgToImage1(4);

end;
procedure TMain_menu.Button6Click(Sender: TObject);
var i,j,k,gx,gy:integer;
begin                              //  sobela
k:=2;
 for i:=1 to high(img)-1 do
 for  j:=1 to high(img[0]) do
     begin

       Gx:= round(
      (1/(k+2))*((img[i+1,j+1].I + k*img[i+1,j].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+k*img[i-1,j].i+img[i-1,j-1].i)));

       Gy:= round(
        (1/(k+2))*((img[i-1,j-1].I+ k*img[i+1,j-1].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+k*img[i,j+1].i+img[i+1,j+1].i)));

       img[i,j].edge:=round( Power(Power(Gx,2)+Power(Gy,2),1/2));

     end;
     imgToImage1(5);

         end;
procedure TMain_menu.Button7Click(Sender: TObject);
var i,j,k,gx,gy:integer;
begin                              //  sobela
k:=2;
 for i:=1 to high(img)-1 do
 for  j:=1 to high(img[0]) do
     begin

       Gx:= round(
      (1/((Power(k,1/2))+2))*((img[i+1,j+1].I + (Power(k,1/2))*img[i+1,j].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+(Power(k,1/2))*img[i-1,j].i+img[i-1,j-1].i)));

       Gy:= round(
        (1/((Power(k,1/2))+2))*((img[i-1,j-1].I+ (Power(k,1/2))*img[i+1,j-1].i + img[i+1,j-1].i )
        - (img[i-1,j+1].i+(Power(k,1/2))*img[i,j+1].i+img[i+1,j+1].i)));

       img[i,j].edge:=round( Power(Power(Gx,2)+Power(Gy,2),1/2));

     end;
     imgToImage1(6);

         end;

procedure TMain_menu.Save1Click(Sender: TObject);
var l:Integer;
begin
 l:=1;
  If dlgSave1.Execute then begin
  if dlgSave1.FilterIndex  = l then   begin
  JPG.Assign(Image1.Picture.Bitmap);
  JPG.SaveToFile(dlgSave1.FileName + '.jpg')
  end
  else
   BMP.Assign(Image1.Picture.Bitmap);
  BMP.SaveToFile(dlgSave1.FileName + '.bmp');

  end;
  end;

end.

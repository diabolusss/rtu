unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, JPEG, StdCtrls,Math;

type
  TStack= array of record
  x,y:integer;
  end;
  TBug= record
    x,y,dir:integer;
    end;
  TRGB = record
    R,G,B: Byte;
    edge,edgeR,edgeG,edgeB: integer;
    int:integer;//intensitaate
    segment:integer;
  end;
  THistogram=array[0..256] of record
    I:Integer;//intensitaate
    end;

  TRGBTripleArray = array[word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Button4: TButton;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Image3: TImage;
    RadioGroup1: TRadioGroup;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Button5: TButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Panel3: TPanel;
    Panel2: TPanel;
    Label16: TLabel;
    Button6: TButton;
    Button7: TButton;
    RadioGroup2: TRadioGroup;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Open1Click(Sender: TObject);
    procedure ReadFromBMP();
    procedure imgToImage1(a:integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DrawHistogram(HRGB:THistogram);
    procedure Normalize(var Histogram:THistogram; RGBnumber, OrStart,OrEnd:integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label7Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  img,temp: array of array of TRGB;
  bmp: TBitmap;
  jpg: TJPEGImage;
  rgbhist:THistogram;
  H_start,H_end:integer;//histogr diapaz vertibas
  HistposX,HistposY,ImagePosX,ImagePosY:integer;
  Sakuma_punkts:Tstack;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp:=TBitmap.Create;
  jpg:=TJPEGImage.Create;
  HistPosx:=0;
  HistPosy:=0;
  ImageposX:=0;
  ImageposY:=0;
  Image1.Visible:=false;
    Image2.Visible:=false;
    Label7.Visible:=false;
    Label8.Visible:=false;
    Label9.Visible:=false;
    Label8.Caption:='Pixels selected: 0';
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
    Image1.Visible:=true;
    Image2.Visible:=true;
    Label7.Visible:=true;
    Label8.Visible:=true;
    Label9.Visible:=true;
    Label8.Caption:='Pixels selected: 0';
    Label9.Caption:='Atrasti objekti: 0';
    DrawHistogram(rgbhist);
end;


procedure TForm1.ReadFromBMP();
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  SetLength(img, bmp.Width, bmp.Height);
  SetLength(temp,bmp.Width,bmp.Height);
  for i:=0 to 256 do
    rgbhist[i].I:=0;//attiiram iepr veertiibas

  for j:=0 to bmp.Height-1 do
    begin
      rinda:=bmp.ScanLine[j];
      for i:=0 to bmp.Width-1 do
        begin
        //sakuma parbaude
           img[i,j].segment:=0;
          img[i,j].R:=rinda[i].rgbtRed;
          img[i,j].G:=rinda[i].rgbtGreen;
          img[i,j].B:=rinda[i].rgbtBlue;
          //izskaitljoam intens katram px
          img[i,j].int:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;

          temp[i,j].R:=rinda[i].rgbtRed;
          temp[i,j].G:=rinda[i].rgbtGreen;
          temp[i,j].B:=rinda[i].rgbtBlue;
          //izskaitljoam intens katram px
          temp[i,j].int:=(77*temp[i,j].R+150*temp[i,j].G+29*temp[i,j].B)div 256;

        //  rgbhist[img[i,j].int].I:=
          inc(rgbhist[img[i,j].int].I);//vai vnk tas pats +1

        end;
    end;
    for i:=0 to 256 do
      rgbhist[256].I:=Max( rgbhist[256].I,rgbhist[i].I);
end;

procedure TForm1.imgToImage1(a:integer);
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  Image1.Width:=Length(img);
  Image2.Height:=Length(img[0]);
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
         case a of
          0:begin
          rinda[i].rgbtRed:=img[i,j].R;
          rinda[i].rgbtGreen:=img[i,j].G;
          rinda[i].rgbtBlue:=img[i,j].B;
          end;
           1:begin
           rinda[i].rgbtRed:=img[i,j].int;
           rinda[i].rgbtGreen:=img[i,j].int;
           rinda[i].rgbtBlue:=img[i,j].int;
         end;
          2:begin
           rinda[i].rgbtRed:=temp[i,j].r;
           rinda[i].rgbtGreen:=temp[i,j].g;
           rinda[i].rgbtBlue:=temp[i,j].b;
         end;
        end;
    end;
  end;
  Image1.Refresh;    
end;
procedure TForm1.Image2Click(Sender: TObject);
begin
if (edit1.Focused=true) then
edit1.Text:=InttoStr(histposX);
if (edit2.focused=true) then
edit2.Text:=Inttostr(HistposX);
end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Label1.Caption:='Levels'+IntToStr(x);
  HistposX:=x;
end;

procedure TForm1.DrawHistogram(HRGB: THistogram);
var i,j:integer;
    row:pRGBTripleArray;
    Bitmap:TBitmap;
begin
    Bitmap:=TBitmap.Create;
    Bitmap.Width:=256;
    Bitmap.Height:=100;
    Bitmap.PixelFormat:=pf24bit;

    for j:=0 to Bitmap.Height-1 do
      begin
          row:=Bitmap.ScanLine[j];
            for i:=0 to Bitmap.Width do
              begin
                  if j<=(100-round(HRGB[i].I/HRGB[256].i*100)) then
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
      Image2.Picture.Graphic:=Bitmap;
      Bitmap.Free;
end;



procedure TForm1.Normalize(var Histogram: THistogram; RGBnumber, OrStart,
  OrEnd: integer);
  var OriginalRange,StretchedRange,Intensity,Ir,Ig,Ib,i,j:integer;
  ScaleFactor:real;
begin
      Repeat
        inc(OrStart);
      until Histogram[OrStart].i>0 ;

      Repeat
        dec(OrEnd);
      until Histogram[OrEnd].i>0 ;

      OriginalRange:=OrEnd-OrStart;
      StretchedRange:=255;

      if OriginalRange=0 then OriginalRange:=1;

      ScaleFactor:=StretchedRange/OriginalRange;

      for i:=0 to 256 do
        Histogram[i].I:=0;     //attiiriijaam

        for i:=0 to High(img) do
          for j:=0 to High(img[0]) do
            begin
                if RGBnumber=1 then //intensity
                  begin
                     Intensity:=Round(ScaleFactor*(img[i,j].int-OrStart));

                     if Intensity>255 then Intensity:=255;
                     if Intensity<0 then Intensity:=0;
                     img[i,j].int:=Intensity;
                  end;
                if RGBnumber=2 then //intensity
                  begin
                  //red
                     Ir:=Round(ScaleFactor*(img[i,j].r-OrStart));
                     if Ir>255 then Ir:=255;
                     if Ir<0 then Ir:=0;
                     img[i,j].r:=Ir;
                  //green
                     Ig:=Round(ScaleFactor*(img[i,j].g-OrStart));
                     if Ig>255 then Ig:=255;
                     if Ig<0 then Ig:=0;
                     img[i,j].g:=Ig;
                  //blue
                     Ib:=Round(ScaleFactor*(img[i,j].b-OrStart));
                     if Ib>255 then Ib:=255;
                     if Ib<0 then Ib:=0;
                     img[i,j].b:=Ib;
                  img[i,j].int:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;
                  end; //if beidzas
                inc(histogram[img[i,j].int].I);
               end; //for iunj
                  for i:=0 to 256 do
                    Histogram[256].I:=Max(Histogram[256].i,Histogram[i].I);
                  //if rgbnumber=2 then RED green blue etc.


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  H_Start:=strtoint(edit1.Text)-1;
  H_End:=strtoint(edit2.Text)+1;
  Normalize(rgbhist,1,H_Start,H_End);
  ImgToImage1(1);//izvadam
  DrawHistogram(rgbhist);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ImgToImage1(2);
  ReadFromBMP;
  DrawHistogram(rgbhist);
  H_Start:=strtoint(edit1.Text)-1;
  H_End:=strtoint(edit2.Text)+1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  H_Start:=strtoint(edit1.Text)-1;
  H_End:=strtoint(edit2.Text)+1;
  Normalize(rgbhist,2,H_Start,H_End);
  ImgToImage1(0);//izvadam
  DrawHistogram(rgbhist);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
ImageposX:=x;
ImageposY:=y;
Label7.Caption:='Position x:'+IntToStr(x)+'; y:'+IntToStr(y)+';';
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
//uz klikski izvelas segmentu
end;

procedure TForm1.Image1Click(Sender: TObject);
var s:TStack;
x,y,i,j,k,sum:integer;
rinda: pRGBTripleArray;
T:integer;

begin
//sagatavo steku ar sakuma lielumiem
SetLength(S,1);
S[0].x:=imageposX;
S[0].y:=imageposY;
T:=strtoint(edit5.Text);
IMG[imageposX,imageposY].segment:=1;
// parbauda kaiminus
//te jabut ciklam un nosacijumam
k:=0;

repeat
x:= s[0].x;
y:= s[0].y;

for j:=-1 to 1 do
for i:=-1 to 1 do
begin
//Nosaka piederibu pec intensitates parbauda attela robezas
if ((x+i>0)AND(x+i<Length(img))AND(y+j>0)AND(y+j<Length(img[0])))then
begin
if (Abs(IMG[x,y].int-IMG[x+i,y+j].int)<T) And (IMG[x+i,y+j].segment=0)then
begin
Inc(k);
SetLength(S,k+1);
IMG[x+i,y+j].segment:=1;
s[k].x:=x+i;
s[k].y:=y+j;
end
else
if IMG[x+i,y+j].segment=0 then
IMG[x+i,y+j].segment:=-1;
end; //for iunj
end;//if robezas
 if k<>0 then
  begin
//Parlasa steka masiivu
for i:=0 to k-1 do
begin
  S[i]:=S[i+1];
end;
SetLength(S,k);
end;
  dec(k);
until k<0;//segmentesanas beigu nosacijums

//Notira histogrammu
for i:=0 to 256 do
rgbhist[i].I:=0;
//Attelo segmenteto

begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  sum:=0;
  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
          if img[i,j].segment=1 then
            begin
              img[i,j].R:=0;
              img[i,j].G:=0;
              img[i,j].B:=0;
              Inc(sum);
            end;
              rinda[i].rgbtRed:=img[i,j].R;
              rinda[i].rgbtGreen:=img[i,j].G;
              rinda[i].rgbtBlue:=img[i,j].B;
              img[i,j].int:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;
              inc(rgbhist[img[i,j].int].I);
    end;
  end;
  Image1.Refresh;
end;//attelosana
//histogramma parzimeta
for i:=0 to 256 do
rgbhist[256].I:=Max( rgbhist[256].I,rgbhist[i].I);

DrawHistogram(rgbhist);
Label8.Caption:='Pixels selected: '+IntToStr(sum);
end;//funkcija

//Skenesanas funkcija

procedure TForm1.Button4Click(Sender: TObject);
var objekti: array of integer;
i,j,k,T,garums,intensity:integer;
hit:bool;

begin
//Sakuma pirmo pixeli uzstada ka pirmo objektu
 Setlength(objekti,1);
 Setlength(Sakuma_punkts,1);
garums:=0;
T:=StrToInt(edit5.Text);
Intensity:=(77*STRTOINT(edit4.Text)+150*STRTOINT(edit6.Text)+29*STRTOINT(edit7.Text))div 256;
 for j:=0 to High(img[0]) do
      for i:=0 to High(img) do
       begin
       hit:=false;
         for k:=0 to Length(objekti) do
         begin
        //Nosacijuma izpildes bloks
        if (Abs(IMG[i,j].int-objekti[k])<T) then
        begin
        hit:=true;
        if img[i,j].int<>intensity then
        begin
         IMG[i,j].R:=0;
         IMG[i,j].G:=0;
         IMG[i,j].B:=0;
         img[i,j].int:=0;
        end; //
        end;//ifam sakrit
         end;// for k
         
    if hit=false then
       begin
       if img[i,j].int<>intensity then
        begin
        inc(garums);
        SetLength(objekti,garums);
        SetLength(Sakuma_punkts,garums);
        objekti[garums-1]:=IMG[i,j].int;
        Sakuma_punkts[garums-1].x:=i;
        Sakuma_punkts[garums-1].y:=j;
        //
         IMG[i,j].R:=0;
         IMG[i,j].G:=0;
         IMG[i,j].B:=0;
         Img[i,j].int:=255;
        end; //
       end;//if hit

 end;//for iunj
  Label9.caption:='Atrasti objekti: '+IntToStr(garums);
  ImgtoImage1(0);
  
end;//funkcija button4click

procedure TForm1.Exit1Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  SaveDialog1 : TSaveDialog;    // Save dialog variable
  filename : String;
begin
  // Create the save dialog object - assign to our save dialog variable
  SaveDialog1 := TSaveDialog.Create(self);

  // Give the dialog a title
  SaveDialog1.Title := 'Attela saglabasana';

  // Set up the starting directory to be the current one
  SaveDialog1.InitialDir := GetCurrentDir;

  // Allow only .txt and .doc file types to be saved
  SaveDialog1.Filter := 'JPEG Image|*.jpg|Bitmap Image|*.bmp';

  // Set the default extension
  SaveDialog1.DefaultExt := 'jpg';

  // Select text files as the starting filter type
  SaveDialog1.FilterIndex := 1;

  // Display the open file dialog
  if SaveDialog1.Execute
  then
  begin
   filename :=  SaveDialog1.FileName;
   if AnsiUpperCase(ExtractFileExt(SaveDialog1.FileName)) = '.JPG' then
    begin
      try
        jpg:=TJpegImage.Create;
        jpg.Assign(Image1.Picture.Graphic);
        jpg.CompressionQuality:=90;
        jpg.Compress;
        jpg.SaveToFile(filename);
    finally
      jpg.Free
    end;
  end
  else
   if AnsiUpperCase(ExtractFileExt(SaveDialog1.FileName)) = '.BMP' then
    begin
      try
      bmp.Assign(Image1.Picture.Graphic);
      bmp.SaveTofile(filename);
    finally
      bmp.Free
    end;
    end;
    ShowMessage('File : '+SaveDialog1.FileName+' have been saved');

  end
  else ShowMessage('Save file was cancelled');

  // Free up the dialog
  SaveDialog1.Free;
 end;
procedure TForm1.Button5Click(Sender: TObject);
var i,j,rx,gx,bx,ry,gy,by:integer;
rinda: pRGBTripleArray;
begin
//Intensitate
 for i:=1 to high(img)-1 do
    for j:= 1 to high(img[0]) do
      begin
        //Notira ieprieksejo
        img[i,j].edgeR:=0;
        img[i,j].edgeG:=0;
        img[i,j].edgeb:=0;
        img[i,j].edge:=0;
       case RadioGroup1.ItemIndex of
       1: begin  //Roberts color

        img[i,j].edgeR:=round(Power(Power(img[i,j].R-img[i+1,j+1].R,2)+
                             Power(img[i,j+1].R-img[i+1,j].R,2),1/2));
        img[i,j].edgeG:=round(Power(Power(img[i,j].G-img[i+1,j+1].G,2)+
                             Power(img[i,j+1].G-img[i+1,j].G,2),1/2));
        img[i,j].edgeB:=round(Power(Power(img[i,j].B-img[i+1,j+1].B,2)+
                             Power(img[i,j+1].B-img[i+1,j].B,2),1/2));
          end;
       0: begin //Roberts BW

        img[i,j].edge:=round(Power(Power(img[i,j].int-img[i+1,j+1].int,2)+
                             Power(img[i,j+1].int-img[i+1,j].int,2),1/2));
          end;

       2: begin //Prewitt

          rx:=Round(1/3*(( img[i+1,j+1].R+img[i+1,j].R+img[i+1,j-1].R)-(img[i-1,j+1].R+img[i-1,j].R+img[i-1,j-1].R)));
          ry:=Round(1/3*(( img[i-1,j-1].R+img[i,j-1].R+img[i+1,j-1].R)-(img[i-1,j+1].R+img[i,j+1].R+img[i+1,j+1].R)));
          img[i,j].edgeR:= Round(Power(Power(Rx,2)+Power(Ry,2)  ,1/2));

          gx:=Round(1/3*(( img[i+1,j+1].g+img[i+1,j].g+img[i+1,j-1].g)-(img[i-1,j+1].g+img[i-1,j].g+img[i-1,j-1].g)));
          gy:=Round(1/3*(( img[i-1,j-1].g+img[i,j-1].g+img[i+1,j-1].g)-(img[i-1,j+1].g+img[i,j+1].g+img[i+1,j+1].g)));
          img[i,j].edgeG:= Round(Power(Power(Gx,2)+Power(Gy,2) ,1/2));

          bx:=Round(1/3*(( img[i+1,j+1].b+img[i+1,j].b+img[i+1,j-1].b)-(img[i-1,j+1].b+img[i-1,j].b+img[i-1,j-1].b)));
          by:=Round(1/3*(( img[i-1,j-1].b+img[i,j-1].b+img[i+1,j-1].b)-(img[i-1,j+1].b+img[i,j+1].b+img[i+1,j+1].b)));
          img[i,j].edgeB:= Round(Power(Power(Bx,2)+Power(By,2) ,1/2));
          end;

       3: begin //Sobel
       
          rx:=Round(1/4*(( img[i+1,j+1].R+2*img[i+1,j].R+img[i+1,j-1].R)-(img[i-1,j+1].R+2*img[i-1,j].R+img[i-1,j-1].R)));
          ry:=Round(1/4*(( img[i-1,j-1].R+2*img[i,j-1].R+img[i+1,j-1].R)-(img[i-1,j+1].R+2*img[i,j+1].R+img[i+1,j+1].R)));
          img[i,j].edgeR:= Round(Power(Power(Rx,2)+Power(Ry,2)  ,1/2));

          gx:=Round(1/4*(( img[i+1,j+1].g+2*img[i+1,j].g+img[i+1,j-1].g)-(img[i-1,j+1].g+2*img[i-1,j].g+img[i-1,j-1].g)));
          gy:=Round(1/4*(( img[i-1,j-1].g+2*img[i,j-1].g+img[i+1,j-1].g)-(img[i-1,j+1].g+2*img[i,j+1].g+img[i+1,j+1].g)));
          img[i,j].edgeG:= Round(Power(Power(Gx,2)+Power(Gy,2) ,1/2));

          bx:=Round(1/4*(( img[i+1,j+1].b+2*img[i+1,j].b+img[i+1,j-1].b)-(img[i-1,j+1].b+2*img[i-1,j].b+img[i-1,j-1].b)));
          by:=Round(1/4*(( img[i-1,j-1].b+2*img[i,j-1].b+img[i+1,j-1].b)-(img[i-1,j+1].b+2*img[i,j+1].b+img[i+1,j+1].b)));
          img[i,j].edgeB:= Round(Power(Power(Bx,2)+Power(By,2) ,1/2));
          end;
          
       4: begin //Frei-Chen

          rx:=Round(1/(Sqrt(2)+2)*(( img[i+1,j+1].R+Sqrt(2)*img[i+1,j].R+img[i+1,j-1].R)-(img[i-1,j+1].R+Sqrt(2)*img[i-1,j].R+img[i-1,j-1].R)));
          ry:=Round(1/(Sqrt(2)+2)*(( img[i-1,j-1].R+Sqrt(2)*img[i,j-1].R+img[i+1,j-1].R)-(img[i-1,j+1].R+Sqrt(2)*img[i,j+1].R+img[i+1,j+1].R)));
          img[i,j].edgeR:= Round(Power(Power(Rx,2)+Power(Ry,2)  ,1/2));

          gx:=Round(1/(Sqrt(2)+2)*(( img[i+1,j+1].g+Sqrt(2)*img[i+1,j].g+img[i+1,j-1].g)-(img[i-1,j+1].g+Sqrt(2)*img[i-1,j].g+img[i-1,j-1].g)));
          gy:=Round(1/(Sqrt(2)+2)*(( img[i-1,j-1].g+Sqrt(2)*img[i,j-1].g+img[i+1,j-1].g)-(img[i-1,j+1].g+Sqrt(2)*img[i,j+1].g+img[i+1,j+1].g)));
          img[i,j].edgeG:= Round(Power(Power(Gx,2)+Power(Gy,2) ,1/2));

          bx:=Round(1/(Sqrt(2)+2)*(( img[i+1,j+1].b+Sqrt(2)*img[i+1,j].b+img[i+1,j-1].b)-(img[i-1,j+1].b+Sqrt(2)*img[i-1,j].b+img[i-1,j-1].b)));
          by:=Round(1/(Sqrt(2)+2)*(( img[i-1,j-1].b+Sqrt(2)*img[i,j-1].b+img[i+1,j-1].b)-(img[i-1,j+1].b+Sqrt(2)*img[i,j+1].b+img[i+1,j+1].b)));
          img[i,j].edgeB:= Round(Power(Power(Bx,2)+Power(By,2) ,1/2));
          end;
    end;
    end;//for iunj
//Attelo
if Image1.Picture.Bitmap.Empty = False then
begin
    Image3.Picture.Bitmap.Width :=Length(img);
    Image3.Picture.Bitmap.Height := Length(img[0]);
    Image3.Picture.Bitmap.PixelFormat := pf24bit;
  for j:=0 to High(img[0]) do
    begin
        rinda:=Image3.Picture.Bitmap.ScanLine[j];
        for i:=0 to High(img) do
          begin
          if radiogroup1.itemindex=0 then
          begin
             if checkbox1.checked=true then
               begin
               //melnbaltais gradients
                if strtoint(edit3.Text)> img[i,j].edge then
                begin
                  rinda[i].rgbtRed:=0;
                  rinda[i].rgbtGreen:=0;
                  rinda[i].rgbtBlue:=0;
                end
                else
                begin
                  rinda[i].rgbtRed:=255;
                  rinda[i].rgbtGreen:=255;
                  rinda[i].rgbtBlue:=255;
                end; //gradienta if
               end
             else
             begin
                  //melnbaltais bez gradienta
                 rinda[i].rgbtRed:=img[i,j].edge;
                 rinda[i].rgbtGreen:=img[i,j].edge;
                 rinda[i].rgbtBlue:=img[i,j].edge;
             end;//if checkbox
          end//if melnbalts
          else
          begin//Krasains
            if checkbox1.checked=true then
               begin
               //krasains gradients
               //R komponente
                if strtoint(edit3.Text)> img[i,j].edgeR then
                begin
                  rinda[i].rgbtRed:=0;
                end
                else
                begin
                  rinda[i].rgbtRed:=255;
                end; //gradienta if

                 //G komponente
                if strtoint(edit3.Text)> img[i,j].edgeG then
                begin
                  rinda[i].rgbtGreen:=0;
                end
                else
                begin
                  rinda[i].rgbtGreen:=255;
                end; //gradienta if

                 //B komponente
                if strtoint(edit3.Text)> img[i,j].edgeB then
                begin
                  rinda[i].rgbtBlue:=0;
                end
                else
                begin
                  rinda[i].rgbtBlue:=255;
                end; //gradienta if
               end
             else
             begin
                  //krasains bez gradienta
                 rinda[i].rgbtRed:=img[i,j].edgeR;
                 rinda[i].rgbtGreen:=img[i,j].edgeG;
                 rinda[i].rgbtBlue:=img[i,j].edgeB;
             end;//if checkbox
          end;//if krasains
          end; // end for i
    end;  //end for j
    Image3.Refresh;
  end; //end check if image is there
end; //funkcija

procedure TForm1.Edit1Change(Sender: TObject);
var i,j:integer;
rinda:pRGBTripleArray;
begin
    DrawHistogram(rgbhist);
    Image2.Picture.Bitmap.Width:=256;
    Image2.Picture.Bitmap.Height:=100;
    Image2.Picture.Bitmap.PixelFormat:=pf24bit;

    for j:=0 to Image2.Picture.Bitmap.Height-1 do
      begin
      rinda:=Image2.Picture.Bitmap.ScanLine[j];
      for i:=0 to Image2.Picture.Bitmap.Width-1 do
        begin
          if ((i=StrtoInt(edit2.Text))OR(i=StrtoInt(edit1.Text))) then   //fonaa buusim iekshaa

            begin
               rinda[i].rgbtRed:=255;
               rinda[i].rgbtGreen:=0;
               rinda[i].rgbtBlue:=0;
            end
          else
          begin
               rinda[i].rgbtRed:= rinda[i].rgbtRed;
               rinda[i].rgbtGreen:= rinda[i].rgbtGreen;
               rinda[i].rgbtBlue:= rinda[i].rgbtblue;
          end;

        end;
end;
Image2.Refresh; //Attels tiek atjaunots
end;

procedure TForm1.Edit2Change(Sender: TObject);
var i,j:integer;
rinda:pRGBTripleArray;
begin
    DrawHistogram(rgbhist);
    Image2.Picture.Bitmap.Width:=256;
    Image2.Picture.Bitmap.Height:=100;
    Image2.Picture.Bitmap.PixelFormat:=pf24bit;

    for j:=0 to Image2.Picture.Bitmap.Height-1 do
      begin
      rinda:=Image2.Picture.Bitmap.ScanLine[j];
      for i:=0 to Image2.Picture.Bitmap.Width-1 do
        begin
          if (i=StrtoInt(edit2.Text))OR(i=StrtoInt(edit1.Text)) then   //fonaa buusim iekshaa

            begin
               rinda[i].rgbtRed:=255;
               rinda[i].rgbtGreen:=0;
               rinda[i].rgbtBlue:=0;
            end
          else
          begin
               rinda[i].rgbtRed:= rinda[i].rgbtRed;
               rinda[i].rgbtGreen:= rinda[i].rgbtGreen;
               rinda[i].rgbtBlue:= rinda[i].rgbtblue;
          end;

        end;
end;
Image2.Refresh;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.checked=true then
form1.edit3.enabled:=true
else
form1.edit3.enabled:=false;
end;

//Kukaina kustibu funkcijas
//Dir:virziens. vertibas:
//1:up, 2:down,3:left,4:right
function Turn_right (x,y,dir:integer):tbug;
  begin
    case dir of
      1:begin
        result.dir:=4;
        Inc(x);
      end;
      2:begin
        result.dir:=3;
        Dec(x);
      end;
      3:begin
        result.dir:=1;
        Dec(y);
      end;
      4:begin
        result.dir:=2;
        Inc(y);
      end;
    end;//case
    result.x:=x;
    result.y:=y;
  end; //function

function Turn_left (x,y,dir:integer):tbug;
 begin
    case dir of
      1:begin
        result.dir:=3;
        Dec(x);

      end;
      2:begin
        result.dir:=4;
        Inc(x);

      end;
      3:begin
        result.dir:=2;
        Inc(y);

      end;
      4:begin
        result.dir:=1;
        Dec(y);

      end;
    end;//case
    result.x:=x;
    result.y:=y;
  end; //function

function Turn_around (x,y,dir:integer):tbug;
 begin
    case dir of
      1:begin
        result.dir:=3;
        inc(y);
        dec(x);
      end;
      2:begin
        result.dir:=4;
        dec(y);
        inc(x);
      end;
      3:begin
        result.dir:=2;
        inc(x);
        inc(y);
      end;
      4:begin
        result.dir:=1;
        dec(x);
        dec(y);
      end;
    end;//case
    result.x:=x;
    result.y:=y;
  end; //function
procedure TForm1.Button6Click(Sender: TObject);
var
bug:Tbug;
count,i,j:integer;
rinda: pRGBTripleArray;
begin
button4.Click();
//  Iegust sakuma punktus, apiet konturu pec kartas katram sakuma punktam
for i:=0 to (Length(Sakuma_punkts)-1) do
begin
 // definee sakuma vertîbas
  bug.x:= Sakuma_punkts[i].x;
  bug.y:= Sakuma_punkts[i].y;


  bug.dir:=1;
  count:=0;
  //kamer nav sasniegts sakuma punkts
  repeat

    //parbauda, vai nav parsniegtas attela robezas
    if ((bug.x>=0)and(bug.x<=High(img)) and(bug.y>=0)and(bug.y<=High(img[0]) ))then
    begin

     //melns :pagrieþas pa kreisi un atzime pikseli ka kontuuru
     if img[bug.x,bug.y].int=0 then
      begin

        //notiek iezimesana un iezimeta piksela pieskaitisana
        if (img[bug.x,bug.y].segment=0) and (img[bug.x,bug.y].int=0) then
        begin
        img[bug.x,bug.y].segment:=1;
        Inc(count);
        end;
      
      bug:=turn_left(bug.x,bug.y,bug.dir);
      end
     //balts :pagrieþas pa labi
     else if  img[bug.x,bug.y].int=255 then
      begin
        bug:=turn_right(bug.x,bug.y,bug.dir);
      end
     else
      begin
        img[bug.x,bug.y].int:=0;
       Showmessage('Pixel '+Inttostr(bug.x)+' '+InttoStr(bug.y)+' is not segmented');
      end;
      end;//ifrobeza
  until ((bug.x=Sakuma_punkts[i].x)and (bug.y=Sakuma_punkts[i].y));
  end;
 Panel3.Caption:='Bug done!';
 Panel3.Caption:=Panel3.caption+' Pixels marked: '+InttoStr(count);

 //Notira histogrammu
for i:=0 to 256 do
rgbhist[i].I:=0;
//Attelo segmenteto

begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
          if img[i,j].segment=1 then
            begin
              img[i,j].R:=255;
              img[i,j].G:=0;
              img[i,j].B:=0;
              
            end;
              rinda[i].rgbtRed:=img[i,j].R;
              rinda[i].rgbtGreen:=img[i,j].G;
              rinda[i].rgbtBlue:=img[i,j].B;
              img[i,j].int:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;
              inc(rgbhist[img[i,j].int].I);
    end;
  end;
  Image1.Refresh;
end;//attelosana
//histogramma parzimeta
for i:=0 to 256 do
rgbhist[256].I:=Max( rgbhist[256].I,rgbhist[i].I);

DrawHistogram(rgbhist);
end; // procedure but6clk

procedure TForm1.Button7Click(Sender: TObject);
var
bug:Tbug;
prev_x,prev_y,prev_int:integer;
count,skaits,i,j:integer;
rinda: pRGBTripleArray;
return:bool;
begin
//sakuma nosacijumi
prev_X:=0;
prev_Y:=0;
prev_int:=255;
count:=0;
//1. segmente attelu
button4.Click();

//2. skenee segmenteto attelu
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
          //nosacijums, ka var sakt kukaini
          //-ja iepr. pikselis balts un tagadejais melns, sak kukaini
          if ((prev_int=255) and (img[i,j].int=0) and (img[i,j].segment=0)) then
          begin
//3. iegust sakuma koord, kukainis sak no tam
     //-pikseli arpus attela robezas ka balti


          // definee sakuma vertîbas
          bug.x:=i;
          bug.y:=j;
           //sak no labaas
          bug.dir:=4;
  //kamer nav sasniegts sakuma punkts
//-izvele ar radiobutton, kuru algoritmu izpildis
  case radiogroup2.ItemIndex of
  //opcija ar solu saglabasanu
   0: begin
    return:=false;
    skaits:=0;
  repeat

    //parbauda, vai nav parsniegtas attela robezas
    //ja parsniegtas, tad griezas pa labi kaa baltaja pikselii
    if ((bug.x>=0)and(bug.x<=High(img)) and(bug.y>=0)and(bug.y<=High(img[0]) ))then
    begin
     //melns :pagrieþas pa kreisi un atzime pikseli ka kontuuru
     if img[bug.x,bug.y].int=0 then
      begin

        //notiek iezimesana un iezimeta piksela pieskaitisana
        if (img[bug.x,bug.y].segment=0) then
        begin
        img[bug.x,bug.y].segment:=1;
        Inc(count);

        end;
        bug:=turn_around(bug.x,bug.y,bug.dir);

     // return:=true;
      end
     //balts :pagrieþas pa labi
     else if  img[bug.x,bug.y].int=255 then
      begin
        bug:=turn_right(bug.x,bug.y,bug.dir);
      end
     else
      begin
        img[bug.x,bug.y].int:=0;
       Showmessage('Pixel '+Inttostr(bug.x)+' '+InttoStr(bug.y)+' is not segmented');
      end;
      end//ifrobeza
   //arpus robezam
    else
       begin
        bug:=turn_right(bug.x,bug.y,bug.dir);
    end;
    //parbaude, cik reizes bija sakums
    if ((bug.x=i)and (bug.y=j))then
      inc(skaits);
    if skaits=2 then
      return:=true;

  until (return=true);
  end;//case0

 //opcija bez solju saglabasanas
  1:begin
   repeat

    //parbauda, vai nav parsniegtas attela robezas
    //ja parsniegtas, tad griezas pa labi kaa baltaja pikselii
    if ((bug.x>=0)and(bug.x<=High(img)) and(bug.y>=0)and(bug.y<=High(img[0]) ))then
    begin

     //melns :pagrieþas pa kreisi un atzime pikseli ka kontuuru
     if img[bug.x,bug.y].int=0 then
      begin

        //notiek iezimesana un iezimeta piksela pieskaitisana
        if (img[bug.x,bug.y].segment=0) then
        begin
        img[bug.x,bug.y].segment:=1;
        Inc(count);
        end;

        bug:=turn_left(bug.x,bug.y,bug.dir);
      end
     //balts :pagrieþas pa labi
     else if  img[bug.x,bug.y].int=255 then
      begin
        bug:=turn_right(bug.x,bug.y,bug.dir);
      end
     else
      begin
        img[bug.x,bug.y].int:=0;
       Showmessage('Pixel '+Inttostr(bug.x)+' '+InttoStr(bug.y)+' is not segmented');
      end;
      end//ifrobeza
    //arpus robezam
   else
    begin
     bug:=turn_right(bug.x,bug.y,bug.dir);
    end;
  until ((bug.x=i)and (bug.y=j));
  end;//case1
  end;//case
  end;//if beigas
  prev_x:=i;
  prev_y:=j;
  prev_int:=img[i,j].int;
 end;//for i
 end;//for j scan beigas

 // pazinojums userim
 Panel3.Caption:='Bug done!';
 Panel3.Caption:=Panel3.caption+' Pixels marked: '+InttoStr(count);

 //#Notira histogrammu
for i:=0 to 256 do
rgbhist[i].I:=0;
//4. Attelo segmenteto

begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  for j:=0 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(img) do
        begin
          if img[i,j].segment=1 then
            begin
              img[i,j].R:=255;
              img[i,j].G:=0;
              img[i,j].B:=0;
              
            end;
              rinda[i].rgbtRed:=img[i,j].R;
              rinda[i].rgbtGreen:=img[i,j].G;
              rinda[i].rgbtBlue:=img[i,j].B;
              img[i,j].int:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;
              inc(rgbhist[img[i,j].int].I);
    end;
  end;
  Image1.Refresh;
end;//attelosana
//#histogramma parzimeta
for i:=0 to 256 do
rgbhist[256].I:=Max( rgbhist[256].I,rgbhist[i].I);

DrawHistogram(rgbhist);
end; // procedure but7clk


procedure TForm1.Button8Click(Sender: TObject);
Var pol:array[1..3] of TPoint; //definçjam objekta virsotòu skaitu
i,j:integer;
begin
  bmp.Width:=800;
  bmp.Height:=400;
  bmp.PixelFormat:=pf24bit;
Image1.Picture:= nil;


  for j:=0 to bmp.height-1 do
   for i:=0 to bmp.width-1 do
    begin
    bmp.Canvas.Pixels[i,j]:=clwhite;
    end;
// Zimejam trijsturus random  4 gab.
 bmp.Canvas.pen.Color:=clBlue;
 bmp.Canvas.brush.Color:=clBlue;
 
 pol[1].X:=20; pol[1].Y:=100+Random(50);
 pol[2].X:=20; pol[2].Y:=60;
 pol[3].X:=250; pol[3].Y:=60;

 bmp.Canvas.Polygon(pol);

 bmp.Canvas.pen.Color:=clyellow;
 bmp.Canvas.brush.Color:=clyellow;
 pol[1].X:=400; pol[1].Y:=100+Random(50);
 pol[2].X:=500; pol[2].Y:=10;
 pol[3].X:=Round(Cos(radtodeg(60))*(pol[2].X-pol[1].X)-(pol[2].y-pol[1].y)*Sin(radtodeg(60))+pol[1].x);
 pol[3].Y:=Round(Cos(radtodeg(60))*(pol[2].y-pol[1].y)+(pol[2].x-pol[1].x)*Sin(radtodeg(60))+pol[1].y);
 bmp.Canvas.Polygon(pol);

 bmp.Canvas.pen.Color:=clgreen;
 bmp.Canvas.brush.Color:=clgreen;
 pol[1].X:=150; pol[1].Y:=200+Random(50);
 pol[2].X:=100; pol[2].Y:=350;
 pol[3].X:=200; pol[3].Y:=350;

 bmp.Canvas.Polygon(pol);

 bmp.Canvas.pen.Color:=clred;
 bmp.Canvas.brush.Color:=clred;
 pol[1].X:=400; pol[1].Y:=200+Random(50);
 pol[2].X:=500; pol[2].Y:=350;
 pol[3].X:=700; pol[3].Y:=350;

 bmp.Canvas.Polygon(pol);

// Image1.Canvas.TextOnt(x,y, klass:string);  
 //uzzime uz image1
 ReadFromBMP();
 imgToImage1(0);
 image1.Height:=bmp.Height;
 image1.Width:=bmp.Width;
end;

end.




unit RGBch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, JPEG, StdCtrls, Math;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Draw(count:integer);
    procedure TrackBarChange(Sender: TObject);

    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    changed:boolean;
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Draw(count:integer);
var bitm, bmp:TBitmap;
i,j:integer;
row: pRGBTripleArray;

begin

 Image1.Proportional:=true;
 bitm:=TBitmap.Create;
 bitm.Width:=Length(Image);
 bitm.Height:=Length(Image[0]);
 bitm.PixelFormat := pf24bit;

  for j := 0 to bitm.Height - 1 do
    begin
      row := bitm.ScanLine[j];
      for i := 0 to bitm.Width - 1 do
        begin
         case count of
         0:begin
            row[i].rgbtRed := image[i, j].R;
            row[i].rgbtGreen :=image[i, j].G;
            row[i].rgbtBlue := image[i, j].B;
           end;

         1:begin
            row[i].rgbtRed := new[i, j].R;
            row[i].rgbtGreen :=new[i, j].G;
            row[i].rgbtBlue :=new[i,j].B;
           end;

         2:begin
            row[i].rgbtRed := image[i, j].colR;
            row[i].rgbtGreen := image[i, j].colG;
            row[i].rgbtBlue := image[i, j].colB;
           end;
         end;
        end;
    end;

    check:=true;
    Form1.ReadFromImage(bitm);
    Image1.Picture.Bitmap:=bitm;

    bitm.Free;


end;



procedure TForm2.FormActivate(Sender: TObject);
var i,j:integer;
bitm:TBitmap;
row: pRGBTripleArray;
begin

 if Form1.back=false then
   Draw(0);

  if Form1.back=true then
   Draw(1);


   Image2.Proportional:=true;
   bitm:=TBitmap.Create;
   bitm.Width:=Length(Image);
   bitm.Height:=Length(Image[0]);
   bitm.PixelFormat := pf24bit;

   for j := 0 to bitm.Height - 1 do
    begin
      row := bitm.ScanLine[j];
      for i := 0 to bitm.Width - 1 do
      begin
       row[i].rgbtRed := image[i, j].R;
       row[i].rgbtGreen :=image[i, j].G;
       row[i].rgbtBlue := image[i, j].B;
      end;
     end;

    Image2.Picture.Bitmap:=bitm;
    edit1.Text:=IntToStr(TrackBar1.position);
    edit2.Text:=IntToStr(TrackBar2.position);
    edit3.Text:=IntToStr(TrackBar3.position);

    bitm.Free;

   Form2.DoubleBuffered:=true;
end;

procedure TForm2.TrackBarChange(Sender: TObject);
var i, j, RedValue, GreenValue, BlueValue: integer;

begin

  RedValue:=TrackBar1.Position;
  GreenValue:=TrackBar2.Position;
  BlueValue:=TrackBar3.Position;

  Edit1.text:=IntToStr(TrackBar1.Position);
  Edit2.text:=IntToStr(TrackBar2.Position);
  Edit3.text:=IntToStr(TrackBar3.Position);

  for i := 0 to high(image) do
    for j := 0 to high(image[0]) do
    begin
      if RedValue > 0 then
        image[i,j].colR:= Min(255, image[i,j].R + RedValue)
      else
        image[i,j].colR:= Max(0, image[i,j].R + RedValue);


      if GreenValue > 0 then
        image[i,j].colG := Min(255, image[i,j].G + GreenValue)
      else
        image[i,j].colG := Max(0, image[i,j].G + GreenValue);


      if BlueValue > 0 then
        image[i,j].colB:= Min(255, image[i,j].B + BlueValue)
      else
        image[i,j].colB:= Max(0, image[i,j].B + BlueValue);

    end;

  Draw(2);
  Form1.Draw(7);
  Form1.back:=false;
end;


procedure TForm2.Button2Click(Sender: TObject);
begin
 TrackBar1.Position:=0;
 TrackBar2.Position:=0;
 TrackBar3.Position:=0;
 Close;
end;

procedure TForm2.Button1Click(Sender: TObject);
var i,j:integer;
begin
changed:=true;

 for i:=0 to high(image) do
    for j:=0 to high(image[0]) do
     begin
      image[i,j].R:=image[i,j].colR;
      image[i,j].G:=image[i,j].colG;
      image[i,j].B:=image[i,j].colB;
     end;
 Close;

 TrackBar1.Position:=0;
 TrackBar2.Position:=0;
 TrackBar3.Position:=0;
end;

end.

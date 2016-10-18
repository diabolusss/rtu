unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
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
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}

procedure Tform4.CreateParams;
begin
 inherited;
 Params.WndParent:= form1.Handle
end;

procedure TForm4.Button1Click(Sender: TObject);
  Var rinda: pRGBTripleArray;
  i,j, outI,outJ, newW,newH ,X1,X2,Y1,Y2, grad: Integer;
  shiftX,shiftY, cosA,sinA, X,Y: Single;
  angle: Real;
  ImgTemp: Array of Array of TRGB;
begin

  Form4.Close;
    grad:=StrToInt(Edit1.Text);
    if  grad<0 then grad:=360+grad;
    angle := -DegToRad(grad mod 360);
    cosA  := Cos(angle);
    sinA  := Sin(angle);

    if angle>=-(PI/2) then
    begin
      newW := Round(Length(Img)*cosA - Length(Img[0])*sinA);
      newH := Round((0*sinA+Length(Img[0])*cosA) - (Length(Img)*sinA+0*cosA));
      shiftX := -High(Img[0])*sinA;
      shiftY := 0;
    end
    else if angle>=-PI then
    begin
      newW := Round((0*cosA-Length(Img[0])*sinA) - (Length(Img)*cosA-0*sinA));
      newH := Abs(Round(Length(Img)*sinA + Length(Img[0])*cosA));
      shiftX := -High(Img)*cosA - High(Img[0])*sinA;
      shiftY := -High(Img[0])*cosA;
    end
    else if angle>=-(PI*3/2) then
    begin
      newW := Abs(Round(Length(Img)*cosA - Length(Img[0])*sinA));
      newH := Round((Length(Img)*sinA+0*cosA) - (0*sinA+Length(Img[0])*cosA));
      shiftX := -High(Img)*cosA;
      shiftY := High(Img)*sinA - High(Img[0])*cosA;
    end
    else
    begin
      newW := Round((Length(Img)*cosA-0*sinA) - (0*cosA-Length(Img[0])*sinA));
      newH := Round(Length(Img)*sinA + Length(Img[0])*cosA);
      shiftX := 0;
      shiftY := High(Img)*sinA;
    end;

    //Coloring in White
    SetLength(ImgTemp, newW, newH);
    for j:=0 to High(ImgTemp[0]) do
    begin
      for i:=0 to High(ImgTemp) do
      begin
        ImgTemp[i,j].R := 255;
        ImgTemp[i,j].G := 255;
        ImgTemp[i,j].B := 255;
      end;
    end;

for j:=-Round(shiftY) to High(ImgTemp[0]) do
      begin
        for i:=-Round(shiftX) to High(ImgTemp) do
        begin
          X := i*cosA - j*sinA;
          if X<0 then
            X := 0;
          if X>High(Img) then
          begin
            X := High(Img)-1;
          end;
          X1 := Trunc(X);
          X2 := X1+1;
          if X2>High(Img) then
          begin
            X1 := High(Img)-1;
            X2 := High(Img);
          end;

          Y := i*sinA + j*cosA;
          if Y<0 then
            Y := 0;
          if Y>High(Img[0]) then
          begin
            Y := High(Img[0])-1;
          end;
          Y1 := Trunc(Y);
          Y2 := Y1+1;
          if Y2>High(Img[0]) then
          begin
            Y1 := High(Img[0])-1;
            Y2 := High(Img[0]);
          end;

          outI := i+Round(shiftX);
          if outI>High(ImgTemp) then
            outI := High(ImgTemp);
          outJ := j+Round(shiftY);
          if outJ>High(ImgTemp[0]) then
            outJ := High(ImgTemp[0]);

          if (Round(i*cosA-j*sinA)>=0) AND (Round(i*cosA-j*sinA)<=High(Img)) AND
             (Round(i*sinA+j*cosA)>=0) AND (Round(i*sinA+j*cosA)<=High(Img[0])) then
          begin
            ImgTemp[outI,outJ].R :=
                Trunc(Img[X1,Y1].R*(X2-X)*(Y2-Y) + Img[X2,Y1].R*(X-X1)*(Y2-Y) +
                Img[X1,Y2].R*(X2-X)*(Y-Y1) + Img[X2,Y2].R*(X-X1)*(Y-Y1));
            ImgTemp[outI,outJ].G :=
                Trunc(Img[X1,Y1].G*(X2-X)*(Y2-Y) + Img[X2,Y1].G*(X-X1)*(Y2-Y) +
                Img[X1,Y2].G*(X2-X)*(Y-Y1) + Img[X2,Y2].G*(X-X1)*(Y-Y1));
            ImgTemp[outI,outJ].B :=
                Trunc(Img[X1,Y1].B*(X2-X)*(Y2-Y) + Img[X2,Y1].B*(X-X1)*(Y2-Y) +
                Img[X1,Y2].B*(X2-X)*(Y-Y1) + Img[X2,Y2].B*(X-X1)*(Y-Y1));
          end;
        end;
      end;

  SetLength(imgres, Length(ImgTemp), Length(ImgTemp[0]));
  for j:=0 to High(imgres[0]) do
  begin
    for i:=0 to High(imgres) do
    begin
      imgres[i,j].R := ImgTemp[i,j].R;
      imgres[i,j].G := ImgTemp[i,j].G;
      imgres[i,j].B := ImgTemp[i,j].B;
    end;
  end;
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

    for j:=0 to High(imgres[0]) do
    begin
      rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres) do
        begin
          rinda[i].rgbtRed:=imgres[i,j].R;
          rinda[i].rgbtGreen:=imgres[i,j].G;
          rinda[i].rgbtBlue:=imgres[i,j].B;
        end;
    end;
  Form1.Image3.Refresh;
end;

end.

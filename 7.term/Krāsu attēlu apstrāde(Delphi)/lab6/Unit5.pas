unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
  
  procedure CreateParams(var Params:TCreateParams);override;

  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}

procedure Tform5.CreateParams;
begin
 inherited;
 Params.WndParent:= form1.Handle
end;

procedure TForm5.Button1Click(Sender: TObject);
Var i, j, e, Rv, Gv, Bv : Integer;
    tr, tg, tb :Array[1..8] of integer;
    x1y1, x2y1, x3y1, x1y2, x2y2, x3y2, x1y3, x2y3, x3y3 : Array[0..1] of Integer;
    rinda: pRGBTripleArray;
begin
e:=StrToInt(edit1.text);
Form5.Close;

SetLength(imgres, Length(img), Length(img[0]));
Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;


for j:=0 to High(imgres[0])-1 do
      for i:=0 to High(imgres)-1 do
        begin
              x2y2[0]:=i; x2y1[0]:=i;
              x1y2[1]:=j; x2y2[1]:=j;
              x2y3[0]:=i; x3y2[1]:=j;

              if i>0 then
              begin
                x1y1[0]:=i-1;
                x1y2[0]:=i-1;
                x1y3[0]:=i-1;
              end else
              begin
                x1y1[0]:=i;
                x1y2[0]:=i;
                x1y3[0]:=i;
              end;

              if j>0 then
              begin
                x2y1[1]:=j-1;
                x1y1[1]:=j-1;
                x3y1[1]:=j-1;
              end else
              begin
                x2y1[1]:=j;
                x1y1[1]:=j;
                x3y1[1]:=j;
              end;

              if i<High(imgres)-1 then
              begin
                x3y1[0]:=i+1;
                x3y2[0]:=i+1;
                x3y3[0]:=i+1;
              end else
              begin
                x3y1[0]:=i;
                x3y2[0]:=i;
                x3y3[0]:=i;
              end;

              if j<High(imgres[0])-1 then
              begin
                x2y3[1]:=j+1;
                x3y3[1]:=j+1;
                x1y3[1]:=j+1;
              end else
              begin
                x2y3[1]:=j;
                x3y3[1]:=j;
                x1y3[1]:=j;
              end;

              tr[1]:=imgres[x1y1[0],x1y1[1]].R;
              tr[2]:=imgres[x2y1[0],x2y1[1]].R;
              tr[3]:=imgres[x3y1[0],x3y1[1]].R;
              tr[4]:=imgres[x1y2[0],x1y2[1]].R;
              tr[5]:=imgres[x3y2[0],x3y2[1]].R;
              tr[6]:=imgres[x1y3[0],x1y3[1]].R;
              tr[7]:=imgres[x2y3[0],x2y3[1]].R;
              tr[8]:=imgres[x3y3[0],x3y3[1]].R;

              tg[1]:=imgres[x1y1[0],x1y1[1]].G;
              tg[2]:=imgres[x2y1[0],x2y1[1]].G;
              tg[3]:=imgres[x3y1[0],x3y1[1]].G;
              tg[4]:=imgres[x1y2[0],x1y2[1]].G;
              tg[5]:=imgres[x3y2[0],x3y2[1]].G;
              tg[6]:=imgres[x1y3[0],x1y3[1]].G;
              tg[7]:=imgres[x2y3[0],x2y3[1]].G;
              tg[8]:=imgres[x3y3[0],x3y3[1]].G;

              tb[1]:=imgres[x1y1[0],x1y1[1]].B;
              tb[2]:=imgres[x2y1[0],x2y1[1]].B;
              tb[3]:=imgres[x3y1[0],x3y1[1]].B;
              tb[4]:=imgres[x1y2[0],x1y2[1]].B;
              tb[5]:=imgres[x3y2[0],x3y2[1]].B;
              tb[6]:=imgres[x1y3[0],x1y3[1]].B;
              tb[7]:=imgres[x2y3[0],x2y3[1]].B;
              tb[8]:=imgres[x3y3[0],x3y3[1]].B;

              Rv:=Round((tr[1]+tr[2]+tr[3]+tr[4]+tr[5]+tr[6]+tr[7]+tr[8])/8);
              Gv:=Round((tg[1]+tg[2]+tg[3]+tg[4]+tg[5]+tg[6]+tg[7]+tg[8])/8);
              Bv:=Round((tb[1]+tb[2]+tb[3]+tb[4]+tb[5]+tb[6]+tb[7]+tb[8])/8);

              if (abs(imgres[i,j].R-Rv) > e) then imgres[i,j].R:=Rv;
              if (abs(imgres[i,j].G-Gv) > e) then imgres[i,j].G:=Gv;
              if (abs(imgres[i,j].B-Bv) > e) then imgres[i,j].B:=Bv;
        end;

    for j:=0 to High(imgres[0])-1 do
    begin
       rinda:=Form1.Image3.Picture.Bitmap.ScanLine[j];
      for i:=0 to High(imgres)-1 do
        begin
          rinda[i].rgbtRed:=imgres[i,j].R;
          rinda[i].rgbtGreen:=imgres[i,j].G;
          rinda[i].rgbtBlue:=imgres[i,j].B;
        end;
    end;
    Form1.Image3.Refresh;
end;

end.

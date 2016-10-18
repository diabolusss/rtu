unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit1, StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected

  procedure CreateParams(var Params:TCreateParams);override;
  
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure Tform3.CreateParams;
begin
 inherited;
 Params.WndParent:= form1.Handle
end;

procedure resizeIMGr();
Var i, j :integer;
begin
    SetLength(imgr, Length(imgres), Length(imgres[0]));

      for j:=0 to High(imgres[0]) do
      for i:=0 to High(imgres) do
        begin
          imgr[i,j]:=imgres[i,j];
        end;
end;

procedure TForm3.Button1Click(Sender: TObject);
  Var kx, ky, x, y, ox, oy, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16:Real;
      i, j, tx, ty, tt, nm, i1, i2, i3, XM1, YM1, X1, Y1, X2, Y2, X0, Y0 :Integer;
      int1, int2, int3, int4 :Array [0..2] of Single;
      tmr, tmg, tmb :Integer;
      rinda: pRGBTripleArray;
begin
  kx:=StrToFloat(Edit1.Text);
  ky:=StrToFloat(Edit2.Text);
  Form3.Close;

  Form1.Image3.Canvas.Brush.Color:=clWhite;
  Form1.Image3.Canvas.FillRect(Form1.Image3.ClientRect);
  Form1.Image3.Picture.Bitmap.Width:=Round(Length(img)*kx);
  Form1.Image3.Picture.Bitmap.Height:=Round(Length(img[0])*ky);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;
  SetLength(imgres, Round(Length(img)*kx), Round(Length(img[0])*ky));

  for j:=0 to High(img[0]) do
      for i:=0 to High(img) do
        begin
            imgres[Trunc(i*kx),Trunc(j*ky)].R:=img[i,j].R;
            imgres[Trunc(i*kx),Trunc(j*ky)].G:=img[i,j].G;
            imgres[Trunc(i*kx),Trunc(j*ky)].B:=img[i,j].B;
        end;

  if transform = 1 then
  begin

  for j:=0 to High(imgres[0])-1 do
      for i:=0 to High(imgres)-1 do
        begin
                imgres[i,j].R:=img[Trunc(i/kx),Trunc(j/ky)].R;
                imgres[i,j].G:=img[Trunc(i/kx),Trunc(j/ky)].G;
                imgres[i,j].B:=img[Trunc(i/kx),Trunc(j/ky)].B;
        end;

  end;

 if transform = 2 then
 begin

    for j:=0 to High(imgres[0])-1 do
      for i:=0 to High(imgres)-1 do
        begin
                x:=(i+0.5)/kx-0.5;
                y:=(j+0.5)/ky-0.5;
                if x<0 then x:=0;
                if y<0 then y:=0;
                tx:=Trunc(x);
                ty:=Trunc(y);

                if tx<=0 then tx:=0;
                if ty<=0 then ty:=0;
                if (tx >= (High(img))) then tx := High(img);
                if (ty >= (High(img[0]))) then ty := High(img[0]);

                if tx<High(img) then x2:=(tx+1) else x2:=High(img);
                if ty<High(img[0]) then y1:=(ty+1) else y1:=High(img[0]);
                x1:=tx;
                y2:=ty;

                if x1=x2 then x1:=x2-1;
                if y1=y2 then y2:=y1-1;

                int1[0]:= img[tx,y1].R * (x2-x)*(y2-y)/((x2-x1)*(y2-y1));
                int1[1]:= img[tx,y1].G * (x2-x)*(y2-y)/((x2-x1)*(y2-y1));
                int1[2]:= img[tx,y1].B * (x2-x)*(y2-y)/((x2-x1)*(y2-y1));

                int2[0]:= img[x2,y1].R * (x-x1)*(y2-y)/((x2-x1)*(y2-y1));
                int2[1]:= img[x2,y1].G * (x-x1)*(y2-y)/((x2-x1)*(y2-y1));
                int2[2]:= img[x2,y1].B * (x-x1)*(y2-y)/((x2-x1)*(y2-y1));

                int3[0]:= img[tx,ty].R * (x2-x)*(y-y1)/((x2-x1)*(y2-y1));
                int3[1]:= img[tx,ty].G * (x2-x)*(y-y1)/((x2-x1)*(y2-y1));
                int3[2]:= img[tx,ty].B * (x2-x)*(y-y1)/((x2-x1)*(y2-y1));

                int4[0]:= img[x2,ty].R * (x-x1)*(y-y1)/((x2-x1)*(y2-y1));
                int4[1]:= img[x2,ty].G * (x-x1)*(y-y1)/((x2-x1)*(y2-y1));
                int4[2]:= img[x2,ty].B * (x-x1)*(y-y1)/((x2-x1)*(y2-y1));

                i1:=Trunc(int1[0]+int2[0]+int3[0]+int4[0]);
                i2:=Trunc(int1[1]+int2[1]+int3[1]+int4[1]);
                i3:=Trunc(int1[2]+int2[2]+int3[2]+int4[2]);

                 if i1 < 0 then i1:=0;
                 if i1 > 255 then i1:=255;
                 if i2 < 0 then i2:=0;
                 if i2 > 255 then i2:=255;
                 if i3 < 0 then i3:=0;
                 if i3 > 255 then i3:=255;

                imgres[i,j].R:=i1;
                imgres[i,j].G:=i2;
                imgres[i,j].B:=i3;
        end;

 end;

 if transform = 3 then
   begin
   
   for j:=0 to High(imgres)-1 do
     for i:=0 to High(imgres[0])-1 do
        begin

          x:=(i+0.5)/ky-0.5;
          y:=(j+0.5)/kx-0.5;
          if x<0 then x:=0;
          if y<0 then y:=0;

          tx:=Trunc(x);
          ty:=Trunc(y);
          ox:=x-Trunc(x);
          oy:=y-Trunc(y);

          X0:=tx; Y0:=ty;
          X1:=tx+1; Y1:=ty+1;
          X2:=tx+2; Y2:=ty+2;
          XM1:=tx-1; YM1:=ty-1;

          if X0<0 then X0:=0;
          if Y0<0 then Y0:=0;
          if XM1<0 then XM1:=0;
          if YM1<0 then YM1:=0;

          if (X0 >= (High(img[0]))) then X0 := High(img[0]);
          if (Y0 >= (High(img))) then Y0 := High(img);
          if (X1 >= (High(img[0]))) then X1 := High(img[0]);
          if (Y1 >= (High(img))) then Y1 := High(img);
          if (X2 >= (High(img[0]))) then X2 := High(img[0]);
          if (Y2 >= (High(img))) then Y2 := High(img);

          b1:=(1/4)*(ox-1)*(ox-2)*(ox+1)*(oy-1)*(oy-2)*(oy+1);
          b2:=(-1/4)*ox*(ox+1)*(ox-2)*(oy-1)*(oy-2)*(oy+1);
          b3:=(-1/4)*oy*(ox-1)*(ox-2)*(ox+1)*(oy+1)*(oy-2);
          b4:=(1/4)*ox*oy*(ox+1)*(ox-2)*(oy+1)*(oy-2);
          b5:=(-1/12)*ox*(ox-1)*(ox-2)*(oy-1)*(oy-2)*(oy+1);
          b6:=(-1/12)*oy*(ox-1)*(ox-2)*(ox+1)*(oy-1)*(oy-2);
          b7:=(1/12)*ox*oy*(ox-1)*(ox-2)*(oy+1)*(oy-2);
          b8:=(1/12)*ox*oy*(ox+1)*(ox-2)*(oy-1)*(oy-2);
          b9:=(1/12)*ox*(ox-1)*(ox+1)*(oy-1)*(oy-2)*(oy+1);
          b10:=(1/12)*oy*(ox-1)*(ox-2)*(ox+1)*(oy-1)*(oy+1);
          b11:=(1/36)*ox*oy*(ox-1)*(ox-2)*(oy-1)*(oy-2);
          b12:=(-1/12)*ox*oy*(ox-1)*(ox+1)*(oy+1)*(oy-2);
          b13:=(-1/12)*ox*oy*(ox+1)*(ox-2)*(oy-1)*(oy+1);
          b14:=(-1/36)*ox*oy*(ox-1)*(ox+1)*(oy-1)*(oy-2);
          b15:=(-1/36)*ox*oy*(ox-1)*(ox-2)*(oy-1)*(oy+1);
          b16:=(1/36)*ox*oy*(ox-1)*(ox+1)*(oy-1)*(oy+1);

          tmr:=Trunc(b1*img[Y0,X0].R+b2*img[Y0,X1].R+b3*img[Y1,X0].R+
                         b4*img[Y1,X1].R+b5*img[Y0,XM1].R+b6*img[YM1,X0].R+
                         b7*img[Y1,XM1].R+b8*img[YM1,X1].R+
                         b9*img[Y0,X2].R+b10*img[Y2,X0].R+b11*img[YM1,XM1].R+
                         b12*img[Y1,X2].R+b13*img[Y2,X1].R+b14*img[YM1,X2].R+
                         b15*img[Y2,XM1].R+b16*img[Y2,X2].R);

          tmg:=Trunc(b1*img[Y0,X0].G+b2*img[Y0,X1].G+b3*img[Y1,X0].G+
                         b4*img[Y1,X1].G+b5*img[Y0,XM1].G+b6*img[YM1,X0].G+
                         b7*img[Y1,XM1].G+b8*img[YM1,X1].G+
                         b9*img[Y0,X2].G+b10*img[Y2,X0].G+b11*img[YM1,XM1].G+
                         b12*img[Y1,X2].G+b13*img[Y2,X1].G+b14*img[YM1,X2].G+
                         b15*img[Y2,XM1].G+b16*img[Y2,X2].G);

          tmb:=Trunc(b1*img[Y0,X0].B+b2*img[Y0,X1].B+b3*img[Y1,X0].B+
                         b4*img[Y1,X1].B+b5*img[Y0,XM1].B+b6*img[YM1,X0].B+
                         b7*img[Y1,XM1].B+b8*img[YM1,X1].B+
                         b9*img[Y0,X2].B+b10*img[Y2,X0].B+b11*img[YM1,XM1].B+
                         b12*img[Y1,X2].B+b13*img[Y2,X1].B+b14*img[YM1,X2].B+
                         b15*img[Y2,XM1].B+b16*img[Y2,X2].B);


          if tmr<0 then tmr:=0; if tmr>255 then tmr:=255;
          if tmg<0 then tmg:=0; if tmg>255 then tmg:=255;
          if tmb<0 then tmb:=0; if tmb>255 then tmb:=255;

          imgres[j,i].R:=tmr;
          imgres[j,i].G:=tmg;
          imgres[j,i].B:=tmb;

         end;
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
     resizeIMGr();
     Form1.Image3.Refresh;
  
end;



end.

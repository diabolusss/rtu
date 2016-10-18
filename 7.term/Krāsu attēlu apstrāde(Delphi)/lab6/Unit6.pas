unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);

  private

  public

  protected

  procedure CreateParams(var Params:TCreateParams);override;

  end;

var
  Form6: TForm6;

implementation

uses Unit1, Unit5;

{$R *.dfm}

procedure Tform6.CreateParams;
begin
 inherited;
 Params.WndParent:= form1.Handle
end;

procedure TForm6.Button1Click(Sender: TObject);
Var i, j, e, Rv, Gv, Bv : Integer;
    tr :Array[1..17] of integer;
    p00, p20, p21, p22, p23, p24, p02, p12, p32, p42, p11, p33, p44, p04, p13, p31, p40 : Array[0..1] of Integer;
    srT, sr1, sr2, sr3, sr4, srR, srG, srB : Double;
    rinda: pRGBTripleArray;
begin

  Form5.edit1.Text:=edit1.text;
  Form6.Close;
  Form5.button1.Click;

  SetLength(imgres, Length(img), Length(img[0]));
  Form1.Image3.Picture.Bitmap.Width:=Length(imgres);
  Form1.Image3.Picture.Bitmap.Height:=Length(imgres[0]);
  Form1.Image3.Picture.Bitmap.PixelFormat:=pf24bit;

  for j:=0 to High(imgres[0])-1 do
      for i:=0 to High(imgres)-1 do
        begin

          if radiogroup1.ItemIndex=0 then
          begin
             p02[0]:=i; p20[1]:=j;
             p12[0]:=i; p21[1]:=j;
             p22[0]:=i; p22[1]:=j;
             p32[0]:=i; p23[1]:=j;
             p42[0]:=i; p24[1]:=j;

             if i>1 then
             begin
               p20[0]:=i-2;
               p21[0]:=i-1;
             end else
             begin
               if i=1 then
               begin
                 p20[0]:=i-1;
                 p21[0]:=i-1;
               end else
               begin
                 p20[0]:=i;
                 p21[0]:=i;
               end;
             end;

             if j>1 then
             begin
               p02[1]:=j-2;
               p12[1]:=j-1;
             end else
             begin
               if j=1 then
               begin
                 p02[1]:=j-1;
                 p12[1]:=j-1;
               end else
               begin
                 p02[1]:=j;
                 p12[1]:=j;
               end;
             end;

             if i<High(imgres)-2 then
              begin
                p23[0]:=i+1;
                p24[0]:=i+2;
              end else
              begin
                 if i=High(imgres)-1 then
                 begin
                   p23[0]:=i+1;
                   p24[0]:=i+1;
                 end else
                 begin
                   p23[0]:=i;
                   p24[0]:=i;
                 end;
              end;

              if j<High(imgres[0])-2 then
              begin
                p32[1]:=j+1;
                p42[1]:=j+2;
              end else
              begin
                 if j=High(imgres[0])-1 then
                 begin
                   p32[1]:=j+1;
                   p42[1]:=j+1;
                 end else
                 begin
                   p32[1]:=j;
                   p42[1]:=j;
                 end;
              end;
              
              tr[1]:=imgres[p02[0],p02[1]].R;
              tr[2]:=imgres[p12[0],p12[1]].R;
              tr[3]:=imgres[p22[0],p22[1]].R;
              tr[4]:=imgres[p32[0],p32[1]].R;
              tr[5]:=imgres[p42[0],p42[1]].R;
              tr[6]:=imgres[p20[0],p20[1]].R;
              tr[7]:=imgres[p21[0],p21[1]].R;
              tr[8]:=imgres[p23[0],p23[1]].R;
              tr[9]:=imgres[p24[0],p24[1]].R;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;

              srR:=(sr1+sr2)/2;

              tr[1]:=imgres[p02[0],p02[1]].G;
              tr[2]:=imgres[p12[0],p12[1]].G;
              tr[3]:=imgres[p22[0],p22[1]].G;
              tr[4]:=imgres[p32[0],p32[1]].G;
              tr[5]:=imgres[p42[0],p42[1]].G;
              tr[6]:=imgres[p20[0],p20[1]].G;
              tr[7]:=imgres[p21[0],p21[1]].G;
              tr[8]:=imgres[p23[0],p23[1]].G;
              tr[9]:=imgres[p24[0],p24[1]].G;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;

              srG:=(sr1+sr2)/2;

              tr[1]:=imgres[p02[0],p02[1]].B;
              tr[2]:=imgres[p12[0],p12[1]].B;
              tr[3]:=imgres[p22[0],p22[1]].B;
              tr[4]:=imgres[p32[0],p32[1]].B;
              tr[5]:=imgres[p42[0],p42[1]].B;
              tr[6]:=imgres[p20[0],p20[1]].B;
              tr[7]:=imgres[p21[0],p21[1]].B;
              tr[8]:=imgres[p23[0],p23[1]].B;
              tr[9]:=imgres[p24[0],p24[1]].B;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;

              srB:=(sr1+sr2)/2;

              srT:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5]+tr[6]+tr[7]+tr[8])/8;

              imgres[i,j].R:=Round(srR);
              imgres[i,j].G:=Round(srG);
              imgres[i,j].B:=Round(srB);
          end;

          if radiogroup1.ItemIndex=1 then
          begin
             p02[0]:=i; p20[1]:=j;
             p12[0]:=i; p21[1]:=j;
             p22[0]:=i; p22[1]:=j;
             p32[0]:=i; p23[1]:=j;
             p42[0]:=i; p24[1]:=j;

             if i>1 then
             begin
               p20[0]:=i-2;
               p21[0]:=i-1;
               p00[0]:=i-2;
               p11[0]:=i-1;
               p04[0]:=i-2;
               p13[0]:=i-1;
             end else
             begin
               if i=1 then
               begin
                 p20[0]:=i-1;
                 p21[0]:=i-1;
                 p00[0]:=i-1;
                 p11[0]:=i-1;
                 p04[0]:=i-1;
                 p13[0]:=i-1;
               end else
               begin
                 p20[0]:=i;
                 p21[0]:=i;
                 p00[0]:=i;
                 p11[0]:=i;
                 p04[0]:=i;
                 p13[0]:=i;
               end;
             end;

             if j>1 then
             begin
               p02[1]:=j-2;
               p12[1]:=j-1;
               p00[1]:=j-2;
               p11[1]:=j-1;
               p04[1]:=j-2;
               p31[1]:=j-1;
             end else
             begin
               if j=1 then
               begin
                 p02[1]:=j-1;
                 p12[1]:=j-1;
                 p00[1]:=j-1;
                 p11[1]:=j-1;
                 p04[1]:=j-1;
                 p31[1]:=j-1;
               end else
               begin
                 p02[1]:=j;
                 p12[1]:=j;
                 p00[1]:=j;
                 p11[1]:=j;
                 p04[1]:=j;
                 p31[1]:=j;
               end;
             end;

             if i<High(imgres)-2 then
              begin
                p23[0]:=i+1;
                p24[0]:=i+2;
                p33[0]:=i+1;
                p44[0]:=i+2;
                p31[0]:=i+1;
                p40[0]:=i+2;
              end else
              begin
                 if i=High(imgres)-1 then
                 begin
                   p23[0]:=i+1;
                   p24[0]:=i+1;
                   p33[0]:=i+1;
                   p44[0]:=i+1;
                   p31[0]:=i+1;
                   p40[0]:=i+1;
                 end else
                 begin
                   p23[0]:=i;
                   p24[0]:=i;
                   p33[0]:=i;
                   p44[0]:=i;
                   p31[0]:=i;
                   p40[0]:=i;
                 end;
              end;

              if j<High(imgres[0])-2 then
              begin
                p32[1]:=j+1;
                p42[1]:=j+2;
                p33[1]:=j+1;
                p44[1]:=j+2;
                p13[1]:=j+1;
                p40[1]:=j+2;
              end else
              begin
                 if j=High(imgres[0])-1 then
                 begin
                   p32[1]:=j+1;
                   p42[1]:=j+1;
                   p33[1]:=j+1;
                   p44[1]:=j+1;
                   p13[1]:=j+1;
                   p40[1]:=j+1;
                 end else
                 begin
                   p32[1]:=j;
                   p42[1]:=j;
                   p33[1]:=j;
                   p44[1]:=j;
                   p13[1]:=j;
                   p40[1]:=j;
                 end;
              end;
              
              tr[1]:=imgres[p02[0],p02[1]].R;
              tr[2]:=imgres[p12[0],p12[1]].R;
              tr[3]:=imgres[p22[0],p22[1]].R;
              tr[4]:=imgres[p32[0],p32[1]].R;
              tr[5]:=imgres[p42[0],p42[1]].R;
              tr[6]:=imgres[p20[0],p20[1]].R;
              tr[7]:=imgres[p21[0],p21[1]].R;
              tr[8]:=imgres[p23[0],p23[1]].R;
              tr[9]:=imgres[p24[0],p24[1]].R;
              tr[10]:=imgres[p00[0],p00[1]].R;
              tr[11]:=imgres[p11[0],p11[1]].R;
              tr[12]:=imgres[p33[0],p33[1]].R;
              tr[13]:=imgres[p44[0],p44[1]].R;
              tr[14]:=imgres[p04[0],p04[1]].R;
              tr[15]:=imgres[p13[0],p13[1]].R;
              tr[16]:=imgres[p31[0],p31[1]].R;
              tr[17]:=imgres[p40[0],p40[1]].R;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;
              sr3:=(tr[10]+tr[11]+tr[3]+tr[12]+tr[13])/5;
              sr4:=(tr[14]+tr[15]+tr[3]+tr[16]+tr[17])/5;

              srR:=(sr1+sr2+sr3+sr4)/4;

              tr[1]:=imgres[p02[0],p02[1]].G;
              tr[2]:=imgres[p12[0],p12[1]].G;
              tr[3]:=imgres[p22[0],p22[1]].G;
              tr[4]:=imgres[p32[0],p32[1]].G;
              tr[5]:=imgres[p42[0],p42[1]].G;
              tr[6]:=imgres[p20[0],p20[1]].G;
              tr[7]:=imgres[p21[0],p21[1]].G;
              tr[8]:=imgres[p23[0],p23[1]].G;
              tr[9]:=imgres[p24[0],p24[1]].G;
              tr[10]:=imgres[p00[0],p00[1]].G;
              tr[11]:=imgres[p11[0],p11[1]].G;
              tr[12]:=imgres[p33[0],p33[1]].G;
              tr[13]:=imgres[p44[0],p44[1]].G;
              tr[14]:=imgres[p04[0],p04[1]].G;
              tr[15]:=imgres[p13[0],p13[1]].G;
              tr[16]:=imgres[p31[0],p31[1]].G;
              tr[17]:=imgres[p40[0],p40[1]].G;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;
              sr3:=(tr[10]+tr[11]+tr[3]+tr[12]+tr[13])/5;
              sr4:=(tr[14]+tr[15]+tr[3]+tr[16]+tr[17])/5;

              srG:=(sr1+sr2+sr3+sr4)/4;

              tr[1]:=imgres[p02[0],p02[1]].B;
              tr[2]:=imgres[p12[0],p12[1]].B;
              tr[3]:=imgres[p22[0],p22[1]].B;
              tr[4]:=imgres[p32[0],p32[1]].B;
              tr[5]:=imgres[p42[0],p42[1]].B;
              tr[6]:=imgres[p20[0],p20[1]].B;
              tr[7]:=imgres[p21[0],p21[1]].B;
              tr[8]:=imgres[p23[0],p23[1]].B;
              tr[9]:=imgres[p24[0],p24[1]].B;
              tr[10]:=imgres[p00[0],p00[1]].B;
              tr[11]:=imgres[p11[0],p11[1]].B;
              tr[12]:=imgres[p33[0],p33[1]].B;
              tr[13]:=imgres[p44[0],p44[1]].B;
              tr[14]:=imgres[p04[0],p04[1]].B;
              tr[15]:=imgres[p13[0],p13[1]].B;
              tr[16]:=imgres[p31[0],p31[1]].B;
              tr[17]:=imgres[p40[0],p40[1]].B;

              sr1:=(tr[1]+tr[2]+tr[3]+tr[4]+tr[5])/5;
              sr2:=(tr[6]+tr[7]+tr[3]+tr[8]+tr[9])/5;
              sr3:=(tr[10]+tr[11]+tr[3]+tr[12]+tr[13])/5;
              sr4:=(tr[14]+tr[15]+tr[3]+tr[16]+tr[17])/5;

              srB:=(sr1+sr2+sr3+sr4)/4;

              imgres[i,j].R:=Round(srR);
              imgres[i,j].G:=Round(srG);
              imgres[i,j].B:=Round(srB);
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
    Form1.Image3.Refresh;
end;

end.

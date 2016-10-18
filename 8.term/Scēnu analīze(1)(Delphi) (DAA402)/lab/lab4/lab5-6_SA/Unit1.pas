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
    segment:integer;
  end;

  type
  Direction = record
    direct :Integer;
    x,y :Integer;
  end;

  TStack = array of record    // massivs kas glaba pikselu koordinates
	x, y: integer;
  end;

  TRGBTripleArray = array[word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

  TMain_menu = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    dlgSave1: TSaveDialog;
    Save1: TMenuItem;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Button1: TButton;
    Label2: TLabel;
    CheckBox1: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Open1Click(Sender: TObject);
    procedure ReadFromBMP();
    procedure imgToImage1(a:integer);
    procedure Save1Click(Sender: TObject);
    procedure segmentToImage();
    procedure Button2Click(Sender: TObject);
    procedure TurnLeft(var dir:Direction);
    procedure TurnRight(var dir:Direction);
    procedure TurnBack(var dir:Direction);
    procedure Kukainis();
    procedure Button1Click(Sender: TObject);

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
  implementation

{$R *.dfm}

procedure TMain_menu.FormCreate(Sender: TObject);
begin
  bmp:=TBitmap.Create;
  jpg:=TJPEGImage.Create;
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
    Button2.Click;
end;

procedure TMain_menu.ReadFromBMP();
var i,j: integer;
    rinda: pRGBTripleArray;
begin
  SetLength(img, bmp.Width, bmp.Height);
  SetLength(temp, bmp.Width, bmp.Height);

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

          temp[i,j].R:=rinda[i].rgbtRed;
          temp[i,j].G:=rinda[i].rgbtGreen;
          temp[i,j].B:=rinda[i].rgbtBlue;
          //intensity for every pixel
          temp[i,j].I := ((77*temp[i,j].R + 150*temp[i,j].G +
              29*temp[i,j].B) div 256);
        end;
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
        2: begin
         rinda[i].rgbtRed:=temp[i,j].R;
         rinda[i].rgbtGreen:=temp[i,j].G;
         rinda[i].rgbtBlue:=temp[i,j].B;
         img[i,j].segment := 0;
         img[i,j].R:= temp[i,j].R;
         img[i,j].G:= temp[i,j].G;
         img[i,j].B:= temp[i,j].B;
        end;
        end;
      end;
    end;
  Image1.Refresh;
end;

procedure TMain_menu.segmentToImage();
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
         if (img[i,j].segment = -1) then
         begin
            rinda[i].rgbtRed:=0;
            rinda[i].rgbtGreen:=255;
            rinda[i].rgbtBlue:=0;
         end else
         begin
            if (img[i,j].segment = 0) then
            begin
              rinda[i].rgbtRed:=img[i,j].R;
              rinda[i].rgbtGreen:=img[i,j].G;
              rinda[i].rgbtBlue:=img[i,j].B;
            end;
         end;
      end;
    end;
  Image1.Refresh;
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
  begin
   BMP.Assign(Image1.Picture.Bitmap);
  BMP.SaveToFile(dlgSave1.FileName + '.bmp');
    end;
  end;
  end;

procedure TMain_menu.Button2Click(Sender: TObject);
Var i, j :Integer;
begin
 for j:=0 to High(img[0]) do
    begin
      for i:=0 to High(img) do
        begin
           img[i,j].R:= temp[i,j].R;
           img[i,j].G:= temp[i,j].G;
           img[i,j].B:= temp[i,j].B;
           img[i,j].I:= temp[i,j].I;
           img[i,j].segment := 0;
        end;
    end;
  imgToImage1(2);
  label2.Caption := '';
end;

procedure TMain_menu.TurnRight(var dir:Direction);
begin
  Case dir.direct of
    1: begin // UP
      dir.direct := 2;
      dir.x := dir.x + 1;
    end;
    2: begin // RIGHT
      dir.direct := 4;
      dir.y := dir.y + 1;
    end;
    3: begin // LEFT
      dir.direct := 1;
      dir.y := dir.y - 1;
    end;
    4: begin // DOWN
      dir.direct := 3;
      dir.x := dir.x - 1;
    end;
  else label2.Caption:='Direction is Unknown!';
  end;
end;

procedure TMain_menu.TurnLeft(var dir:Direction);
begin
  Case dir.direct of
    1: begin // UP
      dir.direct := 3;
      dir.x := dir.x - 1;
    end;
    2: begin // RIGHT
      dir.direct := 1;
      dir.y := dir.y - 1;
    end;
    3: begin // LEFT
      dir.direct := 4;
      dir.y := dir.y + 1;
    end;
    4: begin // DOWN
      dir.direct := 2;
      dir.x := dir.x + 1;
    end;
  else label2.Caption:='Direction is Unknown!';
  end;
end;

procedure TMain_menu.TurnBack(var dir:Direction);
begin
  Case dir.direct of
    1: begin // UP
      dir.direct := 4;
      dir.y := dir.y + 1;
    end;
    2: begin // RIGHT
      dir.direct := 3;
      dir.x := dir.x - 1;
    end;
    3: begin // LEFT
      dir.direct := 2;
      dir.x := dir.x + 1;
    end;
    4: begin // DOWN
      dir.direct := 1;
      dir.y := dir.y - 1;
    end;
  else label2.Caption:='Direction is Unknown!';
  end;
end;

procedure TMain_menu.Kukainis();
Var X,Y :Integer;       // objekta pirmie koordinati
    i,j, ind, maxX, maxY, minX, minY, cc :Integer;
    B :Byte;          // apskatama piksela intensitate
    dir :Direction;   // virziens un tekosie koordinati
begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  minX := 9999; minY := 9999;
  maxX := 0; maxY := 0;
  cc := 0;
  for j:=0 to High(img[0])-1 do
    for i:=0 to High(img)-1 do
      begin
          B := img[i,j].R;
          if (((B = 0) and (img[i,j].segment=0))     // neapstradam jau apskatitus pikselus
          and (((i > maxX) or (i < minX)) and ((j < minY) or (j > maxY))) ) then
          begin
            X := i;
            Y := j;
            img[X,Y].segment := -1;
            dir.direct := 1;
            dir.x := X;
            dir.y := Y-1;
            minX := 9999; minY := 9999;
            maxX := 0; maxY := 0;
            while ((dir.x <> X) or (dir.y <> Y)) do
            begin
              B := img[dir.x, dir.y].R;
              if (B = 0) then
              begin
                if (dir.x > maxX) then maxX := dir.x;
                if (dir.y > maxY) then maxY := dir.y;
                if (dir.x < minX) then minX := dir.x;
                if (dir.y < minY) then minY := dir.y;
                img[dir.x, dir.y].segment := -1;
                if (CheckBox1.Checked = true) then  // parbaude uz uzlaboto kukainu
                begin
                    TurnBack(dir);
                    TurnRight(dir);
                end else TurnLeft(dir);
              end else
              begin
                TurnRight(dir);               // pagriezties pa labi
              end;
            end;
            cc:= cc+1;                        // objektu skaits
        end; //if
    end; //for
    Label2.Caption:='Objektu skaits: '+IntToStr(cc);
    segmentToImage();
end;

procedure TMain_menu.Button1Click(Sender: TObject);
var s:TStack;
x,y,i,j,count,T,skaits:integer;
ir_obj:bool;  //ja pikselis pieder objektam
obj: array of integer; // objektu masivs
rinda:pRGBTripleArray;
begin
skaits:= 0;
// Sakotnejie uzstadijumi
SetLength(S,1);
SetLength(obj, 1);
obj[0]:=Img[0,0].i;
S[0].x:=0;
S[0].y:=0;
T:=1;
IMG[0,0].segment:=1;
count:=0;
//pikselu kaiminu parbaudes cikls
repeat
  x:= s[0].x;
  y:= s[0].y;
  for j:=-1 to 1 do
  for i:=-1 to 1 do
  begin      // parbaude uz attela robezam
    if ((x+i>0)and(x+i<Length(img))and  // x
        (y+j>0)and(y+j<Length(img[0])))then  // y
    begin
      {apskata kaimina pikseli, ja izpildas nosacijums ar slieksni T
      un ja apskatamais px vel nepieder segmentam (vienads ar 0),
      tad pieskaita pikseli apgabalam }
        if (Abs(IMG[x,y].i-IMG[x+i,y+j].i)<T) And (IMG[x+i,y+j].segment=0)then
        begin
            Inc(count);
            SetLength(S,count+1);
            IMG[x+i,y+j].segment:=1;
            s[count].x:=x+i;
            s[count].y:=y+j;
            // pieskaita fonam neapstradatas
        end else if IMG[x,y].segment=0 then IMG[x,y].segment:=-1;
    end;
  end;
  if (count<>0) then
  begin
      for i:=0 to count-1 do
      begin
         S[i]:=S[i+1];
      end;
     SetLength(S,count);
  end;
  dec(count);
until count<0;
//Iekrasam segmentus
begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  for j:=1 to High(img[0]) do
    begin
      rinda:=Image1.Picture.Bitmap.ScanLine[j];
      for i:=1 to High(img) do
        begin
            ir_obj:=false;
            for count:=0 to Length(obj) do
            begin
                //Nosacijuma izpildes bloks
                if Abs(IMG[i,j].i-obj[count]) < T then
                begin
                    ir_obj:=true;
                end;
            end;
            if img[i,j].segment=0 then
            begin
              img[i,j].R:=0;
              img[i,j].G:=0;
              img[i,j].B:=0;
            end;
            if ir_obj=false then
            begin
                inc(skaits);
                SetLength(obj,skaits);
                obj[skaits-1]:=IMG[i,j].i;
            end;
            rinda[i].rgbtRed:=img[i,j].R;
            rinda[i].rgbtGreen:=img[i,j].G;
            rinda[i].rgbtBlue:=img[i,j].B;
            img[i,j].i:=(77*img[i,j].R+150*img[i,j].G+29*img[i,j].B)div 256;
        end;
    end;
  Image1.Refresh;
  Kukainis();
end;
end;

end.

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
    id: integer;
  end;

  type
  Direction = record
    direct :Integer;
    x,y :Integer;
  end;

  TStack = array of record    // massivs kas glaba pikselu koordinates
	x, y: integer;
  end;

  vert = array of record    // kontura punkti
	x, y :Integer;
  end;

  vertexType = record     // objekta virsotnu tips
  x,y: Integer;
  angle: real;
  end;

  ObjectVertexSet = record
  vertex: array[0..3] of vertexType;  // objekta virsotnu masivs
  is4Vert :boolean;
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
    CheckBox1: TCheckBox;
    Button3: TButton;
    Label1: TLabel;

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
    procedure findAllVertixes();
    procedure calculateAngles();
    function getDistanceBetween(X1,Y1,X2,Y2 :Integer):real;
    procedure Button1Click(Sender: TObject);
    procedure classifyObjects(AC,BC,DB,AD :array of real);
    procedure Button3Click(Sender: TObject);

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
  objects: array of vert;
  vertexSet :array of ObjectVertexSet;
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
  Try
  Application.Terminate;
  Except
  End;
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

function TMain_menu.getDistanceBetween(X1,Y1,X2,Y2 :Integer):real;
var res: real;
begin
res := sqrt((sqr(x1-x2))+(sqr(y1-y2)));
getDistanceBetween:=res;
end;

procedure TMain_menu.findAllVertixes();
var i,j,k, maxX, maxY, jD, vertCt: integer;
    distance1, distance2, maxDist, vertDist: real;
begin
  maxDist := 0;
  maxX:=0;
  maxY:=0;
  for i:=0 to length(objects)-1 do
  begin
    distance1:=0;
    distance2:=0;
    vertexSet[i].is4Vert := false;
    jD:=0;
    for j:=0 to length(objects[i])-1 do
    begin
      distance1:= getDistanceBetween(objects[i][0].x,objects[i][0].y,objects[i][j].x, objects[i][j].y);
      if (distance1 > maxDist) then
      begin
        maxDist:=distance1;
        maxX:=objects[i][j].x;
        maxY:=objects[i][j].y;
        jD:=j;
      end;
    end;
    img[maxX,maxY].segment:=2;
    vertexSet[i].vertex[1].X:=maxX;
    vertexSet[i].vertex[1].Y:=maxY;
    maxDist:=0;
    vertCt:=0;
    vertDist:=0;
    vertDist:= getDistanceBetween(vertexSet[i].vertex[0].X,vertexSet[i].vertex[0].Y, vertexSet[i].vertex[1].X, vertexSet[i].vertex[1].Y);

    for k:=0 to jD do
    begin
      if (jD<length(objects[i])) then
      begin
          distance1:= getDistanceBetween(vertexSet[i].vertex[0].X,vertexSet[i].vertex[0].Y, objects[i][k].x, objects[i][k].y);
          distance2:= getDistanceBetween(vertexSet[i].vertex[1].X,vertexSet[i].vertex[1].Y, objects[i][k].x, objects[i][k].y);
          if ((distance1+distance2 > maxDist)) then
          begin
            maxDist:=distance1+distance2;
            maxX:=objects[i][k].x;
            maxY:=objects[i][k].y;
          end;
      end;
    end;
    if (abs(maxDist-vertDist)> 5) then
    begin
      img[maxX,maxY].segment:=2;
      if (length(vertexSet) > i) then
      begin
        vertexSet[i].vertex[2].X:=maxX;
        vertexSet[i].vertex[2].Y:=maxY;
        vertCt:=vertCt+1;
      end;
    end;
    maxDist:=0;

    for k:=jD to length(objects[i])-1 do
    begin
      if (jD<length(objects[i])) then
      begin
          distance1:= getDistanceBetween(vertexSet[i].vertex[0].X,vertexSet[i].vertex[0].Y, objects[i][k].x, objects[i][k].y);
          distance2:= getDistanceBetween(vertexSet[i].vertex[1].X,vertexSet[i].vertex[1].Y, objects[i][k].x, objects[i][k].y);
          if ((distance1+distance2 > maxDist)) then
          begin
            maxDist:=distance1+distance2;
            maxX:=objects[i][k].x;
            maxY:=objects[i][k].y;
         end;
      end;
    end;
    if (abs(maxDist-vertDist)> 5) then
    begin
      img[maxX,maxY].segment:=2;
      if (length(vertexSet) > i) then
      begin
        if (vertCt=0) then
        begin
          vertexSet[i].vertex[2].X:=maxX;
          vertexSet[i].vertex[2].Y:=maxY;
        end else
        begin
          vertexSet[i].vertex[3].X:=maxX;
          vertexSet[i].vertex[3].Y:=maxY;
        end;
        vertCt:=vertCt+1;
      end;
    end;
    maxDist:=0;
    if(vertCt=2) then vertexSet[i].is4Vert := true;
  end;
  calculateAngles();
end;

procedure TMain_menu.calculateAngles();
var i       :integer;
    AB,AC,BC,AD,DC,DB  :array of real;
begin
  SetLength(AB,length(vertexSet));
  SetLength(AC,length(vertexSet));
  SetLength(BC,length(vertexSet));
  SetLength(AD,length(vertexSet));
  SetLength(DC,length(vertexSet));
  SetLength(DB,length(vertexSet));

  for i:=0 to length(vertexSet)-1 do
  begin
    if (vertexSet[i].is4Vert) then
    begin
        AB[i] := getDistanceBetween(vertexSet[i].vertex[0].x,vertexSet[i].vertex[0].y,vertexSet[i].vertex[1].x,vertexSet[i].vertex[1].y);
        AC[i] := getDistanceBetween(vertexSet[i].vertex[0].x,vertexSet[i].vertex[0].y,vertexSet[i].vertex[2].x,vertexSet[i].vertex[2].y);
        BC[i] := getDistanceBetween(vertexSet[i].vertex[1].x,vertexSet[i].vertex[1].y,vertexSet[i].vertex[2].x,vertexSet[i].vertex[2].y);
        AD[i] := getDistanceBetween(vertexSet[i].vertex[0].x,vertexSet[i].vertex[0].y,vertexSet[i].vertex[3].x,vertexSet[i].vertex[3].y);
        DC[i] := getDistanceBetween(vertexSet[i].vertex[3].x,vertexSet[i].vertex[3].y,vertexSet[i].vertex[2].x,vertexSet[i].vertex[2].y);
        DB[i] := getDistanceBetween(vertexSet[i].vertex[3].x,vertexSet[i].vertex[3].y,vertexSet[i].vertex[1].x,vertexSet[i].vertex[1].y);

        vertexSet[i].vertex[3].angle := arccos((sqr(DB[i])+sqr(AD[i])-sqr(AB[i]))/(2*DB[i]*AD[i]))*180/Pi;
        vertexSet[i].vertex[1].angle := arccos((sqr(DB[i])+sqr(BC[i])-sqr(DC[i]))/(2*DB[i]*BC[i]))*180/Pi;
        vertexSet[i].vertex[0].angle := 180 - vertexSet[i].vertex[3].angle;
        vertexSet[i].vertex[2].angle := 180 - vertexSet[i].vertex[1].angle;
    end else
    begin
        AB[i] := getDistanceBetween(vertexSet[i].vertex[0].x,vertexSet[i].vertex[0].y,vertexSet[i].vertex[1].x,vertexSet[i].vertex[1].y);
        AC[i] := getDistanceBetween(vertexSet[i].vertex[0].x,vertexSet[i].vertex[0].y,vertexSet[i].vertex[2].x,vertexSet[i].vertex[2].y);
        BC[i] := getDistanceBetween(vertexSet[i].vertex[1].x,vertexSet[i].vertex[1].y,vertexSet[i].vertex[2].x,vertexSet[i].vertex[2].y);
        if ((round(AB[i])=0) or (round(AC[i])=0) or (round(BC[i])=0)) then
        begin
          vertexSet[i].vertex[0].angle:=0;
          vertexSet[i].vertex[1].angle:=0;
          vertexSet[i].vertex[2].angle:=0;
        end
        else begin
          vertexSet[i].vertex[0].angle := arccos((AC[i]*AC[i]+AB[i]*AB[i]-BC[i]*BC[i])/(2*AC[i]*AB[i]))*180/Pi;
          vertexSet[i].vertex[1].angle := arccos((BC[i]*BC[i]+AB[i]*AB[i]-AC[i]*AC[i])/(2*BC[i]*AB[i]))*180/Pi;
          vertexSet[i].vertex[2].angle := 180-vertexSet[i].vertex[0].angle-vertexSet[i].vertex[1].angle;
        end;
    end;
  end;
  classifyObjects(AC,BC,DB,AD);
end;

procedure TMain_menu.classifyObjects(AC,BC,DB,AD :array of real);
var i,j :integer;
    angle :array of array of integer;
    objectIndex :array of integer;
begin
    SetLength(angle,length(vertexSet), 4);
    SetLength(objectIndex,length(vertexSet));
    for i:=0 to length(vertexSet)-1 do
      for j:=0 to 3 do
      begin
        if (j=3) then
        begin
            if (vertexSet[i].is4Vert) then
            angle[i,j]:= round(vertexSet[i].vertex[j].angle)
            else angle[i,j]:= 0;
        end else
        begin
            angle[i,j]:= round(vertexSet[i].vertex[j].angle);
        end;
      end;

    for i:=0 to length(vertexSet)-1 do
    begin
      if (vertexSet[i].is4Vert) then
      begin
          if ((abs(angle[i,0]-90)<3) and (abs(angle[i,1]-90)<3) and (abs(angle[i,2]-90)<3)) then
          begin
              if ((abs(AC[i]-BC[i])<4) and (abs(AC[i]-DB[i])<4) and (abs(AC[i]-AD[i])<4)) then
              objectIndex[i] := 5 else objectIndex[i] := 6;
          end else
          if (((abs(angle[i,0]-90)<3) and (abs(angle[i,3]-90)<3)) or ((abs(angle[i,1]-90)<3) and (abs(angle[i,2]-90)<3))) then objectIndex[i] := 8
          else
          if ((abs(AD[i]-BC[i])<3) or (abs(AC[i]-DB[i])<3)) then objectIndex[i] := 7
          else objectIndex[i] := 9;
      end else
      begin
          objectIndex[i] := 4;
          if ((abs(angle[i,0]-90)<2) or (abs(angle[i,1]-90)<2) or (abs(angle[i,2]-90)<2)) then objectIndex[i] := 1 else
          begin
            if ((abs(angle[i,0]-angle[i,1])<6) and (abs(angle[i,0]-angle[i,2])<6)) then objectIndex[i] := 3 else
            begin
              if ((abs(angle[i,0]-angle[i,1])<2) or (abs(angle[i,0]-angle[i,2])<2) or (abs(angle[i,1]-angle[i,2])<2)) then objectIndex[i] := 2;
            end;
          end;
      end;

    end;
    segmentToImage();

    Image1.Canvas.Font.Name := 'Tahoma';
    Image1.Canvas.Font.Size := 10;
    Image1.Canvas.Font.Color := clGreen;
    Image1.Canvas.Font.Style := [fsItalic, fsBold];
    Image1.Canvas.Brush.Color := clSilver;
    
    for i:=0 to length(vertexSet)-1 do
    begin
      Case objectIndex[i] of
        1 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+40, 'Taisnlenka trijsturis');
        2 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+40, 'Vienadsanu trijsturis');
        3 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+40, 'Vienadmalu trijsturis');
        4 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+40, 'Dazhadmalu trijsturis');
        5 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+30, 'Kvadrats');
        6 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+30, 'Taisnsturis');
        7 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+30, 'Vienadsanu trapece');
        8 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+30, 'Taisnlenka trapece');
        9 : image1.Canvas.TextOut(vertexSet[i].vertex[0].x-20, vertexSet[i].vertex[0].y+30, 'Dazhadsanu trapece');
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
            if (img[i,j].segment = 2) then
            begin
              rinda[i].rgbtRed:=255;
              rinda[i].rgbtGreen:=0;
              rinda[i].rgbtBlue:=0;
              Image1.Canvas.Brush.Color := clRed;
              image1.Canvas.Ellipse(i-4,j-4,i+4,j+4);
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
  label1.Caption:= '';
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
  setLength(objects,0);
  setLength(vertexSet,0);
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
  end;
end;

procedure TMain_menu.Kukainis();
Var X,Y :Integer;       // objekta pirmie koordinati
    i,j, ind, cc, points, ped_px, ch, check :Integer;
    B :Byte;          // apskatama piksela intensitate
    dir :Direction;   // virziens un tekosie koordinati
begin
  Image1.Picture.Bitmap.Width:=Length(img);
  Image1.Picture.Bitmap.Height:=Length(img[0]);
  Image1.Picture.Bitmap.PixelFormat:=pf24bit;
  cc := 0;
  SetLength(Objects, 1);
  SetLength(Objects[0], 1);
  ped_px:=255;
  for j:=0 to High(img[0])-1 do
    for i:=0 to High(img)-1 do
      begin
          B := img[i,j].R;
          if ((B = 0) and (img[i,j].segment=0) and (ped_px<>0)) then    // neapstradam jau apskatitus pikselus
          begin
          if ((i > 0) and (i < high(img)-1)) then
          if ((img[i+1,j].segment = 0)) then
          begin
            SetLength(Objects[cc], 1);
            objects[cc][0].x := i;
            objects[cc][0].y := j;
            X := i;
            Y := j;
            points:=1;
            img[i,j].segment := 2;
            SetLength(vertexSet, cc+1);
            vertexSet[cc].vertex[0].X:=i;
            vertexSet[cc].vertex[0].Y:=j;
            dir.direct := 1;
            dir.x := X;
            dir.y := Y-1;
            while ((dir.x <> X) or (dir.y <> Y)) do
            begin
              B := img[dir.x, dir.y].R;
              if (B = 0) then
              begin
                img[dir.x, dir.y].segment := -1;
                SetLength(Objects[cc], points+1);
                objects[cc][points].x := dir.x;
                objects[cc][points].y := dir.y;
                points:= points+1;
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
            if (cc=0) then
            begin
              SetLength(Objects, 2);
              cc:= 1;
            end else
            begin
              cc:=cc+1;
              SetLength(Objects, cc+1);
            end;
            end;  // algoritma beigas
        end; //if
        ped_px:=img[i,j].R;
    end; //for
    Label1.Caption:='Objektu skaits: '+IntToStr(cc);
    findAllVertixes();
end;

procedure TMain_menu.Button1Click(Sender: TObject);
var s:TStack;
x,y,i,j,count,T,skaits :integer;
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
            for count:=0 to Length(obj)-1 do
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

procedure TMain_menu.Button3Click(Sender: TObject);
Var pol:array[1..3] of TPoint;
    polK:array[1..4] of TPoint;
i,j, ran:integer;
begin
  if (image1.Height=bmp.Height) then button2.Click();
  bmp.Width:=777;
  bmp.Height:=425;
  bmp.PixelFormat:=pf24bit;

  for j:=0 to bmp.height-1 do
    for i:=0 to bmp.width-1 do
    begin
      bmp.Canvas.Pixels[i,j]:=clwhite;
    end;
 bmp.Canvas.pen.Color:=clgreen;
 bmp.Canvas.brush.Color:=clgreen;

 ran:=150+Random(40);
 pol[1].X:=50; pol[1].Y:=50;
 pol[2].X:=ran; pol[2].Y:=50;
 pol[3].X:=round((ran+50)/2);
 pol[3].Y:=round((pol[1].Y + pol[2].Y + (pol[2].X-pol[1].X)*sqrt(3))/2);

 bmp.Canvas.Polygon(pol);
 bmp.Canvas.pen.Color:=clpurple;
 bmp.Canvas.brush.Color:=clpurple;
 pol[1].X:=400; pol[1].Y:=100+Random(100);
 pol[2].X:=300; pol[2].Y:=120;
 pol[3].X:=Round(Cos(radtodeg(60))*(pol[2].X-pol[1].X)-(pol[2].y-pol[1].y)*Sin(radtodeg(60))+pol[1].x);
 pol[3].Y:=Round(Cos(radtodeg(60))*(pol[2].y-pol[1].y)+(pol[2].x-pol[1].x)*Sin(radtodeg(60))+pol[1].y);
 bmp.Canvas.Polygon(pol);

 bmp.Canvas.pen.Color:=clblue;
 bmp.Canvas.brush.Color:=clblue;
 pol[1].X:=150; pol[1].Y:=250+Random(50);
 pol[2].X:=50; pol[2].Y:=350;
 pol[3].X:=200; pol[3].Y:=400;

 bmp.Canvas.Polygon(pol);

 bmp.Canvas.pen.Color:=clred;
 bmp.Canvas.brush.Color:=clred;
 pol[1].X:=300; pol[1].Y:=250+Random(50);
 pol[2].X:=300; pol[2].Y:=400;
 pol[3].X:=400; pol[3].Y:=400;

 bmp.Canvas.Polygon(pol);

 //kvadrats
 bmp.Canvas.pen.Color:=clMaroon;
 bmp.Canvas.brush.Color:=clMaroon;
 ran := 50+Random(40);
 polk[1].X:=190;        polk[1].Y:=150;
 polk[2].X:=polk[1].X+ran;  polk[2].Y:=polk[1].Y;
 polk[3].X:=polk[1].X;      polk[3].Y:=polk[1].Y+ran;
 polk[4].X:=polk[2].X;      polk[4].Y:=polk[3].Y;
 bmp.Canvas.Rectangle(polk[1].x, polk[1].y, polk[4].x, polk[4].y);

 //taisnsturis
 bmp.Canvas.pen.Color:=clAqua;
 bmp.Canvas.brush.Color:=clAqua;
 ran := 50+Random(50);
 polk[1].X:=480;        polk[1].Y:=30;
 polk[2].X:=polk[1].X+ran;  polk[2].Y:=polk[1].Y;
 polk[3].X:=polk[1].X;      polk[3].Y:=polk[1].Y+ran+60;
 polk[4].X:=polk[2].X;      polk[4].Y:=polk[3].Y;
 bmp.Canvas.Rectangle(polk[1].x, polk[1].y, polk[4].x, polk[4].y);

 // taisnlenka trapece
 bmp.Canvas.pen.Color:=clgreen;
 bmp.Canvas.brush.Color:=clgreen;
 ran := 100+Random(20);
 polk[1].X:=450 + Random(20); polk[1].Y:=270;
 polk[2].X:=520; polk[2].Y:=polk[1].Y;
 polk[3].X:=630; polk[3].Y:=polk[1].Y+ran;
 polk[4].X:=polk[1].X; polk[4].Y:=polk[1].Y+ran;
 bmp.Canvas.Polygon(polk);

 // vienadsanu trapece
 bmp.Canvas.pen.Color:=clyellow;
 bmp.Canvas.brush.Color:=clyellow;
 ran := 100+Random(20);
 polk[1].X:=660;                        polk[1].Y:=30;
 polk[2].X:=polk[1].X + 30+Random(30);  polk[2].Y:=polk[1].Y;
 polk[3].X:=polk[2].X + 30;             polk[3].Y:= 100;
 polk[4].X:=polk[1].X - 30;             polk[4].Y:= 100;
 bmp.Canvas.Polygon(polk);

 // dazadsanu trapece
 bmp.Canvas.pen.Color:=clactivecaption;
 bmp.Canvas.brush.Color:=clactivecaption;
 ran := 50+Random(20);
 polk[1].X:=660;                        polk[1].Y:=200;
 polk[2].X:=polk[1].X + ran;            polk[2].Y:=polk[1].Y;
 polk[3].X:=polk[2].X + 30;             polk[3].Y:= 270;
 polk[4].X:=polk[1].X - 60;             polk[4].Y:= 270;
 bmp.Canvas.Polygon(polk);

 ReadFromBMP();
 imgToImage1(0);
 image1.Height:=bmp.Height;
 image1.Width:=bmp.Width;
end;

end.

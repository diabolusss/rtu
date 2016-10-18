unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,
  OpenGL, StdCtrls, ExtCtrls, Math;

type
  TCoord = Record               //koordinates, tips, glabaa x,y,z
    X, Y, Z : glFLoat;
  end;

  TFace = Record                //Poligonu tips
    Count : Integer;            //Cik virsotnes poligonaa
    vIndex : Array of Integer;  //virsotnu indeksi
    nIndex : Array of Integer;  //normales indeksi
  end;

  TModel = Record               //Modela tips
    MinV : GLFloat;             //minimala koordinates vertiba (nepiecieshama normalizacijai)
    MaxV : GLFloat;             //maximala koordinates vertiba (nepiecieshama normalizacijai)
    V    : Array of TCoord;     //Virsotnu masivs
    N    : Array of TCoord;     //normalu masivs
    F    : Array of TFace;      //poligonu masivs
  end;

  TfrmGL = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Rotation1: TMenuItem;
    RotateX1: TMenuItem;
    RotateY1: TMenuItem;
    RotateZ1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    DC : HDC;
    hrc: HGLRC;
  end;

var
  frmGL: TfrmGL;
  M: TModel;          //modelis

  Open:boolean=false; //kontrole, vai modela fails bija atverts

  Angle : glInt=0;  //pa kadu lenki rotet?

  RotateX,RotateY: integer; //Peles rotacijai
  mDown: boolean; //peles taustinsh nospiests?

implementation

{$R *.DFM}
{=======================================================================
funkcija koordinashu nolasishanai}
Function GetCoord(S: String):TCoord;
var am: array of integer; //atstarpes indeksi
    i: integer;
begin
  SetLength(am,0);

  for i:=1 to Length(S) do
    begin
      if S[i]='.' then S[i]:=',';
      if S[i]=' ' then
        begin
          SetLength(am,Length(am)+1);
          am[High(am)]:=i;
        end;
    end;

  Result.X:=StrToFloat(Copy(S,am[0]+1,
                       am[1]-am[0]-1));
  Result.Y:=StrToFloat(Copy(S,am[1]+1,
                       am[2]-am[1]-1));
  Result.Z:=StrToFloat(Copy(S,am[2]+1,
                       am[3]-am[2]-1));

  //minmax vertibas normalizacijai
  M.MinV:=Min(M.MinV,Min(Result.X,
           Min(Result.Y,Result.Z)));
  M.MaxV:=Max(M.MaxV,Max(Result.X,
           Max(Result.Y,Result.Z)));
end;

function GetFaces(S: String):TFace;
var am: array of integer;
    sm: array of integer;
    i: integer;
begin
  SetLength(am,0);
  SetLength(sm,0);

  for i:=1 to Length(S) do
    begin
      if S[i]='.' then S[i]:=',';
      //nolasam atstarpes
      if S[i]=' ' then
        begin
          SetLength(am,Length(am)+1);
          am[High(am)]:=i;
        end;
      //nolasam sleshus
      if S[i]='/' then
        begin
          SetLength(sm,Length(sm)+1);
          sm[High(sm)]:=i;
        end;
    end;
    Result.Count:=Length(am)-1;
    SetLength(Result.vIndex,Result.Count);
    SetLength(Result.nIndex,Result.Count);

    for i:=0 to Result.Count-1 do
      begin
        Result.vIndex[i]:=StrToInt(
        Copy(S,am[i]+1,sm[2*i]-am[i]-1))-1;
        Result.nIndex[i]:=StrToInt(
        Copy(S,sm[2*i+1]+1,am[i+1]-
        sm[2*i+1]-1))-1;
      end;
end;

{=======================================================================
Ielade no faila}
procedure LoadFromFile(FileName: String);
var f: TextFile;
    S: String;
    i: integer;
begin
  //modela attirishana
  with M do
    begin
      MaxV:=0;
      MinV:=0;
      SetLength(V,0);
      SetLength(N,0);
      SetLength(F,0);
    end;

  AssignFile(f, FileName);
  Reset(f);
    Repeat
      ReadLn(f,S);
    if (Length(S)>0) and
    not (S[Length(S)]=' ') then
    begin
      SetLength(S,Length(S)+1);
      S[Length(S)]:=' ';
    end;
      if Copy(S,0,2)='v ' then
        begin
          SetLength(M.V,Length(M.V)+1);
          M.V[High(M.V)]:=GetCoord(S);
        end;
      if Copy(S,0,2)='vn' then
        begin
          SetLength(M.N,Length(M.N)+1);
          M.N[High(M.N)]:=GetCoord(S);
        end;
      if Copy(S,0,2)='f ' then
        begin
          SetLength(M.F,Length(M.F)+1);
          M.F[High(M.F)]:=GetFaces(S);
        end;
    Until EOF(f);
  CloseFile(f);
  Open:=true;
  //nolasitas koordinates janormalizee
  for i:=0 to High(M.V) do
    begin
      M.V[i].X:=M.V[i].X/(M.MaxV+
                          abs(M.MinV));
      M.V[i].Y:=M.V[i].Y/(M.MaxV+
                          abs(M.MinV));
      M.V[i].Z:=M.V[i].Z/(M.MaxV+
                          abs(M.MinV));
    end;
end;
{=======================================================================
Modela zimeshana}
procedure DrawModel(M:TModel);
var i,j: integer;
begin
  if Open then
    begin
      for i:=0 to High(M.F) do
        begin
          case M.F[i].Count of
            3: glBegin(GL_TRIANGLES);
            4: glBegin(GL_QUADS);
            else
               glBegin(GL_POLYGON);
          end;
            for j:=0 to M.F[i].Count-1 do
              begin
                glNormal3f(M.N[M.F[i].nIndex[j]].X,
                           M.N[M.F[i].nIndex[j]].Y,
                           M.N[M.F[i].nIndex[j]].Z);
                glVertex3f(M.V[M.F[i].vIndex[j]].X,
                           M.V[M.F[i].vIndex[j]].Y,
                           M.V[M.F[i].vIndex[j]].Z);
              end;
          glEnd();
        end;
    end;
end;

{=======================================================================
Loga parzimeshana}
procedure TfrmGL.FormPaint(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // attira ekranu un dziluma buferi

  Angle :=(Angle + 1) mod 360;   //maina lenki

  glPushMatrix;   //ieladejam matricu
  if RotateX1.Checked then glRotatef(Angle, 1, 0, 0);    //rotacija x
  if RotateY1.Checked then glRotatef(Angle, 0, 1, 0);    //rotacija y
  if RotateZ1.Checked then glRotatef(Angle, 0, 0, 1);    //rotacija z
  DrawModel(M);  //modela parzimeshanas procedura
  glPopMatrix;   //izvadam matricu

  SwapBuffers(DC);          //no atminas bufera uz ekranu
  InvalidateRect(Handle, nil, False);    //refresh
end;

{=======================================================================
Piksela formats}
procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

{=======================================================================
Formas veidoshana}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.0, 0.0, 0.0, 1.0);
  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);
  glEnable (GL_DEPTH_TEST);
end;

{=======================================================================
Formas iznicinashana}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;

{=======================================================================
Atvershanas dialogs}
procedure TfrmGL.Open1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then LoadFromFile(OpenDialog1.FileName);
end;

{=======================================================================
Formas izmera izmaina}
procedure TfrmGL.FormResize(Sender: TObject);
begin
  glViewPort(0,0,clientWidth, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(30.0,  ClientWidth / ClientHeight, 1.0, 15.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, -5.0);
  InvalidateRect(Handle, nil, False);
end;

{=======================================================================
Peles taustinsh nospiests}
procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mDown:=true;
end;

{=======================================================================
Peles taustinsh atlaists}
procedure TfrmGL.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mDown:=False;
end;

{=======================================================================
Peles parbidishana}
procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If mDown then
    begin
      glRotatef(RotateY-y, 1.0, 0.0, 0.0);
      glRotatef(RotateX-x, 0.0, 0.0, 1.0);
      RotateY:=Y;
      RotateX:=X;
      InvalidateRect(Handle, nil, False);
    end;
end;

end.


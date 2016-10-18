unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,
  OpenGL;

type
  TfrmGL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    DC : HDC;
    hrc: HGLRC;
  end;

var
  frmGL: TfrmGL;

implementation

{$R *.DFM}

{=======================================================================
parzimeshana}
procedure TfrmGL.FormPaint(Sender: TObject);
begin
 // krasas bufera attirishana
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  //objekts
  glBegin(GL_QUADS);
  glNormal3f(0.0,0.0,1.0);
  glVertex3f(1.0,1.0,1.0);
  glVertex3f(-1.0,1.0,1.0);
  glVertex3f(-1.0,-1.0,1.0);
  glVertex3f(1.0,-1.0,1.0);
  glEnd;

  glBegin(GL_QUADS);
   glNormal3f(-1.0,0.0,0.0);
  glVertex3f(-1.0,1.0,1.0);
  glVertex3f(-1.0,1.0,-1.0);
  glVertex3f(-1.0,-1.0,-1.0);
  glVertex3f(-1.0,-1.0,1.0);
  glEnd;

  glBegin(GL_QUADS);
   glNormal3f(0.0,1.0,0.0);   
  glVertex3f(-1.0,1.0,-1.0);
  glVertex3f(-1.0,1.0,1.0);
  glVertex3f(1.0,1.0,1.0);
  glVertex3f(1.0,1.0,-1.0);
  glEnd;

 SwapBuffers(DC);
end;

{=======================================================================
piksela formats}
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
formas veidoshana}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glClearColor (0.5, 0.5, 0.75, 1.0); // fona krasa
 glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);
 glEnable(GL_DEPTH_TEST);
end;

{=======================================================================
formas iznicinashana}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;

{=======================================================================
formas izmera izmainas}
procedure TfrmGL.FormResize(Sender: TObject);
begin
 glViewport(0, 0, ClientWidth, ClientHeight);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   gluPerspective(30.0,ClientWidth/ClientHeight,1.0,15.0);

   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity;
   glTranslatef(0.0,0.0,-8.0);//parbide pa z
   glRotate(30.0,1.0,0.0,0.0);//ap x asi
   glRotate(70.0,0.0,1.0,0.0);//ap y asi
 InvalidateRect(Handle, nil, False);
end;


end.


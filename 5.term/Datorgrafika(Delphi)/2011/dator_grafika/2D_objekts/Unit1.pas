unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL, StdCtrls, ExtCtrls;

type
  TfrmGL = class(TForm)
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private
    hrc: HGLRC;
    xpos : GLfloat;
    ypos : GLfloat;
  end;

var
  frmGL: TfrmGL;

implementation

{$R *.DFM}
procedure TfrmGL.FormPaint(Sender: TObject);
begin
 wglMakeCurrent(Canvas.Handle, hrc);

 glViewPort (0, 0, ClientWidth, ClientHeight);

 glClear (GL_COLOR_BUFFER_BIT);

 case RadioGroup1.ItemIndex of
0: 	begin
        begin
			    glPointSize (20);
			    glBegin (GL_POINTS);
			      glVertex2f (xpos,ypos);
          glEnd;
        end
		end;
1:  begin
      glColor3f (1.0, 0.0, 0.5);
      glLineWidth (10*random);
      glBegin (GL_LINES);

        glVertex2f (xpos-0.2,ypos+0.2);
        glVertex2f (xpos+0.2,ypos-0.2);

        glVertex2f (xpos+0.2,ypos+0.2);
        glVertex2f (xpos-0.2,ypos-0.2);
      glEnd;
    end;
2:	begin
		  glColor3f (random, random, random);
		  glBegin (GL_TRIANGLES);
		  glVertex2f (xpos-0.2, ypos-0.4);
		  glVertex2f (xpos+0.2, ypos-0.4);
		  glVertex2f (xpos, ypos+0.4);
		  glEnd;
	  end;
end;
 SwapBuffers(Canvas.Handle);
 wglMakeCurrent(0, 0);
end;

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

procedure TfrmGL.FormCreate(Sender: TObject);
begin
 Randomize;
 SetDCPixelFormat(Canvas.Handle);
 hrc := wglCreateContext(Canvas.Handle);
end;

procedure TfrmGL.FormDestroy(Sender: TObject);
begin
 wglDeleteContext(hrc);
end;

procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    xpos := 2 * X / ClientWidth - 1;
  ypos := 2 * (ClientHeight - Y) / ClientHeight - 1;
  InvalidateRect(Handle, nil, False);
end;

end.


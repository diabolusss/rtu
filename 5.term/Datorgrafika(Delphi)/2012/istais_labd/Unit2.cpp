//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <gl\gl.h>
#include <gl\glu.h>
#include <gl\glaux.h>
#include "Unit2.h"
#include<winuser.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm2 *Form2;
//---------------------------------------------------------------------------
	__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
	{
	Application->OnIdle = IdleLoop;
	}
//---------------------------------------------------------------------------

void __fastcall TForm2::SetPixelFormatDescriptor() {
	PIXELFORMATDESCRIPTOR pfd = {
		sizeof (PIXELFORMATDESCRIPTOR), 1,
		PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
		PFD_TYPE_RGBA, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 0,
		PFD_MAIN_PLANE, 0, 0, 0, 0
		};
		PixelFormat = ChoosePixelFormat (hdc, &pfd);
		SetPixelFormat (hdc, PixelFormat, &pfd);
}

void __fastcall TForm2::IdleLoop(TObject*, bool& done) {
	done = false;
	Form2->Paint();
	//SwapBuffers(hdc);
}

void __fastcall TForm2::FormCreate(TObject *Sender)
{
Form2->BorderStyle=bsNone;
Form2->WindowState=wsMaximized;
hdc=GetDC(Handle);
SetPixelFormatDescriptor();
hrc=wglCreateContext(hdc);
wglMakeCurrent(hdc,hrc);
glEnable(GL_COLOR_MATERIAL);
glEnable (GL_DEPTH_TEST);

}
//---------------------------------------------------------------------------

void __fastcall TForm2::FormDestroy(TObject *Sender)
{
wglMakeCurrent(NULL,NULL);
wglDeleteContext(hrc);
ReleaseDC(Handle, hdc);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FormResize(TObject *Sender)
{
w=ClientWidth;
h=ClientHeight;
if (h == 0) {h = 1;}
	//glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glViewport (0, 0, w, h);
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity();
	glFrustum (-1, 1, -1, 1, 3, 10);
	glTranslatef(0.0, 0.0, -5.0);
	//glMatrixMode (GL_MODELVIEW);
	//glLoadIdentity();
	//gluOrtho2D(0, w, h, 0);
	//InvalidateRect(Handle, nil, False);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FormPaint(TObject *Sender)
{
//glViewport (0,0, ClientWidth, ClientHeight);
//glEnable(GL_SCISSOR_TEST);
//glScissor(0,0, (int)(ClientWidth/2), (int)(ClientHeight/2));
glClearColor(0.75, 0.75, 0.75, 0.1);
glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
glPointSize(10);
glRotatef(alpha,1,1,1);
glBegin(GL_QUADS);
	glColor3f(0, 0, 1.0); //zila mala
	glVertex3f(0.5, 0.5, 0.5);
	glVertex3f(0.5, 0.5, 0.0);
	glVertex3f(0.5, -0.5, 0.0);
	glVertex3f(0.5, -0.5, 0.5);

	glColor3f(0, 1.0, 0.0);   //zalja
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(-0.5, 0.5, 0.0);
	glVertex3f(-0.5, -0.5, 0.0);
	glVertex3f(-0.5, -0.5, 0.5);

	glColor3f(1.0, 0.0, 0.0);   //sarkana
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(-0.5, 0.5, 0.0);
	glVertex3f(0.5, 0.5, 0.0);
	glVertex3f(0.5, 0.5, 0.5);

	glColor3f(1.0, 1.0, 0.0);   //dzeltana
	glVertex3f(-0.5, -0.5, 0.5);
	glVertex3f(-0.5, -0.5, 0.0);
	glVertex3f(0.5, -0.5, 0.0);
	glVertex3f(0.5, -0.5, 0.5);

	glColor3f(0.0, 0.0, 0.0);   //melna
	glVertex3f(-0.5, -0.5, 0.0);
	glVertex3f(-0.5, 0.5, 0.0);
	glVertex3f(0.5, 0.5, 0.0);
	glVertex3f(0.5, -0.5, 0.0);

	glColor3f(1.0, 1.0, 1.0);   //balta
	glVertex3f(-0.5, -0.5, 0.5);
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(0.5, 0.5, 0.5);
	glVertex3f(0.5, -0.5, 0.5);
glEnd();

glRotatef(-alpha,1,1,1);
glFlush();
glLoadIdentity();
SwapBuffers(hdc);


}
//---------------------------------------------------------------------------

void __fastcall TForm2::Timer1Timer(TObject *Sender)
{
alpha++;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Button1Click(TObject *Sender)
{
Form2->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FormKeyPress(TObject *Sender, wchar_t &Key)
{
if( Key == VK_ESCAPE ) Form2->Close();
}
//---------------------------------------------------------------------------

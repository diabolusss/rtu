//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include <gl\gl.h>
 #include <gl\glu.h>
 #include <gl\glaux.h>

#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm2 *Form2;

__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
{
                 Application->OnIdle = IdleLoop;
}

//---------------------------------------------------------------------------
void __fastcall TForm2::SetPixelFormatDescriptor() {

PIXELFORMATDESCRIPTOR pfd = {
	sizeof(PIXELFORMATDESCRIPTOR), 1,
	PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
	PFD_TYPE_RGBA, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	32, 0, 0,
	PFD_MAIN_PLANE, 0, 0, 0, 0,
} ;
PixelFormat = ChoosePixelFormat(hdc, &pfd);
SetPixelFormat(hdc, PixelFormat, &pfd);
}

void __fastcall TForm2::IdleLoop(TObject*, bool& done) {
	done = false;
	SwapBuffers(hdc);

}


//---------------------------------------------------------------------------
void __fastcall TForm2::FormCreate(TObject *Sender)
{
	   hdc = GetDC(Handle);        //get device context from main window
	   SetPixelFormatDescriptor();  //initialize pixel format
	   hrc = wglCreateContext(hdc);   //use device context to create
	   wglMakeCurrent(hdc, hrc);
	   glEnable (GL_COLOR_MATERIAL);
	   glEnable (GL_DEPTH_TEST);
}
//---------------------------------------------------------------------------
void __fastcall TForm2::FormDestroy(TObject *Sender)
{
	   wglMakeCurrent(NULL, NULL);
	   wglDeleteContext(hrc);

}
//---------------------------------------------------------------------------
void __fastcall TForm2::FormResize(TObject *Sender)
{
		w = ClientWidth;
		h = ClientHeight;

		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glViewport (0, 0, w, h);
			glMatrixMode (GL_PROJECTION);
			glLoadIdentity ();
			glMatrixMode (GL_MODELVIEW);
			 glLoadIdentity ();
			 glFlush();
}


//---------------------------------------------------------------------------
void __fastcall TForm2::FormPaint(TObject *Sender)
{
	 glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	 glPushMatrix();//"D"
	 glTranslatef(-0.8,0.6,0.0);
	 glRotatef(alpha,0,0,1);
	 glTranslatef(0.8,-0.6,0.0);
	 glColor3f(0.25, 0.87, 0.35);
	 glBegin(GL_LINE_LOOP);
		glVertex2f(-0.9,0.9);
		glVertex2f(-0.9,0.3);
		glVertex2f(-0.7, 0.35);
		glVertex2f(-0.65, 0.6);
		glVertex2f(-0.7, 0.85);
	glEnd();
	glPopMatrix();

	glPushMatrix();//"a"
	 glTranslatef(-0.25,0.15,0.0);
	 glRotatef(-alpha,0,0,1);
	 glTranslatef(0.25,-0.15,0.0);
	 glColor3f(0.55, 0.17, 0.45);
	glBegin(GL_POLYGON);
		glVertex2f(-0.3,0.4);
		glVertex2f(-0.2,0.4);
		glVertex2f(0.0, -0.1);
		glVertex2f(-0.12, -0.1);
		glVertex2f(-0.2, 0.1);
		glVertex2f(-0.3, 0.1);
		glVertex2f(-0.38, -0.1);
		glVertex2f(-0.5, -0.1);
	glEnd();
	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_POLYGON);
		glVertex2f(-0.25,0.3);
		glVertex2f(-0.22,0.2);
		glVertex2f(-0.28, 0.2);
	glEnd();
	glPopMatrix();

	glPushMatrix();//"d"
	 glTranslatef(0.25,-0.3,0.0);
	 glRotatef(alpha,0,0,1);
	 glTranslatef(-0.25,0.3,0.0);
	glColor3f(0.85, 0.67, 0.35);
	glBegin(GL_QUAD_STRIP);
		glVertex2f(0.2,-0.1);
		glVertex2f(0.3,-0.1);
		glVertex2f(0.4, -0.15);
		glVertex2f(0.45, -0.25);
		glVertex2f(0.45, -0.35);
		glVertex2f(0.4, -0.45);
		glVertex2f(0.3, -0.5);
		glVertex2f(0.2, -0.5);
	glEnd();
	glBegin(GL_POLYGON);
		glVertex2f(0.2,-0.1);
		glVertex2f(0.3,-0.1);
		glVertex2f(0.3, -0.5);
		glVertex2f(0.2, -0.5);
	glEnd();
	glPopMatrix();

	glPushMatrix();//"i"
	 glTranslatef(0.8,-0.4,0.0);
	 glRotatef(-alpha,0,0,1);
	 glTranslatef(-0.8,0.4,0.0);
	 glColor3f(0.90, 0.12, 0.05);
	glBegin(GL_TRIANGLES);
		glVertex2f(0.9,-0.9);
		glVertex2f(0.7,-0.9);
		glVertex2f(0.9, -0.7);
		glVertex2f(0.9,-0.6);
		glVertex2f(0.7,-0.8);
		glVertex2f(0.7, -0.6);
		glVertex2f(0.9,-0.5);
		glVertex2f(0.7,-0.5);
		glVertex2f(0.9, -0.3);
		glVertex2f(0.9,-0.2);
		glVertex2f(0.7,-0.2);
		glVertex2f(0.7, -0.4);
		glVertex2f(0.7,-0.1);
		glVertex2f(0.9,-0.1);
		glVertex2f(0.7, 0.1);
		glVertex2f(0.7, 0.1);
		glVertex2f(0.9, 0.1);
		glVertex2f(0.9, -0.1);
	glEnd();
	glPopMatrix();
}
//---------------------------------------------------------------------------
void __fastcall TForm2::Timer1Timer(TObject *Sender)
{
alpha++;
if (alpha>160) alpha=0;
Form2->FormPaint(Sender);
}


#include <iostream.h>
#include <conio.h>

class OverflowException {
   public:
      OverflowException() {
         cout << endl << "Exception created!" << endl;
      }
      OverflowException(OverflowException&) {
         cout << "Exception copied!" << endl;
      }
      ~OverflowException() {
         cout << "Exception finished!" << endl;
      }
};

class CoordPoint {
   protected:
      int X;
      int Y;
   public:
      CoordPoint();
      CoordPoint(int, int);
      virtual ~CoordPoint() {
         // cout << "Message from the \"CoordPoint\" - destroyed!" << endl;
      }
      int GetX() const {
         return X;
      }
      void SetX(int X) {
         this->X = X;
      }
      int GetY() const;
      void SetY(int);
      virtual void Print() const;
};

class DisplayPoint : public CoordPoint {
   private:
      unsigned int Color;
   public:
      DisplayPoint() : CoordPoint(), Color(0) {
      }
      DisplayPoint(int, int, unsigned int);
      virtual ~DisplayPoint() {
         // cout << endl << "Message from the \"DisplayPoint\" - destroyed!" << endl;
      }
      unsigned int GetColor() const {
         return Color;
      }
      void SetColor(unsigned int PColor) {
         this->Color = PColor;
      }
      virtual void Print() const;
};

class DisplayBrokenLine {
   private:
      typedef DisplayPoint* DPPointer;
      DPPointer *Nodes;
      static const unsigned int DEF_MAX_LENGTH;
      unsigned int MaxLength;
      unsigned int Length;
      unsigned int LineColor;
   public:
      DisplayBrokenLine() : MaxLength(DEF_MAX_LENGTH), Length(0), LineColor(0) {
         Nodes = new DPPointer[MaxLength];
      }
      DisplayBrokenLine(unsigned int MaxLength, unsigned int LineColor) : MaxLength(MaxLength), Length(0) {
         this->LineColor = LineColor;
         Nodes = new DPPointer[MaxLength];
      }
      ~DisplayBrokenLine();
      static unsigned int GetDefaultMaxLength() {
         return DEF_MAX_LENGTH;
      }
      int GetMaxLength() const {
         return MaxLength;
      }
      int GetLength() const {
         return Length;
      }
      void AddNode(const DisplayPoint&);
      void Print() const;
};
const unsigned int DisplayBrokenLine::DEF_MAX_LENGTH = 5;

CoordPoint::CoordPoint() : X(0), Y(0) {
}
CoordPoint::CoordPoint(int Px, int Py) : X(Px) {
   Y = Py;
}
inline int CoordPoint::GetY() const {
   return Y;
}
inline void CoordPoint::SetY(int Y) {
   this->Y = Y;
}
inline void CoordPoint::Print() const {
   cout << "X = " << X << ", Y = " << Y;
}

DisplayPoint::DisplayPoint(int Px, int Py, unsigned int PColor) : CoordPoint(Px, Py) {
   Color = PColor;
}
inline void DisplayPoint::Print() const {
   CoordPoint::Print();
   cout << ", Color = " << Color;
}

DisplayBrokenLine::~DisplayBrokenLine() {
   for(unsigned int i=0; i<Length; i++)
      delete Nodes[i];
   delete [] Nodes;
}
void DisplayBrokenLine::Print() const {
   cout << "\nLine's color: " << LineColor << "." << endl
      << "Line's nodes:" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}
void DisplayBrokenLine::AddNode(const DisplayPoint& Node) {
   if (Length == MaxLength)
      throw OverflowException();
   else 
      Nodes[Length++] = new DisplayPoint(
         Node.GetX(), Node.GetY(), Node.GetColor()
      );
}

void main(void) {
   DisplayBrokenLine *Line = new DisplayBrokenLine(2, 1);
   DisplayPoint *D1 = new DisplayPoint(10, 11, 12);
   DisplayPoint  D2(13, 14, 15);

   try {
      Line->AddNode(*D1);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }
      delete D1;

   cout << "\n\nDefault maximal length (from CLASS): " << 
      DisplayBrokenLine::GetDefaultMaxLength() << "." << endl;
   cout << "Default maximal length (from OBJECT): " << 
      Line->GetDefaultMaxLength() << "." << endl;
   cout << "Maximal length: " << Line->GetMaxLength() << "." << endl;
   cout << "Current length: " << Line->GetLength() << "." << endl;

   try {
      Line->AddNode(D2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      Line->AddNode(D2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

      Line->Print();

      delete Line;

      while (kbhit())
         getch();
      getch();
}

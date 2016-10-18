#include <iostream.h>
#include <conio.h>

class OverflowException {
   public:
      OverflowException(){
         cout << endl << "Exception created!" << endl;
      }
      OverflowException(OverflowException&){
         cout << "Exception copied!" << endl;
      }
      ~OverflowException(){
         cout << "Exception finished!" << endl;
      }
};

template <class T>
class CoordPoint {
   protected:
      T X;
      T Y;
   public:
      CoordPoint();
      CoordPoint(T, T);
      virtual ~CoordPoint() {
         //cout << "Message from the \"CoordPoint\" - destroyed!" << endl;
      }
      T GetX() const {
         return X;
      }
      void SetX(T X) {
         this->X = X;
      }
      T GetY() const;
      void SetY(T);
      virtual void Print() const;
};

template <class T>
class DisplayPoint : public CoordPoint<T> {
   private:
      unsigned int Color;
   public:
      DisplayPoint():CoordPoint<T>(), Color(0) {
      }
      DisplayPoint(T, T, unsigned int);
      virtual ~DisplayPoint() {
         //cout << endl << "Message from the \"DisplayPoint\" - destroyed!" << endl;
      }
      unsigned int GetColor() const {
         return Color;
      }
      void SetColor(unsigned int PColor) {
         this->Color = PColor;
      }
      virtual void Print() const;
};

template <class T>
class DisplayBrokenLine {
   private:
      typedef DisplayPoint<T>* DPPointer;
      DPPointer *Nodes;

      static const unsigned int DEF_MAX_SIZE;
      unsigned int MaxSize;
      unsigned int Length;
      unsigned int LineColor;

   public:
      DisplayBrokenLine():MaxSize(DEF_MAX_SIZE), Length(0), LineColor(0) {
         Nodes = new DPPointer[MaxSize];
      }
      DisplayBrokenLine(unsigned int MaxSize, unsigned int LineColor) : MaxSize(MaxSize), Length(0) {
         this->LineColor = LineColor;
         Nodes = new DPPointer[MaxSize];
      }
      ~DisplayBrokenLine();
      static unsigned int GetDefaultMaxSize() {
         return DEF_MAX_SIZE;
      }
      int GetMaxSize() const {
         return MaxSize;
      }
      int GetLength() const{
         return Length;
      }
      void AddNode(const DisplayPoint<T>&);
      void Print() const;
};

template <class T>
const unsigned int DisplayBrokenLine<T>::DEF_MAX_SIZE = 5;

template <class T>
CoordPoint<T>::CoordPoint() : X(0), Y(0) {
}

template <class T>
CoordPoint<T>::CoordPoint(T Px, T Py) : X(Px) {
   Y = Py;
}

template <class T>
inline T CoordPoint<T>::GetY() const {
   return Y;
}

template <class T>
inline void CoordPoint<T>::SetY(T Y) {
   this->Y = Y;
}

template <class T>
inline void CoordPoint<T>::Print() const {
   cout << "X = " << X << ", Y = " << Y;
}

template <class T>
DisplayPoint<T>::DisplayPoint(T Px, T Py, unsigned int PColor) : CoordPoint<T>(Px, Py) {
   Color = PColor;
}

template <class T>
inline void DisplayPoint<T>::Print() const {
   CoordPoint<T>::Print();
   cout << ", Color = " << Color;
}

template <class T>
DisplayBrokenLine<T>::~DisplayBrokenLine() {
   for(unsigned int i=0; i<Length; i++)
      delete Nodes[i];
   delete [] Nodes;
}

template <class T>
void DisplayBrokenLine<T>::Print() const {
   cout << "\nLine's color: " << LineColor << "." << endl
      << "Line's nodes:" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}

template <class T>
void DisplayBrokenLine<T>::AddNode(const DisplayPoint<T>& Node) {
   if (Length == MaxSize)
      throw OverflowException();
   else 
      Nodes[Length++] = new DisplayPoint<T>(
         Node.GetX(), Node.GetY(), Node.GetColor()
      );
}


void main(void) {
   DisplayBrokenLine<int>  *IntLine  = new DisplayBrokenLine<int>(2, 1);
   DisplayBrokenLine<long> *LongLine = new DisplayBrokenLine<long>(2, 1);

   DisplayPoint<int>   *IntD1  = new DisplayPoint<int>(10, 11, 12);
   DisplayPoint<long>  *LongD1 = new DisplayPoint<long>(10L, 11L, 12);

   DisplayPoint<int>   IntD2(13, 14, 15);
   DisplayPoint<long>  LongD2(13L, 14L, 15);

   try {
      IntLine->AddNode(*IntD1);
      cout << "\nNew INTEGER node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "Error: maximal size exceeded!" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      IntLine->AddNode(IntD2);
      cout << "\nNew INTEGER node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "Error: maximal size exceeded !" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      LongLine->AddNode(*LongD1);
      cout << "\nNew LONG node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "Error: maximal size exceeded!" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      LongLine->AddNode(LongD2);
      cout << "\nNew LONG node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "Error: maximal size exceeded !" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

      delete IntD1;
      delete LongD1;

      cout << endl << "INTEGER line:";
      IntLine->Print();

      cout << endl << "LONG line:";
      LongLine->Print();
 
      delete IntLine;
      delete LongLine;

      while (kbhit())
         getch();
      getch();
}

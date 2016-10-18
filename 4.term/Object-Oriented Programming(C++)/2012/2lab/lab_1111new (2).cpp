#include <iostream.h>
#include <conio.h>
#include <cstring.h>

class Article {
	protected:
		string rnum ;
		string nos;
		float cena;
	public:
		Article();
		Article(string, string, float);
		virtual~Article() {
			cout << "Message from the \"article\" - destroyed!" <<
				endl;
		}
		float Getcena() const;
		void Setcena (float cen);

      string Getrnum() const;
		void Setrnum (string rn);

		string Getnos() const;
		void Setnos (string n);

		virtual void Print() const;
};

class DisplayBook : public Article {
	private:
		string Autors;
	public:
		DisplayBook():Article(), Autors(" ") {
      }
		DisplayBook( string, string,float, string);
      virtual ~DisplayBook() {
         cout << endl << "Message from the \"DisplayBook\" - destroyed!" << endl;
      }
     string GetAutors() const {
         return Autors;
      }
		void SetAutors(string Aut) ;


      virtual void Print() const;
};



Article::Article() : rnum(""), nos(""), cena(0) {
}



Article::Article( string rn, string n, float cen) {
	nos = n;
	cena = cen;
   rnum = rn;
}
inline string Article::Getrnum() const {
	 return rnum;
}
 void Article::Setrnum(string rn) {
	this->rnum = rn;
}
inline string Article::Getnos() const {
	 return nos;
}
 void Article::Setnos(string n) {
	this->nos = n;
}
inline float Article::Getcena() const {
	 return cena;
}
inline void Article::Setcena(float cen) {
	this->cena = cen;
}

inline void Article::Print() const {
	cout << "Konta numurs = " << rnum << ", Nosaukums = " << nos << ", Cena = " << cena;
}

DisplayBook::DisplayBook(string rn, string n, float cen, string Autors) : Article(rn, n,cen) {
  this->	Autors =Autors;
}

inline void DisplayBook::Print() const {
   Article::Print();
	cout << ", Autors = " << Autors;
}

void main(void) {
   string nos;
   float cen;
    const int N = 3;
	 DisplayBook *DP1 = new DisplayBook("LV55HABA548946546","Hansa",2000,"Igors");
	Article   *DP2 = new DisplayBook();



		Article *Points[N] = {
		new Article("LV564SEB86465432", "Swedbank", 650),
		new DisplayBook(),
		new DisplayBook("LV55HABA548946546","Hansa",2000,"Vadims")
	};
   clrscr();

        cout << "Array of points: " << endl;
   for(int i=0; i<N; i++) {
		cout << (i+1) << ". ";
		Points[i]->Print();
      cout << endl;
   }

     cout << endl << "Display Point:" << endl;

		DP1->Print();
	cout << endl << "Konta numurs= " << DP1->Getrnum() << ".";
	cout << endl << "Autors= " << DP1->GetAutors() << "." << endl << endl;

   for(int k=0; k<N; k++) {
      delete Points[k];
	  }

	delete DP1;
		delete DP2;
	while (kbhit())
		getch();
	getch();
}

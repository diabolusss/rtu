#include <iostream.h>
#include <conio.h>
#include <cstring.h>

class Article {
	private:
		string rnum ;
		string nos;
		float cena;
	public:
		Article();
		Article(string, string, float);
		~Article() {
			cout << "Message from the \"article\" - destroyed!" <<
				endl;
		}
		float Getcena() const;
		void Setcena (float cen);

      string Getrnum() const;
      void Setrnum (string rn);

		string Getnos() const;
      void Setnos (string n);

		void Print() const;
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
inline void Article::Setrnum(string rn) {
	this->rnum = rn;
}
inline string Article::Getnos() const {
	 return nos;
}
inline void Article::Setnos(string n) {
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

void main(void) {
   string nos;
   float cen;
	Article Carticle1, Carticle2("LV55HABA548946546","Hansa",2000),
		*Carticle4 = new Article("LV564SEB86465432", "Swedbank", 650);

	clrscr();

	Carticle1.Print();cout<<endl;
	Carticle2.Article::Print();cout<<endl;
	Carticle2.Setcena(777);
	Carticle2.Article::Print();cout<<endl;

   nos = Carticle2.Getnos();
	cout << "Carticle2 nosaukums = " << nos << endl;

	cout << endl << "**************" << endl << endl;

	(*Carticle4).Print();cout<<endl;
	Carticle4->Setnos("NewNosaukums");
	(*Carticle4).Article::Print();cout<<endl;


	cout << endl << "**************" << endl << endl;

	(*Carticle4).Print();cout<<endl;
	 Carticle4->Setrnum("LV6845653120");
	(*Carticle4).Print();cout<<endl;

	cen = (*Carticle4).Getcena();
	cout << "Carticle4 cena = " << cen << endl;
   cout << endl << "**************" << endl << endl;
   
   delete Carticle4;

	while (kbhit())
		getch();
	getch();
}

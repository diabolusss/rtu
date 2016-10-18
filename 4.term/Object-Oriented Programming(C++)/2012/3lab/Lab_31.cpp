#include <iostream>
#include <conio>
#include <string>

using namespace std;

class OverflowException {
   public:
      OverflowException() {
         //cout << endl << "Exception created!" << endl;
      }
      OverflowException(OverflowException&) {
         //cout << "Exception copied!" << endl;
      }
      ~OverflowException() {
         //cout << "Exception finished!" << endl;
      }
};

class Article {
   protected:
      string num, name;
      float price;
   public:
      Article();
      Article(string, string, float);
      ~Article() {
         cout << endl << "Message from the \"Article\" - destroyed!" << endl;
      }
      string GetNum() const;
      void SetNum(const string& s);
      string GetName() const;
      void SetName(const string& s);
      float GetPrice() const;
      void SetPrice(float p);
      void Print() const;
};

class Book : public Article {
	private:
   	string author;
   public:
   	Book(): Article(), author(""){}
      Book(string , string , float , string);
      virtual ~Book(){
			cout << endl << "Message from the \"Book\" - destroyed!" << endl;
      }
      string GetAuthor() const {
			return this->author;
      }
      void SetAuthor(const string& s){
			this->author = s;
      }
      virtual void Print() const;
};

Article::Article() : num(""), name(""), price(0) {
}

Article::Article(string Num, string Name, float Price){
   num = Num;
   name = Name;
   price = Price;
}

inline string Article::GetNum() const {
    return this->num;
}

inline void Article::SetNum(const string& s) {
   this->num = s;
}

inline string Article::GetName() const {
    return this->name;
}

inline void Article::SetName(const string& s) {
   this->name = s;
}

inline float Article::GetPrice() const {
    return this->price;
}

inline void Article::SetPrice( float f) {
   this->price = f;
}

inline void Article::Print() const {
   cout << "CODE_NR = " << this->num << ", NAME = " << this->name << ", PRICE = " << this->price;
}

Book::Book(string Num, string Name, float Price, string Author) : Article(Num, Name, Price){
	this->author = Author;
}

inline void Book::Print() const {
	Article::Print();
   cout << ", AUTHOR = " << this->author;
}


class BookShop {
   private:
      typedef Book* BPointer;
      BPointer *Nodes;
      static const unsigned int DEF_MAX_LENGTH;
      unsigned int MaxLength;
      unsigned int Length;
   public:
      BookShop() : MaxLength(DEF_MAX_LENGTH), Length(0) {
         Nodes = new BPointer[MaxLength];
      }
      BookShop(unsigned int MaxLength) : MaxLength(MaxLength), Length(0) {
         Nodes = new BPointer[MaxLength];
      }
      ~BookShop();
      static unsigned int GetDefaultMaxLength() {
         return DEF_MAX_LENGTH;
      }
      int GetMaxLength() const {
         return MaxLength;
      }
      int GetLength() const {
         return Length;
      }
      void AddNode(const Book&);
      void Print() const;
      float GetMaxPrice() const;
};
const unsigned int BookShop::DEF_MAX_LENGTH = 5;

BookShop::~BookShop() {
   for(unsigned int i=0; i<Length; i++){
      delete Nodes[i];
   }
   delete [] Nodes;
}

float BookShop::GetMaxPrice() const {
   float MaxPrice = 0;
	for (unsigned int i=0; i<Length; i++){
   	if (Nodes[i]->GetPrice() > MaxPrice){
      	MaxPrice = Nodes[i]->GetPrice();
		}
   }

   return MaxPrice;
}

void BookShop::Print() const {
	cout << "Books :" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}
void BookShop::AddNode(const Book& Node) {
   if (Length == MaxLength){
      throw OverflowException();
   }else{
      Nodes[Length++] = new Book(
         Node.GetNum(), Node.GetName(), Node.GetPrice(), Node.GetAuthor()
      );
   }
}




void main(void) {
	Book *BO1 = new Book("qwe", "MUMU", 25, "Turgenev");
	BookShop *NewBook = new BookShop(2);
   Book BO2("zxc", "Romeo and Juliet", 14, "William Shakespeare ");

   try{
		NewBook->AddNode(*BO1);
      cout << "\nNew book added successfully !" << endl;
   }
   	catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }
      delete BO1;

   cout << "\n\nDefault maximal length (from CLASS): " <<
      BookShop::GetDefaultMaxLength() << "." << endl;
   cout << "Default maximal length (from OBJECT): " <<
      NewBook->GetDefaultMaxLength() << "." << endl;
   cout << "Maximal length: " << NewBook->GetMaxLength() << "." << endl;
   cout << "Current length: " << NewBook->GetLength() << "." << endl;


   try {
      NewBook->AddNode(BO2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      NewBook->AddNode(BO2);
      cout << "\nNew node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   NewBook->Print();

   cout << endl << "Maximal book price is : " << NewBook->GetMaxPrice() << endl;

   delete NewBook;



   while (kbhit())
      getch();
   getch();
}

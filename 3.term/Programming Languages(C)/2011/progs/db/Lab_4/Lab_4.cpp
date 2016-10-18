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

template <class T>
class Article {
   protected:
      string num, name;
      T price;
   public:
      Article();
      Article(string, string, T);
      ~Article() {
         cout << endl << "Message from the \"Article\" - destroyed!" << endl;
      }
      string GetNum() const;
      void SetNum(const string& s);
      string GetName() const;
      void SetName(const string& s);
      T GetPrice() const;
      void SetPrice(T p);
      void Print() const;
};

template <class T>
class Book : public Article<T> {
	private:
   	string author;
   public:
   	Book(): Article<T>(), author(""){}
      Book(string , string , T , string);
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

template <class T>
Article<T>::Article() : num(""), name(""), price(0) {
}

template <class T>
Article<T>::Article(string Num, string Name, T Price){
   num = Num;
   name = Name;
   price = Price;
}

template <class T>
inline string Article<T>::GetNum() const {
    return this->num;
}

template <class T>
inline void Article<T>::SetNum(const string& s) {
   this->num = s;
}

template <class T>
inline string Article<T>::GetName() const {
    return this->name;
}

template <class T>
inline void Article<T>::SetName(const string& s) {
   this->name = s;
}

template <class T>
inline T Article<T>::GetPrice() const {
    return this->price;
}

template <class T>
inline void Article<T>::SetPrice( T f) {
   this->price = f;
}

template <class T>
inline void Article<T>::Print() const {
   cout << "CODE_NR = " << this->num << ", NAME = " << this->name << ", PRICE = " << this->price;
}

template <class T>
Book<T>::Book(string Num, string Name, T Price, string Author) : Article<T>(Num, Name, Price){
	this->author = Author;
}

template <class T>
inline void Book<T>::Print() const {
	Article<T>::Print();
   cout << ", AUTHOR = " << this->author;
}

template <class T>
class BookShop {
   private:
      typedef Book<T>* BPointer;
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
      void AddNode(const Book<T>&);
      void Print() const;
      T GetMaxPrice() const;
};
template <class T>
const unsigned int BookShop<T>::DEF_MAX_LENGTH = 5;

template <class T>
BookShop<T>::~BookShop() {
   for(unsigned int i=0; i<Length; i++){
      delete Nodes[i];
   }
   delete [] Nodes;
}

template <class T>
T BookShop<T>::GetMaxPrice() const {
   T MaxPrice = 0;
	for (unsigned int i=0; i<Length; i++){
   	if (Nodes[i]->GetPrice() > MaxPrice){
      	MaxPrice = Nodes[i]->GetPrice();
		}
   }

   return MaxPrice;
}

template <class T>
void BookShop<T>::Print() const {
	cout << "Books :" << endl;
   for (unsigned int i=0; i<Length; i++) {
      cout << (i+1) << ". ";
      Nodes[i]->Print();
      cout << "." << endl;
   }
}
template <class T>
void BookShop<T>::AddNode(const Book<T>& Node) {
   if (Length == MaxLength){
      throw OverflowException();
   }else{
      Nodes[Length++] = new Book<T>(
         Node.GetNum(), Node.GetName(), Node.GetPrice(), Node.GetAuthor()
      );
   }
}




void main(void) {
	Book<float> *FBO1 = new Book<float>("fqwe", "MUMU", 25, "Turgenev");
   Book<double> *DBO1 = new Book<double>("dqwe", "MUMU", 25, "Turgenev");
	BookShop<float> *FNewBook = new BookShop<float>(2);
   BookShop<double> *DNewBook = new BookShop<double>(2);
   Book<float> FBO2("fzxc", "Romeo and Juliet", 14, "William Shakespeare ");
   Book<double> DBO2("dzxc", "Romeo and Juliet", 14, "William Shakespeare ");

   try{
		DNewBook->AddNode(*DBO1);
      cout << "\nNew double book added successfully !" << endl;
   }
   	catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }
      delete DBO1;

   cout << "\n\nDefault maximal length (from CLASS): " <<
      BookShop<double>::GetDefaultMaxLength() << "." << endl;
   cout << "Default maximal length (from OBJECT): " <<
      DNewBook->GetDefaultMaxLength() << "." << endl;
   cout << "Maximal length: " << DNewBook->GetMaxLength() << "." << endl;
   cout << "Current length: " << DNewBook->GetLength() << "." << endl;


   try {
      FNewBook->AddNode(FBO2);
      cout << "\nNew float node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   try {
      FNewBook->AddNode(FBO2);
      cout << "\nNew float node added successfully!" << endl;
   }
      catch (OverflowException&) {
         cout << "*** Error: maximal length exceeded ! ***" << endl;
      }
      catch (...) {
         cout << "Unknown Error !" << endl;
      }

   DNewBook->Print();
   getch();
   FNewBook->Print();

   delete DNewBook;
   delete FNewBook;




   while (kbhit())
      getch();
   getch();
}

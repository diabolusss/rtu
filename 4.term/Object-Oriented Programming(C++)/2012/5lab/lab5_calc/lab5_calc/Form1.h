#pragma once


namespace lab5_calc {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for Form1
	///
	/// WARNING: If you change the name of this class, you will need to change the
	///          'Resource File Name' property for the managed resource compiler tool
	///          associated with all .resx files this class depends on.  Otherwise,
	///          the designers will not be able to interact properly with localized
	///          resources associated with this form.
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{
	public:
		Form1(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Panel^  panel1;
	private: System::Windows::Forms::Label^  label3;
	private: System::Windows::Forms::Label^  label2;
	private: System::Windows::Forms::Label^  label1;
	private: System::Windows::Forms::TextBox^  Result;

	private: System::Windows::Forms::TextBox^  SecondOperand;

	private: System::Windows::Forms::TextBox^  FirstOperand;
	private: System::Windows::Forms::Button^  button4;
	private: System::Windows::Forms::Button^  button3;
	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::Button^  button1;
	private: System::Windows::Forms::MenuStrip^  menuStrip1;
	private: System::Windows::Forms::ToolStripMenuItem^  operationToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  addToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  substructToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  multiplyToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  divideToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  exitToolStripMenuItem;
	private: System::Windows::Forms::ContextMenuStrip^  contextMenuStrip1;
	private: System::Windows::Forms::ToolStripMenuItem^  addToolStripMenuItem1;
	private: System::Windows::Forms::ToolStripMenuItem^  subToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  mulToolStripMenuItem;
	private: System::Windows::Forms::ToolStripMenuItem^  divToolStripMenuItem;
	private: System::Windows::Forms::Panel^  panel2;
	private: System::Windows::Forms::Button^  button5;
	private: System::Windows::Forms::Button^  button8;
	private: System::Windows::Forms::Button^  button7;
	private: System::Windows::Forms::Button^  button6;
	private: System::Windows::Forms::Button^  button9;
	private: System::Windows::Forms::ToolStripMenuItem^  exitToolStripMenuItem1;
	private: System::ComponentModel::IContainer^  components;

	protected: 

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>


#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->components = (gcnew System::ComponentModel::Container());
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(Form1::typeid));
			this->panel1 = (gcnew System::Windows::Forms::Panel());
			this->contextMenuStrip1 = (gcnew System::Windows::Forms::ContextMenuStrip(this->components));
			this->addToolStripMenuItem1 = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->subToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->mulToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->divToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->button4 = (gcnew System::Windows::Forms::Button());
			this->button3 = (gcnew System::Windows::Forms::Button());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->Result = (gcnew System::Windows::Forms::TextBox());
			this->SecondOperand = (gcnew System::Windows::Forms::TextBox());
			this->FirstOperand = (gcnew System::Windows::Forms::TextBox());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->menuStrip1 = (gcnew System::Windows::Forms::MenuStrip());
			this->operationToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->addToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->substructToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->multiplyToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->divideToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->exitToolStripMenuItem = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->panel2 = (gcnew System::Windows::Forms::Panel());
			this->button8 = (gcnew System::Windows::Forms::Button());
			this->button7 = (gcnew System::Windows::Forms::Button());
			this->button6 = (gcnew System::Windows::Forms::Button());
			this->button5 = (gcnew System::Windows::Forms::Button());
			this->button9 = (gcnew System::Windows::Forms::Button());
			this->exitToolStripMenuItem1 = (gcnew System::Windows::Forms::ToolStripMenuItem());
			this->panel1->SuspendLayout();
			this->contextMenuStrip1->SuspendLayout();
			this->menuStrip1->SuspendLayout();
			this->panel2->SuspendLayout();
			this->SuspendLayout();
			// 
			// panel1
			// 
			this->panel1->ContextMenuStrip = this->contextMenuStrip1;
			this->panel1->Controls->Add(this->button4);
			this->panel1->Controls->Add(this->button3);
			this->panel1->Controls->Add(this->button2);
			this->panel1->Controls->Add(this->button1);
			this->panel1->Controls->Add(this->Result);
			this->panel1->Controls->Add(this->SecondOperand);
			this->panel1->Controls->Add(this->FirstOperand);
			this->panel1->Controls->Add(this->label3);
			this->panel1->Controls->Add(this->label2);
			this->panel1->Controls->Add(this->label1);
			resources->ApplyResources(this->panel1, L"panel1");
			this->panel1->Name = L"panel1";
			// 
			// contextMenuStrip1
			// 
			this->contextMenuStrip1->Items->AddRange(gcnew cli::array< System::Windows::Forms::ToolStripItem^  >(5) {this->addToolStripMenuItem1, 
				this->subToolStripMenuItem, this->mulToolStripMenuItem, this->divToolStripMenuItem, this->exitToolStripMenuItem1});
			this->contextMenuStrip1->Name = L"contextMenuStrip1";
			resources->ApplyResources(this->contextMenuStrip1, L"contextMenuStrip1");
			// 
			// addToolStripMenuItem1
			// 
			this->addToolStripMenuItem1->Name = L"addToolStripMenuItem1";
			resources->ApplyResources(this->addToolStripMenuItem1, L"addToolStripMenuItem1");
			this->addToolStripMenuItem1->Click += gcnew System::EventHandler(this, &Form1::Add);
			// 
			// subToolStripMenuItem
			// 
			this->subToolStripMenuItem->Name = L"subToolStripMenuItem";
			resources->ApplyResources(this->subToolStripMenuItem, L"subToolStripMenuItem");
			this->subToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Sub);
			// 
			// mulToolStripMenuItem
			// 
			this->mulToolStripMenuItem->Name = L"mulToolStripMenuItem";
			resources->ApplyResources(this->mulToolStripMenuItem, L"mulToolStripMenuItem");
			this->mulToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Mul);
			// 
			// divToolStripMenuItem
			// 
			this->divToolStripMenuItem->Name = L"divToolStripMenuItem";
			resources->ApplyResources(this->divToolStripMenuItem, L"divToolStripMenuItem");
			this->divToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Div);
			// 
			// button4
			// 
			resources->ApplyResources(this->button4, L"button4");
			this->button4->Name = L"button4";
			this->button4->UseVisualStyleBackColor = true;
			this->button4->Click += gcnew System::EventHandler(this, &Form1::Div);
			// 
			// button3
			// 
			resources->ApplyResources(this->button3, L"button3");
			this->button3->Name = L"button3";
			this->button3->UseVisualStyleBackColor = true;
			this->button3->Click += gcnew System::EventHandler(this, &Form1::Mul);
			// 
			// button2
			// 
			resources->ApplyResources(this->button2, L"button2");
			this->button2->Name = L"button2";
			this->button2->UseVisualStyleBackColor = true;
			this->button2->Click += gcnew System::EventHandler(this, &Form1::Sub);
			// 
			// button1
			// 
			resources->ApplyResources(this->button1, L"button1");
			this->button1->Name = L"button1";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &Form1::Add);
			// 
			// Result
			// 
			resources->ApplyResources(this->Result, L"Result");
			this->Result->Name = L"Result";
			this->Result->ReadOnly = true;
			// 
			// SecondOperand
			// 
			resources->ApplyResources(this->SecondOperand, L"SecondOperand");
			this->SecondOperand->Name = L"SecondOperand";
			// 
			// FirstOperand
			// 
			resources->ApplyResources(this->FirstOperand, L"FirstOperand");
			this->FirstOperand->Name = L"FirstOperand";
			this->FirstOperand->TextChanged += gcnew System::EventHandler(this, &Form1::textBox1_TextChanged);
			// 
			// label3
			// 
			resources->ApplyResources(this->label3, L"label3");
			this->label3->Name = L"label3";
			// 
			// label2
			// 
			resources->ApplyResources(this->label2, L"label2");
			this->label2->Name = L"label2";
			// 
			// label1
			// 
			resources->ApplyResources(this->label1, L"label1");
			this->label1->Name = L"label1";
			// 
			// menuStrip1
			// 
			this->menuStrip1->Items->AddRange(gcnew cli::array< System::Windows::Forms::ToolStripItem^  >(2) {this->operationToolStripMenuItem, 
				this->exitToolStripMenuItem});
			resources->ApplyResources(this->menuStrip1, L"menuStrip1");
			this->menuStrip1->Name = L"menuStrip1";
			// 
			// operationToolStripMenuItem
			// 
			this->operationToolStripMenuItem->DropDownItems->AddRange(gcnew cli::array< System::Windows::Forms::ToolStripItem^  >(4) {this->addToolStripMenuItem, 
				this->substructToolStripMenuItem, this->multiplyToolStripMenuItem, this->divideToolStripMenuItem});
			this->operationToolStripMenuItem->Name = L"operationToolStripMenuItem";
			resources->ApplyResources(this->operationToolStripMenuItem, L"operationToolStripMenuItem");
			// 
			// addToolStripMenuItem
			// 
			this->addToolStripMenuItem->Name = L"addToolStripMenuItem";
			resources->ApplyResources(this->addToolStripMenuItem, L"addToolStripMenuItem");
			this->addToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Add);
			// 
			// substructToolStripMenuItem
			// 
			this->substructToolStripMenuItem->Name = L"substructToolStripMenuItem";
			resources->ApplyResources(this->substructToolStripMenuItem, L"substructToolStripMenuItem");
			this->substructToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Sub);
			// 
			// multiplyToolStripMenuItem
			// 
			this->multiplyToolStripMenuItem->Name = L"multiplyToolStripMenuItem";
			resources->ApplyResources(this->multiplyToolStripMenuItem, L"multiplyToolStripMenuItem");
			this->multiplyToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Mul);
			// 
			// divideToolStripMenuItem
			// 
			this->divideToolStripMenuItem->Name = L"divideToolStripMenuItem";
			resources->ApplyResources(this->divideToolStripMenuItem, L"divideToolStripMenuItem");
			this->divideToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Div);
			// 
			// exitToolStripMenuItem
			// 
			this->exitToolStripMenuItem->Name = L"exitToolStripMenuItem";
			resources->ApplyResources(this->exitToolStripMenuItem, L"exitToolStripMenuItem");
			this->exitToolStripMenuItem->Click += gcnew System::EventHandler(this, &Form1::Exit);
			// 
			// panel2
			// 
			this->panel2->BorderStyle = System::Windows::Forms::BorderStyle::Fixed3D;
			this->panel2->Controls->Add(this->button8);
			this->panel2->Controls->Add(this->button7);
			this->panel2->Controls->Add(this->button6);
			this->panel2->Controls->Add(this->button5);
			resources->ApplyResources(this->panel2, L"panel2");
			this->panel2->Name = L"panel2";
			// 
			// button8
			// 
			resources->ApplyResources(this->button8, L"button8");
			this->button8->Name = L"button8";
			this->button8->UseVisualStyleBackColor = true;
			this->button8->Click += gcnew System::EventHandler(this, &Form1::Div);
			// 
			// button7
			// 
			resources->ApplyResources(this->button7, L"button7");
			this->button7->Name = L"button7";
			this->button7->UseVisualStyleBackColor = true;
			this->button7->Click += gcnew System::EventHandler(this, &Form1::Mul);
			// 
			// button6
			// 
			resources->ApplyResources(this->button6, L"button6");
			this->button6->Name = L"button6";
			this->button6->UseVisualStyleBackColor = true;
			this->button6->Click += gcnew System::EventHandler(this, &Form1::Sub);
			// 
			// button5
			// 
			resources->ApplyResources(this->button5, L"button5");
			this->button5->Name = L"button5";
			this->button5->UseVisualStyleBackColor = true;
			this->button5->Click += gcnew System::EventHandler(this, &Form1::Add);
			// 
			// button9
			// 
			resources->ApplyResources(this->button9, L"button9");
			this->button9->Name = L"button9";
			this->button9->UseVisualStyleBackColor = true;
			this->button9->Click += gcnew System::EventHandler(this, &Form1::Exit);
			// 
			// exitToolStripMenuItem1
			// 
			this->exitToolStripMenuItem1->Name = L"exitToolStripMenuItem1";
			resources->ApplyResources(this->exitToolStripMenuItem1, L"exitToolStripMenuItem1");
			this->exitToolStripMenuItem1->Click += gcnew System::EventHandler(this, &Form1::Exit);
			// 
			// Form1
			// 
			resources->ApplyResources(this, L"$this");
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ControlBox = false;
			this->Controls->Add(this->menuStrip1);
			this->Controls->Add(this->button9);
			this->Controls->Add(this->panel1);
			this->Controls->Add(this->panel2);
			this->Cursor = System::Windows::Forms::Cursors::Hand;
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::Fixed3D;
			this->MainMenuStrip = this->menuStrip1;
			this->MaximizeBox = false;
			this->MinimizeBox = false;
			this->Name = L"Form1";
			this->ShowInTaskbar = false;
			this->panel1->ResumeLayout(false);
			this->panel1->PerformLayout();
			this->contextMenuStrip1->ResumeLayout(false);
			this->menuStrip1->ResumeLayout(false);
			this->menuStrip1->PerformLayout();
			this->panel2->ResumeLayout(false);
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private: System::Void textBox1_TextChanged(System::Object^  sender, System::EventArgs^  e) {
			 }
private: System::Void Exit(System::Object^  sender, System::EventArgs^  e) {
			 Close();
		 }
private: System::Void Add(System::Object^  sender, System::EventArgs^  e) {
			 try{
				 Result->Text = Convert::ToString(
					 Convert::ToDouble(FirstOperand->Text)+
					 Convert::ToDouble(SecondOperand->Text));
			 } catch(...){
				 MessageBox::Show("Error  in operands!",
					 "Calculator ERROR",MessageBoxButtons::OK,MessageBoxIcon::Error);
			 }
		 }
private: System::Void Sub(System::Object^  sender, System::EventArgs^  e) {
			 try{
				 Result->Text = Convert::ToString(
					 Convert::ToDouble(FirstOperand->Text)-
					 Convert::ToDouble(SecondOperand->Text));
			 } catch(...){
				 MessageBox::Show("Error  in operands!",
					 "Calculator ERROR",MessageBoxButtons::OK,MessageBoxIcon::Error);
			 }
		 }
private: System::Void Mul(System::Object^  sender, System::EventArgs^  e) {
			 try{
				 Result->Text = Convert::ToString(
					 Convert::ToDouble(FirstOperand->Text)*
					 Convert::ToDouble(SecondOperand->Text));
			 } catch(...){
				 MessageBox::Show("Error  in operands!",
					 "Calculator ERROR",MessageBoxButtons::OK,MessageBoxIcon::Error);
			 }
		 }
private: System::Void Div(System::Object^  sender, System::EventArgs^  e) {
			 try{
				 Result->Text = Convert::ToString(
					 Convert::ToDouble(FirstOperand->Text)/
					 Convert::ToDouble(SecondOperand->Text));
			 } catch(...){
				 MessageBox::Show("Error  in operands!",
					 "Calculator ERROR",MessageBoxButtons::OK,MessageBoxIcon::Error);
			 }
		 }
};
}


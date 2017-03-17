unit Unit1;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, INIFiles, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N6: TMenuItem;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    N7: TMenuItem;
    N8: TMenuItem;
    FontDialog1: TFontDialog;
    N4: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    procedure ComboBox1KeyPress(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure GetFileList;
    procedure N12Click(Sender: TObject);
    procedure ReadSettings;
    procedure SaveSettings;
    procedure LoadFile;
    procedure SaveFile(ask,dialogResult: boolean);
    function DeleteWrongSymbols(str:string):string;
    //procedure Updater;

    procedure ComboBox1Select(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;
const
 MainFileName='EXFiPQuickNotes.efp';
 //константы для обновлятора:
// pID='3';
 //pVer='1.0';
 //pRVer='1';
var
  Form1: TForm1;
  activated,NoSaving:boolean;
  ini:TINIFile;
  filename:string;
  LastName:string;


implementation

{$R *.dfm}

{ TForm1 }



function TForm1.DeleteWrongSymbols(str: string): string;
begin

str := StringReplace(str, '\', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '/', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, ':', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '*', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '?', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '"', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '<', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '>', '',
                          [rfReplaceAll, rfIgnoreCase]);
str := StringReplace(str, '|', '',
                          [rfReplaceAll, rfIgnoreCase]);
result:=str;
end;

//сохранение файла и переключение на следующий
procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  if TMenuItem(N12).Checked then
SaveFile(true,false) else SaveFile(false,true);
  LoadFile;
end;

//инициализация
procedure TForm1.FormActivate(Sender: TObject);
begin
if not activated then
begin
ini:=TiniFile.Create(ExtractFilePath(ParamStr(0))+'settings.ini');
ReadSettings;

if fileexists(ExtractFilePath(Paramstr(0))+MainFileName) then
Memo1.Lines.LoadFromFile(ExtractFilePath(Paramstr(0))+MainFileName) else
  begin
    memo1.Lines.Add('Добро пожаловать в EXFiP QuickNotes!');
  end;

GetFileList;

activated:=true;
end;
end;
//позволяет создавать новый файл изменив имя в комбобоксе
procedure TForm1.ComboBox1KeyPress(Sender: TObject);
begin
  LastName:=Combobox1.text;
end;
//сохранение перед закрытием окна
procedure TForm1.FormCloseQuery(Sender: TObject);
begin
if TMenuItem(N12).Checked then
SaveFile(true,false) else SaveFile(false,true);
SaveSettings;
end;
//поиск txt файлов в папке
procedure TForm1.GetFileList;
Var SR:TSearchRec;
    FindRes:Integer;
    s,f:string;
begin
Combobox1.Clear;
Combobox1.Items.Add('EXFiPQuickNotes');
Combobox1.ItemIndex:=0;
f:=ExtractFilePath(ParamStr(0));
FindRes:=FindFirst(f+'*.txt',faAnyFile,SR);
While FindRes=0 do
   begin
if (((SR.Attr and faDirectory)=faDirectory) and
      ((SR.Name='.')or(SR.Name='..'))) or ((SR.Attr and faDirectory)=faDirectory) then
         begin
            FindRes:=FindNext(SR);
            Continue;
         end;
         s:=SR.Name;
       Delete(s,Length(s)-3,Length(s));
      Combobox1.Items.Add(s);
      FindRes:=FindNext(SR);
   end;
FindClose(SR);
end;

//Задавать ли вопрос перед сохранением
procedure TForm1.N12Click(Sender: TObject);
begin
  if TMenuItem(N12).Checked then TMenuItem(N12).Checked:=false else TMenuItem(N12).Checked:=true;
end;


//загрузка текста
procedure TForm1.LoadFile;
begin
Memo1.Clear;
if Combobox1.Text='EXFiPQuickNotes' then
  begin
    if fileexists(ExtractFilePath(Paramstr(0))+MainFileName) then
    begin
    Memo1.Lines.LoadFromFile(ExtractFilePath(Paramstr(0))+MainFileName);
    LastName:='EXFiPQuickNotes';
    end
    else
      begin
        MessageBoxW(0,'Файл не существует','Ошибка', MB_OK or MB_ICONERROR);
        exit
      end;
  end
 else
  begin
    if fileexists(ExtractFilePath(Paramstr(0))+Combobox1.Text+'.txt') then
    begin
    Memo1.Lines.LoadFromFile(ExtractFilePath(Paramstr(0))+Combobox1.Text+'.txt');
    LastName:=Combobox1.Text;
    end
     else
      begin
        MessageBoxW(0,'Файл не существует','Ошибка', MB_OK or MB_ICONERROR);
        exit
      end;
  end;
end;

// о программе
procedure TForm1.N10Click(Sender: TObject);
begin
Form2.Showmodal;
end;
 //диалог шрифта
procedure TForm1.N11Click(Sender: TObject);
begin
if FontDialog1.Execute then
    form1.Memo1.Font.Assign(FontDialog1.Font);
end;

//создание файла через меню
procedure TForm1.N2Click(Sender: TObject);
begin
LastName:=Combobox1.Text;
if TMenuItem(N12).Checked then
SaveFile(true,false) else SaveFile(false,true);
Combobox1.Text:='Введите сюда название файла';
LastName:='Введите сюда название файла';
Memo1.Clear;
end;
//удаление файла
procedure TForm1.N3Click(Sender: TObject);
var s:string;
begin
if Combobox1.Text='EXFiPQuickNotes' then
begin
  MessageBoxW(0,'Файл EXFiPQuickNotes удалить нельзя.','Ошибка',MB_OK or MB_ICONERROR);
  exit;
end;
s:='Удалить '+Combobox1.Text+'?';
if MessageBoxW(0,PWideChar(UTF8Decode(s)),'Удаление',MB_YESNO or MB_ICONWARNING)=IDYES then
if FileExists(Combobox1.Text+'.txt') then
begin
  DeleteFile(Combobox1.Text+'.txt');
  Memo1.Clear;
  Combobox1.Clear;
  GetFileList;
  LoadFile;
end else MessageBoxW(0,'Невозможно удалить файл: файл не существует','Ошибка',MB_OK or MB_ICONERROR);


end;
//выход без сохранения
procedure TForm1.N4Click(Sender: TObject);
begin
if MessageBoxW(0,'Выйти без сохранения?','Выход', MB_ICONWARNING or MB_YESNO)=IDYES then
begin
NoSaving:=true;
Close;
end;
end;

 //закрытие из меню
procedure TForm1.N6Click(Sender: TObject);
begin
Close;
end;

// чтение настроек
procedure TForm1.ReadSettings;
var
number:byte;
begin
//обновление
//if (FileExists('Updater.exe')) and (FileExists('Updater.dll')) then
//TMenuItem(N13).Enabled:=true else TMenuItem(N13).Enabled:=false;

  //положение и размер окна
  Form1.Left:=ini.ReadInteger('SETTINGS','FormLeft',0);
  Form1.Top:= ini.ReadInteger('SETTINGS','FormTop',0);
  Form1.Height:= ini.ReadInteger('SETTINGS','FormHeight',357);
  Form1.Width:= ini.ReadInteger('SETTINGS','FormWidth',572);
  //задавать вопрос перед сохранением
  if ini.ReadBool('SETTINGS','AskEveryTime',false) then
  TMenuItem(N12).Checked:=true else TMenuItem(N12).Checked:=false;
  //шрифт
 // Memo1.Font.Charset:=ini.ReadInteger('SETTINGS','FontCharset',1);
  Memo1.Font.Color:=ini.ReadInteger('SETTINGS','FontColor',-16777208);
//  Memo1.Font.Height:=ini.ReadInteger('SETTINGS','FontHeight',-11);
  Memo1.Font.Name:=ini.ReadString('SETTINGS','FontName','Tahoma');
  //ini.ReadString('SETTINGS','Pitch',Memo1.Font.Pitch);
  Memo1.Font.Size:=ini.ReadInteger('SETTINGS','FontSize',8);
 // Memo1.Font.Style:=ini.ReadInteger('SETTINGS','FontStyle',8);
   number :=    ini.ReadInteger('SETTINGS', 'FontStyle', 0);
   if number = 0 then Memo1.Font.Style:= [];
   if number - 8 >= 0 then begin
     memo1.Font.Style:=[fsStrikeOut];
     number := number - 8;
   end;
   if number - 4 >= 0 then begin
     Memo1.Font.Style:=memo1.Font.Style + [fsUnderline];
     number := number - 4;
   end;
   if number - 2 >= 0 then begin
     Memo1.Font.Style:=Memo1.Font.Style + [fsItalic];
     number := number - 2;
   end;
   if number - 1 >= 0 then begin
     Memo1.Font.Style:=Memo1.Font.Style + [fsBold];
   end;
end;
//сохранение файла
procedure TForm1.SaveFile(ask,dialogResult: boolean);   //ask - показывать ли вопрос о сохранении. dialogResult отвечает за то, будет файл записан или нет
var s:string;
    res:Integer;
begin
if NoSaving then exit;
if ask then
   begin
        s:='Сохранить '+LastName+'?';
        res:=MessageBoxW(0,PWideChar(UTF8Decode(s)),'Сохранение',MB_ICONWARNING or MB_YESNO);
        if res=IDYES then SaveFile(false,true) else exit;
   end;
if dialogResult then
   begin
       filename:=DeleteWrongSymbols(LastName);
       if LastName='EXFiPQuickNotes' then
       Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+MainFileName)
       else
           begin
                if not FileExists(filename+'.txt') then Combobox1.Items.Add(filename);
                Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+filename+'.txt');
           end;
   LastName:=Combobox1.Text;
   end;
end;
{
  //старое сохранение файла
 //TODO ПЕРЕПИСАТЬ ЧТОБЫ ПРИ ЗАКРЫТИИ ОКНА ЭТОТ ДАИЛОГ ЗАКРЫВАЛ ОКНО ПРИ НАЖАТИИ НЕТ
//ShowMessage('до '+LastName);
s:='Сохранить '+LastName+'?';
if not NoSaving then
   if  TMenuItem(N12).Checked then
       begin
       if MessageBoxW(0,PWideChar(UTF8Decode(s)),'Сохранение',MB_ICONWARNING or MB_YESNO)=IDYES then
          begin
          filename:=DeleteWrongSymbols(LastName);
          if LastName='EXFiPQuickNotes2' then
          Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+MainFileName)
          else
              begin
                   if not FileExists(filename+'.txt') then Combobox1.Items.Add(filename);
                   Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+filename+'.txt');
              end;
          LastName:=Combobox1.Text;
          //ShowMessage('после '+LastName);
          end
       else
          exit;
       end
   else
           begin
                 filename:=DeleteWrongSymbols(LastName);
                 if LastName='EXFiPQuickNotes2' then
                 Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+MainFileName)
                 else
                     begin
                     if not FileExists(filename+'.txt') then Combobox1.Items.Add(filename);
                     Memo1.Lines.SaveToFile(ExtractFilePath(Paramstr(0))+filename+'.txt');
                     end;
                 LastName:=Combobox1.Text;
           end;
end;        }
// сохранение настроек
procedure TForm1.SaveSettings;
var number:byte;
begin
//положение окна
ini.WriteInteger('SETTINGS','FormLeft',Form1.Left);
ini.WriteInteger('SETTINGS','FormTop',Form1.Top);
ini.WriteInteger('SETTINGS','FormHeight',Form1.Height);
ini.WriteInteger('SETTINGS','FormWidth',Form1.Width);
//задавать вопрос преред сохраненем
if TMenuItem(N12).Checked then
ini.WriteBool('SETTINGS','AskEveryTime',true) else ini.WriteBool('SETTINGS','AskEveryTime',false);

//шрифт
//ini.WriteInteger('SETTINGS','FontCharset',Memo1.Font.Charset);
ini.WriteInteger('SETTINGS','FontColor',Memo1.Font.Color);
//ini.WriteInteger('SETTINGS','FontHeight',Memo1.Font.Height);
ini.WriteString('SETTINGS','FontName',Memo1.Font.Name);
//ini.WriteString('SETTINGS','Pitch',Memo1.Font.Pitch);
ini.WriteInteger('SETTINGS','FontSize',Memo1.Font.Size);
 number := 0;
   if fsBold in Memo1.Font.Style then
     number := 1;
   if fsItalic in Memo1.Font.Style then
     number := number + 2;
   if fsUnderline in Memo1.Font.Style then
     number := number + 4;
   if fsStrikeOut in Memo1.Font.Style then
     number := number + 8;
   ini.WriteInteger('SETTINGS', 'FontStyle', number);
end;
//обновление
{procedure TForm1.Updater;
var ver:TINIFile;
begin
ver:=TINIFile.Create(ExtractFilePath(Paramstr(0))+'version.ini');
ver.WriteString('Info','pID',pID);
ver.WriteString('Info','pVer',pVer);
ver.WriteString('Info','pRVer',pRVer);
ver.WriteString('Info','pName',ExtractFileName(Application.ExeName));
ver.WriteString('Proxy','Proxy','0');
ShellExecute(0,'open','Updater.exe','-start -nohide',nil,SW_SHOW);
ver.Free;
end;       }

//инициализация
begin
 activated:=false;
 NoSaving:=false;
 LastName:='EXFiPQuickNotes';
end.

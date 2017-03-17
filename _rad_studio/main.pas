unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, INIFiles,ShellAPI,about;

type
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
    N5: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    procedure FormActivate(Sender: TObject);

    procedure GetFileList;
    procedure ReadSettings;
    procedure SaveSettings;
    procedure LoadFile;
    procedure SaveFile;
    function DeleteWrongSymbols(str:string):string;
    procedure Updater;

    procedure ComboBox1Select(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;
const
 MainFileName='EXFiPQuickNotes2.efp';
 pID='3';
 pVer='1.0';
 pRVer='1';
var
  Form1: TForm1;
  activated,NoSaving:boolean;
  ini:TINIFile;
  filename:string;
  LastName:string;


implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
LastName:=Combobox1.Text;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
SaveFile;
LoadFile;
end;


function TForm1.DeleteWrongSymbols(str: string): string;
var i:integer;
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

procedure TForm1.FormActivate(Sender: TObject);
begin
if not activated then
begin
ini:=TiniFile.Create(ExtractFilePath(ParamStr(0))+'eqn2_settings.ini');
ReadSettings;

if fileexists(ExtractFilePath(Paramstr(0))+MainFileName) then
Memo1.Lines.LoadFromFile(ExtractFilePath(Paramstr(0))+MainFileName) else
  begin
    memo1.Lines.Add('Добро пожаловать в EXFiP QuickNotes 2!');
  end;

GetFileList;

activated:=true;
end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
SaveFile;
SaveSettings;
end;

procedure TForm1.GetFileList;
Var SR:TSearchRec;
    FindRes:Integer;
    s,f:string;
begin
Combobox1.Clear;
Combobox1.Items.Add('EXFiPQuickNotes2');
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

procedure TForm1.LoadFile;
begin
Memo1.Clear;
if Combobox1.Text='EXFiPQuickNotes2' then
  begin
    if fileexists(ExtractFilePath(Paramstr(0))+MainFileName) then
    begin
    Memo1.Lines.LoadFromFile(ExtractFilePath(Paramstr(0))+MainFileName);
    LastName:='EXFiPQuickNotes2';
    end
    else
      begin
        MessageBox(0,'Файл не существует','Ошибка', MB_OK or MB_ICONERROR);
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
        MessageBox(0,'Файл не существует','Ошибка', MB_OK or MB_ICONERROR);
        exit
      end;
  end;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
Form2.Showmodal;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
if FontDialog1.Execute then
    form1.Memo1.Font.Assign(FontDialog1.Font);
end;

procedure TForm1.N13Click(Sender: TObject);
begin
Updater;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
LastName:=Combobox1.Text;
SaveFile;
Combobox1.Text:='Введите сюда название файла';
LastName:='Введите сюда название файла';
Memo1.Clear;
end;

procedure TForm1.N3Click(Sender: TObject);
var s:string;
begin
if Combobox1.Text='EXFiPQuickNotes2' then
begin
  MessageBox(0,'Файл EXFiPQuickNotes2 удалить нельзя.','Ошибка',MB_OK or MB_ICONERROR);
  exit;
end;
s:='Удалить '+Combobox1.Text+'?';
if MessageBox(0,pChar(s),'Удаление',MB_YESNO or MB_ICONWARNING)=IDYES then
if FileExists(Combobox1.Text+'.txt') then
begin
  DeleteFile(Combobox1.Text+'.txt');
  Memo1.Clear;
  Combobox1.Clear;
  GetFileList;
  LoadFile;
end else MessageBox(0,'Невозможно удалить файл: файл не существует','Ошибка',MB_OK or MB_ICONERROR);


end;

procedure TForm1.N4Click(Sender: TObject);
begin
if MessageBox(0,'Выйти без сохранения?','Выход', MB_ICONWARNING or MB_YESNO)=IDYES then
begin
NoSaving:=true;
Close;
end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
ShellExecute(0,'open','http://exfip.org/EQN2_licence',nil,nil,SW_SHOW);
end;

procedure TForm1.N6Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
ShellExecute(0,'open','http://exfip.org/EQN2_help',nil,nil,SW_SHOW);
end;

procedure TForm1.ReadSettings;
var
number:byte;
begin
//обновление
if (FileExists('Updater.exe')) and (FileExists('Updater.dll')) then
TMenuItem(N13).Enabled:=true else TMenuItem(N13).Enabled:=false;

  //положение и размер окна
  Form1.Left:=ini.ReadInteger('SETTINGS','FormLeft',0);
  Form1.Top:= ini.ReadInteger('SETTINGS','FormTop',0);
  Form1.Height:= ini.ReadInteger('SETTINGS','FormHeight',357);
  Form1.Width:= ini.ReadInteger('SETTINGS','FormWidth',572);
  //задавать вопрос перед сохранением
  if ini.ReadBool('SETTINGS','AskAnyTime',false) then
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

procedure TForm1.SaveFile;
var s:string;
begin
//ShowMessage('до '+LastName);
s:='Сохранить '+LastName+'?';
if not NoSaving then
if  TMenuItem(N12).Checked then
begin
if MessageBox(0,PChar(s),'Сохранение',MB_ICONWARNING or MB_YESNO)=IDYES then
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
end else
exit;
end else
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
end;

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
ini.WriteBool('SETTINGS','AskAnyTime',true) else ini.WriteBool('SETTINGS','AskAnyTime',false);

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

procedure TForm1.Updater;
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
end;

begin
 activated:=false;
 NoSaving:=false;
 LastName:='EXFiPQuickNotes2';
end.

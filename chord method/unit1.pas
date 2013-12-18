unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function F(x:real):real;
begin
F:=3*x-4*ln(x)-5;
end;

procedure TForm1.Button1Click(Sender: TObject);
var pred,beg, last, eps, x, k, alfa, f1: extended;
i:byte;
s: string;

begin
beg:=strtofloat(edit1.text);
last:=strtofloat(edit2.text);
eps:=strtofloat(edit3.text);
if beg>=last then messagedlg('Введите правильные значения', mtWarning, [mbOk], 0)
else
if (eps<0) and (eps>1) then messagedlg('Неправильная точность!', mtWarning, [mbOk], 0)
else
begin
if (beg>last) or (F(beg)*F(last)>0) then messagedlg('Нет корней', mtWarning, [mbOk], 0);

memo1.lines.Clear;
memo1.lines.Add(' X'+' '+'F(x)');
i:=0;
 repeat
   x:=beg-f(beg)*(last-beg)/(f(last)-f(beg));
   if f(beg)*f(x)>0 then beg:=x
   else last:=x;
   memo1.Lines.add(floattostr(x)+' '+floattostrf(f(x), fffixed, 6,4));
   Inc(i)
 until abs((f(last)*beg-f(beg)*last)/(f(last)-f(beg))-x)<eps ;
k:=x;
memo1.lines.add('Методом хорд корень уравнения= '+floattostr(x)+', кол-во итераций= '+inttostr(i));
end;
i:=0;
x:=strtofloat(edit1.Text);
F1:=3-4/x;
if F1>0 then alfa:=0.1
else alfa:=-0.1;
repeat
pred:=x;
x:=pred-alfa*F(pred);
i:=i+1;
s:=floattostr(x);
memo1.Lines.add(s);
until (abs(x-pred)<=eps);
memo1.Lines.add('Методом простых итераций корень= '+floattostr(x)+', кол-во итераций= '+inttostr(i));

end;
end.

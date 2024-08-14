unit untfrmpesquisa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, DBGrids, ShellCtrls, FileCtrl, ExtCtrls, Buttons, ZDataset;

type

  { TfrmPesquisa }

  TfrmPesquisa = class(TForm)
    btnPesquisarLista: TBitBtn;
    DBGrid1: TDBGrid;
    dsRelatorio: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    qryRelatorio: TZQuery;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.lfm}

{ TfrmPesquisa }

procedure TfrmPesquisa.Button1Click(Sender: TObject);
begin

end;

end.


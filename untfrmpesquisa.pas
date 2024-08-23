unit untfrmpesquisa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, DBGrids, ShellCtrls, ExtCtrls, Buttons, ZDataset, untdmConexao;

type

  { TfrmPesquisa }

  TfrmPesquisa = class(TForm)
    btnPesquisarLista: TBitBtn;
    DBGrid1: TDBGrid;
    rgTipoAcervo: TDBRadioGroup;
    edtPesqItem: TEdit;
    edtPesqAutor: TEdit;
    edtPesqUsuario: TEdit;
    edtPesqCategoria: TEdit;
    edtPesqGenero: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    rgTipoAcervo1: TRadioGroup;
    procedure btnPesquisarListaClick(Sender: TObject);
  private

  public

  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.lfm}

{ TfrmPesquisa }


procedure TfrmPesquisa.btnPesquisarListaClick(Sender: TObject);
begin
  dmConexao.qryRelatorio.Close;
  dmConexao.qryRelatorio.sql.Clear;
  dmConexao.qryRelatorio.sql.add('select * from vw_relatorio_item where 1 = 1');

  if trim(edtPesqItem.Text) <> '' then
  begin
    dmConexao.qryRelatorio.sql.add('and "Item" like :item');
    dmConexao.qryRelatorio.ParamByName ('item').AsString:= '%' + edtPesqItem.Text + '%';
  end;

  if trim(edtPesqAutor.Text) <> '' then
  begin
    dmConexao.qryRelatorio.sql.add('and "Autor" like :autor');
    dmConexao.qryRelatorio.ParamByName('autor').asstring := '%' + edtPesqAutor.Text + '%';
  end;

  if trim(edtPesqUsuario.Text) <> '' then
  begin
    dmConexao.qryRelatorio.sql.add('and "Nome do Usuário" like :usuario');
    dmConexao.qryRelatorio.ParamByName('usuario').asstring := '%' + edtPesqUsuario.Text + '%';
  end;

  if trim(edtPesqCategoria.Text) <> '' then
  begin
    dmConexao.qryRelatorio.sql.add('and "Categoria" like :categoria');
    dmConexao.qryRelatorio.ParamByName('categoria').asstring := '%' + edtPesqCategoria.Text + '%';
  end;

  if trim(edtPesqGenero.Text) <> '' then
  begin
    dmConexao.qryRelatorio.sql.add('and "Gênero" like :genero');
    dmConexao.qryRelatorio.ParamByName('genero').asstring := '%' + edtPesqGenero.Text + '%';
  end;

  if rgTipoAcervo.ItemIndex <> -1 then  // Verifica se algo foi selecionado
begin
  dmConexao.qryRelatorio.SQL.Add('and "Físico(F) ou Digital(D)?" = :tipo_acervo');
  dmConexao.qryRelatorio.ParamByName('tipo_acervo').AsString := rgTipoAcervo.Values[rgTipoAcervo.ItemIndex];
end;


   dmConexao.qryRelatorio.Open;
end;

end.


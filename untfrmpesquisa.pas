unit untfrmPesquisa;

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
    edtPesqItem: TEdit;
    edtPesqAutor: TEdit;
    edtPesqCategoria: TEdit;
    edtPesqGenero: TEdit;
    GroupBox1: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    procedure btnPesquisarListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  dmConexao.qryRelatorio.SQL.Clear;

  // Inicia a consulta filtrando pelo usuário logado
  dmConexao.qryRelatorio.SQL.Add('SELECT * FROM vw_relatorio_item WHERE "ID Usuario" = :id_usuario');
  dmConexao.qryRelatorio.ParamByName('id_usuario').AsInteger := dmConexao.UsuarioLogadoID;

  // Filtros adicionais baseados nas entradas do usuário
  if Trim(edtPesqItem.Text) <> '' then
  begin
    dmConexao.qryRelatorio.SQL.Add('AND "Item" ILIKE :item');
    dmConexao.qryRelatorio.ParamByName('item').AsString := '%' + edtPesqItem.Text + '%';
  end;

  if Trim(edtPesqAutor.Text) <> '' then
  begin
    dmConexao.qryRelatorio.SQL.Add('AND "Autor" ILIKE :autor');
    dmConexao.qryRelatorio.ParamByName('autor').AsString := '%' + edtPesqAutor.Text + '%';
  end;
//
//  if Trim(edtPesqUsuario.Text) <> '' then
//  begin
//    dmConexao.qryRelatorio.SQL.Add('AND "Nome do Usuário" LIKE :usuario');
//    dmConexao.qryRelatorio.ParamByName('usuario').AsString := '%' + edtPesqUsuario.Text + '%';
//  end;

  if Trim(edtPesqCategoria.Text) <> '' then
  begin
    dmConexao.qryRelatorio.SQL.Add('AND "Categoria" LIKE :categoria');
    dmConexao.qryRelatorio.ParamByName('categoria').AsString := '%' + edtPesqCategoria.Text + '%';
  end;

  if Trim(edtPesqGenero.Text) <> '' then
  begin
    dmConexao.qryRelatorio.SQL.Add('AND "Gênero" LIKE :genero');
    dmConexao.qryRelatorio.ParamByName('genero').AsString := '%' + edtPesqGenero.Text + '%';
  end;

  // Abre a consulta para exibir os resultados filtrados
  dmConexao.qryRelatorio.Open;
end;

procedure TfrmPesquisa.FormCreate(Sender: TObject);
begin
  with dmConexao.qryRelatorio do
  begin
    Close;  // Fecha a consulta atual se estiver aberta
    SQL.Clear;  // Limpa a consulta atual

    // Define a consulta SQL com o filtro para o usuário logado
    SQL.Add('SELECT * FROM vw_relatorio_item WHERE "ID Usuario" = :id_usuario ORDER BY "Item"');

    // Passa o ID do usuário logado como parâmetro
    ParamByName('id_usuario').AsInteger := dmConexao.UsuarioLogadoID;

    // Abre a consulta para carregar os dados na grid
    Open;
  end;
end;

end.


unit untfrmlistadesejos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, DBGrids, StdCtrls, DBCtrls, DBExtCtrls, ShellCtrls,
  RxMDI, DB, ZDataset, ZAbstractRODataset, untdmConexao;

type

  { TfrmListaDesejos }

  TfrmListaDesejos = class(TForm)
    btnAtualizarListaDesejos: TBitBtn;
    btnCadastroLista: TBitBtn;
    btnCancelarListaDesejos: TBitBtn;
    btnConsultaLista: TBitBtn;
    btnEditListaDesejos: TBitBtn;
    btnExcluirListaDesejos: TBitBtn;
    btnLimparListaDesejos: TBitBtn;
    btnNovoListaDesejos: TBitBtn;
    btnPesquisarLista: TBitBtn;
    btnSalvarListaDesejos: TBitBtn;
    DBGrid24: TDBGrid;
    DBGrid25: TDBGrid;
    edtDataDesejos: TDBDateEdit;
    edtNomeDesejos: TDBEdit;
    edtAutorDesejos: TDBEdit;
    edtIdDesejos: TDBEdit;
    cbGeneroDesejos: TDBLookupComboBox;
    edtPesqAutorLista: TEdit;
    edtPesqNomeLista: TEdit;
    GroupBox10: TPanel;
    GroupBox2: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    rgAtendidoDesejos: TDBRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox11: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label29: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    pgcAcoesLista: TPageControl;
    tabCadastroLista: TTabSheet;
    tabConsultaLista: TTabSheet;
    procedure btnAtualizarListaDesejosClick(Sender: TObject);
    procedure btnCancelarListaDesejosClick(Sender: TObject);
    procedure btnEditListaDesejosClick(Sender: TObject);
    procedure btnExcluirListaDesejosClick(Sender: TObject);
    procedure btnLimparListaDesejosClick(Sender: TObject);
    procedure btnNovoListaDesejosClick(Sender: TObject);
    procedure btnPesquisarListaClick(Sender: TObject);
    procedure btnSalvarListaDesejosClick(Sender: TObject);
    procedure edtDataDesejosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CamposPreenchidos: Boolean;
    procedure MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
  public

  end;

var
  frmListaDesejos: TfrmListaDesejos;

implementation

{$R *.lfm}

{ TfrmListaDesejos }

//salvar
procedure TfrmListaDesejos.btnSalvarListaDesejosClick(Sender: TObject);
begin
  // Lógica para salvar item
  btnNovoListaDesejos.Enabled := True;  // Ativa o botão Novo
  btnEditListaDesejos.Enabled := True; // Ativa o botão Editar
  btnExcluirListaDesejos.Enabled := True; // Ativa o botão Excluir
  btnSalvarListaDesejos.Enabled := False; // Desativa o botão Salvar
  btnCancelarListaDesejos.Enabled := False; // Desativa o botão Cancelar
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidos then
    Exit;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsLista.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsLista.DataSet.Post;
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsUsuario.DataSet.State = dsInsert then
    begin
      dmConexao.dsLista.DataSet.Post;
    end;
  end;
end;

procedure TfrmListaDesejos.edtDataDesejosChange(Sender: TObject);
begin

end;

//novo item na lista
procedure TfrmListaDesejos.btnNovoListaDesejosClick(Sender: TObject);
begin
  // desativar botões
  btnNovoListaDesejos.Enabled := True;  // Desativa o botão Novo
  btnEditListaDesejos.Enabled := False; // Desativa o botão Editar
  btnExcluirListaDesejos.Enabled := False; // Desativa o botão Excluir
  btnSalvarListaDesejos.Enabled := True; // Ativa o botão Salvar
  btnCancelarListaDesejos.Enabled := True; // Ativa o botão Cancelar
  //inserir itens
 dmConexao.dsLista.DataSet.Insert;
 edtNomeDesejos.SetFocus;
 edtDataDesejos.SetFocus;
 cbGeneroDesejos.SetFocus;
 edtAutorDesejos.SetFocus;
 rgAtendidoDesejos.SetFocus;
end;
//pesquisa
procedure TfrmListaDesejos.btnPesquisarListaClick(Sender: TObject);
begin
  dmConexao.qryLista.Close;

  dmConexao.qryLista.sql.Clear;
  dmConexao.qryLista.sql.add('select * from lista where 1 = 1');

  if trim(edtPesqNomeLista.Text) <> '' then
  begin
    dmConexao.qryLista.sql.add('and nome like :nome');
    dmConexao.qryLista.ParamByName ('nome').AsString:= '%' + edtPesqNomeLista.Text + '%';
  end;

  if trim(edtPesqAutorLista.Text) <> '' then
  begin
    dmConexao.qryLista.sql.add('and autor like :autor');
    dmConexao.qryLista.ParamByName('autor').asstring := '%' + edtPesqAutorLista.Text + '%';
  end;

   dmConexao.qryLista.Open;
end;
//editar lista
procedure TfrmListaDesejos.btnEditListaDesejosClick(Sender: TObject);
begin
  if not (dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsLista.DataSet.Edit;
    edtNomeDesejos.SetFocus;
    edtDataDesejos.SetFocus;
    cbGeneroDesejos.SetFocus;
    edtAutorDesejos.SetFocus;
    rgAtendidoDesejos.SetFocus;
  end;
end;
//cancelar operação
procedure TfrmListaDesejos.btnCancelarListaDesejosClick(Sender: TObject);
begin
  // Lógica para cancelar a operação atual
  btnNovoListaDesejos.Enabled := True;  // Ativa o botão Novo
  btnEditListaDesejos.Enabled := True; // Ativa o botão Editar
  btnExcluirListaDesejos.Enabled := True; // Ativa o botão Excluir
  btnSalvarListaDesejos.Enabled := False; // Desativa o botão Salvar
  btnCancelarListaDesejos.Enabled := False; // Desativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsLista.DataSet.Cancel;
    edtNomeDesejos.Clear;
    edtDataDesejos.Clear;
    cbGeneroDesejos.Clear;
    edtAutorDesejos.Clear;
    //rgAtendidoDesejos.Clear;
  end;
end;
//atualizar grid
procedure TfrmListaDesejos.btnAtualizarListaDesejosClick(Sender: TObject);
begin
  begin
       dmConexao.qryLista.Refresh;
  end;
end;
//excluir item da lista
procedure TfrmListaDesejos.btnExcluirListaDesejosClick(Sender: TObject);
begin
  gin
    // Lógica para excluir item
  btnNovoListaDesejos.Enabled := True;  // Ativa o botão Novo
  btnEditListaDesejos.Enabled := True; // Ativa o botão Editar
  btnExcluirListaDesejos.Enabled := False; // Desativa o botão Excluir
  btnSalvarListaDesejos.Enabled := False; // Desativa o botão Salvar
  btnCancelarListaDesejos.Enabled := False; // Desativa o botão Cancelar
  begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.está ficando como yes ou no.
  begin
    dmConexao.dsLista.DataSet.Delete;
  end;
end;
end;

procedure TfrmListaDesejos.btnLimparListaDesejosClick(Sender: TObject);
begin
   edtIdDesejos.Clear;
   edtNomeDesejos.Clear;
   edtDataDesejos.Clear;
   cbGeneroDesejos.Clear;
   edtAutorDesejos.Clear;
   //rgAtendidoDesejos.Clear;
end;

procedure TfrmListaDesejos.FormCreate(Sender: TObject);
begin
       edtDataDesejos.Date := Date;

end;

function TfrmListaDesejos.CamposPreenchidos: Boolean;
begin
  Result := True;

  if Trim(edtNomeDesejos.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtNomeDesejos, 'Nome');
    Result := False;
    Exit;
  end;

  if Trim(edtDataDesejos.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtDataDesejos, 'Data de Cadastro');
    Result := False;
    Exit;
  end;

  //if Trim(rgAtendidoDesejos.Text) = '' then
  //begin
   // MostrarMensagemCampoEmBranco(cbGeneroDesejos, '"Item Adquirido?"');
   // Result := False;
   // Exit;
 // end;

  if Trim(edtAutorDesejos.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtAutorDesejos, 'Autor');
    Result := False;
    Exit;
  end;

end;

procedure TfrmListaDesejos.MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
begin
  ShowMessage(Format('%s está em branco e precisa ser preenchido. Por favor, preencha-o para prosseguir com a operação.', [NomeCampo]));
  Campo.SetFocus;
end;

end.


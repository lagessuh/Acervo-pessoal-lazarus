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
    cbGeneroDesejos: TDBLookupComboBox;
    DBGrid24: TDBGrid;
    DBGrid25: TDBGrid;
    edtDataDesejos: TDBDateEdit;
    edtNomeDesejos: TDBEdit;
    edtAutorDesejos: TDBEdit;
    edtIdDesejos: TDBEdit;
    edtPesqAutorLista: TEdit;
    edtPesqNomeLista: TEdit;
    GroupBox10: TPanel;
    GroupBox2: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    rgAtendidoDesejos: TDBRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox11: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pgcAcoesLista: TPageControl;
    tabCadastroLista: TTabSheet;
    tabConsultaLista: TTabSheet;
    procedure btnAtualizarListaDesejosClick(Sender: TObject);
    procedure btnCadastroListaClick(Sender: TObject);
    procedure btnCancelarListaDesejosClick(Sender: TObject);
    procedure btnConsultaListaClick(Sender: TObject);
    procedure btnEditListaDesejosClick(Sender: TObject);
    procedure btnExcluirListaDesejosClick(Sender: TObject);
    procedure btnLimparListaDesejosClick(Sender: TObject);
    procedure btnNovoListaDesejosClick(Sender: TObject);
    procedure btnPesquisarListaClick(Sender: TObject);
    procedure btnSalvarListaDesejosClick(Sender: TObject);
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
  btnSalvarListaDesejos.Enabled := True; // Ativa o botão Salvar
  btnCancelarListaDesejos.Enabled := True; // Ativa o botão Cancelar
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidos then
    Exit;

  //Adiciona a data atual no campo data de cadastro
  dmConexao.dsLista.DataSet.FieldByName('dt_cadastro').AsDateTime := Date;


  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsLista.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsLista.DataSet.Post; // Salva apenas se o usuário clicar em "Sim"
      end
      else
      begin
        dmConexao.dsLista.DataSet.Cancel; // Cancela as alterações se o usuário clicar em "Não"
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsLista.DataSet.State = dsInsert then
    begin
      dmConexao.dsLista.DataSet.Post;
    end;
  end;
end;

//novo item na lista
procedure TfrmListaDesejos.btnNovoListaDesejosClick(Sender: TObject);
begin
  // desativar botões
  btnNovoListaDesejos.Enabled := False;  // Desativa o botão Novo
  btnEditListaDesejos.Enabled := False; // Desativa o botão Editar
  btnExcluirListaDesejos.Enabled := False; // Desativa o botão Excluir
  btnSalvarListaDesejos.Enabled := True; // Ativa o botão Salvar
  btnCancelarListaDesejos.Enabled := True; // Ativa o botão Cancelar
  edtDataDesejos.Enabled := False; //Desabilita o campo de cadastro da data
  //inserir itens
 dmConexao.dsLista.DataSet.Insert;
 edtDataDesejos.Clear;
 edtNomeDesejos.SetFocus;
 cbGeneroDesejos.SetFocus;
 edtAutorDesejos.SetFocus;
 rgAtendidoDesejos.SetFocus;
 edtDataDesejos.Date := Date;
end;
//pesquisa
procedure TfrmListaDesejos.btnPesquisarListaClick(Sender: TObject);
begin
  dmConexao.qryLista.Close;

  dmConexao.qryLista.sql.Clear;
  dmConexao.qryLista.sql.add('select * from lista_desejo where 1 = 1');

  if trim(edtPesqNomeLista.Text) <> '' then
  begin
    dmConexao.qryLista.sql.add('and nm_desejo Ilike :nm_desejo');
    dmConexao.qryLista.ParamByName ('nm_desejo').AsString:= '%' + edtPesqNomeLista.Text + '%';
  end;

  if trim(edtPesqAutorLista.Text) <> '' then
  begin
    dmConexao.qryLista.sql.add('and autor Ilike :autor');
    dmConexao.qryLista.ParamByName('autor').asstring := '%' + edtPesqAutorLista.Text + '%';
  end;

   dmConexao.qryLista.Open;
end;
//editar lista
procedure TfrmListaDesejos.btnEditListaDesejosClick(Sender: TObject);
begin
   // desativar botões
  btnNovoListaDesejos.Enabled := False;  // Desativa o botão Novo
  btnEditListaDesejos.Enabled := False; // Desativa o botão Editar
  btnExcluirListaDesejos.Enabled := False; // Desativa o botão Excluir
  btnSalvarListaDesejos.Enabled := True; // Ativa o botão Salvar
  btnCancelarListaDesejos.Enabled := True; // Ativa o botão Cancelar
  edtDataDesejos.Enabled := False;; //Desabilita o campo da data de cadastro
begin
  if not (dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsLista.DataSet.Edit;
    edtNomeDesejos.SetFocus;
    cbGeneroDesejos.SetFocus;
    edtAutorDesejos.SetFocus;
    rgAtendidoDesejos.SetFocus;
  end;
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
  btnCancelarListaDesejos.Enabled := True; // Ativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsLista.DataSet.Cancel;
    edtNomeDesejos.Clear;
    edtDataDesejos.Clear;
    cbGeneroDesejos.Clear;
    edtAutorDesejos.Clear;
    rgAtendidoDesejos.ItemIndex := -1;
  end;
end;

procedure TfrmListaDesejos.btnConsultaListaClick(Sender: TObject);
begin
  pgcAcoesLista.TabIndex := 0;
end;

//atualizar grid
procedure TfrmListaDesejos.btnAtualizarListaDesejosClick(Sender: TObject);
begin
  begin
       dmConexao.qryLista.Refresh;
  end;
end;

procedure TfrmListaDesejos.btnCadastroListaClick(Sender: TObject);
begin
  pgcAcoesLista.TabIndex := 1;
end;

//excluir item da lista
procedure TfrmListaDesejos.btnExcluirListaDesejosClick(Sender: TObject);
begin
  begin
    // Lógica para excluir item
  btnNovoListaDesejos.Enabled := True;  // Ativa o botão Novo
  btnEditListaDesejos.Enabled := True; // Ativa o botão Editar
  btnExcluirListaDesejos.Enabled := True; // Ativa o botão Excluir
  btnSalvarListaDesejos.Enabled := True; // Ativa o botão Salvar
  btnCancelarListaDesejos.Enabled := False; // Desativa o botão Cancelar
  begin
  if MessageDlg('Confirma a exclusão do registro "' + edtNomeDesejos.Text + '"? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsLista.DataSet.Delete;
  end;
end;
end;
end;
//limpar
procedure TfrmListaDesejos.btnLimparListaDesejosClick(Sender: TObject);
begin
   edtIdDesejos.Clear;
   edtNomeDesejos.Clear;
   cbGeneroDesejos.Clear;
   edtAutorDesejos.Clear;
   rgAtendidoDesejos.ItemIndex := -1;
end;

procedure TfrmListaDesejos.FormCreate(Sender: TObject);
begin
       edtDataDesejos.Clear;

end;

function TfrmListaDesejos.CamposPreenchidos: Boolean;
begin
  Result := True;

  if Trim(edtNomeDesejos.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtNomeDesejos, '"Nome"');
    Result := False;
    Exit;
  end;

  if Trim(edtDataDesejos.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtDataDesejos, '"Data de Cadastro"');
    Result := False;
    Exit;
  end;

  if rgAtendidoDesejos.ItemIndex = -1 then
begin
  MostrarMensagemCampoEmBranco(rgAtendidoDesejos, '"Item Adquirido?"');
  Result := False;
  Exit;
end;


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


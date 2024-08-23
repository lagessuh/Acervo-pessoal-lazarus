unit untfrmcadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, DBExtCtrls, rxswitch, RxMDI,
  untdmConexao, LCLType, ActnList, DB, ZDataset,
  ZAbstractRODataset;

type

  { TfrmCadastro }

  TfrmCadastro = class(TForm)
    btnAtualizarItem: TBitBtn;
    btnAtualizarLocal: TBitBtn;
    btnAtualizarGenero: TBitBtn;
    btnAtualizarCategoria: TBitBtn;
    btnCadastroGenero: TBitBtn;
    btnCadastroCategoria2: TBitBtn;
    btnCadastroItem: TBitBtn;
    btnCadastroLocal: TBitBtn;
    btnCancelarItem: TBitBtn;
    btnCancelarLocal: TBitBtn;
    btnCancelarGenero: TBitBtn;
    btnCancelarCategoria: TBitBtn;
    btnConsultaGenero: TBitBtn;
    btnConsultaCategoria2: TBitBtn;
    btnConsultaItem: TBitBtn;
    btnConsultaLocal: TBitBtn;
    btnEditItem: TBitBtn;
    btnEditLocal: TBitBtn;
    btnEditGenero: TBitBtn;
    btnEditCategoria: TBitBtn;
    btnExcluirItem: TBitBtn;
    btnExcluirLocal: TBitBtn;
    btnExcluirGenero: TBitBtn;
    btnExcluirCategoria: TBitBtn;
    btnLimparItem: TBitBtn;
    btnLimparLocal: TBitBtn;
    btnLimparGenero: TBitBtn;
    btnLimparCategoria: TBitBtn;
    btnNovoItem: TBitBtn;
    btnNovoLocal: TBitBtn;
    btnNovoGenero: TBitBtn;
    btnNovoCategoria: TBitBtn;
    btnPesquisarCategoria: TBitBtn;
    btnPesquisarItem: TBitBtn;
    btnPesquisarLocal: TBitBtn;
    btnGenero: TBitBtn;
    btnCategoria: TBitBtn;
    btnAquisicao: TBitBtn;
    btnItem: TBitBtn;
    btnPesquisarGenero: TBitBtn;
    btnSalvarItem: TBitBtn;
    btnSalvarLocal: TBitBtn;
    btnSalvarGenero: TBitBtn;
    btnSalvarCategoria: TBitBtn;
    cbAvaliacaoItemCad: TDBComboBox;
    Consulta: TGroupBox;
    DBGrid17: TDBGrid;
    DBGrid19: TDBGrid;
    DBGrid20: TDBGrid;
    DBGrid22: TDBGrid;
    DBGrid23: TDBGrid;
    DBGrid24: TDBGrid;
    Label26: TLabel;
    Panel6: TPanel;
    rgTipoAcervoItem: TDBRadioGroup;
    edtLancamentoItemCad: TDBDateEdit;
    edtAquisicaoItemCad: TDBDateEdit;
    edtdataItemCad: TDBDateEdit;
    edtIdItem: TDBEdit;
    edtNomeItemCad: TDBEdit;
    edtAutorItemCad: TDBEdit;
    edtEdicaoItemCad: TDBEdit;
    cbGeneroItemCad: TDBLookupComboBox;
    cbCategoriaItemCad: TDBLookupComboBox;
    dbLocalItemCad: TDBLookupComboBox;
    edtIdLocalCad: TDBEdit;
    edtLocalCad: TDBEdit;
    DBGrid21: TDBGrid;
    edtIdCategoria: TDBEdit;
    edtCategoriaCad: TDBEdit;
    edtGeneroCad: TDBEdit;
    edtIdGeneroCad: TDBEdit;
    DBGrid18: TDBGrid;
    edtPesqAutorItem: TEdit;
    edtPesqCategoria: TEdit;
    edtPesqGenero: TEdit;
    edtPesqLocal: TEdit;
    edtPesqNomeItem: TEdit;
    GroupBox1: TGroupBox;
    GroupBox12: TPanel;
    GroupBox13: TPanel;
    GroupBox14: TPanel;
    GroupBox15: TPanel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TPanel;
    GroupBox9: TPanel;
    Image5: TImage;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label9: TLabel;
    Panel10: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PanelConsultaGenero: TPanel;
    GroupBox11: TPanel;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pgcAcoesGenero: TPageControl;
    pgcAcoesCategoria: TPageControl;
    pgcAcoesLocal: TPageControl;
    pgcCadastro: TPageControl;
    Panel1: TPanel;
    pgcAcoesItem: TPageControl;
    rgTipoAquisicao: TDBRadioGroup;
    tabCadastroGenero: TTabSheet;
    tabCadastroCategoria: TTabSheet;
    tabCadastroLocal: TTabSheet;
    tabCategoria: TTabSheet;
    tabConsultaGenero: TTabSheet;
    tabConsultaCategoria: TTabSheet;
    tabConsultaLocal: TTabSheet;
    tbsGenero: TTabSheet;
    tabCadastroItem: TTabSheet;
    tabConsultaItem: TTabSheet;
    tabLocal: TTabSheet;
    tabItem: TTabSheet;
    procedure btnAtualizarCategoriaClick(Sender: TObject);
    procedure btnAtualizarGeneroClick(Sender: TObject);
    procedure btnAtualizarItemClick(Sender: TObject);
    procedure btnAtualizarLocalClick(Sender: TObject);
    procedure btnCadastroCategoria2Click(Sender: TObject);
    procedure btnCadastroGeneroClick(Sender: TObject);
    procedure btnCadastroItemClick(Sender: TObject);
    procedure btnAquisicaoClick(Sender: TObject);
    procedure btnCadastroLocalClick(Sender: TObject);
    procedure btnCancelarCategoriaClick(Sender: TObject);
    procedure btnCancelarGeneroClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
    procedure btnCancelarLocalClick(Sender: TObject);
    procedure btnCategoriaClick(Sender: TObject);
    procedure btnConsultaCategoria2Click(Sender: TObject);
    procedure btnConsultaGeneroClick(Sender: TObject);
    procedure btnConsultaItemClick(Sender: TObject);
    procedure btnConsultaLocalClick(Sender: TObject);
    procedure btnEditCategoriaClick(Sender: TObject);
    procedure btnEditGeneroClick(Sender: TObject);
    procedure btnEditItemClick(Sender: TObject);
    procedure btnEditLocalClick(Sender: TObject);
    procedure btnExcluirCategoriaClick(Sender: TObject);
    procedure btnExcluirGeneroClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnExcluirLocalClick(Sender: TObject);
    procedure btnGeneroClick(Sender: TObject);
    procedure btnItemClick(Sender: TObject);
    procedure btnLimparCategoriaClick(Sender: TObject);
    procedure btnLimparGeneroClick(Sender: TObject);
    procedure btnLimparItemClick(Sender: TObject);
    procedure btnLimparLocalClick(Sender: TObject);
    procedure btnNovoCategoriaClick(Sender: TObject);
    procedure btnNovoGeneroClick(Sender: TObject);
    procedure btnNovoItemClick(Sender: TObject);
    procedure btnNovoLocalClick(Sender: TObject);
    procedure btnPesquisarCategoriaClick(Sender: TObject);
    procedure btnPesquisarGeneroClick(Sender: TObject);
    procedure btnPesquisarItemClick(Sender: TObject);
    procedure btnPesquisarLocalClick(Sender: TObject);
    procedure btnSalvarCategoriaClick(Sender: TObject);
    procedure btnSalvarGeneroClick(Sender: TObject);
    procedure btnSalvarItemClick(Sender: TObject);
    procedure btnSalvarLocalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxDice1Change(Sender: TObject);
  private
    function CamposPreenchidosGenero: Boolean;
    function CamposPreenchidosCategoria: Boolean;
    function CamposPreenchidosLocal: Boolean;
    function CamposPreenchidosItem: Boolean;
    procedure MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
  public

  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.lfm}

{ TfrmCadastro }

procedure TfrmCadastro.RxDice1Change(Sender: TObject);
begin

end;

procedure TfrmCadastro.btnGeneroClick(Sender: TObject);
begin
    pgcCadastro.TabIndex := 0;
end;

procedure TfrmCadastro.btnItemClick(Sender: TObject);
begin
  pgcCadastro.TabIndex := 3;
end;
//limpar campos Categoria
procedure TfrmCadastro.btnLimparCategoriaClick(Sender: TObject);
begin
  edtCategoriaCad.Clear;
  edtIdCategoria.Clear;
end;
//limpar campos genero
procedure TfrmCadastro.btnLimparGeneroClick(Sender: TObject);
begin
  edtIdGeneroCad.Clear;
  edtGeneroCad.Clear;
end;
//limpar campos item
procedure TfrmCadastro.btnLimparItemClick(Sender: TObject);
begin
    edtIdItem.Clear;
    edtNomeItemCad.Clear;
    edtAutorItemCad.Clear;
    edtEdicaoItemCad.Clear;
    cbGeneroItemCad.Clear;
    cbCategoriaItemCad.Clear;
    dbLocalItemCad.Clear;
    cbAvaliacaoItemCad.Clear;
    edtLancamentoItemCad.Clear;
    edtAquisicaoItemCad.Clear;
    edtdataItemCad.Clear;
end;

//limpar campos local
procedure TfrmCadastro.btnLimparLocalClick(Sender: TObject);
begin
  edtIdLocalCad.Clear;
  edtLocalCad.Clear;
end;

//nova categoria
procedure TfrmCadastro.btnNovoCategoriaClick(Sender: TObject);
begin
  dmConexao.dsCategoria.DataSet.Insert;
  edtCategoriaCad.SetFocus
end;
//novo gênero
procedure TfrmCadastro.btnNovoGeneroClick(Sender: TObject);
begin
  // desativar botões
  btnNovoGenero.Enabled := True;  // Desativa o botão Novo
  btnEditGenero.Enabled := False; // Desativa o botão Editar
  btnExcluirGenero.Enabled := False; // Desativa o botão Excluir
  btnSalvarGenero.Enabled := True; // Ativa o botão Salvar
  btnCancelarGenero.Enabled := True; // Ativa o botão Cancelar
  //inserir itens
  dmConexao.dsGenero.DataSet.Insert;
  edtGeneroCad.SetFocus;
end;
//novo item
procedure TfrmCadastro.btnNovoItemClick(Sender: TObject);
begin
  // desativar botões
  btnNovoItem.Enabled := True;  // Desativa o botão Novo
  btnEditItem.Enabled := False; // Desativa o botão Editar
  btnExcluirItem.Enabled := False; // Desativa o botão Excluir
  btnSalvarItem.Enabled := True; // Ativa o botão Salvar
  btnCancelarItem.Enabled := True; // Ativa o botão Cancelar
  //inserir itens
 dmConexao.dsItem.DataSet.Insert;
 edtNomeItemCad.SetFocus;
 edtAutorItemCad.SetFocus;
 edtEdicaoItemCad.SetFocus;
 cbGeneroItemCad.SetFocus;
 cbCategoriaItemCad.SetFocus;
 dbLocalItemCad.SetFocus;
 rgTipoAquisicao.SetFocus;
 rgTipoAcervoItem.SetFocus;
 cbAvaliacaoItemCad.SetFocus;
 edtLancamentoItemCad.SetFocus;
 edtAquisicaoItemCad.SetFocus;
 edtdataItemCad.SetFocus;

end;

//novo Local
procedure TfrmCadastro.btnNovoLocalClick(Sender: TObject);
begin
 // desativar botões
  btnNovoLocal.Enabled := True;  // Desativa o botão Novo
  btnEditLocal.Enabled := False; // Desativa o botão Editar
  btnExcluirLocal.Enabled := False; // Desativa o botão Excluir
  btnSalvarLocal.Enabled := True; // Ativa o botão Salvar
  btnCancelarLocal.Enabled := True; // Ativa o botão Cancelar
  //inserir itens
 dmConexao.dsLocal.DataSet.Insert;
 edtLocalCad.SetFocus;
end;
//pesquisa categoria
procedure TfrmCadastro.btnPesquisarCategoriaClick(Sender: TObject);
begin
   dmConexao.qryCategoria.Close;

  dmConexao.qryCategoria.sql.Clear;
  dmConexao.qryCategoria.sql.add('select * from categoria where 1 = 1');

  if trim(edtPesqCategoria.Text) <> '' then
  begin
    dmConexao.qryCategoria.sql.add('and ds_categoria like :ds_categoria');
    dmConexao.qryCategoria.ParamByName ('ds_categoria').AsString:= '%' + edtPesqCategoria.Text + '%';
  end;

  dmConexao.qryCategoria.Open;
end;
//pesquisa genero
procedure TfrmCadastro.btnPesquisarGeneroClick(Sender: TObject);
begin
   dmConexao.qryGenero.Close;

  dmConexao.qryGenero.sql.Clear;
  dmConexao.qryGenero.sql.add('select * from genero where 1 = 1');

  if trim(edtPesqGenero.Text) <> '' then
  begin
    dmConexao.qryGenero.sql.add('and ds_genero like :ds_genero');
    dmConexao.qryGenero.ParamByName ('ds_genero').AsString:= '%' + edtPesqGenero.Text + '%';
  end;

  dmConexao.qryGenero.Open;
end;
 //pesquisa item
procedure TfrmCadastro.btnPesquisarItemClick(Sender: TObject);
begin
     dmConexao.qryItem.Close;

  dmConexao.qryItem.sql.Clear;
  dmConexao.qryItem.sql.add('select * from item where 1 = 1');

  if trim(edtPesqNomeItem.Text) <> '' then
  begin
    dmConexao.qryItem.sql.add('and nome like :nome');
    dmConexao.qryItem.ParamByName ('nome').AsString:= '%' + edtPesqNomeItem.Text + '%';
  end;

  if trim(edtPesqAutorItem.Text) <> '' then
  begin
    dmConexao.qryItem.sql.add('and autor like :autor');
    dmConexao.qryItem.ParamByName('autor').asstring := '%' + edtPesqAutorItem.Text + '%';
  end;

   dmConexao.qryItem.Open;
end;
//pesquisa local
procedure TfrmCadastro.btnPesquisarLocalClick(Sender: TObject);
begin
   dmConexao.qryLocal.Close;

  dmConexao.qryLocal.sql.Clear;
  dmConexao.qryLocal.sql.add('select * from local_aquisicao where 1 = 1');

  if trim(edtPesqLocal.Text) <> '' then
  begin
    dmConexao.qryLocal.sql.add('and ds_local_aquisicao like :ds_local_aquisicao');
    dmConexao.qryLocal.ParamByName ('ds_local_aquisicao').AsString:= '%' + edtPesqLocal.Text + '%';
  end;

  dmConexao.qryLocal.Open;
end;
////salvar Gênero
procedure TfrmCadastro.btnSalvarGeneroClick(Sender: TObject);
begin
  // Lógica para salvar item
  btnNovoGenero.Enabled := True;  // Ativa o botão Novo
  btnEditGenero.Enabled := True; // Ativa o botão Editar
  btnExcluirGenero.Enabled := True; // Ativa o botão Excluir
  btnSalvarGenero.Enabled := False; // Desativa o botão Salvar
  btnCancelarGenero.Enabled := False; // Desativa o botão Cancelar
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidosGenero then
    Exit;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsGenero.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsGenero.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsGenero.DataSet.Post; // Salva apenas se o usuário clicar em "Sim"
      end
      else
      begin
        dmConexao.dsGenero.DataSet.Cancel; // Cancela as alterações se o usuário clicar em "Não"
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsGenero.DataSet.State = dsInsert then
    begin
      dmConexao.dsGenero.DataSet.Post;
    end;
  end;
end;
//salvar categoria
procedure TfrmCadastro.btnSalvarCategoriaClick(Sender: TObject);
begin
  // Lógica para salvar item
  btnNovoCategoria.Enabled := True;  // Ativa o botão Novo
  btnEditCategoria.Enabled := True; // Ativa o botão Editar
  btnExcluirCategoria.Enabled := True; // Ativa o botão Excluir
  btnSalvarCategoria.Enabled := False; // Desativa o botão Salvar
  btnCancelarCategoria.Enabled := False; // Desativa o botão Cancelar
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidosCategoria then
    Exit;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsCategoria.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsCategoria.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsCategoria.DataSet.Post; // Salva apenas se o usuário clicar em "Sim"
      end
      else
      begin
        dmConexao.dsCategoria.DataSet.Cancel; // Cancela as alterações se o usuário clicar em "Não"
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsCategoria.DataSet.State = dsInsert then
    begin
      dmConexao.dsCategoria.DataSet.Post;
    end;
  end;
end;
//salvar item
procedure TfrmCadastro.btnSalvarItemClick(Sender: TObject);
begin
  // Lógica para salvar item
  btnNovoItem.Enabled := True;  // Ativa o botão Novo
  btnEditItem.Enabled := True; // Ativa o botão Editar
  btnExcluirItem.Enabled := True; // Ativa o botão Excluir
  btnSalvarItem.Enabled := False; // Desativa o botão Salvar
  btnCancelarItem.Enabled := False; // Desativa o botão Cancelar
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidosItem then
    Exit;

  // Adiciona o ID do usuário logado antes de salvar
  dmConexao.dsItem.DataSet.FieldByName('id_usuario').AsInteger := dmConexao.UsuarioLogadoID;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsItem.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsItem.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsItem.DataSet.Post; // Salva apenas se o usuário clicar em "Sim"
      end
      else
      begin
        dmConexao.dsItem.DataSet.Cancel; // Cancela as alterações se o usuário clicar em "Não"
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsItem.DataSet.State = dsInsert then
    begin
      dmConexao.dsItem.DataSet.Post;
    end;
  end;
end;
//salvar local
procedure TfrmCadastro.btnSalvarLocalClick(Sender: TObject);
begin
  // Lógica para salvar item
    btnNovoLocal.Enabled := True;  // Ativa o botão Novo
    btnEditLocal.Enabled := True; // Ativa o botão Editar
    btnExcluirLocal.Enabled := True; // Ativa o botão Excluir
    btnSalvarLocal.Enabled := False; // Desativa o botão Salvar
    btnCancelarLocal.Enabled := False; // Desativa o botão Cancelar
    // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidosLocal then
    Exit;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsLocal.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsLocal.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsLocal.DataSet.Post; // Salva apenas se o usuário clicar em "Sim"
      end
      else
      begin
        dmConexao.dsLocal.DataSet.Cancel; // Cancela as alterações se o usuário clicar em "Não"
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsLocal.DataSet.State = dsInsert then
    begin
      dmConexao.dsLocal.DataSet.Post;
    end;
  end;
end;
procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
  edtLancamentoItemCad.Date := Date;
  edtdataItemCad.Date := Date;
  edtAquisicaoItemCad.Date := Date;
end;

procedure TfrmCadastro.btnCategoriaClick(Sender: TObject);
begin
  pgcCadastro.TabIndex := 1;
end;

procedure TfrmCadastro.btnConsultaCategoria2Click(Sender: TObject);
begin
     pgcAcoesCategoria.TabIndex := 0;
end;

procedure TfrmCadastro.btnConsultaGeneroClick(Sender: TObject);
begin
    pgcAcoesGenero.TabIndex := 0;
end;

procedure TfrmCadastro.btnConsultaItemClick(Sender: TObject);
begin
  pgcAcoesItem.TabIndex := 0;
end;

procedure TfrmCadastro.btnConsultaLocalClick(Sender: TObject);
begin
  pgcAcoesLocal.TabIndex := 0;
end;
//editar Categoria
procedure TfrmCadastro.btnEditCategoriaClick(Sender: TObject);
begin
  // desativar botões
  btnNovoCategoria.Enabled := False;  // Desativa o botão Novo
  btnEditCategoria.Enabled := False; // Desativa o botão Editar
  btnExcluirCategoria.Enabled := False; // Desativa o botão Excluir
  btnSalvarCategoria.Enabled := True; // Ativa o botão Salvar
  btnCancelarCategoria.Enabled := True; // Ativa o botão Cancelar
   begin
  if not (dmConexao.dsCategoria.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsCategoria.DataSet.Edit;
    edtCategoriaCad.SetFocus;
  end;
end;
end;
//editar gênero
procedure TfrmCadastro.btnEditGeneroClick(Sender: TObject);
begin
  begin
  // desativar botões
  btnNovoGenero.Enabled := False;  // Desativa o botão Novo
  btnEditGenero.Enabled := False; // Desativa o botão Editar
  btnExcluirGenero.Enabled := False; // Desativa o botão Excluir
  btnSalvarGenero.Enabled := True; // Ativa o botão Salvar
  btnCancelarGenero.Enabled := True; // Ativa o botão Cancelar
   begin
  if not (dmConexao.dsGenero.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsGenero.DataSet.Edit;
    edtGeneroCad.SetFocus;
  end;
end;
  end;
end;
//editar item
procedure TfrmCadastro.btnEditItemClick(Sender: TObject);
begin
   // desativar botões
  btnNovoItem.Enabled := False;  // Desativa o botão Novo
  btnEditItem.Enabled := False; // Desativa o botão Editar
  btnExcluirItem.Enabled := False; // Desativa o botão Excluir
  btnSalvarItem.Enabled := True; // Ativa o botão Salvar
  btnCancelarItem.Enabled := True; // Ativa o botão Cancelar
   begin
  if not (dmConexao.dsItem.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsItem.DataSet.Edit;
    edtNomeItemCad.SetFocus;
    edtAutorItemCad.SetFocus;
    edtEdicaoItemCad.SetFocus;
    cbGeneroItemCad.SetFocus;
    cbCategoriaItemCad.SetFocus;
    dbLocalItemCad.SetFocus;
    rgTipoAquisicao.SetFocus;
    rgTipoAcervoItem.SetFocus;
    cbAvaliacaoItemCad.SetFocus;
    edtLancamentoItemCad.SetFocus;
    edtAquisicaoItemCad.SetFocus;
    edtdataItemCad.SetFocus;
  end;
end;
end;
//editar local
procedure TfrmCadastro.btnEditLocalClick(Sender: TObject);
begin
  // desativar botões
  btnNovoLocal.Enabled := False;  // Desativa o botão Novo
  btnEditLocal.Enabled := False; // Desativa o botão Editar
  btnExcluirLocal.Enabled := False; // Desativa o botão Excluir
  btnSalvarLocal.Enabled := True; // Ativa o botão Salvar
  btnCancelarLocal.Enabled := True; // Ativa o botão Cancelar
   begin
  if not (dmConexao.dsLocal.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsLocal.DataSet.Edit;
    edtLocalCad.SetFocus;
  end;
end;
end;
// excluir categoria
procedure TfrmCadastro.btnExcluirCategoriaClick(Sender: TObject);
begin
  // Lógica para excluir item
  btnNovoCategoria.Enabled := True;  // Ativa o botão Novo
  btnEditCategoria.Enabled := True; // Ativa o botão Editar
  btnExcluirCategoria.Enabled := False; // Desativa o botão Excluir
  btnSalvarCategoria.Enabled := False; // Desativa o botão Salvar
  btnCancelarCategoria.Enabled := False; // Desativa o botão Cancelar
  begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsCategoria.DataSet.Delete;
  end;
end;
end;
//excluir Genero
procedure TfrmCadastro.btnExcluirGeneroClick(Sender: TObject);
begin
  // Lógica para excluir item
  btnNovoGenero.Enabled := True;  // Ativa o botão Novo
  btnEditGenero.Enabled := True; // Ativa o botão Editar
  btnExcluirGenero.Enabled := False; // Desativa o botão Excluir
  btnSalvarGenero.Enabled := False; // Desativa o botão Salvar
  btnCancelarGenero.Enabled := False; // Desativa o botão Cancelar
  begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsGenero.DataSet.Delete;
  end;
end;
end;
//excluir item
procedure TfrmCadastro.btnExcluirItemClick(Sender: TObject);
begin
  // Lógica para excluir item
  btnNovoItem.Enabled := True;  // Ativa o botão Novo
  btnEditItem.Enabled := True; // Ativa o botão Editar
  btnExcluirItem.Enabled := False; // Desativa o botão Excluir
  btnSalvarItem.Enabled := False; // Desativa o botão Salvar
  btnCancelarItem.Enabled := False; // Desativa o botão Cancelar
  begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsItem.DataSet.Delete;

  end;
end;
end;
//excluir local
procedure TfrmCadastro.btnExcluirLocalClick(Sender: TObject);
begin
  // Lógica para excluir item
  btnNovoLocal.Enabled := True;  // Ativa o botão Novo
  btnEditLocal.Enabled := True; // Ativa o botão Editar
  btnExcluirLocal.Enabled := False; // Desativa o botão Excluir
  btnSalvarLocal.Enabled := False; // Desativa o botão Salvar
  btnCancelarLocal.Enabled := False; // Desativa o botão Cancelar
   begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsLocal.DataSet.Delete;
  end;
end;
end;

procedure TfrmCadastro.btnAquisicaoClick(Sender: TObject);
begin
  pgcCadastro.TabIndex := 2;
end;

procedure TfrmCadastro.btnCadastroLocalClick(Sender: TObject);
begin
  pgcAcoesLocal.TabIndex := 1;
end;
//cancelar operação Categoria
procedure TfrmCadastro.btnCancelarCategoriaClick(Sender: TObject);
begin
   // Lógica para cancelar a operação atual
  btnNovoCategoria.Enabled := True;  // Ativa o botão Novo
  btnEditCategoria.Enabled := True; // Ativa o botão Editar
  btnExcluirCategoria.Enabled := True; // Ativa o botão Excluir
  btnSalvarCategoria.Enabled := False; // Desativa o botão Salvar
  btnCancelarCategoria.Enabled := False; // Desativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsCategoria.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsCategoria.DataSet.Cancel;
    edtNomeItemCad.Clear;
    edtAutorItemCad.Clear;
    edtEdicaoItemCad.Clear;
    cbGeneroItemCad.Clear;
    cbCategoriaItemCad.Clear;
    dbLocalItemCad.Clear;
    cbAvaliacaoItemCad.Clear;
    edtLancamentoItemCad.Clear;
    edtAquisicaoItemCad.Clear;
    edtdataItemCad.Clear;
  end;
end;

//cancelar operação genero
procedure TfrmCadastro.btnCancelarGeneroClick(Sender: TObject);
begin
   // Lógica para cancelar a operação atual
  btnNovoGenero.Enabled := True;  // Ativa o botão Novo
  btnEditGenero.Enabled := True; // Ativa o botão Editar
  btnExcluirGenero.Enabled := True; // Ativa o botão Excluir
  btnSalvarGenero.Enabled := False; // Desativa o botão Salvar
  btnCancelarGenero.Enabled := False; // Desativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsGenero.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsGenero.DataSet.Cancel;
    edtGeneroCad.Clear;
  end;
end;
 //cancelar operação item
procedure TfrmCadastro.btnCancelarItemClick(Sender: TObject);
begin
   // Lógica para cancelar a operação atual
  btnNovoItem.Enabled := True;  // Ativa o botão Novo
  btnEditItem.Enabled := True; // Ativa o botão Editar
  btnExcluirItem.Enabled := True; // Ativa o botão Excluir
  btnSalvarItem.Enabled := False; // Desativa o botão Salvar
  btnCancelarItem.Enabled := False; // Desativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsItem.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsItem.DataSet.Cancel;
    edtLocalCad.Clear;
  end;
end;

//cancelar operação local
procedure TfrmCadastro.btnCancelarLocalClick(Sender: TObject);
begin
   // Lógica para cancelar a operação atual
  btnNovoLocal.Enabled := True;  // Ativa o botão Novo
  btnEditLocal.Enabled := True; // Ativa o botão Editar
  btnExcluirLocal.Enabled := True; // Ativa o botão Excluir
  btnSalvarLocal.Enabled := False; // Desativa o botão Salvar
  btnCancelarLocal.Enabled := False; // Desativa o botão Cancelar
  //mesagem de confirmação
  if dmConexao.dsLocal.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsLocal.DataSet.Cancel;
    edtLocalCad.Clear;
  end;
end;

procedure TfrmCadastro.btnCadastroItemClick(Sender: TObject);
begin
  pgcAcoesItem.TabIndex := 1;
end;

procedure TfrmCadastro.btnCadastroGeneroClick(Sender: TObject);
begin
    pgcAcoesGenero.TabIndex := 1;
end;

procedure TfrmCadastro.btnCadastroCategoria2Click(Sender: TObject);
begin
  pgcAcoesCategoria.TabIndex := 1;
end;
//atualiza grid genero
procedure TfrmCadastro.btnAtualizarGeneroClick(Sender: TObject);
begin
  begin
  dmConexao.qryGenero.Refresh;
end;
end;
//atualizar grid item
procedure TfrmCadastro.btnAtualizarItemClick(Sender: TObject);
begin
  begin
   dmConexao.qryItem.Refresh;
end;
end;
//atualiza grid Local
procedure TfrmCadastro.btnAtualizarLocalClick(Sender: TObject);
begin
   begin
  dmConexao.qryLocal.Refresh;
end;
end;
//atualiza grid Categoria
procedure TfrmCadastro.btnAtualizarCategoriaClick(Sender: TObject);
begin
   begin
  dmConexao.qryCategoria.Refresh;
end;
end;

function TfrmCadastro.CamposPreenchidosGenero: Boolean;
begin
  Result := True;

  if Trim(edtGeneroCad.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtGeneroCad, 'Gênero');
    Result := False;
    Exit;
  end;
end;
function TfrmCadastro.CamposPreenchidosCategoria: Boolean;
begin
  Result := True;

  if Trim(edtCategoriaCad.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtCategoriaCad, 'Categoria');
    Result := False;
    Exit;
  end;
end;

function TfrmCadastro.CamposPreenchidosLocal: Boolean;
begin
  Result := True;

  if Trim(edtLocalCad.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtLocalCad, 'Local de Aquisição');
    Result := False;
    Exit;
  end;
end;
function TfrmCadastro.CamposPreenchidosItem: Boolean;
begin
  Result := True;

  if Trim(edtNomeItemCad.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtNomeItemCad, 'Nome');
    Result := False;
    Exit;
  end;

  if Trim(edtdataItemCad.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtdataItemCad, 'Data de Cadastro');
    Result := False;
    Exit;
  end;

end;

procedure TfrmCadastro.MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
begin
  ShowMessage(Format('%s está em branco e precisa ser preenchido. Por favor, preencha-o para prosseguir com a operação.', [NomeCampo]));
  Campo.SetFocus;
end;

end.


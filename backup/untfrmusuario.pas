unit untfrmusuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ComCtrls, ExtCtrls, ActnList, DBGrids,  rxtoolbar, RxMDI, rxspin, untdmConexao, DB,
  ZDataset, ZAbstractRODataset, LCLType;

//DBExtCtrls, ButtonPanel, ZConnection, ZAbstractDataset
type

  { TfrmUsuario }

  TfrmUsuario = class(TForm)
    btnAtualizarUsuario: TBitBtn;
    btnCadastroUsuario: TBitBtn;
    btnCancelarUsuario: TBitBtn;
    btnConsultaUsuario: TBitBtn;
    btnEditUsuario: TBitBtn;
    btnExcluirUsuario: TBitBtn;
    btnLimparUsuario: TBitBtn;
    btnNovoUsuario: TBitBtn;
    btnPesquisarUsuario1: TBitBtn;
    btnSalvarUsuario: TBitBtn;
    cbPesqStatus1: TComboBox;
    DBGrid12: TDBGrid;
    DBGrid13: TDBGrid;
    edtIdUsuario: TDBEdit;
    edtNomeUsuario: TDBEdit;
    edtPesqNomeUsuario1: TEdit;
    edtPesqUsername1: TEdit;
    edtSenhaUsuario: TDBEdit;
    edtStatusUsuario: TDBComboBox;
    edtUserUsuario: TDBEdit;
    GroupBox1: TGroupBox;
    GroupBox11: TPanel;
    GroupBox2: TGroupBox;
    Image2: TImage;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    pgcAcoesUsuario: TPageControl;
    tabCadastroUsuario: TTabSheet;
    tabConsultaUsuario: TTabSheet;
    procedure btnAtualizarUsuarioClick(Sender: TObject);
    procedure btnCadastroUsuarioClick(Sender: TObject);
    procedure btnCancelarUsuarioClick(Sender: TObject);
    procedure btnConsultaUsuarioClick(Sender: TObject);
    procedure btnEditUsuarioClick(Sender: TObject);
    procedure btnExcluirUsuarioClick(Sender: TObject);
    procedure btnLimparUsuarioClick(Sender: TObject);
    procedure btnNovoUsuarioClick(Sender: TObject);
    procedure btnPesquisarUsuarioClick(Sender: TObject);
    procedure btnSalvarUsuarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function CamposPreenchidos: Boolean;
    procedure MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);

  public

  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.lfm}

{ TfrmUsuario }

procedure TfrmUsuario.btnConsultaUsuarioClick(Sender: TObject);
begin
 pgcAcoesUsuario.TabIndex := 0;
end;

procedure TfrmUsuario.btnCadastroUsuarioClick(Sender: TObject);
begin
 pgcAcoesUsuario.TabIndex := 1;
end;
//atualizar
procedure TfrmUsuario.btnAtualizarUsuarioClick(Sender: TObject);
begin
  begin
  dmConexao.qryUsuario.Refresh;
end;
end;

//Cancelar operação
procedure TfrmUsuario.btnCancelarUsuarioClick(Sender: TObject);
begin
  if dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert] then
  if MessageDlg('Tem certeza de que deseja cancelar a operação?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then //tentar colocar em português.
//está ficando como yes ou no.
  begin
    dmConexao.dsUsuario.DataSet.Cancel;
    edtNomeUsuario.Clear;
    edtUserUsuario.Clear;
    //edtStatusUsuario.Clear; //edtStatusUsuario.ItemIndex := -1
    edtSenhaUsuario.Clear;
  end;
end;

//editar registro
procedure TfrmUsuario.btnEditUsuarioClick(Sender: TObject);
begin
  if not (dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dmConexao.dsUsuario.DataSet.Edit;
    edtNomeUsuario.SetFocus;
    edtUserUsuario.SetFocus;
    edtStatusUsuario.SetFocus;
    edtSenhaUsuario.SetFocus;
  end;
end;
//Exluir registro (delete)
procedure TfrmUsuario.btnExcluirUsuarioClick(Sender: TObject);
  begin
  begin
  if MessageDlg('Confirma a exclusão do registro? Essa ação não poderá ser desfeita',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsUsuario.DataSet.Delete;
  end;
end;
end;
//limpar campos
procedure TfrmUsuario.btnLimparUsuarioClick(Sender: TObject);
begin
     edtIdUsuario.Clear;
    edtNomeUsuario.Clear;
    edtUserUsuario.Clear;
    //edtStatusUsuario.ItemIndex := -1
    edtSenhaUsuario.Clear;
end;
//inserir novo registro (insert)
procedure TfrmUsuario.btnNovoUsuarioClick(Sender: TObject);
begin
  dmConexao.dsUsuario.DataSet.Insert;
  edtNomeUsuario.SetFocus;
  edtUserUsuario.SetFocus;
  edtStatusUsuario.SetFocus;
  edtSenhaUsuario.SetFocus;
end;
//pesquisa (select)
procedure TfrmUsuario.btnPesquisarUsuarioClick(Sender: TObject);
begin
  dmConexao.qryUsuario.Close;

  dmConexao.qryUsuario.sql.Clear;
  dmConexao.qryUsuario.sql.add('select * from usuario where 1 = 1');

  if trim(edtPesqNomeUsuario1.Text) <> '' then
  begin
    dmConexao.qryUsuario.sql.add('and nm_usuario Ilike :nm_usuario');
    dmConexao.qryUsuario.ParamByName ('nm_usuario').AsString:= '%' + edtPesqNomeUsuario1.Text + '%';
  end;

  if trim(cbPesqStatus1.Text) <> '' then
  begin
    dmConexao.qryUsuario.sql.add('and ds_status like :ds_status');
    dmConexao.qryUsuario.ParamByName('ds_status').asstring := '%' + cbPesqStatus1.Text + '%';
  end;

  if trim(edtPesqUsername1.Text) <> '' then
  begin
    dmConexao.qryUsuario.sql.add('and username like :username');
    dmConexao.qryUsuario.ParamByName('username').asstring := '%' + edtPesqUsername1.Text + '%';
  end;

   dmConexao.qryUsuario.Open;
end;
 //Salvar registros
procedure TfrmUsuario.btnSalvarUsuarioClick(Sender: TObject);
begin
  // Verifica se todos os campos obrigatórios estão preenchidos
  if not CamposPreenchidos then
    Exit;

  // Verifica se o dataset está em modo de edição ou inserção
  if dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert] then
  begin
    // Se estiver em modo de edição, solicita confirmação antes de salvar
    if dmConexao.dsUsuario.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsUsuario.DataSet.Post;
      end;
    end
    // Se estiver em modo de inserção, salva diretamente sem pedir confirmação
    else if dmConexao.dsUsuario.DataSet.State = dsInsert then
    begin
      dmConexao.dsUsuario.DataSet.Post;
    end;
  end;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin

end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  pgcAcoesUsuario.ActivePage := tabConsultaUsuario;
end;

function TfrmUsuario.CamposPreenchidos: Boolean;
begin
  Result := True;

  if Trim(edtNomeUsuario.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtNomeUsuario, 'Nome');
    Result := False;
    Exit;
  end;

  if Trim(edtUserUsuario.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtUserUsuario, 'Username');
    Result := False;
    Exit;
  end;

  if edtStatusUsuario.ItemIndex = -1 then
  begin
    MostrarMensagemCampoEmBranco(edtStatusUsuario, 'Status');
    Result := False;
    Exit;
  end;

  if Trim(edtSenhaUsuario.Text) = '' then
  begin
    MostrarMensagemCampoEmBranco(edtSenhaUsuario, 'Senha');
    Result := False;
    Exit;
  end;

  // Verificação do comprimento da senha
  if Length(edtSenhaUsuario.Text) < 8 then
  begin
    ShowMessage('A senha deve ter no mínimo 8 caracteres. Por favor, insira uma senha válida.');
    edtSenhaUsuario.SetFocus;
    Result := False;
    Exit;
  end;
end;

procedure TfrmUsuario.MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
begin
  ShowMessage(Format('%s está em branco e precisa ser preenchido. Por favor, preencha-o para prosseguir com a operação.', [NomeCampo]));
  Campo.SetFocus;
end;

end.


unit untfrmusuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ComCtrls, ExtCtrls, ActnList, DBGrids, rxtoolbar, RxMDI, rxspin,
  untdmConexao, DB, ZDataset, ZAbstractRODataset, LCLType;

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
    Label14: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
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

procedure TfrmUsuario.btnAtualizarUsuarioClick(Sender: TObject);
begin
  dmConexao.qryUsuario.Refresh;
end;

procedure TfrmUsuario.btnCancelarUsuarioClick(Sender: TObject);
begin
  // Mesagem de confirmação
  if dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert] then
    if MessageDlg('Tem certeza de que deseja cancelar a operação?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      dmConexao.dsUsuario.DataSet.Cancel;
      btnLimparUsuarioClick(Sender);
    end;
  // Ajustar botões
  btnNovoUsuario.Enabled := True;
  btnEditUsuario.Enabled := True;
  btnExcluirUsuario.Enabled := True;
  btnSalvarUsuario.Enabled := False;
  btnCancelarUsuario.Enabled := False;
end;

procedure TfrmUsuario.btnEditUsuarioClick(Sender: TObject);
begin
  if not (dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert]) then
    dmConexao.dsUsuario.DataSet.Edit;

  // Ajustar botões
  btnNovoUsuario.Enabled := False;
  btnEditUsuario.Enabled := False;
  btnExcluirUsuario.Enabled := False;
  btnSalvarUsuario.Enabled := True;
  btnCancelarUsuario.Enabled := True;
end;
//exluir usuario
procedure TfrmUsuario.btnExcluirUsuarioClick(Sender: TObject);
begin
   // Ajustar botões
  btnNovoUsuario.Enabled := True;
  btnEditUsuario.Enabled := True;
  btnExcluirUsuario.Enabled := True;
  btnSalvarUsuario.Enabled := False;
  btnCancelarUsuario.Enabled := False;

  // Verifica se há itens associados à categoria antes de excluir
  with dmConexao.qryConsulta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) FROM item WHERE id_usuario = :id_usuario');
    ParamByName('id_usuario').AsInteger := dmConexao.dsUsuario.DataSet.FieldByName('id_usuario').AsInteger;
    Open;

    // Se a categoria está associada a algum item, impede a exclusão
    if Fields[0].AsInteger > 0 then
    begin
      ShowMessage('Não é possível excluir o usuário "' + edtNomeUsuario.Text + '" porque está associado a um ou mais itens. você pode tentar inativar o perfil');
      Exit;
    end;
  end;

  if StrToInt(edtIdUsuario.Text) = dmConexao.UsuarioLogadoID then
  begin
    ShowMessage('Não é possível excluir o usuário "' + edtIdUsuario.Text + '" porque ele está logado no sistema')
  end;

  //if StrToInt(edtIdUsuario.Text) = dmConexao.UsuarioLogadoID and
  //edtStatusUsuario.ItemIndex = 1 then // 'I' segundo item (índice 1)
  //begin
  //ShowMessage('Não é possível inativar o usuário "' + edtIdUsuario.Text + '" porque ele está logado no sistema');
  //else
  //ShowMessage('Não é possível excluir o usuário "' + edtIdUsuario.Text + '" porque ele está logado no sistema')
  //end;
  //

  if (StrToInt(edtIdUsuario.Text) = dmConexao.UsuarioLogadoID) and
   (edtStatusUsuario.ItemIndex = 1) then  // Verifica se o status é 'Inativo' (índice 1)
begin
  ShowMessage('Não é possível inativar o usuário "' + edtIdUsuario.Text + '" porque ele está logado no sistema');
  exit
end
else if StrToInt(edtIdUsuario.Text) = dmConexao.UsuarioLogadoID then
begin
  ShowMessage('Não é possível excluir o usuário "' + edtIdUsuario.Text + '" porque ele está logado no sistema');
end;






  // Se não houver itens associados, solicita confirmação antes de excluir
  if MessageDlg('Confirma a exclusão do registro "' + edtNomeUsuario.Text + '"? Essa ação não poderá ser desfeita',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmConexao.dsUsuario.DataSet.Delete;
    ShowMessage('Usuário excluída com sucesso.');
  end;
end;

procedure TfrmUsuario.btnLimparUsuarioClick(Sender: TObject);
begin
  edtIdUsuario.Clear;
  edtNomeUsuario.Clear;
  edtUserUsuario.Clear;
  edtStatusUsuario.ItemIndex := -1;
  edtSenhaUsuario.Clear;
end;

procedure TfrmUsuario.btnNovoUsuarioClick(Sender: TObject);
begin
  dmConexao.dsUsuario.DataSet.Insert;

  // Ajustar botões
  btnNovoUsuario.Enabled := False;
  btnEditUsuario.Enabled := False;
  btnExcluirUsuario.Enabled := False;
  btnSalvarUsuario.Enabled := True;
  btnCancelarUsuario.Enabled := True;

  // Foco no primeiro campo
  edtNomeUsuario.SetFocus;
end;

procedure TfrmUsuario.btnPesquisarUsuarioClick(Sender: TObject);
begin
  dmConexao.qryUsuario.Close;
  dmConexao.qryUsuario.SQL.Clear;
  dmConexao.qryUsuario.SQL.Add('select * from usuario where 1 = 1');

  if Trim(edtPesqNomeUsuario1.Text) <> '' then
  begin
    dmConexao.qryUsuario.SQL.Add('and nm_usuario ILIKE :nm_usuario');
    dmConexao.qryUsuario.ParamByName('nm_usuario').AsString := '%' + edtPesqNomeUsuario1.Text + '%';
  end;

  if Trim(cbPesqStatus1.Text) <> '' then
  begin
    dmConexao.qryUsuario.SQL.Add('and ds_status LIKE :ds_status');
    dmConexao.qryUsuario.ParamByName('ds_status').AsString := '%' + cbPesqStatus1.Text + '%';
  end;

  if Trim(edtPesqUsername1.Text) <> '' then
  begin
    dmConexao.qryUsuario.SQL.Add('and username LIKE :username');
    dmConexao.qryUsuario.ParamByName('username').AsString := '%' + edtPesqUsername1.Text + '%';
  end;

  dmConexao.qryUsuario.Open;
end;

procedure TfrmUsuario.btnSalvarUsuarioClick(Sender: TObject);
begin
  if not CamposPreenchidos then
    Exit;

  if dmConexao.dsUsuario.DataSet.State in [dsEdit, dsInsert] then
  begin
    if dmConexao.dsUsuario.DataSet.State = dsEdit then
    begin
      if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
      begin
        dmConexao.dsUsuario.DataSet.Post;
      end
      else
      begin
        dmConexao.dsUsuario.DataSet.Cancel;
      end;
    end
    else
    begin
      dmConexao.dsUsuario.DataSet.Post;
    end;
  end;

  // Ajustar botões
  btnNovoUsuario.Enabled := True;
  btnEditUsuario.Enabled := True;
  btnExcluirUsuario.Enabled := True;
  btnSalvarUsuario.Enabled := False;
  btnCancelarUsuario.Enabled := False;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  dmConexao.qryUsuario.Close;
  dmConexao.qryUsuario.SQL.Clear;
  dmConexao.qryUsuario.SQL.Add('select * from usuario');
end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  pgcAcoesUsuario.ActivePage := tabConsultaUsuario;
  if not dmConexao.qryUsuario.Active then
    dmConexao.qryUsuario.Open
  else
    dmConexao.qryUsuario.Refresh;
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
  //if Length(edtSenhaUsuario.Text) < 8 then
  //begin
  //  ShowMessage('A senha deve ter no mínimo 8 caracteres. Por favor, insira uma senha válida.');
  //  edtSenhaUsuario.SetFocus;
  //  Result := False;
  //  Exit;
  //end;
end;

procedure TfrmUsuario.MostrarMensagemCampoEmBranco(Campo: TWinControl; const NomeCampo: String);
begin
  ShowMessage(Format('%s está em branco e precisa ser preenchido. Por favor, preencha-o para prosseguir com a operação.', [NomeCampo]));
  Campo.SetFocus;
end;

end.


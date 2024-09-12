unit untfrmlogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Menus, ActnList, ComCtrls, ZConnection, ZDataset,
  RTTICtrls, rxtoolbar, RxMDI, RxTimeEdit, rxspin, untdmConexao,
  rxmemds;


type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    btnEntrar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    EdtUsername: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    btnSair: TSpeedButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure btnSairClick(Sender: TObject);
  private
  public
     UsuarioLogadoID: Integer;
     UsuarioLogadoNome: String;
  end;

var
  frmLogin: TfrmLogin;


implementation

{$R *.lfm}

uses
untfrmprincipal;

{ TfrmLogin }


procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Application.terminate;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: char);
//procedure para que os dados sejam enviados ao acionar o "enter" do teclado.
begin
  if Key = #13 then
  begin

    if ActiveControl is TEdit then
      Exit
    else
    begin
       //edtClick(Sender);
      btnSair.Click;
      Key := #0;
    end;
  end;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
var
  username, senha: string;
begin
  username := edtUsername.Text;
  senha := edtSenha.Text;

  dmConexao.qryUsuario.SQL.Text := 'SELECT * FROM Usuario WHERE username = :username AND senha = :senha';
  dmConexao.qryUsuario.Params.ParamByName('username').AsString := username;
  dmConexao.qryUsuario.Params.ParamByName('senha').AsString := senha;

  dmConexao.qryUsuario.Open;

  if dmConexao.qryUsuario.FieldByName('ds_status').AsString = 'I' then
  begin
    ShowMessage('Usuário inativo, entre em contato com o administrador');
  end
  else
  if not dmConexao.qryUsuario.IsEmpty then
  begin
    // Armazena o ID e o nome do usuário logado no data module
    dmConexao.UsuarioLogadoID := dmConexao.qryUsuario.FieldByName('id_usuario').AsInteger;
    dmConexao.UsuarioLogadoNome := dmConexao.qryUsuario.FieldByName('nm_usuario').AsString;

    // Fechar a consulta após processar os dados
    dmConexao.qryUsuario.Close;

    ShowMessage('Login bem-sucedido, ' + dmConexao.UsuarioLogadoNome);

    Close;
    // Se o formulário principal não existir, crie-o novamente
    if frmPrincipal = nil then
      Application.CreateForm(TfrmPrincipal, frmPrincipal);

    frmPrincipal.Show;  // Exibe o formulário principal
    Self.Hide;  // Esconde o formulário de login
  end
  else
  begin
    ShowMessage('Usuário ou senha inválidos');
  end;

end;
end.


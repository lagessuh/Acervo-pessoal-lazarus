unit untfrmlogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Menus, ActnList, ComCtrls, ZConnection, ZDataset,
  RTTICtrls, rxtoolbar, RxMDI, RxTimeEdit, rxspin, untdmConexao,
  rxmemds;
  //untfrmprincipal,

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
    SpeedButton1: TSpeedButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure SpeedButton1Click(Sender: TObject);
  private
      function ValidarLogin(const Username, Password: string): Boolean;
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


procedure TfrmLogin.SpeedButton1Click(Sender: TObject);
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
      SpeedButton1.Click;
      Key := #0;
    end;
  end;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
  //var
    //username, senha: string;
//begin
 // username := edtUsername.Text;
 // senha := edtSenha.Text;


  //Zquery1.SQL.Text := 'SELECT * FROM Usuario WHERE username = :username AND senha = :senha';
  //Zquery1.Params.ParamByName('username').AsString := username;
  //Zquery1.Params.ParamByName('senha').AsString := senha;


  //Zquery1.Open;

 // + 'Usuário Logado' + dmConexao.UsuarioLogadoNome


 // if not Zquery1.IsEmpty then
 // begin

  //  Close;
 // end
 // else
 // begin
  //  ShowMessage('Usuário ou senha inválidos');
  //end;

//end;
var
  username, senha: string;
begin
  username := edtUsername.Text;
  senha := edtSenha.Text;

  ZQuery1.SQL.Text := 'SELECT * FROM Usuario WHERE username = :username AND senha = :senha';
  ZQuery1.Params.ParamByName('username').AsString := username;
  ZQuery1.Params.ParamByName('senha').AsString := senha;

  ZQuery1.Open;

  if not ZQuery1.IsEmpty then
  begin
    // Armazena o ID e o nome do usuário logado no data module
    dmConexao.UsuarioLogadoID := ZQuery1.FieldByName('id_usuario').AsInteger;
    dmConexao.UsuarioLogadoNome := ZQuery1.FieldByName('nm_usuario').AsString;
    //UsuarioLogadoID := ZQuery1.FieldByName('id_usuario').AsInteger;
    //UsuarioLogadoNome := ZQuery1.FieldByName('nm_usuario').AsString;

    // Fechar a consulta após processar os dados
    ZQuery1.Close;

    ShowMessage('Login bem-sucedido, ' + dmConexao.UsuarioLogadoNome);
    // Abre o formulário principal da aplicação
    //frmPrincipal.Show;
    //Self.Hide;
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

function TfrmLogin.ValidarLogin(const Username, Password: string): Boolean;
begin
  Result := False;
  with ZQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT id_usuario, nm_usuario FROM usuarios WHERE username = :username AND password = :password AND status = ''ativo''';
    Params.ParamByName('username').AsString := Username;
    Params.ParamByName('password').AsString := Password;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      // Armazena o ID do usuário logado
      dmConexao.UsuarioLogadoID := FieldByName('id_usuario').AsInteger;
      dmConexao.UsuarioLogadoNome := FieldByName('nm_usuario').AsString;
    end;
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
  var centroX, centroY: integer;
begin
        centroX := Screen.Width div 2;
        centroY := Screen.Height div 2;

        Left := centroX - Width div 2;
        Top := centroY - Height div 2;
end;

end.


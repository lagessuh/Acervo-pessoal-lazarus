unit untfrmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, Menus, ActnList, StdCtrls, LR_Class, RxMDI, untfrmlogin,
  untdmConexao, untfrmCadastro, untfrmPesquisa, untfrmusuario,
  untfrmlistadesejos;


type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    btnUsuario: TBitBtn;
    btnCadastro: TBitBtn;
    btnPesquisa: TBitBtn;
    btnListaDesejos: TBitBtn;
    Label1: TLabel;
    btnLogout: TSpeedButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure btnListaDesejosClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.btnCadastroClick(Sender: TObject);
begin
  try
    frmCadastro := TfrmCadastro.Create(self);
                frmCadastro.showmodal();
  finally
    frmCadastro.Free;
  end;
end;

procedure TfrmPrincipal.btnUsuarioClick(Sender: TObject);
begin
 try
    frmUsuario := TfrmUsuario.Create(self);
                frmUsuario.showmodal();
  finally
    frmUsuario.Free;
  end;
end;

procedure TfrmPrincipal.btnListaDesejosClick(Sender: TObject);
begin
   try
    frmListaDesejos := TfrmListaDesejos.Create(self);
                frmListaDesejos.showmodal();
  finally
    frmListaDesejos.Free;
  end;
end;

procedure TfrmPrincipal.btnPesquisaClick(Sender: TObject);
begin
    try
    frmPesquisa := TfrmPesquisa.Create(self);
                frmPesquisa.showmodal();
  finally
    frmPesquisa.Free;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(Self);
   frmLogin.showmodal();
end;
procedure TfrmPrincipal.btnLogoutClick(Sender: TObject);
  var
  I: Integer;
begin
  // Itera por todos os formulários abertos
  for I := Screen.FormCount - 1 downto 0 do
  begin
    if (Screen.Forms[I] <> frmLogin) and (Screen.Forms[I] <> frmPrincipal) then
    begin
      Screen.Forms[I].Close;
    end;
  end;

  // Esvazia as variáveis de login, se necessário
  dmConexao.UsuarioLogadoID := 0;
  dmConexao.UsuarioLogadoNome := '';

  // Mostra o formulário de login novamente
  frmLogin.Show;
  frmLogin.BringToFront;  // Traz o formulário de login para a frente

  // Agora, fechar o formulário principal sem encerrar a aplicação
  Self.Hide;  // Esconde o formulário principal
end;
procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
var
quantidadeItens: Integer;

begin
  // Abrir a query para contar os itens cadastrados pelo usuário logado
  with dmConexao.qryContagem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) FROM item WHERE id_usuario = :id_usuario');
    ParamByName('id_usuario').AsInteger := dmConexao.UsuarioLogadoID;
    Open;

    // Armazenar a contagem de itens na variável
    quantidadeItens := Fields[0].AsInteger;
  end;
begin
 StatusBar1.Panels[0].Text := '  ' + 'Data: ' + DateToStr(date);
 StatusBar1.Panels[1].Text := '   Hora: ' + TimeToStr(Time);
 StatusBar1.Panels[2].Text := '   Usuário Logado: ' + dmConexao.UsuarioLogadoNome;
 StatusBar1.Panels[3].Text := IntToStr(quantidadeItens) + ' ' + 'itens no Acervo.'
 //StatusBar1.Panels[1].Text := ('Hora: ' + TimeToStr(Time));
 //StatusBar1.Panels[].Text := TimeToStr(now);
end;

end;
end.


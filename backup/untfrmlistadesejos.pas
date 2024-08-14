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
    procedure btnPesquisarItemClick(Sender: TObject);
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
    dmConexao.qryLista.sql.add('and autor like :ds_status');
    dmConexao.qryLista.ParamByName('autor').asstring := '%' + edtPesqAutorLista.Text + '%';
  end;

   dmConexao.qryLista.Open;
end;

procedure TfrmListaDesejos.btnSalvarListaDesejosClick(Sender: TObject);
begin
  begin
  begin
    if not CamposPreenchidos then
      Exit;
  begin
  if dmConexao.dsLista.DataSet.State in [dsEdit, dsInsert] then
  begin
  if MessageDlg('Tem certeza que deseja salvar as alterações?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then //tentar colocar em português. está ficando como yes ou no.
  begin
    dmConexao.dsLista.DataSet.Post;
  end;
  end;
  end;
  end;
  end;
end;

procedure TfrmListaDesejos.btnNovoListaDesejosClick(Sender: TObject);
begin
 dmConexao.dsLista.DataSet.Insert;
 edtNomeDesejos.SetFocus;
 edtDataDesejos.SetFocus;
 cbGeneroDesejos.SetFocus;
 edtAutorDesejos.SetFocus;
 rgAtendidoDesejos.SetFocus;
end;

procedure TfrmListaDesejos.btnPesquisarItemClick(Sender: TObject);
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

procedure TfrmListaDesejos.btnCancelarListaDesejosClick(Sender: TObject);
begin
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

procedure TfrmListaDesejos.btnAtualizarListaDesejosClick(Sender: TObject);
begin
  begin
       dmConexao.qryLista.Refresh;
  end;
end;

procedure TfrmListaDesejos.btnExcluirListaDesejosClick(Sender: TObject);
begin
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
var centroX, centroY: integer;
begin
        centroX := Screen.Width div 2;
        centroY := Screen.Height div 2;

        Left := centroX - Width div 2;
        Top := centroY - Height div 2;
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


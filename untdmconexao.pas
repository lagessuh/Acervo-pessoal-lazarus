unit untdmConexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, ZConnection, ZDataset, ZSqlUpdate, UCZEOSConn,
  ucsqldbconn, UCBase, UCSettings, Dialogs;

type

  { TdmConexao }

  TdmConexao = class(TDataModule)
    dsCategoria: TDataSource;
    dsItem: TDataSource;
    dsLocal: TDataSource;
    dsLista: TDataSource;
    dsRelatorio: TDataSource;
    dsUsuario: TDataSource;
    dsGenero: TDataSource;
    dbConexao: TZConnection;
    qryCategoria: TZQuery;
    qryItem: TZQuery;
    qryLocal: TZQuery;
    qryLista: TZQuery;
    qryRelatorio: TZQuery;
    qryContagem: TZQuery;
    qryUsuario: TZQuery;
    qryGenero: TZQuery;
    updQryCategoria: TZUpdateSQL;
    updQryItem: TZUpdateSQL;
    updQryLocal: TZUpdateSQL;
    updQryLista: TZUpdateSQL;
    updQryUsuario: TZUpdateSQL;
    updQryGenero: TZUpdateSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryUsuarioBeforePost(DataSet: TDataSet);
  private

  public
    UsuarioLogadoID: Integer;
    UsuarioLogadoNome: String;
  end;

var
  dmConexao: TdmConexao;

implementation

{$R *.lfm}

{ TdmConexao }

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  if not dbConexao.Connected then
  dbConexao.Connected := true;
end;

procedure TdmConexao.qryUsuarioBeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('username').IsNull) or
     (DataSet.FieldByName('senha').IsNull) or
     (DataSet.FieldByName('ds_status').IsNull) or
     (DataSet.FieldByName('nm_usuario').IsNull) then
  begin
    Dialogs.ShowMessage('Preencha todos os campos obrigatórios!');
    Abort;
  end;
end;

end.


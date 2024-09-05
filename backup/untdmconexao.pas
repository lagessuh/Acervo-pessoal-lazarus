unit untdmConexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, ZConnection, ZDataset, ZSqlUpdate,
  ucsqldbconn, Dialogs;

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
    qryConsulta: TZQuery;
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

end.


object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 232
  Width = 346
  object BD: TFDConnection
    Params.Strings = (
      
        'Database=D:\Desenvolvimento\Delphi\trunk\Projeto Educando\pe5000' +
        '\ImportarXLS\Win32\Debug\Dados\pe5000.db'
      'LockingMode=Normal'
      'Encrypt=aes-128'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 56
    Top = 64
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 126
  end
  object qryPerguntas: TFDQuery
    Connection = BD
    SQL.Strings = (
      'select * from perguntas')
    Left = 183
    Top = 72
  end
  object qryTemp: TFDQuery
    Connection = BD
    Left = 280
    Top = 73
  end
end

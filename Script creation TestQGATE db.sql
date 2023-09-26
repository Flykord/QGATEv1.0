USE TestQGATE

--CREATE USER [QGATEWriter] FOR LOGIN [QGATEWriter] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [QGATEWriter]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [QGATEWriter]
GO

CREATE TABLE [dbo].[Operador](
	[numOperador] [smallint] NOT NULL,
	[nombre] [varchar](15) NOT NULL,
	[apellido] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numOperador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

insert into Operador values(2255,'Juan Manuel','Vazquez')
insert into Operador values(2212,'Juan','Ibarra')

select * from Operador;
SELECT * FROM Pieza;

CREATE TABLE [dbo].[Operador_Pieza](
	[numEtiqueta] [varchar](33) NOT NULL,
	[serial] [smallint] NOT NULL,
	[numOperador] [smallint] NOT NULL,
	[idPieza] [smallint] NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[punto1] [char](3) NOT NULL,
	[punto2] [char](3) NULL,
	[punto3] [char](3) NULL,
	[punto4] [char](3) NULL,
	[punto5] [char](3) NULL,
	[punto6] [char](3) NULL,
	[punto7] [char](3) NULL,
	[punto8] [char](3) NULL,
	[punto9] [char](3) NULL,
	[punto10] [char](3) NULL,
	[punto11] [char](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[numEtiqueta] ASC,
	[serial] ASC,
	[numOperador] ASC,
	[idPieza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Creación de tabla debil para relacion operador pieza, proceso de validación

CREATE TABLE [dbo].[Pieza](
	[idPieza] [smallint] NOT NULL,
	[descripcion] [varchar](40) NOT NULL,
	[claveComp] [char](10) NULL,
	[inicioCadena] [char](1) NULL,
	[finCadena] [char](2) NULL,
	[pasos] [smallint] NULL,
	[puntoReescaneo] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[idPieza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[claveComp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---Modificaciónes de configuración adicionales.

CREATE NONCLUSTERED INDEX [UQ_Pieza_claveComp] ON [dbo].[Pieza]
(
	[claveComp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Operador_Pieza]  WITH CHECK ADD FOREIGN KEY([idPieza])
REFERENCES [dbo].[Pieza] ([idPieza])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Operador_Pieza]  WITH CHECK ADD FOREIGN KEY([numOperador])
REFERENCES [dbo].[Operador] ([numOperador])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Operador]  WITH CHECK ADD CHECK  (([numOperador]>=(0)))
GO
ALTER TABLE [dbo].[Operador_Pieza]  WITH CHECK ADD CHECK  (([serial]>=(0)))
GO
ALTER TABLE [dbo].[Pieza]  WITH CHECK ADD CHECK  (([idPieza]>=(0)))
GO


select * from operador

--Creación de usuario para acceso a la bd

CREATE USER [QGATEWriter] FOR LOGIN [QGATEWriter] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [QGATEWriter]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [QGATEWriter]
GO


--Agregar permisos a la bd
--USE [master]
GO
ALTER DATABASE [TestQGATE] SET  READ_WRITE 
GO

--Eliminar registro erroneo de BD 
DELETE  FROM Pieza WHERE idPieza=1;
SELECT * FROM Pieza;
select * from Operador_Pieza;
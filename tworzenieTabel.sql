CREATE TABLE AdresFirmy(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Miejscowosc NVARCHAR(50) NOT NULL,
	Ulica NVARCHAR(50) NOT NULL,
	NumerBudynku INT NOT NULL,
	NumerMieszkania INT NULL,
	KodPocztowy NCHAR(6) NOT NULL
)

CREATE TABLE Pracodawca(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdAdresuFirmy INT NOT NULL FOREIGN KEY REFERENCES AdresFirmy(Id),
	NIP INT NOT NULL,
	KRS NCHAR(10) NULL,
	Regon INT NULL,
	NazwaFirmy NVARCHAR(50) NOT NULL,
	OpisPracodawcy NVARCHAR(500) NOT NULL,
	DataZalozenia DATE NOT NULL,
	Reprezentacja NVARCHAR(50) NOT NULL
)
ALTER TABLE Pracodawca ALTER COLUMN NIP NCHAR(10)  NOT NULL
ALTER TABLE Pracodawca ALTER COLUMN	OpisPracodawcy NVARCHAR(1000) NOT NULL

CREATE TABLE Stanowisko(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	PoziomStanowiska NVARCHAR(15) NOT NULL
)

CREATE TABLE FormaPracy(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	FormaPracy NVARCHAR(15) NOT NULL,
)

CREATE TABLE SzczegolyOferty(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdFirmy INT NOT NULL FOREIGN KEY REFERENCES Pracodawca(Id),
	NazwaStanowiska NVARCHAR(50) NOT NULL,
	MinimalneWynagrodzenie INT NOT NULL,
	MaksymalneWynagrodzenie INT NOT NULL,
	ZakresObowiazkow NVARCHAR(200) NOT NULL,
	Wymagania NVARCHAR(200) NOT NULL,
	PoziomStanowiska INT NOT NULL FOREIGN KEY REFERENCES Stanowisko(Id),
	RodzajEtatu INT NOT NULL,
	RodzajPracy INT NOT NULL FOREIGN KEY REFERENCES FormaPracy(Id),
	LiczbaWakatow INT NOT NULL,
	DataWystawienia DATETIME NOT NULL,
	DataWygasniecia DATETIME NOT NULL,
	TerminRozpoczęcia DATETIME NOT NULL,
	Benefity NVARCHAR(50) NULL,
	EtapyRekrutacji INT NOT NULL,
)

CREATE TABLE RodzajCzynnosciBazy(
	Id INT NOT NULL PRIMARY KEY,
	RodzajCzynnosci NVARCHAR(50) NOT NULL,
	OpisProcesu NVARCHAR(80) NOT NULL,
)

CREATE TABLE RodzajUprawnien(
	Id INT NOT NULL PRIMARY KEY,
	TypUprawnien NVARCHAR(10) NOT NULL
)

CREATE TABLE RodzajZalacznika(
	Id INT NOT NULL PRIMARY KEY,
	TypZalacznika NVARCHAR(20) NOT NULL
)

CREATE TABLE Zalacznik(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdRodzajuZalacznika INT NOT NULL FOREIGN KEY REFERENCES RodzajZalacznika(Id),
	IdPliku INT NOT NULL,
	DataDodania DATETIME NOT NULL
)

CREATE TABLE BazaWiedzy(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdCzynnosci INT NOT NULL FOREIGN KEY REFERENCES RodzajCzynnosciBazy(Id),
	TrescCzynnosci NVARCHAR(500) NOT NULL,
	IdUprawnien INT NOT NULL FOREIGN KEY REFERENCES RodzajUprawnien(Id),
	IdZalacznika INT NULL FOREIGN KEY REFERENCES Zalacznik(Id)
)

CREATE TABLE StatusAplikacji(
	Id INT NOT NULL PRIMARY KEY,
	[Status] NVARCHAR(50) NOT NULL,
	PowiadomienieUsera NVARCHAR(100) NOT NULL,
	OpisDzialania NVARCHAR(80) NOT NULL,
)
CREATE TABLE RodzajWyksztalcenia(
	Id INT NOT NULL PRIMARY KEY,
	RodzajWyksztalcenia NVARCHAR(20) NOT NULL,
)

CREATE TABLE [User](
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nazwisko NVARCHAR(50) NOT NULL,
	Imie NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Stanowisko NVARCHAR(30) NOT NULL,
	IdUprawnien INT NOT NULL FOREIGN KEY REFERENCES RodzajUprawnien(Id),
	NumerTelefonu NVARCHAR(50) NULL,
	IdZalacznika INT NULL FOREIGN KEY REFERENCES Zalacznik(Id),
	NazwaUzytkownika NVARCHAR(20) NOT NULL,
	IdWyksztalcenia INT NULL FOREIGN KEY REFERENCES RodzajWyksztalcenia(Id)
)

CREATE TABLE Aplikacja(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdOferty INT NOT NULL FOREIGN KEY REFERENCES SzczegolyOferty(Id),
	IdKandydata INT NOT NULL FOREIGN KEY REFERENCES [User](Id),
	IdStatus INT NOT NULL FOREIGN KEY REFERENCES StatusAplikacji(Id),
)

CREATE TABLE AplikacjaZalacznik(
	IdZalacznika INT NOT NULL FOREIGN KEY REFERENCES Zalacznik(Id),
	IdAplikacji INT NOT NULL FOREIGN KEY REFERENCES Aplikacja(Id)
)

CREATE TABLE DaneDoswiadczenie(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdUsera INT NOT NULL FOREIGN KEY REFERENCES [User](Id),
	Poczatek DATE NOT NULL,
	Koniec DATE NOT NULL,
	Firma NVARCHAR(20) NOT NULL
)

CREATE TABLE OcenaKandydata(
	Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Opinia NVARCHAR(100) NULL,
	Ocena INT NULL,
	IdKandydata INT NOT NULL FOREIGN KEY REFERENCES Aplikacja(Id),
)

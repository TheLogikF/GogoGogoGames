USE [ProjectLIBRARY]

CREATE TABLE [Genres] -- Жанры
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Genres_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Genres_Name] UNIQUE ([Name])
)
GO
CREATE TABLE [PublishingHouses] -- Издательства
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_PublishingHouses_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [Authors] -- Авторы
(
	[Id] INT IDENTITY NOT NULL,
	[Nickname] NVARCHAR(255) NULL,
	[FirstName] NVARCHAR(255) NULL,
	[LastName] NVARCHAR(255) NULL,
	[Patronymic] NVARCHAR(255) NULL,
	CONSTRAINT [PK_Authors_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CHECK([Nickname] != NULL OR ([FirstName] != NULL AND [LastName] != NULL))
)
GO
CREATE TABLE [Books] -- Книги
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_Books_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [BookAuthor] -- Связь многие ко многим. Книги могут иметь несколько авторов. Автор может иметь несколько книг.
(
	[BookId] INT NOT NULL,
	[AuthorId] INT NOT NULL,
	CONSTRAINT [PK_BookAuthor] PRIMARY KEY CLUSTERED ([BookId] ASC, [AuthorId] ASC),
	CONSTRAINT [FK_BookAuthor_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookAuthor_Authors_AuthorId] FOREIGN KEY ([AuthorId]) REFERENCES [dbo].[Authors] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookGenre] -- Связь многие ко многим. Книги могут иметь несколько жанров. Жанр может иметь несколько книг.
(
	[BookId] INT NOT NULL,
	[GenreId] INT NOT NULL,
	CONSTRAINT [PK_BookGenre] PRIMARY KEY CLUSTERED ([BookId] ASC, [GenreId] ASC),
	CONSTRAINT [FK_BookGenre_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookGenre_Genres_GenreId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookEditions] -- Издания книг
(
	[Id] INT IDENTITY NOT NULL,
	[BookId] INT NOT NULL,
	[PublishingHouseId] INT NOT NULL,
	[CoverPath] NVARCHAR(MAX) NULL, -- Если NULL, то используется обложка по умолчанию
	[AudioBookPath] NVARCHAR(MAX) NULL, -- Если NULL, то аудио книги нет
	[EBookPath] NVARCHAR(MAX) NULL, --Если NULL, то электронной книги нет
	CONSTRAINT [PK_BookEditions_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_BookEditions_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]),
	CONSTRAINT [FK_BookEditions_PublishingHouses_PublishingHouseId] FOREIGN KEY ([PublishingHouseId]) REFERENCES [dbo].[PublishingHouses] ([Id]),
	CONSTRAINT [UQ_BookEditions] UNIQUE ([BookId], [PublishingHouseId]),
)
GO
CREATE TABLE [Administrators] -- Адиминистраторы могут изменять данные в БД
(
	[Id] INT IDENTITY NOT NULL,
	[IdentificationCode] NVARCHAR(9) NOT NULL CHECK(LEN(IdentificationCode) = 9),
	[Password] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[Patronymic] NVARCHAR(255) NULL,
	CONSTRAINT [PK_Administrators_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Administrators_IdentificationCode] UNIQUE ([IdentificationCode]),
)
GO
CREATE TABLE [Employees] -- Работники могут обработать запросы на получение и возврат книги
(
	[Id] INT IDENTITY NOT NULL,
	[IdentificationCode] NVARCHAR(9) NOT NULL CHECK(LEN(IdentificationCode) = 9),
	[Password] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[Patronymic] NVARCHAR(255) NULL,
	CONSTRAINT [PK_Administrators_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Administrators_IdentificationCode] UNIQUE ([IdentificationCode]),
)
GO
CREATE TABLE [Readers] -- Читатели могут оформлять запросы на получение и возврат книги
(
	[Id] INT IDENTITY NOT NULL,
	[IdentificationCode] NVARCHAR(9) NOT NULL CHECK(LEN(IdentificationCode) = 9),
	[Password] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[Patronymic] NVARCHAR(255) NULL,
	CONSTRAINT [PK_Administrators_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Administrators_IdentificationCode] UNIQUE ([IdentificationCode]),
)
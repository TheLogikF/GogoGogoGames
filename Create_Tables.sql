USE [ProjectLIBRARY]

CREATE TABLE [Genres] -- �����
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Genres_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Genres_Name] UNIQUE ([Name])
)
GO
CREATE TABLE [PublishingHouses] -- ������������
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_PublishingHouses_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [Authors] -- ������
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
CREATE TABLE [Books] -- �����
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_Books_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [BookAuthor] -- ����� ������ �� ������. ����� ����� ����� ��������� �������. ����� ����� ����� ��������� ����.
(
	[BookId] INT NOT NULL,
	[AuthorId] INT NOT NULL,
	CONSTRAINT [PK_BookAuthor] PRIMARY KEY CLUSTERED ([BookId] ASC, [AuthorId] ASC),
	CONSTRAINT [FK_BookAuthor_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookAuthor_Authors_AuthorId] FOREIGN KEY ([AuthorId]) REFERENCES [dbo].[Authors] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookGenre] -- ����� ������ �� ������. ����� ����� ����� ��������� ������. ���� ����� ����� ��������� ����.
(
	[BookId] INT NOT NULL,
	[GenreId] INT NOT NULL,
	CONSTRAINT [PK_BookGenre] PRIMARY KEY CLUSTERED ([BookId] ASC, [GenreId] ASC),
	CONSTRAINT [FK_BookGenre_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookGenre_Genres_GenreId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookEditions] -- ������� ����
(
	[Id] INT IDENTITY NOT NULL,
	[BookId] INT NOT NULL,
	[PublishingHouseId] INT NOT NULL,
	[CoverPath] NVARCHAR(MAX) NULL, -- ���� NULL, �� ������������ ������� �� ���������
	[AudioBookPath] NVARCHAR(MAX) NULL, -- ���� NULL, �� ����� ����� ���
	[EBookPath] NVARCHAR(MAX) NULL, --���� NULL, �� ����������� ����� ���
	CONSTRAINT [PK_BookEditions_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_BookEditions_Books_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Books] ([Id]),
	CONSTRAINT [FK_BookEditions_PublishingHouses_PublishingHouseId] FOREIGN KEY ([PublishingHouseId]) REFERENCES [dbo].[PublishingHouses] ([Id]),
	CONSTRAINT [UQ_BookEditions] UNIQUE ([BookId], [PublishingHouseId]),
)
GO
CREATE TABLE [Administrators] -- ��������������� ����� �������� ������ � ��
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
CREATE TABLE [Employees] -- ��������� ����� ���������� ������� �� ��������� � ������� �����
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
CREATE TABLE [Readers] -- �������� ����� ��������� ������� �� ��������� � ������� �����
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
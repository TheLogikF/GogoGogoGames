USE [ProjectLIBRARY]

CREATE TABLE [Genres] -- ����� GOOD
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Genres_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Genres_Name] UNIQUE ([Name])
)
GO
CREATE TABLE [PublishingHouses] -- ������������ GOOD
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_PublishingHouses_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [Authors] -- ������ GOOD
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
CREATE TABLE [BookTemplates] -- ������� ���� GOOD
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_BookTemplates_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
CREATE TABLE [BookTemplateAuthor] -- ����� ������ �� ������. ����� ����� ����� ��������� �������. ����� ����� ����� ��������� ����. GOOD
(
	[BookTemplateId] INT NOT NULL,
	[AuthorId] INT NOT NULL,
	CONSTRAINT [PK_BookTemplateAuthor] PRIMARY KEY CLUSTERED ([BookTemplateId] ASC, [AuthorId] ASC),
	CONSTRAINT [FK_BookTemplateAuthor_Books_BookTemplateId] FOREIGN KEY ([BookTemplateId]) REFERENCES [dbo].[BookTemplates] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookTemplateAuthor_Authors_AuthorId] FOREIGN KEY ([AuthorId]) REFERENCES [dbo].[Authors] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookTemplateGenre] -- ����� ������ �� ������. ����� ����� ����� ��������� ������. ���� ����� ����� ��������� ����. GOOD
(
	[BookTemplateId] INT NOT NULL,
	[GenreId] INT NOT NULL,
	CONSTRAINT [PK_BookTemplateGenre] PRIMARY KEY CLUSTERED ([BookTemplateId] ASC, [GenreId] ASC),
	CONSTRAINT [FK_BookTemplateGenre_Books_BookId] FOREIGN KEY ([BookTemplateId]) REFERENCES [dbo].[BookTemplates] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BookTemplateGenre_Genres_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
)
GO
CREATE TABLE [BookEditions] -- ������� ���� GOOD
(
	[Id] INT IDENTITY NOT NULL,
	[BookTemplateId] INT NOT NULL,
	[PublishingHouseId] INT NOT NULL,
	[CoverPath] NVARCHAR(MAX) NULL, -- ���� NULL, �� ������������ ������� �� ���������
	[AudioBookPath] NVARCHAR(MAX) NULL, -- ���� NULL, �� ����� ����� ���
	[EBookPath] NVARCHAR(MAX) NULL, --���� NULL, �� ����������� ����� ���
	CONSTRAINT [PK_BookEditions_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_BookEditions_BookTemplates_BookTemplateId] FOREIGN KEY ([BookTemplateId]) REFERENCES [dbo].[BookTemplates] ([Id]),
	CONSTRAINT [FK_BookEditions_PublishingHouses_PublishingHouseId] FOREIGN KEY ([PublishingHouseId]) REFERENCES [dbo].[PublishingHouses] ([Id]),
	CONSTRAINT [UQ_BookEditions] UNIQUE ([BookTemplateId], [PublishingHouseId]),
)
GO
CREATE TABLE [Books] -- ���������� ���� GOOD?
(
	[Id] INT IDENTITY NOT NULL,
	[BookEditionId] INT NOT NULL,
	[IsAvailable] BIT NOT NULL DEFAULT 0,
	CONSTRAINT [PK_Books_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_Books_BookEditions_BookEditionId] FOREIGN KEY ([BookEditionId]) REFERENCES [dbo].[BookEditions] ([Id]),
)
GO
CREATE TABLE [Roles] -- ����. ����� ������ ��������� �����.
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Roles_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Roles_Name] UNIQUE ([Name]),
)
GO
CREATE TABLE [Users]
(
	[Id] INT IDENTITY NOT NULL,
	[Login] NVARCHAR(255) NOT NULL,
	[Password] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[Patronymic] NVARCHAR(255) NULL,
	[RoleId] INT NOT NULL,
	CONSTRAINT [PK_Administrators_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_Administrators_Login] UNIQUE ([Login]),
	CONSTRAINT [FK_Users_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([Id]),
)
GO
CREATE TABLE [BookRequests]
(
	[Id] INT IDENTITY NOT NULL,
	[Number] NVARCHAR(6) NOT NULL, -- ����� ����� ���: 000000. � ����� ���������� ������ ����.
	[EmployeeId] INT NOT NULL, -- ��������, ������� ����� �����
	[ReadersId] INT NOT NULL, -- ��������, �������� ������ �����
	[CreationDate] DATE NOT NULL, -- ���� �������� �������
	[CreationTime] TIME NOT NULL, -- ����� �������� �������
	[IssueDate] DATE NULL, -- ���� ������ �����
	[IssueTime] TIME NULL, -- ����� ����� �����
	[ReturnDate] DATE NULL, -- ���� �������� �����
	[ReturnTime] TIME NULL, -- ����� �������� �����
)
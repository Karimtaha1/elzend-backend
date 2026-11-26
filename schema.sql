CREATE DATABASE elzend_demo;
GO

USE elzend_demo;
GO

-- =============================================
-- 1. USERS TABLE (Admin, Staff, Volunteers)
-- =============================================
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    passwordHash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'volunteer' CHECK (role IN ('superadmin', 'admin', 'staff', 'volunteer')),
    avatar NVARCHAR(255),
    isActive BIT DEFAULT 1,
    lastLogin DATETIME2,
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 2. VOLUNTEERS TABLE
-- =============================================
CREATE TABLE Volunteers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20) NOT NULL,
    governorate NVARCHAR(50),
    field NVARCHAR(50) NOT NULL,
    skills NVARCHAR(500),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected', 'active', 'inactive')),
    hoursLogged INT DEFAULT 0,
    joinedAt DATETIME2 DEFAULT GETDATE(),
    notes NVARCHAR(500),
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 3. PROJECTS TABLE
-- =============================================
CREATE TABLE Projects (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titleAr NVARCHAR(200) NOT NULL,
    titleEn NVARCHAR(200) NOT NULL,
    descriptionAr NVARCHAR(MAX),
    descriptionEn NVARCHAR(MAX),
    category NVARCHAR(50) NOT NULL CHECK (category IN ('education', 'health', 'women', 'families', 'water', 'training', 'sustainable')),
    goalAmount DECIMAL(18,2) NOT NULL,
    raisedAmount DECIMAL(18,2) DEFAULT 0,
    beneficiariesCount INT DEFAULT 0,
    location NVARCHAR(100),
    image NVARCHAR(255),
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'completed', 'pending', 'cancelled')),
    startDate DATE,
    endDate DATE,
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 4. DONATIONS TABLE
-- =============================================
CREATE TABLE Donations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    donorName NVARCHAR(100) NOT NULL,
    donorEmail NVARCHAR(100),
    donorPhone NVARCHAR(20),
    amount DECIMAL(18,2) NOT NULL,
    currency NVARCHAR(3) DEFAULT 'EGP',
    donationType NVARCHAR(20) DEFAULT 'one-time' CHECK (donationType IN ('one-time', 'monthly', 'sponsorship', 'zakat', 'sadaqah')),
    projectId INT,
    paymentMethod NVARCHAR(30) NOT NULL CHECK (paymentMethod IN ('vodafone_cash', 'credit_card', 'bank_transfer', 'fawry', 'cash')),
    transactionId NVARCHAR(100),
    paymentStatus NVARCHAR(20) DEFAULT 'pending' CHECK (paymentStatus IN ('pending', 'completed', 'failed', 'refunded')),
    isAnonymous BIT DEFAULT 0,
    message NVARCHAR(500),
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (projectId) REFERENCES Projects(id)
);

-- =============================================
-- 5. BENEFICIARIES TABLE
-- =============================================
CREATE TABLE Beneficiaries (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    nationalId NVARCHAR(20),
    phone NVARCHAR(20),
    governorate NVARCHAR(50),
    address NVARCHAR(200),
    familySize INT DEFAULT 1,
    category NVARCHAR(30) CHECK (category IN ('orphan', 'widow', 'elderly', 'disabled', 'poor', 'student', 'patient')),
    needsDescription NVARCHAR(MAX),
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'sponsored', 'completed', 'on_hold')),
    sponsorId INT,
    monthlySupport DECIMAL(18,2),
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 6. SUCCESS STORIES TABLE
-- =============================================
CREATE TABLE SuccessStories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titleAr NVARCHAR(200) NOT NULL,
    titleEn NVARCHAR(200) NOT NULL,
    contentAr NVARCHAR(MAX),
    contentEn NVARCHAR(MAX),
    beneficiaryName NVARCHAR(100),
    category NVARCHAR(50),
    image NVARCHAR(255),
    videoUrl NVARCHAR(255),
    isFeatured BIT DEFAULT 0,
    viewsCount INT DEFAULT 0,
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 7. NEWS & EVENTS TABLE
-- =============================================
CREATE TABLE NewsEvents (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titleAr NVARCHAR(200) NOT NULL,
    titleEn NVARCHAR(200) NOT NULL,
    contentAr NVARCHAR(MAX),
    contentEn NVARCHAR(MAX),
    type NVARCHAR(20) DEFAULT 'news' CHECK (type IN ('news', 'event', 'campaign', 'announcement')),
    image NVARCHAR(255),
    eventDate DATETIME2,
    location NVARCHAR(100),
    isFeatured BIT DEFAULT 0,
    viewsCount INT DEFAULT 0,
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 8. CONTACT MESSAGES TABLE
-- =============================================
CREATE TABLE ContactMessages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    subject NVARCHAR(100),
    message NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(20) DEFAULT 'unread' CHECK (status IN ('unread', 'read', 'replied', 'archived')),
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 9. PARTNERS TABLE
-- =============================================
CREATE TABLE Partners (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nameAr NVARCHAR(100) NOT NULL,
    nameEn NVARCHAR(100) NOT NULL,
    type NVARCHAR(30) CHECK (type IN ('company', 'government', 'ngo', 'individual')),
    logo NVARCHAR(255),
    website NVARCHAR(200),
    description NVARCHAR(500),
    isActive BIT DEFAULT 1,
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 10. FINANCIAL REPORTS TABLE
-- =============================================
CREATE TABLE FinancialReports (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titleAr NVARCHAR(200) NOT NULL,
    titleEn NVARCHAR(200) NOT NULL,
    year INT NOT NULL,
    quarter INT CHECK (quarter IN (1,2,3,4)),
    totalIncome DECIMAL(18,2) DEFAULT 0,
    totalExpenses DECIMAL(18,2) DEFAULT 0,
    fileUrl NVARCHAR(255),
    reportType NVARCHAR(20) DEFAULT 'annual' CHECK (reportType IN ('annual', 'quarterly', 'monthly')),
    createdAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 11. SITE SETTINGS TABLE
-- =============================================
CREATE TABLE SiteSettings (
    id INT PRIMARY KEY DEFAULT 1,
    siteNameAr NVARCHAR(100) DEFAULT N'مؤسسة الزند',
    siteNameEn NVARCHAR(100) DEFAULT 'Al-Zand Foundation',
    siteDescriptionAr NVARCHAR(500),
    siteDescriptionEn NVARCHAR(500),
    totalDonations DECIMAL(18,2) DEFAULT 0,
    totalBeneficiaries INT DEFAULT 0,
    totalProjects INT DEFAULT 0,
    totalVolunteers INT DEFAULT 0,
    sdgProgress INT DEFAULT 0,
    contactEmail NVARCHAR(100),
    contactPhone NVARCHAR(20),
    contactAddress NVARCHAR(200),
    facebookUrl NVARCHAR(200),
    twitterUrl NVARCHAR(200),
    instagramUrl NVARCHAR(200),
    youtubeUrl NVARCHAR(200),
    linkedinUrl NVARCHAR(200),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- 12. AUDIT LOG TABLE
-- =============================================
CREATE TABLE AuditLog (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT,
    action NVARCHAR(100) NOT NULL,
    tableName NVARCHAR(50),
    recordId INT,
    oldValues NVARCHAR(MAX),
    newValues NVARCHAR(MAX),
    ipAddress NVARCHAR(50),
    createdAt DATETIME2 DEFAULT GETDATE()
);

GO


-- No seed data or default accounts are included.

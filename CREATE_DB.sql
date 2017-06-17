CREATE TABLE CriminalRecord(
	ID INT NOT NULL,
	NAME VARCHAR(30) NOT NULL,
	ADDRESS TEXT NOT NULL,
	ID_MARK_1 VARCHAR(30) NOT NULL,
	ID_MARK_2 VARCHAR(30),
	ID_MARK_3 VARCHAR(30),
	DOB DATE,
	BIOMETRICS TEXT,
	CRIM_TYPE CHAR(1),
	PRIMARY KEY (ID),
	CHECK (CRIM_TYPE = "CRIMINAL" OR CRIM_TYPE = "SUSPECT")
);

CREATE TABLE CriminalIMEI(
	ID INT references CriminalRecord(ID),
	IMEI CHAR(16),
	USED_FROM_DATE DATE,
	USED_FROM_TIME TIME,
	USED_TO_DATE DATE,
	USED_TO_TIME TIME
);

CREATE TABLE CriminalNames(
	ID INT references CriminalRecord(ID),
	NAME VARCHAR(30)
);

CREATE TABLE CriminalAddresses(
	ID INT references CriminalRecord(ID),
	ADDRESS TEXT
);

CREATE TABLE GangRecord(
	ID INT NOT NULL,
	CRIM_ID INT references CriminalRecord(ID),
	PRIMARY KEY (ID, CRIM_ID)
);

CREATE TABLE CriminalMobInfo(
	ID INT references CriminalRecord(ID),
	MOB_NO INT NOT NULL CHECK (MOB_NO BETWEEN 1000000000 AND 9999999999),
	USED_FROM_DATE DATE,
	USED_FROM_TIME TIME,
	USED_TO_DATE DATE,
	USED_TO_TIME TIME
);

CREATE TABLE IncidentInfo(
	ID INT NOT NULL,
	INC_DATE DATE,
	INC_TIME TIME,
	LOCATION TEXT,
	TRAIN INT CHECK (TRAIN BETWEEN 10000 AND 99999),
	COACH INT,
	DEPT_DATE DATE,
	DEPT_TIME TIME,
	PASSENGER_NAME VARCHAR(30),
	PNR CHAR(15),
	DESCRIPTION TEXT,
	ALT_CONTACT_NO INT CHECK (ALT_CONTACT_NO BETWEEN 1000000 AND 9999999999),
	PRIMARY KEY (ID)
);

CREATE TABLE CrimeDetail(
	CRIM_ID INT references CriminalRecord (ID),
	INC_ID INT references IncidentInfo(ID),
	ACTION_ID INT references ActionInfo(ID),
	JAIL_BEGIN_DATE DATE,
	JAIL_END_DATE DATE,
	JAIL ID INT,
	PRIMARY KEY (CRIM_ID, INC_ID, ACTION_ID)
);

CREATE TABLE CDRInfo(
	MOB_NO TEXT,
	IMEI CHAR(16),
	OTHER_MOB_NO TEXT,
	CALL_SMS VARCHAR(4),
	CALL_TYPE VARCHAR(3),
	SMS_TYPE VARCHAR(3),
	CALL_DURATION INT,
	COM_DATE DATE,
	COM_TIME TIME,
	TOWER_ID INT references TowerInfo(ID),
	ANTENNA_ID INT references TowerInfo(ANTENNA_ID),
	CHECK (CALL_SMS = "CALL" OR CALL_SMS = "SMS"),
	CHECK (CALL_TYPE = "IN" OR CALL_TYPE = "OUT"),
);

CREATE TABLE LostMobInfo(
	INC_ID INT references IncidentInfo(ID),
	MOB_NO INT NOT NULL CHECK (MOB_NO BETWEEN 1000000000 AND 9999999999),
	IMEI_LOST CHAR(16)
);

CREATE TABLE ActionInfo(
	ID INT NOT NULL,
	TYPE VARCHAR(6) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE TowerInfo(
	ID TEXT NOT NULL,
	ANTENNA_ID TEXT,
	SERV_PROV TEXT,
	TOWN TEXT,
	ROAM TEXT,
	LOCATION TEXT,
	LATITUDE REAL,
	LONGITUDE REAL,
	AZIMUTH REAL
	PRIMARY KEY (ID)
);

CREATE TABLE InformerInfo(
	ID INT NOT NULL,
	ADDRESS TEXT,
	NAME VARCHAR(30),
	CRIMINAL_ID INT NOT NULL
);

CREATE TABLE InformationInfo(
	INFORMER_ID INT references InformerInfo(ID),
	CRIMINAL_ID INT references CriminalRecord(ID),
	LATITUDE REAL,
	LONGITUDE REAL,
	INFO_DATE DATE,
	INFO_TIME TIME,
	MORE_INFO TEXT
);

CREATE TABLE CriminalTravelInfo(
	CRIM_ID INT references CriminalRecord(ID),
	PNR CHAR(15) NOT NULL,
	TRAIN INT CHECK (TRAIN BETWEEN 10000 AND 99999),
	TRAVEL_DATE DATE,
	TRAVEL_TIME TIME, 
	STATION_FROM VARCHAR(10),
	STATION_TO VARCHAR(10),
	BOOKED_BY VARCHAR(30),
	DEPT_TIME TIME,
	PRIMARY KEY (CRIM_ID, PNR)
);

DROP TABLE CrimRecord;
DROP TABLE GangRecord;
DROP TABLE CrimIMEI;
DROP TABLE CrimName_2;
DROP TABLE CrimAddr_2;
DROP TABLE Incident;
DROP TABLE CriminalMobInfo;
DROP TABLE CrimeDetail;
DROP TABLE CDRInfo;
DROP TABLE LostMobInfo;
DROP TABLE TowerInfo;
DROP TABLE InformerInfo;
DROP TABLE InformationInfo;
DROP TABLE CriminalTravelInfo;
DROP TABLE ActionInfo;
DROP TABLE Insured_education_level_map CASCADE CONSTRAINTS;
DROP TABLE Insured_occupation_map CASCADE CONSTRAINTS;
DROP TABLE Incident_severity_map CASCADE CONSTRAINTS;
DROP TABLE Authorities_contacted_map CASCADE CONSTRAINTS;
DROP TABLE Property_damage_map CASCADE CONSTRAINTS;
DROP TABLE Police_report_available_map CASCADE CONSTRAINTS;
DROP TABLE Fraud_reported_map CASCADE CONSTRAINTS;

CREATE TABLE Insured_education_level_map(
	val VARCHAR2(50),
	num NUMBER
);
CREATE TABLE Insured_occupation_map(
	val VARCHAR2(50),
	num NUMBER
);
CREATE TABLE Incident_severity_map(
	val VARCHAR2(50),
	num NUMBER
);
CREATE TABLE Authorities_contacted_map(
	val VARCHAR2(50),
	num NUMBER
);

CREATE TABLE Property_damage_map(
	val VARCHAR2(50),
	num NUMBER
);
CREATE TABLE Police_report_available_map(
	val VARCHAR2(50),
	num NUMBER
);
CREATE TABLE Fraud_reported_map(
	val VARCHAR2(50),
	num NUMBER
);


DECLARE
	num NUMBER := 1;
BEGIN
	
	FOR R in (SELECT DISTINCT insured_education_level FROM Premium_data) LOOP
	
		INSERT INTO Insured_education_level_map VALUES(R.insured_education_level,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT insured_occupation FROM Premium_data) LOOP
	
		INSERT INTO Insured_occupation_map VALUES(R.insured_occupation,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT incident_severity FROM Premium_data) LOOP
	
		INSERT INTO Incident_severity_map VALUES(R.incident_severity,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT authorities_contacted FROM Premium_data) LOOP
	
		INSERT INTO Authorities_contacted_map VALUES(R.authorities_contacted,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT property_damage FROM Premium_data) LOOP
	
		INSERT INTO Property_damage_map VALUES(R.property_damage,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT police_report_available FROM Premium_data) LOOP
	
		INSERT INTO Police_report_available_map VALUES(R.police_report_available,num);
		num := num+1;
	
	END LOOP;
	
	num :=1;
	
	FOR R in (SELECT DISTINCT fraud_reported FROM Premium_data) LOOP
	
		INSERT INTO Fraud_reported_map VALUES(R.fraud_reported,num);
		num := num+1;
	
	END LOOP;
	
END;
/

COMMIT;
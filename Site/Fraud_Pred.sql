
DROP TABLE KNN_table_train CASCADE CONSTRAINTS;
DROP TABLE KNN_table_test CASCADE CONSTRAINTS;
CREATE TABLE KNN_table_train(
	id int,
	m_a_c NUMBER,
	p_d NUMBER,
	p_a_p NUMBER,
	i_e_l NUMBER,
	i_o NUMBER,
	c_g NUMBER,
	c_l NUMBER,
	i_s NUMBER,
	a_c NUMBER,
	n_v_i NUMBER,
	pr_d NUMBER,
	b_i NUMBER,
	wit NUMBER,
	p_r NUMBER,
	t_c_a NUMBER,
	i_c NUMBER,
	p_c NUMBER,
	v_c NUMBER,
	f_r VARCHAR2(50),
	PRIMARY KEY (id)
);
CREATE TABLE KNN_table_test(
	id int,
	m_a_c NUMBER,
	p_d NUMBER,
	p_a_p NUMBER,
	i_e_l NUMBER,
	i_o NUMBER,
	c_g NUMBER,
	c_l NUMBER,
	i_s NUMBER,
	a_c NUMBER,
	n_v_i NUMBER,
	pr_d NUMBER,
	b_i NUMBER,
	wit NUMBER,
	p_r NUMBER,
	t_c_a NUMBER,
	i_c NUMBER,
	p_c NUMBER,
	v_c NUMBER,
	f_r VARCHAR2(50),
	PRIMARY KEY (id)
);

SELECT val as Education_Level,num as ID FROM Insured_education_level_map@site_link;
SELECT val as Occupation_Level,num as ID FROM Insured_occupation_map@site_link;
SELECT val as Incident_Severity,num as ID FROM Incident_severity_map@site_link;
SELECT val as Authorities_Contacted,num as ID FROM Authorities_contacted_map@site_link;
SELECT val as Property_Damage,num as ID FROM Property_damage_map@site_link;
SELECT val as Police_Report_Available,num as ID FROM Police_report_available_map@site_link;



set serveroutput on;
set verify off;
CREATE OR REPLACE TRIGGER Show_details 
After INSERT 
ON KNN_table_test
BEGIN
	dbms_output.put_line('Test Data Inserted!!!');
END;
/


ACCEPT A NUMBER PROMPT "Number of Months as Customer = "
ACCEPT B NUMBER PROMPT "Policy Amount Deductable  = "
ACCEPT C NUMBER PROMPT "Policy Annual Premium  = "
ACCEPT D NUMBER PROMPT "Enter Id of Education Level  = "
ACCEPT E NUMBER PROMPT "Enter Id of Occupation = "
ACCEPT F NUMBER PROMPT "Capital Gain  = "
ACCEPT G NUMBER PROMPT "Captial Loss  = "
ACCEPT H NUMBER PROMPT "Enter Id of Incident Severity  = "
ACCEPT I NUMBER PROMPT "Enter Id of Authorities Contacted = "
ACCEPT J NUMBER PROMPT "Number Of Vehicle Involved  = "
ACCEPT K NUMBER PROMPT "Enter Id of Property Damage  = "
ACCEPT L NUMBER PROMPT "Number of Bodily Injuries  = "
ACCEPT M NUMBER PROMPT "Number Witnesses = "
ACCEPT N NUMBER PROMPT "Enter Id of Police Report Available  = "
ACCEPT O NUMBER PROMPT "Total Amount Claimed  = "
ACCEPT P NUMBER PROMPT "Injury Amount Claimed  = "
ACCEPT Q NUMBER PROMPT "Property Amount Claimed = "
ACCEPT R NUMBER PROMPT "Vehicle Amount Claimed   = "

DECLARE
	v1 NUMBER;
	v2 NUMBER;
	v3 NUMBER;
	v4 NUMBER;
	v5 NUMBER;
	v6 NUMBER;
	v7 NUMBER;
	k_nn int;
	mac NUMBER;
	pd NUMBER;
	pap NUMBER;
	iel NUMBER;
	io NUMBER;
	cg NUMBER;
	cl NUMBER;
	i_ss NUMBER;
	ac NUMBER;
	nvi NUMBER;
	prd NUMBER;
	bi NUMBER;
	wit NUMBER;
	pr NUMBER;
	tca NUMBER;
	ic NUMBER;
	pc NUMBER;
	vc NUMBER;
	Custom_Exception EXCEPTION;
BEGIN
	
	FOR R IN (SELECT * FROM Train_data) LOOP
		SELECT num INTO v1 FROM Insured_education_level_map@site_link where val = R.i_e_l;
		SELECT num INTO v2 FROM Insured_occupation_map@site_link where val = R.i_o;
		SELECT num INTO v3 FROM Incident_severity_map@site_link where val = R.i_s;
		SELECT num INTO v4 FROM Authorities_contacted_map@site_link where val = R.a_c;
		SELECT num INTO v5 FROM Property_damage_map@site_link where val = R.pr_d;
		SELECT num INTO v6 FROM Police_report_available_map@site_link where val = R.p_r;
		SELECT num INTO v7 FROM Fraud_reported_map@site_link where val = R.f_r;
		
		INSERT INTO KNN_table_train VALUES(R.id,R.m_a_c,R.p_d,R.p_a_p,v1,v2,R.c_g,R.c_l,v3,v4,R.n_v_i,v5,R.b_i,R.wit,v6,R.t_c_a,R.i_c,R.p_c,R.v_c,v7);
	
	END LOOP;
	FOR R IN (SELECT * FROM Test_data) LOOP
		SELECT num INTO v1 FROM Insured_education_level_map@site_link where val = R.i_e_l;
		SELECT num INTO v2 FROM Insured_occupation_map@site_link where val = R.i_o;
		SELECT num INTO v3 FROM Incident_severity_map@site_link where val = R.i_s;
		SELECT num INTO v4 FROM Authorities_contacted_map@site_link where val = R.a_c;
		SELECT num INTO v5 FROM Property_damage_map@site_link where val = R.pr_d;
		SELECT num INTO v6 FROM Police_report_available_map@site_link where val = R.p_r;
		SELECT num INTO v7 FROM Fraud_reported_map@site_link where val = R.f_r;
		
		INSERT INTO KNN_table_test VALUES(R.id,R.m_a_c,R.p_d,R.p_a_p,v1,v2,R.c_g,R.c_l,v3,v4,R.n_v_i,v5,R.b_i,R.wit,v6,R.t_c_a,R.i_c,R.p_c,R.v_c,v7);
	
	END LOOP;
	
	
	SELECT SQRT(COUNT(*)) INTO k_nn FROM Train_data ;
	IF MOD(k_nn,2) = 0 THEN
		k_nn := k_nn +1;
	END IF;
	
	KNN.get_acc(k_nn+2);
	mac := &A;
	pd := &B;
	pap := &C;
	iel := &D;
	io :=&E;
	cg := &F;
	cl := &G;
	i_ss := &H;
	ac := &I;
	nvi := &J;
	prd := &K;
	bi := &L;
	wit := &M;
	pr := &N;
	tca := &O;
	ic := &P;
	pc := &Q;
	vc := &R;
	
	IF iel<1 OR iel>7 THEN
		RAISE Custom_Exception;
	ELSIF io<1 OR io>14 THEN
		RAISE Custom_Exception;
	ELSIF i_ss<1 OR i_ss>4 THEN
		RAISE Custom_Exception;
	ELSIF ac<1 OR ac>5 THEN
		RAISE Custom_Exception;
	ELSIF prd<1 or prd>2 THEN
		RAISE Custom_Exception;
	ELSIF pr<1 or pr>2 THEN
		RAISE Custom_Exception;
	END IF;
	
	predict(mac,pd,pap,iel,io,cg,cl,i_ss,ac,nvi,prd,bi,wit,pr,tca,ic,pc,vc);
	
	EXCEPTION
		WHEN Custom_Exception THEN
			DBMS_OUTPUT.PUT_LINE('Invalid input has been given!!!');
		
END;
/

COMMIT;
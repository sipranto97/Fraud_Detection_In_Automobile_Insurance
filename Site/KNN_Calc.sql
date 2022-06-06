CREATE OR REPLACE PACKAGE KNN AS
	FUNCTION acc_calc(tp IN NUMBER, tn IN NUMBER, fp IN NUMBER ,fn IN NUMBER)
	RETURN int;
	FUNCTION pre_calc(tn IN NUMBER, fn IN NUMBER)
	RETURN int;
	FUNCTION rec_calc(tn IN NUMBER, fp IN NUMBER )
	RETURN int;
	FUNCTION f1_calc(pre IN NUMBER, rec IN NUMBER)
	RETURN int;
	PROCEDURE get_acc(k_nn IN int);
END KNN;
/

CREATE OR REPLACE PACKAGE BODY KNN AS

	FUNCTION acc_calc(tp IN NUMBER, tn IN NUMBER, fp IN NUMBER ,fn IN NUMBER)
	RETURN int
	IS
	n NUMBER;
	p int;
	BEGIN
	
		n := (tp+tn)/(tp+tn+fp+fn);
		p := n*100;
		RETURN p;
	
	END acc_calc;
	
	
	FUNCTION pre_calc(tn IN NUMBER, fn IN NUMBER)
	RETURN int
	IS
	n NUMBER;
	p int;
	BEGIN
	
		n := (tn)/(tn+fn);
		p := n*100;
		RETURN p;
	
	END pre_calc;
	
	FUNCTION rec_calc(tn IN NUMBER, fp IN NUMBER)
	RETURN int
	IS
	n NUMBER;
	p int;
	BEGIN
		n := (tn)/(tn+fp);
		p := n*100;
		RETURN p;
	END rec_calc;
	
	FUNCTION f1_calc(pre IN NUMBER, rec IN NUMBER)
	RETURN int
	IS
	n NUMBER;
	p int;
	BEGIN
		
		n :=(2*pre*rec)/(pre+rec);
		p := n*100;
		RETURN p;
	END f1_calc;

	PROCEDURE get_acc(k_nn IN int)
	IS
		y_cnt int := 0;
		n_cnt int :=0;
		accu int :=0;
		pre int :=0;
		recall int :=0;
		f1 int :=0;
		d_pre NUMBER :=0;
		d_rec NUMBER :=0;
		tp NUMBER := 0;
		tn NUMBER := 0;
		fp NUMBER := 0;
		fn NUMBER := 0;
		l_c int:= 0;
	BEGIN
		FOR R IN ( SELECT * FROM KNN_table_test ) LOOP
		
			FOR RR IN (SELECT * FROM KNN_table_train ORDER BY (SQRT(POWER(R.m_a_c - m_a_c , 2) + POWER(R.p_d - p_d, 2) + POWER(R.p_a_p - p_a_p,2) + 
			POWER(R.i_e_l  - i_e_l , 2)+ POWER(R.i_o - i_o, 2) +  POWER(R.c_g - c_g, 2) + POWER(R.c_l - c_l, 2) + POWER(R.i_s - i_s, 2) + 
			POWER(R.a_c - a_c, 2) + POWER(R.n_v_i - n_v_i, 2) + POWER(R.pr_d - pr_d, 2) + POWER(R.b_i - b_i, 2) + POWER(R.wit - wit, 2) + 
			POWER(R.p_r - p_r, 2) + POWER(R.t_c_a - t_c_a, 2) + POWER(R.i_c - i_c, 2) + POWER(R.p_c - p_c, 2) + POWER(R.v_c - v_c, 2) )) ASC) LOOP
				--dbms_output.put_line(RR.f_r);
				IF RR.f_r = 1 THEN
					y_cnt := y_cnt+1;
				ELSE 
					n_cnt := n_cnt+1;
				END IF;
				
				l_c := l_c+1;
				--dbms_output.put_line(l_c||' ' || n_cnt);
				IF l_c = 3 THEN
					l_c :=0;
					EXIT;
				END IF;
				
			END LOOP;
			--dbms_output.put_line(y_cnt||' ' || n_cnt);
			IF y_cnt>n_cnt THEN
				
				IF R.f_r = 1 THEN
					tp := tp+1;
				ELSE
					fp := fp+1;
				END IF;
				
			ELSE
				IF R.f_r = 1 THEN
					fn := fn+1;
				ELSE
					tn := tn+1;
				END IF;
			END IF;
			y_cnt := 0;
			n_cnt :=0;
		END LOOP;
		dbms_output.put_line('-------------------------');
		dbms_output.put_line('Model Details');
		
		accu := acc_calc(tp, tn, fp, fn);
		pre := pre_calc(tn, fn);
		recall := rec_calc(tn, fp);
		d_pre := pre/100;
		d_rec := recall/100;
		f1 := f1_calc(d_pre, d_rec);
		dbms_output.put_line('Accuracy:' || CHR(9) || accu || '%');
		dbms_output.put_line('Precision:' || CHR(9) || pre || '%');
		dbms_output.put_line('Recall:'|| CHR(9) || CHR(9) || recall || '%');
		dbms_output.put_line('F1 Score:' || CHR(9) || f1 || '%');
		dbms_output.put_line('-------------------------');
	END get_acc;
END KNN;
/
COMMIT;


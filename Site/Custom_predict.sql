CREATE OR REPLACE PROCEDURE predict(A IN NUMBER,B IN NUMBER,C IN NUMBER,D IN NUMBER,E IN NUMBER,F IN NUMBER,G IN NUMBER,H IN NUMBER,I IN NUMBER,J IN NUMBER,K IN NUMBER,L IN NUMBER,M IN NUMBER,N IN NUMBER,O IN NUMBER,P IN NUMBER,Q IN NUMBER,R IN NUMBER )
IS
	y_cnt int := 0;
	n_cnt int := 0;
	l_c int :=0;
BEGIN
	FOR RR IN (SELECT * FROM KNN_table_train ORDER BY (SQRT(POWER(A - m_a_c , 2) + POWER(B- p_d, 2) + POWER(C - p_a_p,2) + 
			POWER(D  - i_e_l , 2)+ POWER(E - i_o, 2) +  POWER(F - c_g, 2) + POWER(G - c_l, 2) + POWER(H - i_s, 2) + 
			POWER(I - a_c, 2) + POWER(J - n_v_i, 2) + POWER(K - pr_d, 2) + POWER(L - b_i, 2) + POWER(M - wit, 2) + 
			POWER(N - p_r, 2) + POWER(O - t_c_a, 2) + POWER(P- i_c, 2) + POWER(Q - p_c, 2) + POWER(R - v_c, 2) )) ASC) LOOP
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
	IF y_cnt>n_cnt THEN
		DBMS_OUTPUT.PUT_LINE('Fraud Detected!!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Not a Fraud!!');
	END IF;
END predict;
/

COMMIT;
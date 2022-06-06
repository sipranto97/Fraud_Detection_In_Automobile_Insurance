create or replace view Train_data(id,m_a_c, p_d, p_a_p, i_e_l, i_o, c_g, c_l, i_s, a_c, n_v_i, pr_d, b_i, wit, p_r, t_c_a, i_c, p_c, v_c, f_r) as
select S.id, S.months_as_customer, S.policy_deductable, S.policy_annual_premium, S.insured_education_level,
S.insured_occupation, S.capital_gains, S.captial_loss,S.incident_severity, S.authorities_contacted, S.number_of_vehicles_involved,
S.property_damage, S.bodily_injuries, S.witnesses,S.police_report_available, S.total_claim_amount, S.injury_claim,
S.property_claim, S.vehicle_claim, S.fraud_reported
from Premium_data@site_link S where id<=350;

create or replace view Test_data(id,m_a_c, p_d, p_a_p, i_e_l, i_o, c_g, c_l, i_s, a_c, n_v_i, pr_d, b_i, wit, p_r, t_c_a, i_c, p_c, v_c, f_r) as
select S.id, S.months_as_customer, S.policy_deductable, S.policy_annual_premium, S.insured_education_level,
S.insured_occupation, S.capital_gains, S.captial_loss,S.incident_severity, S.authorities_contacted, S.number_of_vehicles_involved,
S.property_damage, S.bodily_injuries, S.witnesses,S.police_report_available, S.total_claim_amount, S.injury_claim,
S.property_claim, S.vehicle_claim, S.fraud_reported
from Premium_data@site_link S where id>350;

COMMIT;
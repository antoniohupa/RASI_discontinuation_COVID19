
*************************************************************************************************************************
*** MAIN STATISTICAL ANALYSIS OF THE STUDY ENTITLED : 

*** Prof Francisco J. de Abajo, MD, PhD, MPH, Antonio Rodríguez-Miguel, PhD, Sara Rodríguez-Martín, PhD, Victoria Lerma, RN, Alberto García-Lledó, MD, PhD, 
*** on behalf of MED-ACE2-COVID19 Study Group: 
*** "IMPACT OF IN-HOSPITAL DISCONTINUATION WITH ANGIOTENSIN RECEPTOR BLOCKERS AND ANGIOTENSIN CONVERTING ENZYME INHIBITORS 
***  ON THE MORTALITY OF COVID-19 PATIENTS. A RETROSPECTIVE COHORT STUDY"

*** AUTHOR: Antonio Rodríguez-Miguel, PhD

*** DATASET: ......csv


*** COMMENTS: Main analysis considering the 3-days time window for RASI discontinuation


*** PACKAGES NEEDED TO INSTALL:

** Install table1_mc package: 

* ssc install table1_mc

** Install stddiff package: 

* ssc install stddiff

*************************************************************************************************************************
*************************************************************************************************************************



********************************************************************************
*** 1. MEDIATION ANALYSIS ***
********************************************************************************


** 1.1. Outcome = Death
************************


* Consider only descendants of the exposure, that is, in-hospital treatments after discontinuaton of RASIs:
foreach var in oac pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic steroid tocilizumab other_immuno immunomod anticoag {
display "-----------------------------------------------------"
display "`var'"

* First, assess the association between the potential mediator and the exposure:
logistic `var' raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2

* Then assess the association between the potential mediator and the outcome, adjusted by the exposure:
logistic exitus `var' raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2
display "------------------------------------------------------"
}


display " Potential mediators observed: oac, immunomod and steroids"


* For each potential mediator, must assess the presence of mediator-outcome confounders:

* oac

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic anticoag  {
display "-----------------------------------------------------"
display "`var'"
logistic `var' oac
logistic exitus `var' oac
display "------------------------------------------------------"
}

display "antipla is a M-O confounder of oac"


* immunomod

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic anticoag  {
display "-----------------------------------------------------"
display "`var'"
logistic `var' immunomod
logistic exitus `var' immunomod
display "------------------------------------------------------"
}

display "no M-O confounders of immunomod observed"


* steroids

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic anticoag  {
display "-----------------------------------------------------"
display "`var'"
logistic `var' steroid
logistic exitus `var' steroid
display "------------------------------------------------------"
}

display "no M-O confounders of steroids observed"


display "The final model when the outcome is death must include anticoagulants, immunomodulators and corticosteroids as mediators as well as antiplatelet drugs as mediator-outcome confounder"


** 1.2. Outcome =  Death + ICU admission
*****************************************


* Consider only descendants of the exposure, thus in-hospital treatments after discontinuaton of RASIs:
foreach var in oac pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic steroid tocilizumab other_immuno immunomod anticoag {
display "-----------------------------------------------------"
display "`var'"
logistic `var' raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2
logistic uci_muerte `var' raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2
display "------------------------------------------------------"
}

display " Potential mediators: oac, tocilizumab, other_immuno,steroids and immunomod"

* For each potential mediator, must assess the presence of mediator-outcome confounders:

* oac:

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic tozilizumab other_immuno steroid immunomod anticoag {
display "-----------------"
display "`var'"
logistic oac `var'
logistic uci_muerte `var' oac
display "------------------"
}

display "Possible M-O confounder: other_immuno"

* tocilizumab: 

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic other_immuno steroid immunomod anticoag {
display "-----------------"
display "`var'"
logistic tozilizumab `var'
logistic uci_muerte `var' tozilizumab
display "------------------"
}

display "Possible M-O confounder: other_immuno, steroids"

* other_immuno:

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic tozilizumab steroid immunomod anticoag {
display "-----------------"
display "`var'"
logistic other_immuno `var'
logistic uci_muerte `var' other_immuno
display "------------------"
}

display "Possible M-O confounder: steroids"


* immunomod:

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic steroid anticoag {
display "-----------------"
display "`var'"
logistic immunomod `var'
logistic uci_muerte `var' immunomod
display "------------------"
}

display "Possible M-O confounder: steroids"

* steroids:

foreach var in pac antipla stat ogld insulin azithro other_antivir macrolid other_antibiotic immunomod anticoag {
display "-----------------"
display "`var'"
logistic steroid `var'
logistic uci_muerte `var' steroid
display "------------------"
}

display "Possible M-O confounder: immunomod"


display "The final model when the outcome is death+ICU must include anticoagulants and immunomodulators  as mediators as well as corticosteroids as mediator-outcome confounder"
 

********************************************************************************************
*** TABLE 1. Baseline characteristics and disease severity markers at admission 
*** of renin-angiotensin system inhibitors users in discontinuation and continuation cohorts
********************************************************************************************

* Table
table1_mc if raas_cont_itt_3d_rev<2, by(raas_cont_itt_3d_rev) vars(sexo cat \ edad conts \ obesidad cat\ smoking cat\ hta cat \ diabetes_2 cat \ dislipemia_2 cat\ iam cat\ insuf cat \ fa cat \tep_tvp cat\ ictus cat\ epoc cat \ asma cat \ cancer_prev cat\ cancer_act cat\ irc cat\ ieca cat \ araii cat \ antiald cat \ aca cat \ diur cat\ beta_bloq cat\ alfa_bloq cat\ aco cat\ antiag cat\ aine cat\ cortic cat\ para cat \ meta cat \ estat cat\ ezet cat\ ado cat \ insulina cat\ hospital_cat cat \ semana_ingreso_3cat2 cat \ pneumonia cat\ hipoxemia_cat cat\ crp_cat2 cat\ troponin_cat2 cat\ d_dimer_cat2 cat\ procalcitonin_cat2 cat\ probnp_cat2 cat\ lympho_cat cat\ severscore_cat cat\ severscore contn)	 

* Standardized difference
stddiff sexo edad obesidad smoking hta diabetes_2 dislipemia_2 iam insuf fa tep_tvp ictus epoc asma cancer_prev cancer_act irc ieca araii antiald aca diur beta_bloq alfa_bloq aco antiag aine cortic para meta estat ezet ado insulina hospital_cat semana_ingreso_3cat2 pneumonia hipoxemia_cat crp_cat2 troponin_cat2 d_dimer_cat2 procalcitonin_cat2 probnp_cat2 lympho_cat severscore_cat severscore if raas_cont_itt_3d_rev<2, by(raas_cont_itt_3d_rev) 


**********************************************************************************************************
*** TABLE 2. In-hospital stay and treatment received according to discontinuation or continuation of RASIs.
**********************************************************************************************************

* Table
table1_mc if raas_cont_itt_3d_rev<2, by(raas_cont_itt_3d_rev) vars(tiempo2 conts\ uci cat\ oac cat\ pac cat\ antipla cat\ stat cat\ ogld cat\ insulin cat\ chloroq cat\ lopi_daru cat\ azithro cat\ macrolid cat\ other_antivir cat\ other_antibiotic cat\ tozilizumab cat\ other_immuno cat\ steroid cat\ aca_3d_ing_2cat cat\ bb_3d_ing_rev cat\ alpha_3d_ing_rev cat\ diur_hc_3d_ing_rev cat\ diur_lc_3d_ing_rev cat) 

* Standardized difference
stddiff tiempo2 uci oac pac antipla stat ogld insulin chloroq lopi_daru azithro macrolid other_antivir other_antibiotic tozilizumab other_immuno steroid aca_3d_ing_2cat bb_3d_ing_rev alpha_3d_ing_rev diur_hc_3d_ing_rev diur_lc_3d_ing_rev if raas_cont_itt_3d_rev<2, by(raas_cont_itt_3d_rev) 


************************************************************************************************************************************************************************
*** TABLE 3. Crude and adjusted hazard ratios of in-hospital death or a composite of death and ICU admission, according to the discontinuation or continuation of 
*** in-hospital of ACEIs and ARBs, either pooling as a group (RASIs) or disaggregated. The category of reference is the continuation of RASIs, ARBs and ACEIs, respectively. 
************************************************************************************************************************************************************************

** RASIs **
***********

** Outcome = Death:
*******************

* Mortality rate
tab exitus raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2, col

* Propensity score (PS) model
logit raas_cont_itt_3d_rev sexo i.edad_cat ib4.hospital_cat##ib1.semana_ingreso2cat i.diabetes_2 obesidad i.dislipemia_2 i.iam i.insuf i.fa i.tep_tvp i.ictus i.epoc i.asma i.cancer i.irc i.aca i.diur i.beta_bloq i.alfa_bloq i.aco i.antiag i.aine i.cortic i.smoking i.severscore_cat i.pneumonia2 i.aca_3d_ing_2cat i.bb_3d_ing_rev i.diur_hc_3d_ing_rev i.diur_lc_3d_ing_rev i.chloroq i.lopi_daru if raas_cont_itt_3d_rev<2

* Predict PS
predict ps_raas3d_cox2 if e(sample)

* Imputation of missing PS
sum ps_raas3d_cox2 if hospital_cat==1 & edad_cat == 5 & sexo == 1
replace ps_raas3d_cox2 = r(mean) if raas_cont_itt_3d_rev <2 & hospital_cat==1 & ps_raas3d_cox2 == .
sum ps_raas3d_cox2 if hospital_cat==5 & edad_cat == 1 & sexo == 1	  
replace ps_raas3d_cox2 = r(mean) if raas_cont_itt_3d_rev <2 & hospital_cat==5 & ps_raas3d_cox2 == .


* Restricted cubic splines with 5 knots accounting for 5th,25th,50th,75th and 95th percentiles of the PS:

* Get percentiles
sum ps_raas3d_cox2, d

* Build the smooth function
mkspline rcs_raas3d_cox2 = ps_raas3d_cox2, cubic knots(0.11,0.31,0.52,0.82,0.95) displayknots


* Survival analysis:

* Set time-to-event and failure variable
stset tiempo2 if raas_cont_itt_3d_rev<2, fail(exitus)

* Unadjusted Cox regression
stcox raas_cont_itt_3d_rev

* PS-adjusted (using restricted cubic splines) Cox regression
stcox raas_cont_itt_3d_rev rcs_raas3d_cox21-rcs_raas3d_cox24

* PS-adjusted, mediators and mediator-outcome confounders adjusted Cox regression
stcox raas_cont_itt_3d_rev  oac antipla immunomod steroid rcs_raas3d_cox21-rcs_raas3d_cox24 

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** Outcome = death + ICU:
*************************

* Mortality rate
tab uci_muerte raas_cont_itt_3d_rev if raas_cont_itt_3d_rev<2, col

* PS are the same as before

* Survival analysis:

* Set time-to-event and failure variable
stset tiempo3 if raas_cont_itt_3d_rev<2, fail(uci_muerte)

* Unadjusted Cox regression
stcox raas_cont_itt_3d_rev

* PS- adjusted (Resctricted cubic splines) Cox regression
stcox raas_cont_itt_3d_rev rcs_raas3d_cox21-rcs_raas3d_cox24

* PS, mediators and mediator-outcome confounders adjusted Cox regression
stcox raas_cont_itt_3d_rev oac immunomod steroid pac rcs_raas3d_cox21-rcs_raas3d_cox24 

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** ARBs** (switchers to ACEI excluded)
*********

** Outcome = Death:
*******************


* Mortality rate
tab exitus araii_cont_itt_3d_rev if ieca==0 & araii_cont_itt_3d_rev <2 & ieca_cont_itt_3d_rev ==1, col

* PS model
logit araii_cont_itt_3d_rev sexo i.edad_cat ib4.hospital_cat##ib1.semana_ingreso2cat i.diabetes_2 obesidad i.dislipemia_2 i.iam i.insuf i.fa i.tep_tvp i.ictus i.epoc i.asma i.cancer i.irc i.aca i.diur i.beta_bloq i.alfa_bloq i.aco i.antiag i.aine i.cortic i.smoking i.severscore_cat i.pneumonia2 i.aca_3d_ing_2cat i.bb_3d_ing_rev i.diur_hc_3d_ing_rev i.diur_lc_3d_ing_rev i.chloroq i.lopi_daru if araii_cont_itt_3d_rev<2 & ieca ==0 & ieca_cont_itt_3d_rev ==1

* Predict PS
predict ps_ara3d_cox2 if e(sample)

* Imputation of missing PS
sum ps_ara3d_cox2 if hospital_cat==1 & edad_cat ==5 & sexo == 1 & ieca==0
replace ps_ara3d_cox2 = r(mean) if araii_cont_itt_3d_rev <2 & hospital_cat==1 & edad_cat ==5 & sexo == 1 & ieca==0 & ps_ara3d_cox2 == . 
replace ps_ara3d_cox2 = 0.99 if araii_cont_itt_3d_rev <2 & hospital_cat==6 & edad_cat ==3 & sexo == 2 & ieca==0 & ps_ara3d_cox2 == . 
replace ps_ara3d_cox2 = 0.99 if araii_cont_itt_3d_rev <2 & hospital_cat==6 & edad_cat ==3 & sexo == 1 & ieca==0 & ps_ara3d_cox2 == . 
replace ps_ara3d_cox2 = 0.99 if araii_cont_itt_3d_rev <2 & hospital_cat==6 & edad_cat ==4 & sexo == 2 & ieca==0 & ps_ara3d_cox2 == . 
replace ps_ara3d_cox2 = 0.99 if araii_cont_itt_3d_rev <2 & hospital_cat==6 & edad_cat ==1 & sexo == 2 & ieca==0 & ps_ara3d_cox2 == . 
replace ps_ara3d_cox2 = 0.99 if araii_cont_itt_3d_rev <2 & hospital_cat==6 & edad_cat ==1 & sexo == 1 & ieca==0 & ps_ara3d_cox2 == . 


* Restricted cubic splines with 5 knots accounting for 5th,25th,50th,75th and 95th percentiles of the PS:

* Get percentiles
sum ps_ara3d_cox2, d

* Build the smooth function
mkspline rcs_ara3d_cox2 = ps_ara3d_cox2, cubic knots(0.07,0.31,0.60,0.90,0.99) displayknots


* Survival analysis:

* Set time-to-event and failure variable
stset tiempo2 if ieca==0 & araii_cont_itt_3d_rev <2 & ieca_cont_itt_3d_rev ==1, fail(exitus)

* Unadjusted Cox regression
stcox araii_cont_itt_3d_rev

* PS adjusted (using restricted cubic splines) Cox regression
stcox araii_cont_itt_3d_rev rcs_ara3d_cox21-rcs_ara3d_cox24

* PS-adjusted, mediators and mediator-outcome confounders adjusted Cox regression
stcox araii_cont_itt_3d_rev oac antipla steroid  immunomod rcs_ara3d_cox21-rcs_ara3d_cox24

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** Outcome = Death+ICU
**********************

* Mortality rate
tab uci_muerte araii_cont_itt_3d_rev if ieca==0 & araii_cont_itt_3d_rev <2 & ieca_cont_itt_3d_rev ==1, col

* PS are the same as before

* Survival analysis:

* Set time-to-event and failure variable
stset tiempo3 if ieca==0 & araii_cont_itt_3d_rev <2 & ieca_cont_itt_3d_rev ==1, fail(uci_muerte)

* Unadjusted Cox regression
stcox araii_cont_itt_3d_rev

* PS- adjusted (Resctricted cubic splines) Cox regression
stcox araii_cont_itt_3d_rev rcs_ara3d_cox21-rcs_ara3d_cox24

* PS, mediators and mediator-outcome confounders adjusted Cox regression
stcox araii_cont_itt_3d_rev oac  immunomod steroid pac rcs_ara3d_cox21-rcs_ara3d_cox24 

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** ACEIs** (switchers to ARBs excluded)
*********

** Outcome = Death:
*******************


* Mortality rate
tab exitus ieca_cont_itt_3d_rev if araii==0 & ieca_cont_itt_3d_rev <2 & araii_cont_itt_3d_rev==1, col

* PS model
logit ieca_cont_itt_3d_rev sexo i.edad_cat ib4.hospital_cat##ib1.semana_ingreso2cat i.diabetes_2 obesidad i.dislipemia_2 i.iam i.insuf i.fa i.tep_tvp i.ictus i.epoc i.asma i.cancer i.irc i.aca i.diur i.beta_bloq i.alfa_bloq i.aco i.antiag i.aine i.cortic i.smoking i.severscore_cat i.pneumonia2 i.aca_3d_ing_2cat i.bb_3d_ing_rev i.diur_hc_3d_ing_rev i.diur_lc_3d_ing_rev i.chloroq i.lopi_daru if araii==0 & ieca_cont_itt_3d_rev <2 & araii_cont_itt_3d_rev==1

* Predict PS
predict ps_ieca3d_cox2 if e(sample)

* Imputation of missing PS
sum ps_ieca3d_cox2 if hospital_cat==5 & edad_cat ==1 & sexo == 1 & araii==0
replace ps_ieca3d_cox2 = r(mean) if ieca_cont_itt_3d_rev <2 & hospital_cat==5 & edad_cat ==1 & ps_ieca3d_cox2 == . & araii==0


* Restricted cubic splines with 5 knots accounting for 5th,25th,50th,75th and 95th percentiles of the PS:

* Get percentiles
sum ps_ieca3d_cox2, d

* Build the smooth function
mkspline rcs_ieca3d_cox2 = ps_ieca3d_cox2, cubic knots(0.08,0.28,0.60,0.87,0.98) displayknots


* Survival analysis:

* Set time-to-event and failure variable
stset tiempo2 if araii==0 & ieca_cont_itt_3d_rev <2 & araii_cont_itt_3d_rev==1, fail(exitus)

* Unadjusted Cox regression
stcox ieca_cont_itt_3d_rev

* PS adjusted (using restricted cubic splines) Cox regression
stcox ieca_cont_itt_3d_rev rcs_ieca3d_cox21-rcs_ieca3d_cox24

* PS-adjusted, mediators and mediator-outcome confounders adjusted Cox regression
stcox ieca_cont_itt_3d_rev oac antipla steroid immunomod rcs_ieca3d_cox21-rcs_ieca3d_cox24

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** Outcome = Death+ICU
**********************

* Mortality rate
tab uci_muerte ieca_cont_itt_3d_rev if araii==0 & ieca_cont_itt_3d_rev <2 & araii_cont_itt_3d_rev==1, col

* PS are the same as before

* Survival analysis:

* Set time-to-event and failure variable
stset tiempo3 if araii==0 & ieca_cont_itt_3d_rev <2 & araii_cont_itt_3d_rev==1, fail(uci_muerte)

* Unadjusted Cox regression
stcox ieca_cont_itt_3d_rev

* PS- adjusted (Resctricted cubic splines) Cox regression
stcox ieca_cont_itt_3d_rev rcs_ieca3d_cox21-rcs_ieca3d_cox24

* PS, mediators and mediator-outcome confounders adjusted Cox regression
stcox ieca_cont_itt_3d_rev oac immunomod steroid pac rcs_ieca3d_cox21-rcs_ieca3d_cox24 

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail



************************************************************************************************************************************************************************
*** TABLE 4. Head-to-head comparison of patients who continued treatment with angiotensin receptor blockers with patients who 
*** continued treatment with angiotensin converting enzyme inhibitors. 
************************************************************************************************************************************************************************

** Outcome = Death:
*******************

* Generate a new variable to include ARBs continuers and ACEIs continuers, excluding switchers
gen ieca_ara_cont3d_2 = 0 if ieca==0 & araii_cont_itt_3d_rev==0 & ieca_cont_itt_3d_rev==1
recode ieca_ara_cont3d_2 .=1 if araii==0 & ieca_cont_itt_3d_rev==0 & araii_cont_itt_3d_rev==1
label var ieca_ara_cont3d_2 "0:ARBcont, 1:ACEIcont"
label define ieca_ara_cont3d_2 0"ARBcont"1"ACEIcont"
label values ieca_ara_cont3d_2 ieca_ara_cont3d_2

* Mortality rate
tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2 <., col chi exact

* PS model
logit ieca_ara_cont3d sexo i.edad_cat ib4.hospital_cat##ib1.semana_ingreso2cat i.diabetes_2 obesidad i.dislipemia_2 i.iam i.insuf i.fa i.tep_tvp i.ictus i.epoc i.asma i.cancer i.irc i.aca i.diur i.beta_bloq i.alfa_bloq i.aco i.antiag i.aine i.cortic i.smoking i.severscore_cat i.pneumonia2 i.aca_3d_ing_2cat i.bb_3d_ing_rev i.diur_hc_3d_ing_rev i.diur_lc_3d_ing_rev i.chloroq i.lopi_daru if ieca_ara_cont3d <.

* Predict PS
predict ps_ieca_ara_cont3d_cox2 if e(sample)

* Imputation of missing PS
sum ps_ieca_ara_cont3d_cox2 if hospital_cat==1 & edad_cat ==5 & sexo == 1 & ieca_ara_cont3d <.
replace ps_ieca_ara_cont3d_cox2 = r(mean) if hospital_cat==1 & edad_cat ==5 & sexo == 1 & ieca_ara_cont3d <. & ps_ieca_ara_cont3d_cox2 == . 

sum ps_ieca_ara_cont3d_cox2 if hospital_cat==5 & edad_cat ==1 & sexo == 1 & ieca_ara_cont3d <.
replace ps_ieca_ara_cont3d_cox2 = r(mean) if hospital_cat==5 & edad_cat ==1 & sexo == 1 & ieca_ara_cont3d <. & ps_ieca_ara_cont3d_cox2 == . 

sum ps_ieca_ara_cont3d_cox2 if hospital_cat==6 & edad_cat ==3 & sexo == 1 & ieca_ara_cont3d <.
replace ps_ieca_ara_cont3d_cox2 = r(mean) if hospital_cat==6 & edad_cat ==3 & sexo == 1 & ieca_ara_cont3d <. & ps_ieca_ara_cont3d_cox2 == . 

* Restricted cubic splines with 5 knots accounting for 5th,25th,50th,75th and 95th percentiles of the PS:

* Get percentiles
sum ps_ieca_ara_cont3d_cox2, d

* Build the smooth function
mkspline rcs_ieca_ara_cont3d_cox2 = ps_ieca_ara_cont3d_cox2, cubic knots(0.06,0.21,0.47,0.72,0.95) displayknots

* Survival analysis:

* Set time-to-event and failure variable
stset tiempo2 if ieca_ara_cont3d_2 <., fail(exitus)

* Unadjusted Cox regression
stcox ib1.ieca_ara_cont3d_2

* PS- adjusted (Resctricted cubic splines) Cox regression
stcox ib1.ieca_ara_cont3d_2 rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24

* PS, mediators and mediator-outcome confounders adjusted Cox regression
stcox ib1.ieca_ara_cont3d_2 oac  antipla  steroid  immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


** Outcome = Death+ICU
**********************

* Mortality rate
tab uci_muerte ieca_ara_cont3d_2 if ieca_ara_cont3d_2 <., col

* PS are the same as before

* Survival analysis:

* Set time-to-event and failure variable
stset tiempo3 if ieca_ara_cont3d_2 <., fail(uci_muerte)

* Unadjusted Cox regression
stcox ib1.ieca_ara_cont3d_2

* PS- adjusted (Resctricted cubic splines) Cox regression
stcox ib1.ieca_ara_cont3d_2 rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24

* PS, mediators and mediator-outcome confounders adjusted Cox regression
stcox ib1.ieca_ara_cont3d_2 oac  pac  steroid  immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24

* Test proportional hazards assumption (Schoenfeld residuals test)
estat phtest, detail


*****************************************************************************************************************************************
*** FIGURE 2. Switching from RASIs to CCBs, other antihypertensive drugs (OADs) or no antihypertensive treatment during the first 3 days 
*** since hospital admission (patients with uncertain discontinuation were excluded).
*****************************************************************************************************************************************

* Generate new indicator variable
gen rasi_at_admission = 1 if raas_inh==1 & (aca==0 & diur==0 & beta_bloq==0 & alfa_bloq ==0)
recode rasi_at_admission .= 0
recode rasi_at_admission 0=2 if aca==1
recode rasi_at_admission 0=3 if aca==0
label define rasi_at_admission 1"RASI alone"2"RASI+aca(+others)"3"RASI+others"
label values rasi_at_admission rasi_at_admission

* Switch from RASI alone to RASI alone (n=65)
keep if rasi_at_admission==1

tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI alone to RASi+CCB (n=5)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1  & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI alone to RASi+OADs (n=2)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI alone to CCB (+OADs) (n=33)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1 & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI alone to OADs alone (n=2)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI alone to no treatment (n=62)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==1 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to RASI alone (n=22)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to RASI+CCB (n=51)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1  & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to RASI+OADs (n=8)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to CCB (+OADs) (n=71)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1 & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to OADs alone (n=8)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+CCB (+OADs) to no treatment (n=36)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==2 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to RASI alone (n=43)
keep if rasi_at_admission==3

tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==3 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to RASI+CCB (n=14)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1  & rasi_at_admission==3 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to RASI+OADs (n=75)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==3 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to CCB (+OADs) (n=27)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==1 & rasi_at_admission==3 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to OADs alone (n=41)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==1 & rasi_at_admission==3 & raas_cont_itt_3d_rev<2

* Switch from RASI+OADs to no treatment (n=60)
tab raas_cont_itt_3d_rev rasi_at_admission if aca_3d_ing_2cat ==0 & other_anti_hta3d_nodiurhc==0 & rasi_at_admission==3 & raas_cont_itt_3d_rev<2


* Excel graph data file: "Figure_2_Sankey.xlsx"


*****************************************************************************************************************************************
*** FIGURE 3. Kaplan-Meier survival curves of in-hospital death among patients in whom treatment with ARBs was continued as compared 
*** to those in whom ACEIs was continued (defined in the first 3-days window).
*****************************************************************************************************************************************

* Generate new indicator variable
gen rasi_ieca_ara_km = ieca_ara_cont3d
recode rasi_ieca_ara_km 0=1 1=2
recode rasi_ieca_ara_km . = 0 if raas_cont_itt_3d_rev ==1	
label var rasi_ieca_ara_km "0:rasi disc, 1:ieca_cont,2:ara_cont"

* Kaplan-Meier
stset tiempo2 if ieca_ara_cont3d_2 <., fail(exitus)
sts graph, by(ieca_ara_cont3d_2) tmax(30) risktable

* Graph File: "km_ieca_ara_cont_f.gph"


*****************************************************************************************************************************************
*** FIGURE 4 Head-to-head comparison of continuation with angiotensin receptor blockers vs. continuation with angiotensin 
*** converting enzyme inhibitors, by different subgroups. 
*****************************************************************************************************************************************

** File: "figura_ACEIcon_ARBcont_sin_switch.csv"
** R-Studio code file: "Figure_4_Foresplot.R"


* By gender

bysort sexo: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stset tiempo2 if ieca_ara_cont3d <., fail(exitus)
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if sexo==1	  
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if sexo==2	  

* By age

bysort edad_cat4: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if edad_cat4==1	  
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if edad_cat4==2	

* By obesity

bysort obesidad: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if obesidad==0
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if obesidad==1	

* By diabetes:

bysort diabetes_2: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if diabetes_2==0	
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if diabetes_2==1	

* By heart failure

bysort insuf: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if insuf==0		
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if insuf==1	

* By CV_risk

bysort cv_risk: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if cv_risk==2		
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if cv_risk==3	

* By severity score

bysort severscore_2cat: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if severscore_2cat==0	
stcox ib1.ieca_ara_cont3d_2 oac antipla steroid immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if severscore_2cat==1	

* In-hospital use of corticosteroids

bysort steroid: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac antipla immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if steroid==0	
stcox ib1.ieca_ara_cont3d_2 oac antipla immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if steroid==1	

* In-hospital use of beta blockers:

bysort bb_3d_ing_rev: tab exitus ieca_ara_cont3d_2 if ieca_ara_cont3d_2<., col
stcox ib1.ieca_ara_cont3d_2 oac steroid antipla immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if bb_3d_ing_rev==0	
stcox ib1.ieca_ara_cont3d_2 oac steroid antipla immunomod rcs_ieca_ara_cont3d_cox21-rcs_ieca_ara_cont3d_cox24 if bb_3d_ing_rev==1	
























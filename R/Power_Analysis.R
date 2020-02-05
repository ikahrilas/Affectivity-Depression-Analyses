### Power Analyses for Mediation Model

library(bmem) ### install.packages("bmem")

# model specification

sad_model_power <- 'phq_total ~ cp*masq_pa + start(-.16)*masq_pa
                    phq_total ~ cn*masq_na + start(.49)*masq_na
                    reminiscing ~ a1*masq_pa + start(.39)*masq_pa
                    savoring_moment ~ a2*masq_pa + start(.46)*masq_pa
                    anticipating ~ a3*masq_pa + start(.41)*masq_pa
                    phq_total ~ b1*reminiscing + start(.01)*reminiscing
                    phq_total ~ b2*savoring_moment + start(-.07)*savoring_moment
                    phq_total ~ b3*anticipating + start(.01)*anticipating
                    reminiscing ~ ai*masq_na + start(-.16)*masq_na
                    savoring_moment ~ aii*masq_na + start(-.28)*masq_na
                    anticipating ~ aiii*masq_na + start(-.11)*masq_na
                    masq_pa ~~ start(-.41)*masq_na
                    anticipating ~~ start(.55)*savoring_moment + start(.64)*reminiscing
                    savoring_moment ~~ start(.58)*reminiscing
                    masq_pa ~~ start(1)*masq_pa
                    masq_na ~~ start(1)*masq_na
                    reminiscing ~~ start(1)*reminiscing
                    savoring_moment ~~ start(1)*savoring_moment
                    anticipating ~~ start(1)*anticipating
                    phq_total ~~ start(1)*phq_total
'

# mediation paths

mediation <- "pa_rem := a1*b1
              pa_mom := a2*b2
              pa_ant := a3*b3
              na_rem := ai*b1
              na_mom := aii*b2
              na_ant := aiii*b3
"

# power analysis

power_results <- bmem::power.boot(model = sad_model_power, 
                                  indirect = mediation, 
                                  nobs = 1618, # run with 2122
                                  parallel = "snow")

power_results_min <- bmem::power.boot(model = sad_model_power, 
                                      indirect = mediation, 
                                      nobs = 3500,
                                      parallel = "multicore",
                                      ncore = 8)

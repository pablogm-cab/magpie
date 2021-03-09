*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s35_shift number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 i35_secdforest(j,ac)							              Inital secdforest (mio. ha)
 i35_other(j,ac)								                Inital other land (mio. ha)
 p35_secdforest(t,j,ac)  	                      Secdforest per age class (mio. ha)
 p35_other(t,j,ac)   	  	                      Other land per age class (mio. ha)
 pc35_secdforest(j,ac)    	                    Secdforest per age class in current time step (mio. ha)
 pc35_other(j,ac)   	  	                      Other land per age class in current time step (mio. ha)
 p35_protect_shr(t,j,prot_type)                 Protection share for primforest secdforest and other land (1)
 p35_save_primforest(t,j) 		                  Primforest protection (mio. ha)
 p35_save_secdforest(t,j)		                    Secdforest protection (mio. ha)
 p35_save_other(t,j)			                      Other land protection (mio. ha)
 p35_recovered_forest(t,j,ac) 	                Recovered forest (mio. ha)
 p35_min_forest(t,j) 			                      Minimum forest stock [land protection policies] (Mha)
 p35_min_other(t,j)      		                    Minimum other land stock [land protection policies] (Mha)
 p35_carbon_density_secdforest(t,j,ac,ag_pools) Carbon density secdforest (tC per ha)
 p35_carbon_density_other(t,j,ac,ag_pools) 	    Carbon density other land (tC per ha)
 p35_disturbance_loss_secdf(t,j,ac)                 Loss due to disturbances in secondary forest (mio. ha)
 p35_disturbance_loss_primf(t,j)                   Loss due to disturbances in primary forest (mio. ha)
 i35_plantedclass_ac(j,ac)                       Area of age-classes in secondary forest (1)
 p35_poulter_dist(j,ac)                          Share of age-classes in secondary forest (1)
 p35_save_dist(j,ac)                             Distribution of secondary forest saving (1)
 p35_land(t,j,land_natveg,ac)                    Natural vegetation area (mio. ha)
 p35_updated_gs_natfor(t,i)                      Updated growing stock in natural forests after calibration (m3 per ha)
 p35_land_start_ac(j,ac,land_natveg)             Initial Natural vegetation area (mio. ha)
 p35_observed_gs_reg(i)                          Observed growing stock in natural forests before calibration (m3 per ha)
 p35_gs_scaling_reg(i)                           Regional calibration factors for natural vegetation yields (1)
;

equations
 q35_land_secdforest(j)       		              Secdforest land pool calculation (mio. ha)
 q35_land_other(j)       		                    Other land pool calculation (mio. ha)
 q35_carbon_primforest(j,ag_pools)              Primforest carbon stock calculation (mio tC)
 q35_carbon_secdforest(j,ag_pools)              Secdforest carbon stock calculation (mio tC)
 q35_carbon_other(j,ag_pools)      	            Other land carbon stock calculation (mio tC)
 q35_landdiff              			                Difference in natveg land (mio. ha)
 q35_other_expansion(j,ac)		                  Other land expansion (mio. ha)
 q35_other_reduction(j,ac)		                  Other land reduction (mio. ha)
 q35_secdforest_expansion(j,ac)                 Secdforest reduction (mio. ha)
 q35_secdforest_reduction(j,ac)                 Secdforest reduction (mio. ha)
 q35_primforest_reduction(j)   	                Primforest reduction (mio. ha)
 q35_min_forest(j)					                    Minimum forest land constraint (mio. ha)
 q35_min_other(j)                               Minimum other land constraint (mio. ha)
 q35_secdforest_conversion(j)                   Secondary forest remains secondary forest (mio. ha)
 q35_other_conversion(j)                        Other land remains secondary forest (mio. ha)
 q35_other_est(j,ac)                        	  Distribution of other land additions over ac_est (mio. ha)
 q35_secdforest_est(j,ac)                    	  Distribution of secdforest additions over ac_est (mio. ha)
 q35_hvarea_other(j,ac)							            Harvested area other land (mio. ha)
 q35_hvarea_secdforest(j,ac)					          Harvested area secdforest (mio. ha)
 q35_hvarea_primforest(j)						            Harvested area primforest (mio. ha)
 q35_prod_secdforest(j)                                                   Production of woody biomass from secondary forests (mio. tDM per yr)
 q35_prod_primforest(j)                                                      Production of woody biomass from primary forests (mio. tDM per yr)
 q35_prod_other(j)                                                        Production of woody biomass from other land (mio. tDM per yr)
 q35_cost_hvarea(i) blub
 q35_bv_primary(j,potnatveg)                  Biodiversity value of primary forest (Mha)
 q35_bv_secondary(j,potnatveg)                Biodiversity value of secondary vegetation (Mha)

;

positive variables
  v35_secdforest(j,ac)                          Detailed stock of secdforest (mio. ha)
  v35_other(j,ac)                               Detailed stock of other land (mio. ha)
  vm_landdiff_natveg                            Aggregated difference in natveg land compared to previous timestep (mio. ha)
  v35_other_expansion(j,ac)                     Other land expansion compared to previous timestep (mio. ha)
  v35_other_reduction(j,ac)                     Other land reduction compared to previous timestep (mio. ha)
  v35_secdforest_expansion(j,ac)                Secdforest reduction compared to previous timestep (mio. ha)
  v35_secdforest_reduction(j,ac)                Secdforest reduction compared to previous timestep (mio. ha)
  v35_primforest_reduction(j)                   Primforest reduction compared to previous timestep (mio. ha)
  v35_hvarea_secdforest(j,ac)                    Harvested area from secondary forest (mio. ha)
  v35_hvarea_other(j,ac)                         Harvested area from other land (mio. ha)
  v35_hvarea_primforest(j)                       Harvested area from primary forest (mio. ha)
  vm_prod_natveg(j,land_natveg,kforestry)       Production of woody biomass from natural vegetation (mio. tDM per yr)
 vm_cost_hvarea_natveg(i)						blub
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_secdforest(t,j,ac,type)                   Detailed stock of secdforest (mio. ha)
 ov35_other(t,j,ac,type)                        Detailed stock of other land (mio. ha)
 ov_landdiff_natveg(t,type)                     Aggregated difference in natveg land compared to previous timestep (mio. ha)
 ov35_other_expansion(t,j,ac,type)              Other land expansion compared to previous timestep (mio. ha)
 ov35_other_reduction(t,j,ac,type)              Other land reduction compared to previous timestep (mio. ha)
 ov35_secdforest_expansion(t,j,ac,type)         Secdforest reduction compared to previous timestep (mio. ha)
 ov35_secdforest_reduction(t,j,ac,type)         Secdforest reduction compared to previous timestep (mio. ha)
 ov35_primforest_reduction(t,j,type)            Primforest reduction compared to previous timestep (mio. ha)
 ov35_hvarea_secdforest(t,j,ac,type)            Harvested area from secondary forest (mio. ha)
 ov35_hvarea_other(t,j,ac,type)                 Harvested area from other land (mio. ha)
 ov35_hvarea_primforest(t,j,type)               Harvested area from primary forest (mio. ha)
 ov_prod_natveg(t,j,land_natveg,kforestry,type) Production of woody biomass from natural vegetation (mio. tDM per yr)
 ov_cost_hvarea_natveg(t,i,type)                blub
 oq35_land_secdforest(t,j,type)                 Secdforest land pool calculation (mio. ha)
 oq35_land_other(t,j,type)                      Other land pool calculation (mio. ha)
 oq35_carbon_primforest(t,j,ag_pools,type)      Primforest carbon stock calculation (mio tC)
 oq35_carbon_secdforest(t,j,ag_pools,type)      Secdforest carbon stock calculation (mio tC)
 oq35_carbon_other(t,j,ag_pools,type)           Other land carbon stock calculation (mio tC)
 oq35_landdiff(t,type)                          Difference in natveg land (mio. ha)
 oq35_other_expansion(t,j,ac,type)              Other land expansion (mio. ha)
 oq35_other_reduction(t,j,ac,type)              Other land reduction (mio. ha)
 oq35_secdforest_expansion(t,j,ac,type)         Secdforest reduction (mio. ha)
 oq35_secdforest_reduction(t,j,ac,type)         Secdforest reduction (mio. ha)
 oq35_primforest_reduction(t,j,type)            Primforest reduction (mio. ha)
 oq35_min_forest(t,j,type)                      Minimum forest land constraint (mio. ha)
 oq35_min_other(t,j,type)                       Minimum other land constraint (mio. ha)
 oq35_secdforest_conversion(t,j,type)           Secondary forest remains secondary forest (mio. ha)
 oq35_other_conversion(t,j,type)                Other land remains secondary forest (mio. ha)
 oq35_other_est(t,j,ac,type)                    Distribution of other land additions over ac_est (mio. ha)
 oq35_secdforest_est(t,j,ac,type)               Distribution of secdforest additions over ac_est (mio. ha)
 oq35_hvarea_other(t,j,ac,type)                 Harvested area other land (mio. ha)
 oq35_hvarea_secdforest(t,j,ac,type)            Harvested area secdforest (mio. ha)
 oq35_hvarea_primforest(t,j,type)               Harvested area primforest (mio. ha)
 oq35_prod_secdforest(t,j,type)                 Production of woody biomass from secondary forests (mio. tDM per yr)
 oq35_prod_primforest(t,j,type)                 Production of woody biomass from primary forests (mio. tDM per yr)
 oq35_prod_other(t,j,type)                      Production of woody biomass from other land (mio. tDM per yr)
 oq35_cost_hvarea(t,i,type)                     blub
 oq35_bv_primary(t,j,potnatveg,type)            Biodiversity value of primary forest (Mha)
 oq35_bv_secondary(t,j,potnatveg,type)          Biodiversity value of secondary vegetation (Mha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

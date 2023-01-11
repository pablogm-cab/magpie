*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* choosing between regional (+time dependent) or global (from 2005) factor requirements
$if "%c38_fac_req%" == "glo" i38_fac_req(t,i,kcr) = f38_fac_req(kcr);
$if "%c38_fac_req%" == "reg" i38_fac_req(t,i,kcr) = f38_fac_req_fao_reg(t,i,kcr);

if (m_year(t)<=1995,
 i38_fac_req(t,i,kcr) = i38_fac_req("y1995",i,kcr);
elseif m_year(t)>=2010,
 i38_fac_req(t,i,kcr) = i38_fac_req("y2010",i,kcr);
else
 i38_fac_req(t,i,kcr) = i38_fac_req(t,i,kcr);
);

p38_labor_need(t,i,kcr) = i38_fac_req(t,i,kcr)  * pm_cost_share_crops(t,i,"labor");
p38_capital_need(t,i,kcr,"mobile") = i38_fac_req(t,i,kcr) * pm_cost_share_crops(t,i,"capital") / (pm_interest(t,i)+s38_depreciation_rate) * (1-s38_immobile);
p38_capital_need(t,i,kcr,"immobile") = i38_fac_req(t,i,kcr)  * pm_cost_share_crops(t,i,"capital") / (pm_interest(t,i)+s38_depreciation_rate) * s38_immobile;

*** Variable labor costs BEGIN

* set bounds for labor requirements (in terms of hours worked per output unit)
v38_laborhours_need.lo(j,kcr) = 0.1 * (sum(cell(i,j),p38_labor_need(t,i,kcr)) / sum(cell(i,j), pm_hourly_costs(t,i,"baseline")));
v38_laborhours_need.l(j,kcr) = sum(cell(i,j),p38_labor_need(t,i,kcr)) / sum(cell(i,j), pm_hourly_costs(t,i,"baseline"));
v38_laborhours_need.up(j,kcr) = 10 * (sum(cell(i,j),p38_labor_need(t,i,kcr))  / sum(cell(i,j), pm_hourly_costs(t,i,"baseline")));

* set bounds for captial requirements
if (m_year(t) <= s38_startyear_labor_substitution,
    v38_capital_need.fx(j,kcr,mobil38) = sum(cell(i,j),p38_capital_need(t,i,kcr,mobil38));
else 
    v38_capital_need.lo(j,kcr,mobil38) = 0.1*sum(cell(i,j),p38_capital_need(t,i,kcr,mobil38));
    v38_capital_need.l(j,kcr,mobil38) = sum(cell(i,j),p38_capital_need(t,i,kcr,mobil38));
    v38_capital_need.up(j,kcr,mobil38) = 10 * sum(cell(i,j),p38_capital_need(t,i,kcr,mobil38));
);

* update CES parameters
i38_ces_shr(j,kcr) = sum(cell(i,j), (p38_intr_depr(t,i) * sum(mobil38, v38_capital_need.l(j,kcr,mobil38))**(1 + s38_ces_elast_par)) / (p38_intr_depr(t,i) * sum(mobil38, v38_capital_need.l(j,kcr,mobil38))**(1 + s38_ces_elast_par) + pm_hourly_costs(t,i,"baseline") * v38_laborhours_need.l(j,kcr)**(1 + s38_ces_elast_par)));
i38_ces_scale(j,kcr) = sum(cell(i,j), 1/([i38_ces_shr(j,kcr) * sum(mobil38, v38_capital_need.l(j,kcr,mobil38))**(-s38_ces_elast_par) + (1 - i38_ces_shr(j,kcr)) * v38_laborhours_need.l(j,kcr)**(-s38_ces_elast_par)]**(-1/s38_ces_elast_par)));

* minimum labor share based on target and adjustment factor
if (m_year(t) < s38_startyear_labor_substitution,
  p38_min_labor_share(t,i) = 0;
elseif m_year(t) <= 2050,
  p38_min_labor_share(t,i) = max(pm_cost_share_crops(t,i,"labor"), pm_cost_share_crops(t,i,"labor") + 
                            ((m_year(t)-s38_startyear_labor_substitution)/(2050-s38_startyear_labor_substitution) *
                             (s38_target_fullfilment * (s38_target_labor_share - pm_cost_share_crops("y2050",i,"labor")))));
else 
  p38_min_labor_share(t,i)$(pm_cost_share_crops("y2050",i,"labor") <= s38_target_labor_share) =  p38_min_labor_share("y2050",i);
  p38_min_labor_share(t,i)$(pm_cost_share_crops("y2050",i,"labor") > s38_target_labor_share)  =  max(pm_cost_share_crops(t,i,"labor"), s38_target_labor_share);
);

* overwrite with 0 in case target labor share is 0 (i.e. off)
if (s38_target_labor_share = 0,
  p38_min_labor_share(t,i) = 0;
);

*** Variable labor costs END

if (ord(t) = 1,

*' Estimate capital stock based on capital remuneration. We assume that in 1994 and 1995 production is the same and the stocks gets depreciated from 1994.
  p38_capital_immobile(t,j,kcr)    = sum(cell(i,j), p38_capital_need(t,i,kcr,"immobile")*pm_prod_init(j,kcr))*(1-s38_depreciation_rate);
  p38_capital_mobile(t,j)    = sum((cell(i,j),kcr), p38_capital_need(t,i,kcr,"mobile")*pm_prod_init(j,kcr))*(1-s38_depreciation_rate);

else

*' Update of existing stocks

    p38_capital_immobile(t,j,kcr)=p38_capital_immobile(t,j,kcr)*(1-s38_depreciation_rate)**(m_timestep_length);
    p38_capital_mobile(t,j)=p38_capital_mobile(t,j)*(1-s38_depreciation_rate)**(m_timestep_length);

    );

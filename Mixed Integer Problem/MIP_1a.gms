$ontext
Irrigation Mixed Integer Problem
CEE 6410/5410
Ammon Wallace
October 14, 2026

This problem is taken from chapter 7 in Bishop, A Bruce; Hughes, Trevor; and McKee, Mac, "Water Resources Systems Analysis - Course Notes"
(1999). All ECSTATIC Materials. Paper 76.
https://digitalcommons.usu.edu/ecstatic_all/76Learning objectives.

A farmer plans to develop water for irrigation. He is considering two possible sources of
water: a gravity diversion from a possible reservoir with two alternative capacities and/or a
pump from a lower river diversion (refer to Figure 7.3). Between the reservoir and pump
site the river base flow increases by 2 acft/day due to groundwater drainage into the river.
Ignore losses from the reservoir. The river flow into the reservoir and the farmer's demand
during each of two six-month seasons of the year are given in Table 7.5. Revenue is esti-
mated at $300 per year per acre irrigated.

Season, t       River Inflow,       Qt (acft) Irrigation Demand (acft/acre)
    1               600                             1.0
    2               200                             3.0

Assume that there are only two possible sizes of reservoir: a high dam that has capacity of
700 acft or a low dam with capacity of 300 acft. The capital costs are $10,000/year and
$6,000/year for the high and low dams, respectively (no operating cost). The pump capac-
ity is fixed at 2.2 acft/day with a capital cost (if it is built) of $8,000/year and operating cost
of $20/acft.


Ammon Wallace
ammon.wallace@usu.edu
$offtext

Sets
loc The location of water /Res, River, Farm, Pump/
source Different sources to choose from /High_dam, Low_dam, Pump/
t The irrigation season /1, 2/;

Parameters
river_gain The river base flow increase due to groundwater  (acft per day) /2/
unit_rev The revenue per acre irrigated in dollars /300/    
river_inflow(t) The river inflow for each season (acft) /1 600, 2 200/
irr_demand(t) The irrigation demand (acft per acre) for each season /1 1.0, 2 3.0/
Capacity(source) The capacity of each source (acft) and (acft per day) for pump /High_dam 700, Low_dam 300, Pump 2.2/
Cost(source) The cost of each dam in dollars per year /High_dam 10000, Low_dam 6000, Pump 8000/
Operating_cost_pump The operating cost of the pump in dollars per acft /20/
days_in_season the number of days in a 6 month season /182.5/
res_storage_init The initial res storage (ac-ft) /0/;

Variables
I(source) binary decision variable for each source
TPROFIT total profit gained
X(loc, t) How much water to send to each location for each season (ac-ft)
A Number of Acres to plant;

Binary Variables
I(source);

Positive Variables
X(loc,t)
S(t)
A;
    
Equations
Objective The objective function
Mass_balance_res(t) The mass balance constraint at the reservoir
Mass_balance_pump(t) The mass balance constraint at the pump
Dam_capacity(t) The dam capacity constraint
Pump_capacity(t) The pump capacity constraint
Mutually_exclusive_dams The constraint that only 1 dam will be decided
Irrigation_demand(t) The irrigation demand from number of acres planted;


Objective.. A*unit_rev - sum(source, I(source)*Cost(source)) - sum(t, X('Pump',t)*Operating_cost_pump) =E= TPROFIT;
Mutually_exclusive_dams.. I('High_dam')+I('Low_dam') =L= 1;
Dam_capacity(t).. X('Res',t) =L= Capacity('High_dam')*I('High_dam') + Capacity('Low_dam')*I('low_dam');
Mass_balance_res(t).. X('Res',t) =E= (res_storage_init$(ord(t) eq 1)) +
                      (X('Res',t-1)$(ord(t) gt 1)) + river_inflow(t) - X('River', t) - X('Farm', t);
Pump_capacity(t).. X('Pump',t) =L= days_in_season*capacity('Pump')*I('Pump');
Mass_balance_pump(t).. X('Pump',t) =L= X('River',t) + river_gain*days_in_season;
Irrigation_demand(t).. X('Farm',t) + X('Pump',t) =E= A * irr_demand(t);

Model Seasons /All/;

Solve Seasons using MIP maximizing TPROFIT;

Display X.L, TPROFIT.L, A.L, I.L;

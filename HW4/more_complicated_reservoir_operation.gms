$onText
Resevoir Operation Problem

Taken from:
HW4-MoreComplicatedLinearProgram.docx
USU CEE 6410
Dr. Rosenberg

A reservoir is designed to provide hydropower and water for irrigation. The turbine releases may
also be used for irrigation as shown in Figure 1. At least one unit of water must be kept in the
river each month at point A. The hydropower turbines have a capacity of 4 units of water per
month (flows are constant during any single month), and any other releases must bypass the tur-
bines. The size of farmed area is very large relative to the amount of irrigation water available, so
there is no upper limit on usable irrigation water. The reservoir has a capacity of 9 units, and initial
storage is 5 units of water. The ending storage must be equal to or greater than the beginning
storage. The benefits per unit of water, and the estimated average inflows to the reservoir are given
in Table 1.

                                Table 1
Month | Inflow Units | Hydropower Benefits ($/unit) | Irrigation Benefits ($/unit)
1           2                   1.6                              1.0
2           2                   1.7                              1.2
3           3                   1.8                              1.9
4           4                   1.9                              2.0
5           3                   2.0                              2.2
6           2                   2.0                              2.2


Ammon Wallace
CEE 6410
ammon.wallace@usu.edu
$offText

* 1. Define the Sets
Sets
t  Months in increaseing order /mon1 * mon6/
loc Location in the Network /Hydro, Res, Spill, Irr, River/;

    
* 2. Define Input Data
Parameters
    hydropower_b(t) Hydropower Benefits Coeffiecients ($ per unit)
    /mon1 1.6,
    mon2 1.7,
    mon3 1.8,
    mon4 1.9,
    mon5 2.0,
    mon6 2.0/
    
    irrigation_b(t) Irrigation Benefits Coeffiecients ($ per unit)
    /mon1 1.0,
    mon2 1.2,
    mon3 1.9,
    mon4 2.0,
    mon5 2.2,
    mon6 2.2/
    
    inflow(t) Inflow input data (units)
    /mon1 2,
    mon2 2,
    mon3 3,
    mon4 4,
    mon5 3,
    mon6 2/
    
    max_capacity_hydro Hydropower Capacity (units per month) /4/
    river_minimum_flow Minimum river amount (units per month) /1/
    res_init_storage inital reservoir storage (units) /5/
    res_max_storage the max capacity of the reservoir (units) /9/;
 
* 3. Define Variables   
Positive Variables
    X(loc, t) Decision Variables for location of water in the network for each month;
    
Variables
    total_benefits the total amount of profit ($);


* 4. Define equations
Equations
    Profit Objective Function
    Res_capacity(t) Maximum Reservoir Capacity
    River_min_capacity(t) Minimum river capacity
    Turbine_capacity(t) Maximum Turbine capacity
    Ending_Storage Ending storage must be greater than initial storage
    Res_mass_balance(t) Mass balance equation for the reservoir
    Junction_mass_balance(t) Mass balance equation for the junction;

* Objective Function
Profit.. total_benefits =E= sum(t, hydropower_b(t)*X("Hydro", t)) + sum(t, irrigation_b(t)*X("Irr", t));


* Constrain Equations
Res_capacity(t).. X("Res",t) =L= res_max_storage;
River_min_capacity(t).. X("River", t) =G= river_minimum_flow;
Turbine_capacity(t).. X("Hydro", t) =L= max_capacity_hydro;
Ending_Storage.. X("Res", "mon6") =G= res_init_storage;
Res_mass_balance(t).. inflow(t) - X("Hydro",t) - X("Spill",t) =E= X("Res",t) - res_init_storage$(ord(t) eq 1)  - X("Res",t-1)$(ord(t) gt 1);
Junction_mass_balance(t).. X("Spill", t) + X("Hydro", t) - X("Irr", t) =E= X("River", t);

* 5. Create the model using all of the defined equations
Model Reservoir /all/;


* 6. Solve the model and create a .lst file
Solve Reservoir using LP maximing total_benefits;
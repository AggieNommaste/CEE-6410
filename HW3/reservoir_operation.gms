$onText
Resevoir Operation Problem

Taken from:
HW3-LinearProgramingInGAMS.docx
USU CEE 6410
Dr. Rosenberg

A reservoir is designed to provide water for irrigation. The reservoir has a capacity of 9,000 acre-
feet. Initial storage is 3,000 acre-feet of water. The size of the diversion canal and farmed area is
very large relative to the amount of irrigation water available, so there is no upper limit on usable
irrigation water. Any water above the reservoir capacity must be released to the river (spill). The
ending storage must be equal to or greater than the beginning storage. The benefits per unit of
water, and the estimated inflows to the reservoir in 3 months are given in Table 1. What is the
diversion schedule that maximizes benefits?

Month   |   Inflow (acre-ft)   | Irrigation Benefits ($/acre-ft)

June   |         5,000         |    150
July   |         3,200         |    170
August |         2,000         |    425


Ammon Wallace
CEE 6410
ammon.wallace@usu.edu
$offText

* 1. Define the Sets
Sets
t Time of Month /June, July, August/
loc Location in the Network /Div, Res, Spill/;


* 2. Define Input Data
Parameters
    c(t) Objective Function Coeffiecients ($ per ac-ft)
    /June 150, July 170, August 425/
    
    inflow(t) Inflow input data (ac-ft)
    /June 5000, July 3200, August 2000/
    
    init_storage inital reservoir storage /3000/
    max_storage the max capacity of the reservoir/9000/;
 
* 3. Define Variables   
Positive Variables
    X(loc, t) Decision Variables for location of water in the network for each month;
    
Variables
    total_benefits the total amount of profit ($);


* 4. Define equations
Equations
    Profit Objective Function
    Capacity Reservoir Capacity
    Ending_Storage Ending storage must be greater than initial storage
    Mass_balance Mass balance equation;

* Objective Function
Profit.. total_benefits =E= sum(t, c(t)*X("Div", t));


* Constrain Equations
Capacity(t).. X("Res",t) =L= max_storage;
Ending_Storage(t).. X("Res", "August") =G= init_storage;
Mass_balance(t).. inflow(t) - X("Div",t) - X("Spill",t) =E= X("Res",t) - init_storage$(ord(t) eq 1)  - X("Res",t-1)$(ord(t) gt 1);

* 5. Create the model using all of the defined equations
Model Reservoir /all/;


* 6. Solve the model and create a .lst file
Solve Reservoir using LP maximing total_benefits;
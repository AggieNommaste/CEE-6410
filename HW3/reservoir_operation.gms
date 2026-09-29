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


* 2. Define Input Data
Parameters
    c(t) Objective Function Coeffiecients ($ per ac-ft)
    /June 150, July 170, August 425/
    
    inflow(t) Inflow input data (ac-ft)
    /June 5000, July 3200, August 2000/;
    
Positive Variables
    X_div(t) Amount of Water to Divert each month (ac-ft)
    X_res(t) Amount of Water to keep in the Resevoir at the end of each month (ac-ft)
    X_spill(t) Amount of Water to spill over each month (ac-ft);

Variables
    total_benefits the total amount of profit ($)
    Max_level the maximum capacity of the resevoir (ac-ft)
    Min_level the resevoir protection level (ac-ft);
    
*Max_level = 9000;
*Min_level = 3000;

* Defining equations
Equations
    Profit
    Capacity
    Protection_level
    Mass_balance;

* Objective Function
Profit.. total_benefits =E= sum(t, c(t)*X_div(t)) + sum(t, 0*X_res(t)) + sum(t, 0*X_spill(t));
*Capacity(t).. X_res(t) =L= Max_level;
*Protection_level(t).. X_res(t) =G= Min_level;

* Constrain Equations
Capacity(t).. X_res(t) =L= 9000;
Protection_level(t).. X_res(t) =G= 3000;
Mass_balance(t).. inflow(t) - X_div(t) - X_spill(t) =E= X_res(t) - 3000 $(ord(t) = 1)  - X_res(t-1);

* Create the model
Model Reservoir /all/;


* Run the model using Linear method
Solve Reservoir using LP maximing total_benefits;
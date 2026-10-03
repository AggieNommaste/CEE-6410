$onText
USU
CEE 6410
Homework 2
Irrigation Problem

An aqueduct constructed to supply water to industrial users has an excess capacity in the months
of June, July, and August of 14,000 acft, 18,000 acft, and 6,000 acft, respectively. It is
proposed to develop not more than 10,000 acres of new land by utilizing the excess aqueduct
capacity for irrigation water deliveries. Two crops, hay and grain, are to be grown. Their
monthly water requirements and expected net returns are given in the following table:
Monthly Water Requirement (acft/acre)
        June July August    Return, $/acre
Hay       2    1    1            100
Grain     1    2    0            120


Ammon Wallace
Ammon Wallace
CEE 6410
ammon.wallace@usu.edu
$offText


* 1. Define Sets
Sets
crop different crops /Hay, Grain/
t months /June, July, August/;

* 2. Define Parameters
Parameters
obj_fun_coef(crop) objective function coef. ($ per acre) /100, 120/
irr(t) the volume of water (acre-ft) accessible each month /14000, 18000, 6000/
max_development the maximimum development (acres) /10000/;

* 3. Define C matrix
Table C(crop, t) Water requirements for each crop per month
        June    July    August
Hay       2       1        1
Grain     1       2        0;

* 4. Define Variables
Positive Variables
Y_land Dual objective function variable [$ per acre]
Y(t) Dual objective function variables [S per acre-ft]
X(crop) Primal objective function variables [amount of hay and grain in acres];

Variables
MaxProfit maximize primal obj. function
MinProfit minimize dual obj. function;

* 5. Define Equations
Equations
Primal_obj Primal objective function
Dual_obj Dual objective function
Primal_land Primal Land constraint
Primal_irr Primal irrigation constraint
Dual_con Dual constraints equation;


* Objective Functions
Primal_obj.. sum(crop, obj_fun_coef(crop)*X(crop)) =E= MaxProfit;
Dual_obj.. Y_land*max_development + sum(t, Y(t)*irr(t)) =E= MinProfit;

* Primal Constraints
Primal_land.. sum(crop, X(crop) =L= max_development;
Primal_irr(t).. sum(crop, irr(t)*X(crop)) =L= irr(t);

* Dual Constraints
Dual_con(crop).. Y_land+sum(t, C(crop,t)*Y(t)) =G= obj_fun_coef(crop);


* 6. Create Models
Model Primal /Primal_obj, Primal_land, Primal_irr/;
Model Dual /Dual_obj, Dual_con/;

* 7. Solve Models
Solve Primal using LP maximizing MaxProfit;
Solve Dual using LP minimizing MinProfit;


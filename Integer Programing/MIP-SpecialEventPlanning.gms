$ontext
Special-Event Park-and-Ride Planning Problem
CEE 6410/5410
David Rosenberg
October 10, 2026

This problem was contributed by Dr. Ran Sun and expanded by Dr. David Rosenberg

Learning objectives.
Students will be able to:
•   Define dimensions, decision variables and an objective function;
•   Formulate demand, capacity, and service-quality constraints;
•   Solve a small linear program;
•   Identify constraints;

Problem Statement
State Department of Transportation guidance for special events emphasizes advance parklotanning for transportation demand, traffic, parking, transit operations, and seating.

Passengers must also be assigned in full bus-loads of 50 passengers per bus.

Additionally, the event parklotanners must rent and bring in grandstands for the attendees. They have 2 potential venders. Each vender has an up-front reservation cost, number of seats per grandstand, and cost to load, ship, and setup a grandstand.

Vendor  Reservation cost ($)    Seats per grandstand    Cost to load, ship, and setup ($ per grandstand)
PurpleRain $1,000                   100                 200
Blue Sky    $1,500                  200                 300

Full details at https://usu.instructure.com/courses/818402/files/100525844?wrap=1

David E Rosenberg
david.rosenberg@usu.edu
$offtext

* 1. DEFINE the SETS
SETS parklot Parking Lots /north, south, west/
    vendor Vendors of grandstands /PurpleRain, BlueSky/;

* 2. DEFINE input data
PARAMETERS
   MaxPassengers(parklot) maximimum number of peoparklote parking lot can handle (Number)
         /north 600,
          south 500,
          west  600/
   Cost(parklot) cost per passenger from parking lot ($ per person)
          /north 4,
          south 5,
          west  7/
   TravelTime(parklot) Travel time from parking lot (minutes)
         /north 20,
          south 12,
          west  8/
   MaxAverageTime Maximum average travel time for all pasengers (minutes) /13/
   Attendees number of attendees /1200/
   ReservationCost(vendor) Cost to reserve grandstands from vendor ($)
        /PurpleRain 1000,
         BlueSky    1500/
   Seats(vendor) Seats per grandstand (number)
        /PurpleRain 100,
         BlueSky    200/
    UnitCost(vendor) Cost per grandstand to load ship and setup ($ per grandstand)
        /PurpleRain 200,
         BlueSky    300/
    Bus_load The amount of passengers per bus /50/;



* 3. DEFINE the variables
Variables
TCOST the total cost of vendors and buses
Buses(parklot) how many buses to schedule from each parking lot
Grandstands(vendor) How many grandstands to schedule from vendor
I(vendor) Binary decision variable to decide on which vendor;

* Setting binary constraint for vendor
Binary Variable
I(vendor);

* Setting Buses and Grandstands to be integers because you can't have 1/2 a bus or grandstand
Integer Variables
Buses(parklot)
Grandstands(vendor);


* 4. COMBINE variables and data in equations
EQUATIONS
Obj_func Objective function Equation
Seat_Attendees_cons Ensure enough grandstand seats for all attendees
Bus_attendees_cons Attendees constraint
Capacity_cons(parklot) Capacity of parking facilities
Travel_time_cons Constraint of max travel time per person;

Obj_func.. TCOST =E= sum(parklot, Cost(parklot)*Buses(parklot)*Bus_load) +
                     sum(vendor, ReservationCost(vendor)*I(vendor) +
                     UnitCost(Vendor)*Grandstands(vendor));

Seat_attendees_cons.. sum(vendor, I(vendor)*Seats(vendor)*Grandstands(vendor)) =G= Attendees;
Bus_attendees_cons.. sum(parklot, Buses(parklot)*50) =G= Attendees;
Capacity_cons(parklot).. Buses(parklot)*Bus_load =L= MaxPassengers(parklot);
Travel_time_cons.. sum(parklot, Buses(parklot)*Bus_load*TravelTime(parklot)) =L= 
                   MaxAverageTime * sum(parklot, Buses(parklot)*Bus_load);


* 5. DEFINE the MODEL from the EQUATIONS
Model Event /ALL/;

* 6. Solve the Model as a Mixed Integer Program
Solve Event using MIP minimizing TCOST;

* 7. Disparklotay the decision variable values in the list file
*DISLAY X.L, I.L, TCOST.L;
Display Buses.L, Grandstands.L, I.L, TCOST.L;

* Dump all input data and results to a GAMS gdx file
Execute_Unload "MIP-SpecialEvent.gdx";
* Dump the gdx file to an Excel workbook
*Execute "gdx2xls MIP-SpecialEvent.gdx"

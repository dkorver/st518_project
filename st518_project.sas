
/*
Brand= name, store
Temp= 6, 23, 40
Stirred= yes, no

https://blogs.sas.com/content/iml/2013/02/27/slope-of-a-regression-line.html
\\rtpnfil01\hsdevdata1\OPQtesting\dkorver\ST518\ST518\effervescence.csv
*/
%let path=/sasdata/hsdevdata1/OPQtesting/dkorver/ST518/ST518/;
libname home "&path.";
/*
PROC IMPORT DATAFILE="/sasdata/hsdevdata1/OPQtesting/dkorver/ST518/ST518/effervescence.csv"
	DBMS=CSV
	OUT=home.effervescence;
	GETNAMES=YES;
RUN;
PROC CONTENTS DATA=home.effervescence; RUN;
proc freq data=home.effervescence;
table Stirred Temp Brand;
run;
proc means data=home.effervescence n nmiss mean std median min max;
var Time Order;
run;
*//*
ods graphics on;
proc glm data=home.effervescence;
where Stirred="no";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
run;
*/
/*
ods graphics on;
proc glm data=home.effervescence;
where Stirred="yes";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
means Brand Temp;
lsmeans Brand Temp/stderr;
run;

ods graphics on;
proc glm data=home.effervescence;
where Stirred="no";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
means Brand Temp;
lsmeans Brand Temp/stderr;
run;
*/

proc mixed data=home.effervescence;
title "Stirred=no";
where Stirred="no";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
lsmeans Brand*Temp/pdiff;
/*
lsmeans Brand/pdiff at Temp=6;
lsmeans Brand/pdiff at Temp=23;
lsmeans Brand/pdiff at Temp=40;
*/
run;

proc mixed data=home.effervescence;
title "Stirred=yes";
where Stirred="yes";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
lsmeans Brand*Temp/pdiff;
/*
lsmeans Brand/pdiff at Temp=6;
lsmeans Brand/pdiff at Temp=23;
lsmeans Brand/pdiff at Temp=40;
*/
run;

/*
ods graphics on;
proc sgplot data=home.effervescence;
reg y=Time x=Order/group=Stirred;
run;

/*
ods graphics on;
proc reg data=home.effervescence;
where Stirred="yes";
model Time = Order;
run;

ods graphics on;
proc reg data=home.effervescence;
where Stirred="no";
model Time = Order;
run;


/*
proc mixed data=effervescence method=type3;
class Stirred;
model Time=Order;
run; 
*/
/*
proc reg data=home.effervescence;
where Stirred="yes";
model Time=Order;
run; 
proc reg data=home.effervescence;
where Stirred="no";
model Time=Order;
run; 
*//*
data effervescence;
set home.effervescence;
if Brand="name" then Brand_Ind=1; else Brand_Ind=2;
     if Temp=6 then Temp_Ind=1;
else if Temp=23 then Temp_Ind=2;
else if Temp=40 then Temp_Ind=3;
run;
/*


ods graphics on;
ods trace on;
proc sgplot data=effervescence;
where Stirred="yes";
reg y=Time x=Order/group=Brand;
ods output SGPlot=PE1;
run;
*/
/*
proc mixed data=effervescence;
where Stirred="yes";
class Brand;
model Time=Order Brand;
lsmeans Brand/pdiff at Temp=6;
lsmeans Brand/pdiff at Temp=23;
lsmeans Brand/pdiff at Temp=40;
run;

/*
ods graphics on;
proc sgplot data=effervescence;
where Stirred="no";
reg y=Time x=Order/group=Brand;
ods output ParameterEstimates=PE2;
run;
*/

/*
proc mixed data=effervescence;
where Stirred="no";
class Brand Temp;
model Time=Brand Temp Brand*Temp;
*lsmeans Brand/pdiff at Temp=6;
lsmeans Brand*Temp/pdiff;
*lsmeans Brand/pdiff at Temp=23;
*lsmeans Brand/pdiff at Temp=40;
run;


/*
proc reg data=effervescence;
where Stirred="yes";
model Time=Brand_Ind Temp Order;
run; 

proc reg data=effervescence;
where Stirred="no";
model Time=Brand_Ind Temp Order;
run; 


/*
proc mixed data=effervescence;
class Stirred;
model Time=Stirred Order Temp Stirred*Order Temp*Order;
lsmeans Stirred/pdiff at Temp=6;
lsmeans Stirred/pdiff at Temp=23;
lsmeans Stirred/pdiff at Temp=40;
run;

/*
proc reg data=effervescence;
where Stirred="yes";
model Time=Brand_Ind Temp_Ind;
run; 

proc reg data=effervescence;
where Stirred="no";
model Time=Brand_Ind Temp_Ind;
run; 

proc mixed data=effervescence;
class Stirred;
model Time=Brand_Ind Temp_Ind Order;
run;


/*
proc means data=home.effervescence n nmiss mean std median min max;
class Stirred;
var Time;
run;
/*
proc means data=home.effervescence n nmiss mean std median min max;
class Brand Temp;
var Time;
run;
proc means data=home.effervescence n nmiss mean std median min max;
class Brand Stirred;
var Time;
run;
proc means data=home.effervescence n nmiss mean std median min max;
class Temp Stirred;
var Time;
run;
proc means data=home.effervescence n nmiss mean std median min max;
class Stirred;
var Time;
run;

/*
proc sort data=home.effervescence; by Order; run;

ODS GRAPHICS ON /reset = all imagename="Interaction Plot where it was Stirred" imagefmt=png;
ODS LISTING GPATH = "&path.";
proc glm data=home.effervescence;
   where Stirred='yes';
   class Brand Temp;
   model Time = Brand | Temp; 
run;
ods graphics off;

ODS GRAPHICS ON /reset = all imagename="Interaction Plot where it wasn't Stirred" imagefmt=png;
ODS LISTING GPATH = "&path.";
proc glm data=home.effervescence;
   where Stirred='no';
   class Brand Temp;
   model Time = Brand | Temp; 
run;
ods graphics off;
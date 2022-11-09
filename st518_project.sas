
/*
Brand= name, store
Temp= 6, 23, 40
Stirred= yes, no
*/
%let path=<update file path>;

libname home "&path.";

FILENAME REFFILE '&path.effervescence.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=home.effervescence;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=home.effervescence; RUN;
/*
proc freq data=home.effervescence;
run;
*/
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
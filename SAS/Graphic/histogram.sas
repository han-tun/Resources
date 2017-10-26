/*------------------------------------
* Created :       26/10/2017  (fr)  
* Last update :   26/10/2017  
* Author(s) : Nicolas Dupont         
* Contributor(s) : 		          
* On SAS Studio 9.4M4 onDemand 
* Update :
-------------------------------------*/

/*------------------------------------
* The histogram is a good solution to represent the distribution of a numerical variable.
* Take care of the number of bins
-------------------------------------*/

/*------------------------------------
* Histogram with the proc Univariate
-------------------------------------*/

title '1# Distribution of the numerical variable horsepower in the cars dataset';
proc univariate data=sashelp.cars noprint;
   histogram horsepower;
run;

title '2# Distribution of the numerical variable horsepower in the cars dataset  / with the midpoints option';
proc univariate data=sashelp.cars noprint;
   histogram horsepower / midpoints = 50 to 500 by 50;
run;

title '3# Distribution of the numerical variable horsepower in the cars dataset';
proc univariate data=sashelp.cars noprint;
   histogram horsepower / midpoints = 0 to 550 by 10 barlabel=percent;
run;

title '4# Distribution of the numerical variable horsepower compared between the categorial variable "Make"';
proc univariate data=sashelp.cars(where=(Make in ('Audi','Chevrolet')));
  class Make;
  histogram horsepower / nrows=2;  
  ods select histogram; /* display on the histograms */
run;


/*------------------------------------
* Histogram with the sgplot procedure
-------------------------------------*/

proc sgplot data=sashelp.cars;
  title "5# horsepower Distribution";
  histogram horsepower;
  density horsepower;
  keylegend / location=inside position=topright;
run;

proc sgplot data=sashelp.cars;
  title "6# horsepower Distribution";
  histogram horsepower;
  density horsepower;
  keylegend / location=inside position=topright;
  xaxis values=(0 to 550 by 20); 
run;

proc sgplot data=sashelp.cars;
  title "7# horsepower Distribution in number";
  histogram horsepower / scale=count;
  density horsepower;
  keylegend / location=inside position=topright;
  xaxis values=(0 to 550 by 20) LABEL='Horsepower'; 
  yaxis LABEL='Number of observations';
run;

proc sgplot data=sashelp.cars;
  title "8# horsepower Distribution for two groups";
  where Make in ('Audi','Chevrolet'); /* only two groups */
  histogram horsepower / group=Make transparency=0.5;       /* since SAS 9.4m2 */
  xaxis values=(0 to 550 by 20);
run;

proc sgplot data=sashelp.cars;
  title "9# horsepower Distribution for two groups";
  where Make in ('Audi','Chevrolet');   
  histogram horsepower / group=Make transparency=0.5;
  density horsepower / type=kernel group=Make; 
run;

proc sgplot data=sashelp.cars;
  title "9# horsepower Distribution for two groups";
  where Make in ('Audi','Chevrolet');   
  histogram horsepower / group=Make transparency=0.5 scale=count;
  density horsepower / type=kernel group=Make; 
run;

proc sgplot data=sashelp.cars;
  title "10# Distributions of two differents numerical variables in one histogram (not really appropriate in that case)";
  histogram Length / binwidth=5 transparency=0.5 name="length" legendlabel="Length";
  histogram Wheelbase / binwidth=5 transparency=0.5 name="wheelbase" legendlabel="Wheelbase";
  xaxis label="Length (IN)" min=0;
  yaxis label="%" min=0;
  keylegend "length" "wheelbase" / across=1 position=Topleft location=Inside;
run;


proc sgplot data=Sashelp.Iris;
  title "11# Another exemple with the iris dataset";
  histogram PetalLength / binwidth=5 transparency=0.5 name="petal" legendlabel="Petal Width";
  histogram SepalLength / binwidth=5 transparency=0.5 name="sepal" legendlabel="Sepal Width";
  density PetalLength / type=kernel lineattrs=GraphData1;  /* optional */
  density SepalLength / type=kernel lineattrs=GraphData2;  /* optional */
  xaxis label="Length (mm)" min=0;
  keylegend "petal" "sepal" / across=1 position=TopRight location=Inside;
run;

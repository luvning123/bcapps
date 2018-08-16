(*

different and easier approach to solve 

https://earthscience.stackexchange.com/questions/14656/how-to-calculate-boundary-around-all-land-on-earth

using https://oceancolor.gsfc.nasa.gov/docs/distfromcoast/ (signed version)

Mathematica surprisingly disappointed me so I wrote and ran
bc-buffer-land.pl and put the results in land-by-coast-dist.txt.bz2,
and I use that file below

*)

(* 

data notes:

-2509.97 = given to two digits for min to ...

-999.999 = three digits to ...

-99.9998 = four digits to ...

-9.99994 = five digits to ...

-0.999988 = six digits to ...

-0.0999988 = seven digits to ...

-0.00998305 = eight digits to ...

-0.000997388 = nine digits to end

*)

<formulas>

(* to stop Mathematica stupidity *)

$AllowInternet = False;

showit2 := Module[{file}, file = StringJoin["/tmp/math", 
       ToString[RunThrough["date +%Y%m%d%H%M%S", ""]], ".gif"]; 
     Export[file, %, ImageSize -> {8192, 4096}]; 
     Run[StringJoin["display -geometry 800x600 -update 1 ", file, "&"]]; 
    Return[file];];

</formulas>

(* restore Internet *)

$AllowInternet = True;

(* must determine Earth's radius w/ Internet on, grumble *)

earthRadius = Entity["Planet", "Earth"]["Radius"]/Quantity[1,"km"];

(* read NASA file *)

nasaFile = "/home/barrycarter/20180807/dist2coast.signed.txt.bz2";

(* TODO: using a fixed filename for output here is bad *)

Run["bzcat "<>nasaFile<>" > /tmp/output.txt"];

coast0 = ReadList["/tmp/output.txt", {Number, Number, Number}];

(* rounding distance to nearest 10m because least precise data is that
precise, except when close to 0, to preserve sign *)

round2[x_] = If[Round[x,0.01] == 0, Sign[x]*0.01, Round[x,0.01]];

(* special case small neg/pos; using precise numbers slows Mathematica
down so the "0.01" above is intentionally not 1/100 *)

coast = Table[{i[[1]], i[[2]], round2[i[[3]]]}, {i, coast0}];

(*  different values, 509997 when rounded to nearest 10m, 509996 once I get rid of the 0's *)

(* there were 1031 0s per Select[coast, #[[3]] == 0 &] *)

dists = DeleteDuplicates[Sort[Transpose[coast][[3]]]];

(* TODO: maybe dist vs number of points, though irrelevant *)

(* TODO: level 4 data incl ponds on islands in seas *)

(* the area of a cell at the equator, .04 degree x .04 degree *)

maxarea = (earthRadius*2*Pi/360/25)^2

(* the amount of area for each distance *)

(* Gather was too slow when I didn't round should be ok now *)

pointsByDist = Gather[coast, #1[[3]] == #2[[3]] &];

(* create a function to make things easier (?) *)

(* Table[dist2Points[i[[1,3]]] = i  *)

distTotal = Sort[Table[{i[[1,3]], 
 maxarea*Total[Map[Cos[#*Degree] &, Transpose[i][[2]]]]},
 {i, pointsByDist}], #1[[1]] < #2[[1]] &];

ListPlot[distTotal, PlotRange -> All, PlotJoined -> True]




(* TODO: there must be a better way to do this, but Gather[] is too slow *)

Clear[f];
f[x_] = 0;
Table[f[i[[3]]] = f[i[[3]]] + maxarea*Cos[i[[2]]*Degree], {i, coast}];

ListPlot[Table[{i, f[i]}, {i, dists}], PlotJoined -> True];

TODO: discretize

TODO: use the word "discretize" as much as possible

100km hue plot

hue[x_] = If[x>0, Min[0.8,0.5 + 0.3/1000*x], Max[0.4+0.4/1000*x, 0]]

t1330 = Partition[Transpose[coast][[3]], 9000];

t1331 = Map[hue, t1330, {2}];

t1332 = Raster[t1331, ColorFunction -> Hue];

Graphics[t1332]

testing...


t1348 = Raster[Take[t1331,500], ColorFunction -> Hue];

Graphics[t1348]


















(* this has some inherent interest *)

t1736 = Sort[t1258, #1[[3]] < #2[[3]] &];

t1805 = Gather[t1736, #1[[3]] == #2[[3]] &];

(* to do: find number of coast line points? *)



area = (4/100/360*earthRadius*2*Pi)^2

t1717 = Table[{Cos[i[[2]]*Degree], i[[3]]}, {i, t1258}];

t1727 = Gather[t1717, #1[[2]] == #2[[2]] &];



ListPlot3D[t1258] (* times out *)

4500 points per line of longitude? (yes)

t1705 = Interpolation[t1258];

ContourPlot[t1705[lon,lat], {lon, -180, 180}, {lat, -90, 90}]

t1709 = ContourPlot[t1705[lon,lat], {lon, -180, 180}, {lat, -90, 90},
 AspectRatio -> 1/2, ColorFunction -> Hue, Contours -> 64,  
 PlotLegends -> True, ImageSize -> {8192, 4096}]

.04 longitude times .04 latitude (= fixed)

t1722 = Gather[t1717, #1[[2]] == #2[[2]] &];

<answer>

*** PUT GRAPH HERE ***

why de[ck]ameter

using https://oceancolor.gsfc.nasa.gov/docs/distfromcoast/ (signed version)


The file *** makes this problem trivial, since it lists coastal distances both on land (given as negative numbers) and water (given as positive numbers). Brief notes:

  - 


TODO: note text file

rounded to nearest kn

two other approaches: GeoDistance and 3D projection

points only not vectors

tides and coastline paradox

see bc-buffer-land.m for other version

also solve the antipode problem

compare to known total area and known water/land area

note spherical

color kode and key [prob 25km/color for 64 colors and top out]

</answer>

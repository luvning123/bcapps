(* Sun/Moon/Earth JFF *)

(* from NASA, ICRF2000, km and s on 2457023.500000000 =
A.D. 2015-Jan-01 00:00:00.0000 *)

NDSolve[{

e[0]=={-2.518093251638549*10^7,1.327949054280765*10^8,5.754641055834983*10^7},
e'[0]=={-2.980233994481606*10^1,-4.859672762093325*10^0,-2.105837716452624},

s[0]=={4.250119210295542*10^5,-1.092065778824771*10^5,-6.972086949195851*10^4},
s'[0]=={6.882105685687786*10^-3,8.386463510315816*10^-3,
	3.452129224055193*10^-3},


m[0]=={-2.493673284195151*10^7,1.330734168777016*10^8,5.764600356317691*10^7},
m'[0]=={-3.056658316901732*10^1,-4.207149336797371*10^0,-1.904942957747298},

grav == 6.67384*10^-20,

mm == 7.34767309*10^22,
em == 5.972*10^24,
sm == 1.989*10^30,

s''[t] == grav*(em/(Norm[e[t]-s[t]]^2) + mm/Norm[m[t]-s[t]]^2),
e''[t] == grav*(sm/(Norm[e[t]-s[t]]^2) + mm/Norm[m[t]-e[t]]^2),
m''[t] == grav*(em/(Norm[e[t]-m[t]]^2) + sm/Norm[m[t]-s[t]]^2)

}, s, {t,0,86400*365}]

(* constants and mass *)

grav = 6.67384*10^-20;
em = 5.972*10^24;
sm = 1.989*10^30;

(* initial conditions [putting these here lets me play with them
outside NDSolve] *)

e0 = {-2.518093251638549*10^7,1.327949054280765*10^8,5.754641055834983*10^7};
ed0 = {-2.980233994481606*10^1,-4.859672762093325*10^0,-2.105837716452624};

s0 = {4.250119210295542*10^5,-1.092065778824771*10^5,-6.972086949195851*10^4};
sd0={6.882105685687786*10^-3,8.386463510315816*10^-3,3.452129224055193*10^-3};

{s,e} = {s,e} /.

NDSolve[{

e[0]==e0, e'[0] == ed0,
s[0]==s0, s'[0]== sd0,

s''[t] == grav*em*(e[t]-s[t])/Norm[e[t]-s[t]]^3,
e''[t] == grav*sm*(s[t]-e[t])/Norm[s[t]-e[t]]^3

}, {s,e}, {t,0,86400*365}][[1]]










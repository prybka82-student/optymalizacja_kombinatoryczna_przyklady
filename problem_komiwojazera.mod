# problem komiwojazera

param start 	symbolic;
param finish 	symbolic, != start;
param maxspeed;

set PLACES;
param lat{PLACES};
param lng{PLACES};
param S1{PLACES};
param S2{p in PLACES} >= S1[p];

# oblicz najwieksze odleglosci i najmniejsze czasy przejazdu

param d2r := 3.1415926/180;
param alpha{a in PLACES, b in PLACES} := sin(d2r * (lat[a] - lat[b])/2)**2
		+ cos(d2r*lat[a]) * cos(d2r * lat[b])* sin(d2r * (lng[a] - lng[b])/2)**2;
param gcdist{a in PLACES, b in PLACES} := 2*6371 * atan(sqrt(alpha[a,b]),sqrt(1-alpha[a,b]));

# ograniczenia drogi

var x{PLACES, PLACES} binary;

# ograniczenia

# komiwojazer musi wyjsc z wszystkich miast za wyjatkiem ostatniego

s.t. lv1 {a in PLACES : a != finish}: sum{b in PLACES} x[a,b] = 1;
s.t. lv2 : sum{b in PLACES} x[finish,b] = 0;

# komiwojazer musi dojsc do wszystkich miast za wyjatkiem pierwszego

s.t. ar1 {a in PLACES : a != start}: sum{b in PLACES} x[b,a] = 1;
s.t. ar2 : sum{b in PLACES} x[b,start] = 0;

# eliminacja powrotow do startu z pominieciem wszystkich miast

var y{PLACES, PLACES} >= 0, integer;

s.t. capbnd {a in PLACES,b in PLACES} : y[a,b] <= (card(PLACES)-1)*x[a,b];
s.t. capcon {a in PLACES} : sum{b in PLACES} y[b,a]
	+ (if a=start then card(PLACES)) = 1 + sum{b in PLACES} y[a,b];

# ograniczenia czasowe

param bigM := 50;

var tar{PLACES}; 		# przybycie
var tlv{PLACES};		# wyjazd
var tea{PLACES} >= 0;	# wczesne przybycie (przed zakonczeniem wyznaczonego czasu)
var tla{PLACES} >= 0;	# pozne przybycie (po zakonczeniu wyznaczonego czasu)
var ted{PLACES} >= 0; 	# wczesny wyjazd (przed zakonczeniem wyznaczonego czasowe)
var tld{PLACES} >= 0; 	# pozny wyjazd (po zakonczeniem wyjatkiem czasu)

s.t. t1 {a in PLACES} : tlv[a] >= tar[a];
s.t. t2 {a in PLACES, b in PLACES} : tar[b] >= tlv[a] + gcdist[a,b]/maxspeed - bigM*(1-x[a,b]);
s.t. t3 {a in PLACES : a != start } : tea[a] >= S1[a] - tar[a]; # wczesne przybycie
s.t. t4 {a in PLACES : a != start } : tla[a] >= tar[a] - S2[a]; # pozne przybycie
s.t. t5 {a in PLACES : a != finish} : ted[a] >= S1[a] - tlv[a]; # wczesny wyjatkiem
s.t. t6 {a in PLACES : a != finish} : tld[a] >= tlv[a] - S2[a]; # pozny wyjatkiem
 
# cel - suma wazona sredniego i maksymalnego czasu podrozy 

var tmax >= 0;

s.t. o1 {a in PLACES} : tea[a] <= tmax;
s.t. o2 {a in PLACES} : tla[a] <= tmax;
s.t. o3 {a in PLACES} : ted[a] <= tmax;
s.t. o4 {a in PLACES} : tld[a] <= tmax;

minimize obj: sum{a in PLACES} (1*tea[a] + 2*tla[a] + 2*ted[a] + 1*tld[a]) + 2*tmax;

solve;

printf "%6s %3s %6s %3s %6s %6s %6s %6s %7s %5s %6s\n",
	'Depart', '', 'Arrive', '', 'EDep', 'LDep','EArr','LArr','Dist','Time','Speed';
	
for {k in card(PLACES)-1..0 by -1} {
	printf {a in PLACES, b in PLACES : (y[a,b]=k) && (x[a,b]=1)}
		"%-3s %7.2f %-3s %7.2f %6.2f %1s %5.2f %1s %5.2f %1s %5.2f %1s %6.1f %5.2f %6.1f\n",
		a, tlv[a], b, tar[b],
		ted[a], if (ted[a]>0) then '*' else ' ',
		tld[a], if (tld[a]>0) then '*' else ' ', 
		tea[b], if (tea[b]>0) then '*' else ' ',
		tla[b], if (tla[b]>0) then '*' else ' ',
		gcdist[a,b], (tar[b]-tlv[a]), gcdist[a,b]/(tar[b]-tlv[a]);
}

data;

param start := 'ATL';
param finish := 'ORD';
param maxspeed := 800;

param : PLACES: 	lat			lng				S1		S2 :=
		ATL			33.6366995	-84.4278639		8.0		24.0
		BOS			42.3629722	-71.0064167		8.0		9.0
		DEN			39.8616667	-104.6731667	12.0	15.0
		DFW			32.8968281	-97.0379958		12.0	13.0
		JFK			40.6397511	-73.7789256		18.0	20.0
		LAX			33.9424955	-118.4080684	12.0	16.0
		ORD			41.9816486	-87.9066714		20.0	24.0
		STL			38.7486972	-90.3700289		11.0	13.0
;

end;
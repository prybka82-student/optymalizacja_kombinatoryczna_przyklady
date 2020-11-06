# przyklad z parametrami

# definicje zbiorow

set STUDENCI;
set KURSY;

# deklaracja parametrow

param oceny{k in KURSY} >= 0;
param harmonogramy{s in STUDENCI, k in KURSY} binary;

# parametry obliczane

param loads{s in STUDENCI} := sum{k in KURSY} harmonogramy[s,k]*oceny[k];

# wyniki

printf "STUDENCI\n";
printf {student in STUDENCI} " %-10s %3d \n",student, loads[student];

printf "\nKURSY\n";
printf {kurs in KURSY} " %s\n", kurs;
printf "\n\n";

# dane

data;

set STUDENCI := Adam Bartek Karol Dorota Emil Franek;
set KURSY := matma angielski chemia fizyka;

param oceny :=
	matma		3
	angielski	3
	chemia		4
	fizyka		5;

param harmonogramy: matma angielski chemia fizyka :=
	Adam		1	1	0	0
	Bartek		0	0	1	1
	Karol		1	0	0	1
	Dorota		0	1	1	1
	Emil		1	0	1	0
	Franek		0	1	1	0;

end;
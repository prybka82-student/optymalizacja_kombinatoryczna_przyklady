# znalezc optymalne rozwiazanie - najwiekszy zysk Giapetta

# definicja zmiennych
var x1 >= 0 integer; # liczba zolnierzy - musi byc liczba calkowita
var x2 >= 0 integer; # liczba pociagow - musi byc liczba calkowita

# funkcja celu
maximize zysk: 3*x1 + 2*x2;

# ograniczenia
s.t. wykonczenie: 1.85*x1 + x2 <= 100;
s.t. stolarka: x1 + x2 <= 80;
s.t. zlecenie: x1 <= 40;

solve;

# wyswietlenie wynikow
display x1, x2, zysk;
display wykonczenie, stolarka, zlecenie;

end;
# komentarz - polskie znaki wykluczone - program sie sypie

# Przykladowy program: zadanie z dwiema zmiennymi

# definicja zmiennych
var x;
var y;

# definicja ograniczen
s.t. A: x + 2*y <= 14;
s.t. B: 3*x - y >= 0;
s.t. C: x - y <= 2;

# funkcja celu
maximize z: 3*x + 4*y; #domyslnie minimize

# rozwiaz
solve;

display z;
display x, y;

end;
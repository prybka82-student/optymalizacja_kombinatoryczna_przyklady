# przyklad ze zbiorami 

# zbiory
set PSY   := { 'Beagle', 'Labrador', 'Owczarek', 'Boxer' };
set KOTY  := { 'Tygrys', 'Lew' };
set RYBKI := { 'Zlota rybka', 'Gupik', 'Rekin' };

# zlaczenia zbiorow

set ZWIERZAKI := PSY union KOTY union RYBKI;

# wylistowanie elementow zbioru

printf "ZWIERZAKI: ";
for { zwierzak in ZWIERZAKI } printf "%4s ", zwierzak;

# wielkosc zbioru
printf "\n\nLiczba zwierzat: %d", card(ZWIERZAKI);

set NIEBEZPIECZNE := { 'Tygrys', 'Lew', 'Rekin', 'Krokodyl' };

# roznica zbiorow

set BEZPIECZNE := ZWIERZAKI diff NIEBEZPIECZNE;

printf "\n\nBEZPIECZNE: ";
for { zwierzak in BEZPIECZNE} printf "%4s ", zwierzak;

printf "\n\n";

end;
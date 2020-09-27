/* 
Egy termosztát szoftverének a specifikációját kell elkészíteni, amelynek az alábbi követelményeket kell
megvalósítania:
• 100 db mérési eredményt legyen képes eltárolni,
• a mért eredmények megadásához rendelkezzen egy művelettel,
• a géptől le lehessen kérdezni, hogy a megadott értékek között mi a maximális és minimális érték,
valamint le lehessen kérdezni az értékek átlagát is,
• az adatok folyamatosan érkeznek, a 101. adat érkezésekor a gép felejtse el a legrégebben megadott
adatot.
Az eltárolható mérési eredmények száma egy konstanssal legyen definiálva. Az adatokat egyesével lehessen
beolvasni.



Megoldás összefoglaló:
Mérési eredmények (hőmérsékletek) hozzáadása (addTemp hívások) után az eddig kiszámolt min, max és átlag (avg) mérési értékek érvénytelenek lesznek. Le kell őket kérni ismét, ekkor lesznek kiszámolva az eddigi összes hőmérsékletre. Az addTemp művelet csak egy-egy mérés eltárolására szolgál.
 */
MACHINE
    thermostat

DEFINITIONS
    MIN_POSSIBLE_TEMP == - 50 ;
    MAX_POSSIBLE_TEMP == 120 ;
    TEMP == MIN_POSSIBLE_TEMP .. MAX_POSSIBLE_TEMP ;
    TEMPS_CAPACITY == 100 ;
    DOM_MIN == 1 ;
    DOM_TEMPS == DOM_MIN .. TEMPS_CAPACITY

ABSTRACT_VARIABLES
    temps ,  // a méréseket tároló parciális függvény
    nextIndex , // az az értelmezési helye a temps függvénynek, ahova 
               // a következő beolvasott mérési eredmény kerülne
    minTemp , // a legkisebb eltárolt hőmérséklet
    maxTemp , // a legnagyobb eltárolt hőmérséklet
    avgTemp , // az eltárolt hőmérsékletek átlaga

    isMinComputed , // ki van-e épp számolva a minTemp érték (invariánshoz kell)
    isMaxComputed , // ki van-e épp számolva a maxTemp érték (invariánshoz kell)
    isAvgComputed  // ki van-e épp számolva a avgTemp érték (invariánshoz kell)

INVARIANT
    temps : DOM_TEMPS +-> TEMP & // TEMP értékű parciális függvényben tároljuk a méréseket
    nextIndex : DOM_TEMPS &

    minTemp : TEMP &
    maxTemp : TEMP &
    avgTemp : TEMP &

    isMinComputed : BOOL &
    isMaxComputed : BOOL &
    isAvgComputed : BOOL &
    // változók típusainak megadásának vége

    ( temps = {} =>
        isMinComputed = FALSE &
        isMaxComputed = FALSE &
        isAvgComputed = FALSE
    ) &
    ( isMinComputed = TRUE => minTemp = min ( ran ( temps ) ) ) &
    ( isMaxComputed = TRUE => maxTemp = max ( ran ( temps ) ) ) &
    ( isAvgComputed = TRUE => avgTemp = ( SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) ) / card ( temps ) )

INITIALISATION
    temps   := {} ||
    nextIndex := DOM_MIN ||

    minTemp :: TEMP  ||
    maxTemp :: TEMP ||
    avgTemp :: TEMP ||

    isMinComputed := FALSE ||
    isMaxComputed := FALSE ||
    isAvgComputed := FALSE

OPERATIONS

    addTemp ( newTemp ) =
    PRE
        newTemp : TEMP &
        ( nextIndex mod TEMPS_CAPACITY ) + 1 : DOM_TEMPS
    THEN
        nextIndex := ( nextIndex mod TEMPS_CAPACITY ) + 1 || // <mod TEMPS_CAPACITY>: az index ahova a következő mérési értéket beszúrjuk maradjon az értelmezési tartományban.
        temps ( nextIndex ) := newTemp ||
        isMinComputed := FALSE ||
        isMaxComputed := FALSE ||
        isAvgComputed := FALSE
    END ;

    ret <-- getMinTemp =
    PRE
        temps /= {}
    THEN
        isMinComputed := TRUE ||
        minTemp := min ( ran ( temps ) ) ||
        ret := min ( ran ( temps ) )
    END ;

    ret <-- getMaxTemp =
    PRE
        temps /= {}
    THEN
        isMaxComputed := TRUE ||
        maxTemp := max ( ran ( temps ) ) ||
        ret := max ( ran ( temps ) )
    END ;

    ret <-- getAvgTemp =
    PRE
        temps /= {}
    THEN
        isAvgComputed := TRUE ||
        avgTemp := SIGMA ( xx ) . ( xx : dom ( temps ) | ( temps ) ( xx ) ) / card ( temps ) || // átlagszámítás, egész-osztással
        ret := SIGMA ( xx ) . ( xx : dom ( temps ) | ( temps ) ( xx ) ) / card ( temps )
    END ;

    init =
    BEGIN
        temps   := {} ||
        nextIndex := DOM_MIN ||

        minTemp :: TEMP  ||
        maxTemp :: TEMP ||
        avgTemp :: TEMP ||

        isMinComputed := FALSE ||
        isMaxComputed := FALSE ||
        isAvgComputed := FALSE
    END

END

/* 
Egy termosztat szoftverenek a specifikaciojat kell elkesziteni, amelynek az alabbi kovetelmenyeket kell
megvalositania:
• 100 db meresi eredmenyt legyen kepes eltarolni,
• a mert eredmenyek megadasahoz rendelkezzen egy muvelettel,
• a geptol le lehessen kerdezni, hogy a megadott ertekek kozott mi a maximalis es minimalis ertek,
valamint le lehessen kerdezni az ertekek atlagat is,
• az adatok folyamatosan erkeznek, a 101. adat erkezesekor a gep felejtse el a legregebben megadott
adatot.
Az eltarolhato meresi eredmenyek szama egy konstanssal legyen definialva. Az adatokat egyesevel lehessen
beolvasni.

"-50 és 120 fokcelzius kozotti ertekeket kaphat a vezerlo"
 */
MACHINE
    thermostat









                                                                  // átlagszámítás, egész-osztással

CONCRETE_CONSTANTS
    TEMPS_CAPACITY // ennyi erteket tudunk eltarolni

PROPERTIES
    TEMPS_CAPACITY : INT & TEMPS_CAPACITY = 100

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
    temps : 1 .. TEMPS_CAPACITY +-> - 50 .. 120 & // TEMP értékű parciális függvényben tároljuk a méréseket
    nextIndex : 1 .. TEMPS_CAPACITY &

    minTemp : - 50 .. 120 &
    maxTemp : - 50 .. 120 &
    avgTemp : - 50 .. 120 &

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
    ( isAvgComputed = TRUE => avgTemp = SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps ) )

INITIALISATION
    temps   := {} ||
    nextIndex := 1       ||

    minTemp :: - 50 .. 120 ||
    maxTemp :: - 50 .. 120 ||
    avgTemp :: - 50 .. 120 ||

    isMinComputed := FALSE ||
    isMaxComputed := FALSE ||
    isAvgComputed := FALSE

OPERATIONS

    addTemp ( newTemp ) =
    PRE
        newTemp : - 50 .. 120
    THEN
        nextIndex := ( nextIndex mod TEMPS_CAPACITY ) + 1 || // <mod TEMPS_CAPACITY>: az index ahova a következő mérési értéket beszúrjuk maradjon az értelmezési tartományban.
        temps ( nextIndex ) := newTemp ||
        isMinComputed := FALSE ||
        isMaxComputed := FALSE ||
        isAvgComputed := FALSE
    END ;

    ret <-- getMinTemp = // legkisebb ertek lekerese
    PRE
        temps /= {}
    THEN
        isMinComputed := TRUE ||
        minTemp := min ( ran ( temps ) ) ||
        ret     := min ( ran ( temps ) )
    END ;

    ret <-- getMaxTemp = // legnagyobb ertek lekerese
    PRE
        temps /= {}
    THEN
        isMaxComputed := TRUE ||
        maxTemp := max ( ran ( temps ) ) ||
        ret     := max ( ran ( temps ) )
    END ;

    ret <-- getAvgTemp = // ertekek atlaganak lekerese
    PRE
        temps /= {}
    THEN
        isAvgComputed := TRUE ||
        avgTemp := SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps ) ||
        ret     := SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps )
    END ;

    init = // ha kell, ujra tudjuk inditani a gepet
    BEGIN
        temps   := {} ||
        nextIndex := 1       ||

        minTemp :: - 50 .. 120 ||
        maxTemp :: - 50 .. 120 ||
        avgTemp :: - 50 .. 120 ||

        isMinComputed := FALSE ||
        isMaxComputed := FALSE ||
        isAvgComputed := FALSE
    END

END

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

"-50 es 120 fokcelzius kozotti ertekeket kaphat a vezerlo"
 */
MACHINE
    thermostat







                                                                   // atlagszamitas, egesz-osztassal

CONCRETE_CONSTANTS
    TEMPS_CAPACITY // ennyi erteket tudunk eltarolni

PROPERTIES
    TEMPS_CAPACITY : 100 .. 100 & TEMPS_CAPACITY = 100

ABSTRACT_VARIABLES
    temps ,  // a mereseket tarolo parcialis fuggveny
    minTemp , // a legkisebb eltarolt homerseklet
    maxTemp , // a legnagyobb eltarolt homerseklet
    avgTemp , // az eltarolt homersekletek atlaga

    isMinComputed , // ki van-e epp szamolva a minTemp ertek (invarianshoz kell)
    isMaxComputed , // ki van-e epp szamolva a maxTemp ertek (invarianshoz kell)
    isAvgComputed  // ki van-e epp szamolva a avgTemp ertek (invarianshoz kell)

INVARIANT
    temps : ( 1 .. TEMPS_CAPACITY ) +-> ( - 50 .. 120 ) & // a mereseket tarolo parcialis fuggveny
    card ( ran ( temps ) ) <= TEMPS_CAPACITY &
    dom ( temps ) = 1 .. ( card ( ran ( temps ) ) ) &

    minTemp : ( - 50 .. 120 ) & // a legkisebb eltarolt homerseklet tipusa
    maxTemp : ( - 50 .. 120 ) & // a legnagyobb eltarolt homerseklet tipusa
    avgTemp : ( - 50 .. 120 ) & // az eltarolt homersekletek atlaganak tipusa

    isMinComputed : BOOL &
    isMaxComputed : BOOL &
    isAvgComputed : BOOL &
    // valtozok tipusainak megadasanak vege

    ( temps = {} => // amikor nincs meres
        isMinComputed = FALSE & // nincs kiszamolva a min
        isMaxComputed = FALSE & // nincs kiszamolva a max
        isAvgComputed = FALSE   // nincs kiszamolva az atlag (avg)
    ) &
    // ha ki vannak szamolva, akkor a megfelelo valtozoban helyes ertek van
    ( isMinComputed = TRUE => minTemp = min ( ran ( temps ) ) ) &
    ( isMaxComputed = TRUE => maxTemp = max ( ran ( temps ) ) ) &
    ( isAvgComputed = TRUE => avgTemp = ( SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps ) ) )

INITIALISATION
    temps   := {} || // ures a fuggveny kezdetben

    minTemp :: ( - 50 .. 120 ) || // tetszoleges homerseklet lehet
    maxTemp :: ( - 50 .. 120 ) || // tetszoleges homerseklet lehet
    avgTemp :: ( - 50 .. 120 ) || // tetszoleges homerseklet lehet

    isMinComputed := FALSE || // kezdetben nincs kiszamitva a minTemp
    isMaxComputed := FALSE || // kezdetben nincs kiszamitva a maxTemp
    isAvgComputed := FALSE    // kezdetben nincs kiszamitva az avgTemp

OPERATIONS

    // a kovetkezo homerseklet hozzaadasa, ez invalidda teszi az eddigi min, max, avg temp ertekeket.
    addTemp ( newTemp ) =
    PRE
        newTemp : ( - 50 .. 120 )
    THEN
        ANY
            tTemps , tTemps2
        WHERE
            tTemps : 1 .. ( card ( temps ) + 1 ) +-> ( - 50 .. 120 ) &
            tTemps2 : ( 1 .. TEMPS_CAPACITY ) +-> ( - 50 .. 120 ) &

            1 : dom ( tTemps ) &
            tTemps ( 1 ) = newTemp &
            ! ii . ( ii : 1 .. card ( temps ) => tTemps ( ii + 1 ) = temps ( ii ) ) &
            tTemps2 = ( 1 .. TEMPS_CAPACITY ) <| tTemps &
            dom ( tTemps2 ) = 1 .. ( card ( ran ( tTemps2 ) ) )
        THEN
            temps := tTemps2
        END ||
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
        avgTemp := ( SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps ) ) ||
        ret     := ( SIGMA ( xx ) . ( xx : dom ( temps ) | temps ( xx ) ) / card ( temps ) )
    END ;

    init = // ha kell, ujra tudjuk inditani a gepet
    BEGIN
        temps   := {} ||

        minTemp :: ( - 50 .. 120 ) ||
        maxTemp :: ( - 50 .. 120 ) ||
        avgTemp :: ( - 50 .. 120 ) ||

        isMinComputed := FALSE ||
        isMaxComputed := FALSE ||
        isAvgComputed := FALSE
    END

END

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

DEFINITIONS
    MIN_POSSIBLE_TEMP == -50;
    MAX_POSSIBLE_TEMP == 120;
    TEMP == MIN_POSSIBLE_TEMP..MAX_POSSIBLE_TEMP; // a lehetseges mert homersekleti ertekek intervalluma
    DOM_MIN == 1; // a mert ertekek ertelmezesi tartomanyanak minimuma
    DOM_TEMPS == DOM_MIN..TEMPS_CAPACITY // a mert ertekek ertelmezesi tartomanya
    
CONSTANTS
    TEMPS_CAPACITY // ennyi erteket tudunk eltarolni
    
PROPERTIES
    TEMPS_CAPACITY : INT & TEMPS_CAPACITY = 100
    
VARIABLES
    temps,   // a mereseket tarolo parcialis fuggveny
    minTemp, // a legkisebb eltarolt homerseklet
    maxTemp, // a legnagyobb eltarolt homerseklet
    avgTemp, // az eltarolt homersekletek atlaga
    nextIndex // az az ertelmezesi helye a temps fuggvenynek, ahova 
              // a kovetkezo beolvasott meresi eredmeny kerulne
INVARIANT
    temps : DOM_TEMPS +-> TEMP & // a mereseket tarolo parcialis fuggveny tipusa
    minTemp : TEMP & // a legkisebb eltarolt homerseklet tipusa
    maxTemp : TEMP & // a legnagyobb eltarolt homerseklet tipusa
    avgTemp : TEMP & // az eltarolt homersekletek atlaganak tipusa
    nextIndex : DOM_TEMPS & // a kovetkezo beolvasott meresi eredmeny helyenek tipusa
    // valtozok tipusainak megadasanak vege

    (temps /= {} => // ha van eltarolt meresunk:
        minTemp = min(ran(temps)) & // akkor a minTemp erteke a homersekletek minimuma
        maxTemp = max(ran(temps)) & // akkor a maxTemp erteke a homersekletek maximuma
        avgTemp = (SIGMA(xx).(xx : dom(temps) | temps(xx))) / card(temps) // akkor az avgTemp erteke a homersekletek atlaga
    )
    
INITIALISATION  
       temps   := {} // ures a fuggveny kezdetben
    || minTemp :: TEMP // tetszoleges homerseklet lehet
    || maxTemp :: TEMP // tetszoleges homerseklet lehet
    || avgTemp :: TEMP // tetszoleges homerseklet lehet
    || nextIndex := DOM_MIN // az ertelmezesi tartomany elejen kezdjuk feltolteni a fuggvenyt a homersekletekkel
    
OPERATIONS
    
    // a kovetkezo homerseklet hozzaadasa, ekkor rogton ki is szamitjuk a minimumot, maximumot es az atlagot is.
    addTemp(newTemp) = 
    PRE
        newTemp : TEMP &
        
        // trivialis (abbol, hogy a fuggveny ertelmezesi tartomanya es ertekkeszlete is zart intervallumok), de kell minTemp helyes beallitasanak bizonyitasahoz: 
        ran(temps<+{nextIndex|->newTemp})/\INTEGER-NATURAL: FIN(INTEGER) & // van minimuma a halmaznak
        
        // trivialis, de kell maxTemp helyes beallitasanak bizonyitasahoz:
        ran(temps <+ {nextIndex |-> newTemp})/\NATURAL: FIN(NATURAL) & // van maximuma a halmaznak
        
        // trivialis, de kell avgTemp helyes beallitasanak bizonyitasahoz:
        temps<+{nextIndex|->newTemp}: FIN(temps <+ {nextIndex |-> newTemp}) // veges halmazt osszegezzunk az atlag szamitashoz
        
    THEN
        nextIndex := (nextIndex mod TEMPS_CAPACITY) + 1 // <mod TEMPS_CAPACITY>: az index ahova a kovetkezo meresi erteket beszurjuk maradjon az ertelmezesi tartomanyban.
        || temps(nextIndex) := newTemp // uj meresi eredmeny eltarolasa
        || minTemp :(
            minTemp : TEMP & // trivialitas az alabbibol, de a bizonyitonak kell
            minTemp = min(ran(temps <+ {nextIndex |-> newTemp})) // legyen a minimuma az eddigi mereseknek es a most berakott elemnek
        )
        || maxTemp :(
            maxTemp : TEMP & // trivialitas az alabbibol, de a bizonyitonak kell
            maxTemp = max(ran(temps <+ {nextIndex |-> newTemp}))
        )
        || avgTemp :(
            avgTemp : TEMP & // a bizonyitonak kell
            avgTemp = SIGMA(xx).(xx:dom(temps <+ {nextIndex |-> newTemp}) | (temps <+ {nextIndex |-> newTemp})(xx)) / card(temps <+ {nextIndex |-> newTemp}) // atlagszamitas, egeszosztassal
        ) 
    END;
    
    ret <-- getMinTemp = // legkisebb ertek lekerese
    PRE
        temps /= {}
    THEN
       ret := minTemp
    END;
    
    ret <-- getMaxTemp = // legnagyobb ertek lekerese
    PRE
        temps /= {}
    THEN
       ret := maxTemp
    END;
    
    ret <-- getAvgTemp = // ertekek atlaganak lekerese
    PRE
        temps /= {}
    THEN
       ret := avgTemp
    END;
    
    init = // ha kell, ujra tudjuk inditani a gepet
    BEGIN  
        temps := {}
        || minTemp :: TEMP 
        || maxTemp :: TEMP
        || avgTemp :: TEMP
        || nextIndex := DOM_MIN
    END    

END

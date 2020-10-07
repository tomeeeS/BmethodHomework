Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(thermostat))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(thermostat))==(Machine(thermostat));
  Level(Machine(thermostat))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(thermostat)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(thermostat))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(thermostat))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(thermostat))==(?);
  List_Includes(Machine(thermostat))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(thermostat))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(thermostat))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(thermostat))==(?);
  Context_List_Variables(Machine(thermostat))==(?);
  Abstract_List_Variables(Machine(thermostat))==(?);
  Local_List_Variables(Machine(thermostat))==(isAvgComputed,isMaxComputed,isMinComputed,avgTemp,maxTemp,minTemp,temps);
  List_Variables(Machine(thermostat))==(isAvgComputed,isMaxComputed,isMinComputed,avgTemp,maxTemp,minTemp,temps);
  External_List_Variables(Machine(thermostat))==(isAvgComputed,isMaxComputed,isMinComputed,avgTemp,maxTemp,minTemp,temps)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(thermostat))==(?);
  Abstract_List_VisibleVariables(Machine(thermostat))==(?);
  External_List_VisibleVariables(Machine(thermostat))==(?);
  Expanded_List_VisibleVariables(Machine(thermostat))==(?);
  List_VisibleVariables(Machine(thermostat))==(?);
  Internal_List_VisibleVariables(Machine(thermostat))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(thermostat))==(btrue);
  Gluing_List_Invariant(Machine(thermostat))==(btrue);
  Expanded_List_Invariant(Machine(thermostat))==(btrue);
  Abstract_List_Invariant(Machine(thermostat))==(btrue);
  Context_List_Invariant(Machine(thermostat))==(btrue);
  List_Invariant(Machine(thermostat))==(temps: 1..TEMPS_CAPACITY +-> -50..120 & card(ran(temps))<=TEMPS_CAPACITY & dom(temps) = 1..card(ran(temps)) & minTemp: -50..120 & maxTemp: -50..120 & avgTemp: -50..120 & isMinComputed: BOOL & isMaxComputed: BOOL & isAvgComputed: BOOL & (temps = {} => isMinComputed = FALSE & isMaxComputed = FALSE & isAvgComputed = FALSE) & (isMinComputed = TRUE => minTemp = min(ran(temps))) & (isMaxComputed = TRUE => maxTemp = max(ran(temps))) & (isAvgComputed = TRUE => avgTemp = SIGMA(xx).(xx: dom(temps) | temps(xx))/card(temps)))
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(thermostat))==(btrue);
  Abstract_List_Assertions(Machine(thermostat))==(btrue);
  Context_List_Assertions(Machine(thermostat))==(btrue);
  List_Assertions(Machine(thermostat))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(thermostat))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(thermostat))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(thermostat))==(temps:={} || @(minTemp$0).(minTemp$0: -50..120 ==> minTemp:=minTemp$0) || @(maxTemp$0).(maxTemp$0: -50..120 ==> maxTemp:=maxTemp$0) || @(avgTemp$0).(avgTemp$0: -50..120 ==> avgTemp:=avgTemp$0) || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE);
  Context_List_Initialisation(Machine(thermostat))==(skip);
  List_Initialisation(Machine(thermostat))==(temps:={} || minTemp:: -50..120 || maxTemp:: -50..120 || avgTemp:: -50..120 || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(thermostat))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(thermostat))==(btrue);
  List_Constraints(Machine(thermostat))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(thermostat))==(addTemp,getMinTemp,getMaxTemp,getAvgTemp,init);
  List_Operations(Machine(thermostat))==(addTemp,getMinTemp,getMaxTemp,getAvgTemp,init)
END
&
THEORY ListInputX IS
  List_Input(Machine(thermostat),addTemp)==(newTemp);
  List_Input(Machine(thermostat),getMinTemp)==(?);
  List_Input(Machine(thermostat),getMaxTemp)==(?);
  List_Input(Machine(thermostat),getAvgTemp)==(?);
  List_Input(Machine(thermostat),init)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(thermostat),addTemp)==(?);
  List_Output(Machine(thermostat),getMinTemp)==(ret);
  List_Output(Machine(thermostat),getMaxTemp)==(ret);
  List_Output(Machine(thermostat),getAvgTemp)==(ret);
  List_Output(Machine(thermostat),init)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(thermostat),addTemp)==(addTemp(newTemp));
  List_Header(Machine(thermostat),getMinTemp)==(ret <-- getMinTemp);
  List_Header(Machine(thermostat),getMaxTemp)==(ret <-- getMaxTemp);
  List_Header(Machine(thermostat),getAvgTemp)==(ret <-- getAvgTemp);
  List_Header(Machine(thermostat),init)==(init)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(thermostat),addTemp)==(newTemp: -50..120);
  List_Precondition(Machine(thermostat),getMinTemp)==(temps/={});
  List_Precondition(Machine(thermostat),getMaxTemp)==(temps/={});
  List_Precondition(Machine(thermostat),getAvgTemp)==(temps/={});
  List_Precondition(Machine(thermostat),init)==(btrue)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(thermostat),init)==(btrue | temps:={} || @(minTemp$0).(minTemp$0: -50..120 ==> minTemp:=minTemp$0) || @(maxTemp$0).(maxTemp$0: -50..120 ==> maxTemp:=maxTemp$0) || @(avgTemp$0).(avgTemp$0: -50..120 ==> avgTemp:=avgTemp$0) || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE);
  Expanded_List_Substitution(Machine(thermostat),getAvgTemp)==(temps/={} | isAvgComputed,avgTemp,ret:=TRUE,SIGMA(xx).(xx: dom(temps) | temps(xx))/card(temps),SIGMA(xx).(xx: dom(temps) | temps(xx))/card(temps));
  Expanded_List_Substitution(Machine(thermostat),getMaxTemp)==(temps/={} | isMaxComputed,maxTemp,ret:=TRUE,max(ran(temps)),max(ran(temps)));
  Expanded_List_Substitution(Machine(thermostat),getMinTemp)==(temps/={} | isMinComputed,minTemp,ret:=TRUE,min(ran(temps)),min(ran(temps)));
  Expanded_List_Substitution(Machine(thermostat),addTemp)==(newTemp: -50..120 | @(tTemps,tTemps2).(tTemps: 1..card(temps)+1 +-> -50..120 & tTemps2: 1..TEMPS_CAPACITY +-> -50..120 & 1: dom(tTemps) & tTemps(1) = newTemp & !ii.(ii: 1..card(temps) => tTemps(ii+1) = temps(ii)) & tTemps2 = 1..TEMPS_CAPACITY<|tTemps & dom(tTemps2) = 1..card(ran(tTemps2)) ==> temps:=tTemps2) || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE);
  List_Substitution(Machine(thermostat),addTemp)==(ANY tTemps,tTemps2 WHERE tTemps: 1..card(temps)+1 +-> -50..120 & tTemps2: 1..TEMPS_CAPACITY +-> -50..120 & 1: dom(tTemps) & tTemps(1) = newTemp & !ii.(ii: 1..card(temps) => tTemps(ii+1) = temps(ii)) & tTemps2 = 1..TEMPS_CAPACITY<|tTemps & dom(tTemps2) = 1..card(ran(tTemps2)) THEN temps:=tTemps2 END || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE);
  List_Substitution(Machine(thermostat),getMinTemp)==(isMinComputed:=TRUE || minTemp:=min(ran(temps)) || ret:=min(ran(temps)));
  List_Substitution(Machine(thermostat),getMaxTemp)==(isMaxComputed:=TRUE || maxTemp:=max(ran(temps)) || ret:=max(ran(temps)));
  List_Substitution(Machine(thermostat),getAvgTemp)==(isAvgComputed:=TRUE || avgTemp:=SIGMA(xx).(xx: dom(temps) | temps(xx))/card(temps) || ret:=SIGMA(xx).(xx: dom(temps) | temps(xx))/card(temps));
  List_Substitution(Machine(thermostat),init)==(temps:={} || minTemp:: -50..120 || maxTemp:: -50..120 || avgTemp:: -50..120 || isMinComputed:=FALSE || isMaxComputed:=FALSE || isAvgComputed:=FALSE)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(thermostat))==(TEMPS_CAPACITY);
  Inherited_List_Constants(Machine(thermostat))==(?);
  List_Constants(Machine(thermostat))==(TEMPS_CAPACITY)
END
&
THEORY ListSetsX IS
  Context_List_Enumerated(Machine(thermostat))==(?);
  Context_List_Defered(Machine(thermostat))==(?);
  Context_List_Sets(Machine(thermostat))==(?);
  List_Valuable_Sets(Machine(thermostat))==(?);
  Inherited_List_Enumerated(Machine(thermostat))==(?);
  Inherited_List_Defered(Machine(thermostat))==(?);
  Inherited_List_Sets(Machine(thermostat))==(?);
  List_Enumerated(Machine(thermostat))==(?);
  List_Defered(Machine(thermostat))==(?);
  List_Sets(Machine(thermostat))==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(thermostat))==(?);
  Expanded_List_HiddenConstants(Machine(thermostat))==(?);
  List_HiddenConstants(Machine(thermostat))==(?);
  External_List_HiddenConstants(Machine(thermostat))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(thermostat))==(btrue);
  Context_List_Properties(Machine(thermostat))==(btrue);
  Inherited_List_Properties(Machine(thermostat))==(btrue);
  List_Properties(Machine(thermostat))==(TEMPS_CAPACITY: 100..100 & TEMPS_CAPACITY = 100)
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(thermostat),addTemp)==((Var(tTemps) == SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))),(Var(tTemps2) == SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))));
  List_ANY_Var(Machine(thermostat),getMinTemp)==(?);
  List_ANY_Var(Machine(thermostat),getMaxTemp)==(?);
  List_ANY_Var(Machine(thermostat),getAvgTemp)==(?);
  List_ANY_Var(Machine(thermostat),init)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(thermostat)) == (TEMPS_CAPACITY | ? | isAvgComputed,isMaxComputed,isMinComputed,avgTemp,maxTemp,minTemp,temps | ? | addTemp,getMinTemp,getMaxTemp,getAvgTemp,init | ? | ? | ? | thermostat);
  List_Of_HiddenCst_Ids(Machine(thermostat)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(thermostat)) == (TEMPS_CAPACITY);
  List_Of_VisibleVar_Ids(Machine(thermostat)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(thermostat)) == (?: ?)
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(thermostat)) == (Type(TEMPS_CAPACITY) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(thermostat)) == (Type(isAvgComputed) == Mvl(btype(BOOL,?,?));Type(isMaxComputed) == Mvl(btype(BOOL,?,?));Type(isMinComputed) == Mvl(btype(BOOL,?,?));Type(avgTemp) == Mvl(btype(INTEGER,?,?));Type(maxTemp) == Mvl(btype(INTEGER,?,?));Type(minTemp) == Mvl(btype(INTEGER,?,?));Type(temps) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(thermostat)) == (Type(init) == Cst(No_type,No_type);Type(getAvgTemp) == Cst(btype(INTEGER,?,?),No_type);Type(getMaxTemp) == Cst(btype(INTEGER,?,?),No_type);Type(getMinTemp) == Cst(btype(INTEGER,?,?),No_type);Type(addTemp) == Cst(No_type,btype(INTEGER,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)

/*
	Leader Agendas
	Authors: MC
*/

-----------------------------------------------
-- Types

-- This inserts the agenda's trait reference into the primary Data Types table as a usable trait. This is mandatory. The string listed under 'Type' must be used throughout the mod when referring to the TraitType.

-- It is customary for this to take the following format: TRAIT_AGENDA_PREFIX_LEADERNAME
-----------------------------------------------

INSERT INTO Types
			(Type,							Kind			)
VALUES		('TRAIT_AGENDA_MC_PO_NGBE',		'KIND_TRAIT'	);

-----------------------------------------------
-- Agendas

-- This defines the AgendaType itself, such that the agenda exists as an entity alongside the other agendas. We can then reference it to associate it with our leader.

-- All leaders are assigned at least one unique, known agenda, which is a mechanism the game uses to control their personality/behaviour.
-----------------------------------------------

INSERT INTO Agendas
			(AgendaType,			Name,							Description								)
VALUES 		('AGENDA_MC_PO_NGBE',	'LOC_AGENDA_MC_PO_NGBE_NAME',	'LOC_AGENDA_MC_PO_NGBE_DESCRIPTION'		);

-----------------------------------------------
-- Traits

-- With the TraitType defined (above), the below then inserts it into the overall Traits table. This allows it to exist in its own right, alongside other TraitType elements and ties it to the locally-referenced Name and Description text strings that name and describe the trait, respectively.
-----------------------------------------------

INSERT INTO Traits				
			(TraitType,						Name,							Description								)
VALUES		('TRAIT_AGENDA_MC_PO_NGBE',		'LOC_AGENDA_MC_PO_NGBE_NAME',	'LOC_AGENDA_MC_PO_NGBE_DESCRIPTION'		);

-----------------------------------------------
-- AgendaTraits

-- This defines the agenda to which the TraitType is applied. This is a simple matter of referencing the custom AgendaType defined above and using the TraitType defined at the head of this document.

-- We'll use the TraitType, later in this document, to apply some modifiers that influence the leader's behaviour.
-----------------------------------------------

INSERT INTO AgendaTraits
			(AgendaType,			TraitType					)
VALUES 		('AGENDA_MC_PO_NGBE',	'TRAIT_AGENDA_MC_PO_NGBE'	);

-----------------------------------------------
-- HistoricalAgendas

-- In this section, we assign our custom leader the AgendaType we've defined. This ensures that our leader's behaviour (when controlled by the AI) is influenced by the factors we'll specify (further down in this file).
-----------------------------------------------

INSERT INTO HistoricalAgendas
			(LeaderType,			AgendaType				)
VALUES 		('LEADER_MC_PO_NGBE',	'AGENDA_MC_PO_NGBE'		);

-----------------------------------------------
-- ExclusiveAgendas

-- In addition to a unique, known agenda, leaders are also assigned one hidden agenda at random upon the start of a new game. The ExclusiveAgendas table allows us a degree of control over the known (HistoricalAgendas) and hidden agendas that can be paired.

-- A pair of values in AgendaOne and AgendaTwo will never be assigned to the same leader. As such, we specify a list of agendas in AgendaTwo that we do not think pair cohesively with our AgendaType.

-- The list of base-game hidden agendas can be found in Agendas.xml (lins 250-273).
-----------------------------------------------

INSERT INTO ExclusiveAgendas
			(AgendaOne,				AgendaTwo					)
VALUES 		('AGENDA_MC_PO_NGBE',	'AGENDA_INDUSTRIALIST'		);

-----------------------------------------------
-- TraitModifiers

-- The below entries tie some specific modifiers to the TraitType. A modifier is the top-level item that instructs the game to perform a deviation away from the base ruleset in some way. In the case of Diplomacy effects, which is what Agendas are used to control, we specify two: one for UNHAPPY and one for HAPPY.

-- We'll flesh these out further in the sections below - but the general principle is that we will modify the 'happiness' value dependent on certain circumstances. This has the effect of adjusting the leader's opinion of you, over time, depending on the factors stipulated by the Requirement Sets.
-----------------------------------------------

INSERT INTO TraitModifiers
			(TraitType,						ModifierId								)
VALUES		('TRAIT_AGENDA_MC_PO_NGBE',		'AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY'	),
			('TRAIT_AGENDA_MC_PO_NGBE',		'AGENDA_MODIFIER_MC_PO_NGBE_HAPPY'		);
		
-----------------------------------------------
-- Modifiers

-- This section defines, for each of your modifiers, the type of modifier it is and the conditions under which it is applied.

-- The ModifierType is important - it governs the sphere of application of the effect(s) in question. Again, in the case of Diplomacy interactions, we leverage existing modifiers that exist in the game - which are configured to adjust a leader's stance from a diplomacy perspective. The SubjectRequirementSetId entries will be defined by us, further down in this file.
-----------------------------------------------

INSERT INTO Modifiers	
			(ModifierId,								ModifierType,									SubjectRequirementSetId			)
VALUES		('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',		'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'REQSET_MC_PO_NGBE_UNHAPPY'		),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',		'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'REQSET_MC_PO_NGBE_HAPPY'		);

-----------------------------------------------	
-- ModifierStrings

-- For each Modifier you have (typically, two for diplomacy - a happy and an unhappy instance), you will need an entry with the Context and Text values, as below. The 'Text' value, in particular, is a special reference that will present the diplomatic reason behind the reaction presented.

-- It is recommended not to amend these entries, except to ensure the ModifierId values match the ones you are configuring.
-----------------------------------------------	
INSERT INTO ModifierStrings
			(ModifierId,								Context,	Text								)
VALUES		('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',		'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'	),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',		'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'	);

-----------------------------------------------
-- ModifierArguments

-- The below entries define the variables required by the MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER that we leveraged earlier.

-- Together, these values trigger an immediate (and then turn-by-turn) adjustment of a leader's attitude towards an opponent. The values should be used as follows:

-- InitialValue: the initial adjustment made once the Modifier is triggered.
-- IncrementValue: the amount to adjust the value upon each increment.
-- IncrementTurns: the number of turns to pass before the next increment.
-- MaxValue: the threshold/limit value that can be reached through increments via this Modifier.

-- In all cases, the values adjust the leader's attitude in the case where the requirements are continuously met. Effectively, the leader will become happy/unhappy with you if you satisfy the criteria specified (in the Requirement Sets code, further down) and then get progressively happier/unhappier until they hit the limit. If the conditions stop being met, at some point, the leader's attitude will stay as it is and if the criteria are met again, the process will restart.

-- The values used here are just examples. It is worth exploring the existing Agendas (via Agendas.xml) to get a sense of the types of values used by the game, for balance purposes.
-----------------------------------------------

INSERT INTO ModifierArguments
			(ModifierId,							Name,							Value												)
VALUES		('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'InitialValue',					-5													),
			('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'IncrementValue',				-1													),
			('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'IncrementTurns',				-10													),
			('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'MaxValue',						-25													),
			('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'StatementKey',					'LOC_DIPLO_WARNING_LEADER_MC_PO_NGBE_REASON_ANY'	),
			('AGENDA_MODIFIER_MC_PO_NGBE_UNHAPPY',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_MC_PO_NGBE_UNHAPPY'				),
	
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'InitialValue',					5													),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'IncrementValue',				1													),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'IncrementTurns',				10													),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'MaxValue',						12													),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'StatementKey',					'LOC_DIPLO_KUDO_LEADER_MC_PO_NGBE_REASON_ANY'		),
			('AGENDA_MODIFIER_MC_PO_NGBE_HAPPY',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_MC_PO_NGBE_HAPPY'				);
			
-----------------------------------------------
-- RequirementSets

-- RequirementSets define the test criteria to verify whether a particular RequirementSetId returns 'true' (and therefore the code reliant on it is executed) or 'false' (and therefore is not).

-- The two values I am aware of for RequirementSetType are:

-- REQUIREMENTSET_TEST_ALL: Every listed criteria must return 'true' for an overall value of 'true'
-- REQUIREMENTSET_TEST_ANY: Any one listed criteria must return 'true' for an overall value of 'true'

-- In this section, we are specifying two different Requirement Sets - which set up the conditions to trigger either an UNHAPPY or HAPPY change to the leader's attitude.
-----------------------------------------------

INSERT INTO RequirementSets
			(RequirementSetId,				RequirementSetType			)
VALUES		('REQSET_MC_PO_NGBE_UNHAPPY',	'REQUIREMENTSET_TEST_ALL'	),
			('REQSET_MC_PO_NGBE_HAPPY',		'REQUIREMENTSET_TEST_ALL'	);

-----------------------------------------------
-- RequirementSetRequirements

-- Finally, we put together a number of criteria for each of the Requirement Sets. In this case, we are leveraging existing RequirementId values from the base-game.

-- For each RequirementSetId, we use some common values:

-- REQUIRES_MAJOR_CIV_OPPONENT: This stipulates that the opposition leader must be a major civilization.
-- REQUIRES_MET_10_TURNS_AGO: This stipulates that the civilizations must have been known to each other for at least 10 turns.

-- We then leverage a variation of RequirementId entries. In the case of the UNHAPPY reaction, we use REQUIRES_HAS_LOW_FAITH as our custom leader dislikes civilizations with low levels of Faith. For the HAPPY reaction, our custom leader expects the civilization to have both high Culture (REQUIRES_HAS_HIGH_CULTURE) and high Science (REQUIRES_HAS_HIGH_SCIENCE).

-- There are plenty of existing diplomacy-affecting requirements that can be found in Agendas.xml - I would recommend taking a look there and piecing together a personality for your custom leader accordingly.
-----------------------------------------------

INSERT INTO RequirementSetRequirements
			(RequirementSetId,				RequirementId						)
VALUES		('REQSET_MC_PO_NGBE_UNHAPPY',	'REQUIRES_MAJOR_CIV_OPPONENT'		),
			('REQSET_MC_PO_NGBE_UNHAPPY',	'REQUIRES_MET_10_TURNS_AGO'			),
			('REQSET_MC_PO_NGBE_UNHAPPY',	'REQUIRES_HAS_LOW_FAITH'			),
			('REQSET_MC_PO_NGBE_HAPPY',		'REQUIRES_MAJOR_CIV_OPPONENT'		),
			('REQSET_MC_PO_NGBE_HAPPY',		'REQUIRES_MET_10_TURNS_AGO'			),
			('REQSET_MC_PO_NGBE_HAPPY',		'REQUIRES_HAS_HIGH_CULTURE'			),
			('REQSET_MC_PO_NGBE_HAPPY',		'REQUIRES_HAS_HIGH_SCIENCE'			);

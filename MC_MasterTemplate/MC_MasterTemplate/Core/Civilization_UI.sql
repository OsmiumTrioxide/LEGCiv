/*
	Civilization Unique Infrastructure (Example: Improvement)

	Please note: the unique improvement implemented in this example utilises the logic and code found in Durkle's Olmec mod for Rise & Fall (available on the Steam Workshop). It is not my intention to publish this in any capacity, aside from using it as an interesting example for this template.

	If you have not yet stepped through the Civilization_UA.sql file, I would recommend attempting to work through that first. This example is a little more complex.
	
	Authors: MC & Durkle
*/

-----------------------------------------------
-- Types

-- This inserts the Unique Infrastructure reference into the primary Data Types table as a recognised trait. This is mandatory, if configuring a custom trait for your civilization. The string listed under 'Type' must be used throughout the mod when referring to the TraitType.

-- The standard naming convention follows: TRAIT_CIVILIZATION_UNIQUEITEMTYPE_TRAITNAME

-- Configuring Unique Infrastructure for your custom civilization is entirely optional, but it is typically considered appropriate for balance to configure one, such that your custom civilization matches those from the base games in terms of complexity, both for flavour and gameplay balance.

-- In this example mod, we are going to create a new version of the Colossal Head improvement which can only be built by our civilization. For info, this particular improvement is one that can be built by the Suzerain of a specific City-State. This mod does not alter the existence of that improvement - so it can also be built by the Suzerain of that City-State even with this mod loaded. However, by using the same element, we eliminate the need to configure anything to have the 2D artwork/icons and 3D model display in-game. The string 'INSERT OR REPLACE INTO' is used as a way to flexibly negotiate the fact that the IMPROVEMENT_COLOSSAL_HEAD already exists, whilst still allowing me to illustrate the code needed - as this particular improvement is, in fact, configured in the base game. 
-----------------------------------------------		

INSERT OR REPLACE INTO Types	
		(Type,													Kind						)
VALUES	('TRAIT_CIVILIZATION_IMPROVEMENT_OLMEC_COLOSSAL_HEAD',	'KIND_TRAIT'				),
		('IMPROVEMENT_COLOSSAL_HEAD',							'KIND_IMPROVEMENT'			);

-----------------------------------------------
-- CivilizationTraits

-- This defines the civilization to which the TraitType is applied (i.e. which civilization gets the Unique Infrastructure). This is a simple matter of referencing the custom CivilizationType defined in Civilization_Config.sql and using the TraitType defined in this document.
-----------------------------------------------
		
INSERT INTO CivilizationTraits
		(TraitType,												CivilizationType			)
VALUES	('TRAIT_CIVILIZATION_IMPROVEMENT_OLMEC_COLOSSAL_HEAD',	'CIVILIZATION_MC_OLMEC'		);

-----------------------------------------------
-- Traits

-- With the TraitType defined (above), the below then inserts it into the overall Traits table. This allows it to exist in its own right, alongside other TraitType elements and ties it to the locally-referenced Name and Description text strings that name and describe the trait, respectively.
-----------------------------------------------

INSERT INTO Traits
		(TraitType,												Name,											Description												)
VALUES	('TRAIT_CIVILIZATION_IMPROVEMENT_OLMEC_COLOSSAL_HEAD',	'LOC_IMPROVEMENT_OLMEC_COLOSSAL_HEAD_NAME',		'LOC_IMPROVEMENT_OLMEC_COLOSSAL_HEAD_DESCRIPTION'		);

--------------------------------------------------------------------------------------------------------------------------
-- Improvements

-- The below defines the core behaviour/configuration of our custom Improvement. This is where we instruct the game to ensure it is unique (by setting the TraitType value), as well as tie together the various locally-defined elements in this mod (ImprovementType, Name, Description, Icon).

-- You will note that the initial instruction is a DELETE. This clears the values from the base-game implementation of IMPROVEMENT_COLOSSAL_HEAD - paving the way for the behaviour/effect we define here.

-- Whilst the majority of information is locally-defined (in this mod), please note the PrereqCivic value, which is where we tell the game which Civic must be attained in order to unlock the Improvement.

-- If you have been following the documents in order, below you will find the first reference to an ICON element. The naming convention is always to append ICON_ in front of the full element name to which it applies. In this case, we're referencing an icon from the base-game; but the same logic should be applied throughout.
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Improvements WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT OR REPLACE INTO Improvements	
		(
			ImprovementType,
			Name,
			Description,
			Icon,
			-----------------
			-- Building Info
			-----------------
			Buildable,
			SameAdjacentValid,
			TraitType,
			PrereqCivic,
			-----------------
			-- Plunder Info
			-----------------
			PlunderType,
			PlunderAmount,
			-----------------
			-- Housing Info
			-----------------
			Housing,
			TilesRequired
		)
VALUES	
		(
			'IMPROVEMENT_COLOSSAL_HEAD', -- ImprovementType
			'LOC_IMPROVEMENT_OLMEC_COLOSSAL_HEAD_NAME', -- Name
			'LOC_IMPROVEMENT_OLMEC_COLOSSAL_HEAD_DESCRIPTION', -- Description
			'ICON_IMPROVEMENT_COLOSSAL_HEAD', -- Icon
			-----------------
			-- Building Info
			-----------------
			1, -- Buildable
			0, -- SameAdjacentValid
			'TRAIT_CIVILIZATION_IMPROVEMENT_OLMEC_COLOSSAL_HEAD', -- TraitType
			'CIVIC_MYSTICISM', -- PrereqCivic
			-----------------
			-- Plunder Info
			-----------------
			'PLUNDER_SCIENCE', -- PlunderType
			1, -- PlunderAmount
			-----------------
			-- Housing Info
			-----------------
			0, -- Housing
			1 -- TilesRequired
		);
-----------------------------------------------------------------------------------
-- Improvement_ValidTerrains

-- This section instructs the game on which TerrainType elements the Improvement can be built. As before, we are first performing a DELETE function to pave the way for our preferred behaviour.

-- The valid values for the TerrainType column can be derived from Terrains.xml (base-game), specifically those that are labelled with 'KIND_TERRAIN' within the core Game Data Types table.
-----------------------------------------------------------------------------------
DELETE FROM Improvement_ValidTerrains WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT OR REPLACE INTO Improvement_ValidTerrains
			(ImprovementType,								TerrainType				)
VALUES 		('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_GRASS'			),
			('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_GRASS_HILLS'	),
			('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_PLAINS'		),
			('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_PLAINS_HILLS'	),
			('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_TUNDRA'		),
			('IMPROVEMENT_COLOSSAL_HEAD',					'TERRAIN_TUNDRA_HILLS'	);

-----------------------------------------------------------------------------------
-- Improvement_ValidFeatures

-- This section instructs the game on which FeatureType elements the Improvement can be built. As before, we are first performing a DELETE function to pave the way for our preferred behaviour.

-- The valid values for the FeatureType column can be derived from Features.xml (base-game), specifically those that are labelled with 'KIND_FEATURE' within the core Game Data Types table.

-- As advised within Civilization_Config.sql (reference: StartBiasFeatures), the use of FeatureType entries from either Expansion1 or Expansion2 will dictate compatibility for your mod.
-----------------------------------------------------------------------------------
DELETE FROM Improvement_ValidFeatures WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT OR REPLACE INTO Improvement_ValidFeatures
			(ImprovementType,						FeatureType			)
VALUES 		('IMPROVEMENT_COLOSSAL_HEAD',			'FEATURE_JUNGLE'	);

-----------------------------------------------------------------------------------
-- Improvement_ValidBuildUnits

-- This section defines the UnitType elements that can perform the action to build the Improvement. In most cases, this will always be UNIT_BUILDER - but, naturally, there are other units which you may wish to grant this action.
-----------------------------------------------------------------------------------
INSERT or REPLACE INTO Improvement_ValidBuildUnits
			(ImprovementType,						UnitType			)
VALUES 		('IMPROVEMENT_COLOSSAL_HEAD',			'UNIT_BUILDER'		);

-----------------------------------------------------------------------------------
-- Improvement_YieldChanges

-- This section defines the change to the base yield of the plot/tile, that is applied once the Improvement is built.

-- YieldType must be chosen from the explicit list of YieldType elements, as follows: YIELD_CULTURE, YIELD_FAITH, YIELD_FOOD, YIELD_GOLD, YIELD_PRODUCTION or YIELD_SCIENCE.
-- YieldChange is an integer value and can be positive or negative. Please note that as this is an integer, it is entered 'raw' with no quotation-mark wrapper.
-----------------------------------------------------------------------------------	
DELETE FROM Improvement_YieldChanges WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT or REPLACE INTO Improvement_YieldChanges	
		(ImprovementType,					YieldType,						YieldChange		)
VALUES	('IMPROVEMENT_COLOSSAL_HEAD',		'YIELD_FAITH',					1				),
		('IMPROVEMENT_COLOSSAL_HEAD',		'YIELD_SCIENCE',				1				);		

-----------------------------------------------------------------------------------
-- Improvement_Adjacencies

-- This section defines the additional bonus to the yield the plot/tile with the Improvement provides should it have an adjacent District.

-- This section is optional and not all Improvements receive additional yield bonuses from adjacent districts.

-- The logic here consists of two parts - the first ties the YieldChangeID to the ImprovementType; the second section defines those YieldChangeID elements and their effect on the yield of the Improvement itself.

-- ID: This should match the YieldChangeId value in the first table and should be unique.
-- YieldType must be chosen from the explicit list of YieldType elements, as follows: YIELD_CULTURE, YIELD_FAITH, YIELD_FOOD, YIELD_GOLD, YIELD_PRODUCTION or YIELD_SCIENCE.
-- YieldChange is an integer value and can be positive or negative. Please note that as this is an integer, it is entered 'raw' with no quotation-mark wrapper.
-- TilesRequired is an integer that defines how many adjacent tiles of the defined type are required to trigger the YieldChange. For Districts, this must always be one.
-- AdjacentDistrict defines which type of District the game requires to be adjacent to the Improvement. This column can be replaced with a number of alternatives, for different effects: AdjacentFeature (string), AdjacentTerrain (string), AdjacentNaturalWonder (boolean), AdjacentSeaResource (boolean).
-----------------------------------------------------------------------------------
DELETE FROM Improvement_Adjacencies WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT or REPLACE INTO Improvement_Adjacencies	
		(ImprovementType,				YieldChangeId)
VALUES	('IMPROVEMENT_COLOSSAL_HEAD',	'OLMEC_COLOSSAL_HEAD_HOLY_SITE'		),
		('IMPROVEMENT_COLOSSAL_HEAD',	'OLMEC_COLOSSAL_HEAD_CAMPUS'		);

INSERT INTO Adjacency_YieldChanges
		(ID,								Description,	YieldType,			YieldChange,	TilesRequired,		AdjacentDistrict			)
VALUES	('OLMEC_COLOSSAL_HEAD_HOLY_SITE',	'Placeholder',	'YIELD_SCIENCE',	1,				1,					'DISTRICT_HOLY_SITE'		),
		('OLMEC_COLOSSAL_HEAD_CAMPUS',		'Placeholder',	'YIELD_FAITH',		1,				1,					'DISTRICT_CAMPUS'			);

-----------------------------------------------------------------------------------
-- Improvement_Tourism

-- This Improvement grants a bonus to Tourism following the discovery of a particular Technology. That effect is defined below - this is a fairly 'rare' flavour to add and I include it here to showcase the type of effect that is possible.

-- A search within Improvements.xml (base-game) for TOURISMSOURCE_ will showcase the way this effect is used by the game for certain improvements (including the original implementation of IMPROVEMENT_COLOSSAL_HEAD). This can be used as a good reference and serves as a reminder as to the presence of the DELETE instruction.
-----------------------------------------------------------------------------------	
DELETE FROM Improvement_Tourism WHERE ImprovementType = 'IMPROVEMENT_COLOSSAL_HEAD';

INSERT INTO Improvement_Tourism	
		(ImprovementType,				TourismSource,						PrereqTech,			ScalingFactor	)
VALUES	('IMPROVEMENT_COLOSSAL_HEAD',	'TOURISMSOURCE_SCIENCE',			'TECH_FLIGHT',		100				);

-------------------------------------
-- TraitModifiers

-- The below entry ties the effective modifiers to the TraitType. A modifier is the top-level item that instructs the game to perform a deviation away from the base ruleset in some way. The possibilities are endless, so these notes make no attempt to cover what can be done - only to instruct against the logic, step by step.

-- This template will walk you through an example, nonetheless; though I highly recommend spending some time familiarising yourself with the base-game files and/or the database to get a general appreciation of how things work.

-- Learning point: There are numerous ways to unfurl the logic that follows below. For me, the most effective way was a combination of following the base game data, trial and error and (admittedly) a healthy dose of asking for help.

-- Learning point: The starting point to search in the base game XML is to look-up an existing CivilizationType (e.g. CIVILIZATION_FRANCE) and note their TRAIT_CIVILIZATION_ that is neither the Unique Ability nor the Unique Unit. In France's case, it is TRAIT_CIVILIZATION_IMPROVEMENT_CHATEAU. Searching that will lead you to the ModifierId entry (or entries) that grant the various bonuses associated with that TraitType. You can apply this simple principle in order to look-up how the code is constructed, in every situation.
-------------------------------------
INSERT INTO TraitModifiers			
		(TraitType,													ModifierId								)
VALUES	('TRAIT_CIVILIZATION_IMPROVEMENT_OLMEC_COLOSSAL_HEAD', 		'OLMEC_COLOSSAL_HEAD_GREAT_ARTIST'		);

-------------------------------------
-- Modifiers

-- This section defines, for each of your modifiers, the type of modifier it is and the conditions under which it is applied.

-- The ModifierType is important - it governs the sphere of application of the effect(s) in question. It does this by having a defined pair of values linked to it - known as a CollectionType and an EffectType. The CollectionType instructs the game on which elements/items (all civilizations, one specific civilization, all cities of one civilization, etc) to apply the modifier, whilst the EffectType instructs the game as to what change to apply (grant more of a yield, increase combat strength, etc).

-- The naming convention for a ModifierType is typically: MODIFIER_COLLECTIONTYPE_EFFECTTYPE, where COLLECTIONTYPE and EFFECTTYPE cite the two parts that make up a modifier (explained directly above). I strongly recommend making use of existing ModifierType values until you are confident with creating your own. As a general principle, find an existing ability that is similar in construct to what you wish to achieve, look it up, identify the ModifierType it uses and then enter that into the ModifierType value(s) below.

-- There is an excellent guide available via CivFanatics that explains these concepts (and more) that I, once again, highly recommend:

-- https://forums.civfanatics.com/resources/using-modifiers-chapter-1-creating-and-attaching-modifiers.25683/ --

-- The ability we are configuring is to grant the player +1 Great Artist point for every city that has at least four Colossal Head improvements constructed. With that as our end goal, what follows are the various bits of logic required to stitch that together.

-- If you've already followed the walkthrough in Civilization_UA.sql, then the only 'new' concept introduced here is SubjectRequirementSetId. This is used to apply a set of criteria that must be met for the Modifier to be attached. Each section covers the logic applied individually.

-- You may also note that we are creating two Modifiers, here, despite only linking one to our trait. In this example, the second modifier is referenced by the first one (which has the MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER ModifierType). I'll detail how this works in the next code section.
-------------------------------------
INSERT INTO Modifiers	
		(ModifierId,										ModifierType,											SubjectRequirementSetId		)
VALUES	('OLMEC_COLOSSAL_HEAD_GREAT_ARTIST',				'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',				'OLMEC_4_COLOSSAL_HEAD'		),
		('OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT',			'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',			null						);

-------------------------------------
-- ModifierArguments

-- The below entries define the specific deviations from the base game ruleset that are applied when the modifier is executed and attached to the pertinent items.

-- The ModifierType governs the actual 'values' that are accepted within the Name column, which in turn governs the values that are accepted within the value column. I expect the below example data will make those connections clear.

-- More specifically, the EffectType that is used by the ModifierType directly dictates the values allowed. In our case, the two Modifiers have different types:

-- ModifierId: OLMEC_COLOSSAL_HEAD_GREAT_ARTIST
-- ModifierType: MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER
-- Expected variables: ModifierId (i.e. it is asking for the unique string of another Modifier)

-- ModifierId: OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT
-- ModifierType: MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS
-- Expected variables: GreatPersonClassType and Amount

-- You may note that the below section ties together two separate ModifierId elements by referencing the value of OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT to populate the value of OLMEC_COLOSSAL_HEAD_GREAT_ARTIST.
-------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,										Name,						Value										)
VALUES	('OLMEC_COLOSSAL_HEAD_GREAT_ARTIST',				'ModifierId',				'OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT'	),
		('OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT',			'GreatPersonClassType',		'GREAT_PERSON_CLASS_ARTIST'					),
		('OLMEC_COLOSSAL_HEAD_GREAT_ARTIST_POINT',			'Amount',					1											);

-------------------------------------
-- RequirementSets

-- RequirementSets define the test criteria to verify whether a particular RequirementSetId returns 'true' (and therefore the code reliant on it is executed) or 'false' (and therefore is not).

-- The two values I am aware of for RequirementSetType are:

-- REQUIREMENTSET_TEST_ALL: Every listed criteria must return 'true' for an overall value of 'true'
-- REQUIREMENTSET_TEST_ANY: Any one listed criteria must return 'true' for an overall value of 'true'

-- In this section, we are specifying two different Requirement Sets - the first (OLMEC_4_COLOSSAL_HEAD) is the one that dictates whether our first modifier is executed by checking whether the number of improvements meets a certain threshold, whilst the second (PLOT_HAS_OLMEC_COLOSSAL_HEAD) is used to count the number of improvements on a per-tile basis.

-- This particular example daisy-chains two RequirementSetId elements together - further down, you'll see that one references the other. It's essentially a 'layered' requirement - one feeds the other.
-------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId,						RequirementSetType				)
VALUES	('OLMEC_4_COLOSSAL_HEAD',				'REQUIREMENTSET_TEST_ALL'		),
		('PLOT_HAS_OLMEC_COLOSSAL_HEAD',		'REQUIREMENTSET_TEST_ALL'		);

-------------------------------------
-- RequirementSetRequirements

-- RequirementSetRequirements tie the RequirementSetId to the actual requirement - you'll note from earlier that our Modifier is looking for a RequirementSetId to return 'true'. Below is where we expand the logic of the specific checks the game will perform to determine the result of that check.

-- In the below table, we're simply mapping a RequirementSetId to a RequirementId. All of these values are held locally, in this mod, as we'll be defining the RequirementId parameters ourselves.
-------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId									)
VALUES	('OLMEC_4_COLOSSAL_HEAD',				'OLMEC_4_COLOSSAL_HEAD_REQUIREMENT'				),
		('PLOT_HAS_OLMEC_COLOSSAL_HEAD',		'PLOT_HAS_OLMEC_COLOSSAL_HEAD_REQUIREMENT'		);

-------------------------------------
-- Requirements

-- The game logic defines that every Requirement identifies a RequirementType - the below table is, therefore, needed, to create this mapping. It dictates the values that we'll be inserting into the RequirementArguments table. A mismatch here would lead the game to not being able to make sense of the values as a cohesive series.

-- Again, we're using two RequirementId entries because in our RequirementArguments (further below), we'll be using the value of one to drive the check for the other.

--Because the final table (further below) is where the logic is tied together, we'll walk through it all in the notes in that section.
-------------------------------------
INSERT INTO Requirements
		(RequirementId, 									RequirementType									)
VALUES	('OLMEC_4_COLOSSAL_HEAD_REQUIREMENT',				'REQUIREMENT_COLLECTION_COUNT_ATLEAST'			),
		('PLOT_HAS_OLMEC_COLOSSAL_HEAD_REQUIREMENT',		'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES'		);

-------------------------------------
-- RequirementArguments

-- The RequirementArguments is where the specific values that the check is looking to reference are defined. In conjunction with the RequirementType, this gives the game enough information to know whether the check returns a 'true' or a 'false' result.

-- So what does all of this result in?

-- In order to achieve our desired effect, which is to grant a Great Artist Point for a city having at least four Colossal Head improvements built, the game must identify this.

-- The RequirementArguments below for OLMEC_4_COLOSSAL_HEAD_REQUIREMENT are used in conjunction with the REQUIREMENT_COLLECTION_COUNT_ATLEAST RequirementType. This surfaces us the CollectionType column, which we specify as COLLECTION_CITY_PLOT_YIELDS. This allows the check to be performed on a per-city basis. We specify the count as 4 and we then point our RequirementSetId to the other RequirementSetId, which is where the link between the two is established.

-- The PLOT_HAS_OLMEC_COLOSSAL_HEAD RequirementSetId is a little more simple - it's RequirementType is REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES, which is self-explanatory. We enter a single RequirementArgument, which looks for our ImprovementType.

-- Now we have all of this logic, if we follow this back up the document, we note that we establish the specifics of the argument as being four Colossal Heads in a single city in the latter sections. It is only a valid check if all of the RequirementArguments are true, as dictated by the RequirementSets table. It is our earlier Modifiers that are subjected to these requirements being met. If they are, then the Modifier - which is tied to the Civilization via a Trait (this is what makes it unique) provides an effect, which in our case is the additional Great Artist Point per turn.
-------------------------------------
INSERT INTO RequirementArguments
		(RequirementId, 								Name,						Value							)
VALUES	('OLMEC_4_COLOSSAL_HEAD_REQUIREMENT', 			'CollectionType',			'COLLECTION_CITY_PLOT_YIELDS'	),
		('OLMEC_4_COLOSSAL_HEAD_REQUIREMENT', 			'Count',					4								),
		('OLMEC_4_COLOSSAL_HEAD_REQUIREMENT', 			'RequirementSetId',			'PLOT_HAS_OLMEC_COLOSSAL_HEAD'	),
		('PLOT_HAS_OLMEC_COLOSSAL_HEAD_REQUIREMENT', 	'ImprovementType',			'IMPROVEMENT_COLOSSAL_HEAD'		);
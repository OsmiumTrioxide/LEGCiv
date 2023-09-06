/*
	Civilization Unique Unit

	Please note: the unique unit configured here replaces an existing unit in the 'food-chain' - which is the case for the majority of unique units that are included in the base game.

	It is, however, not required that a unique unit replaces an existing unit.
	
	Authors: MC
*/

-----------------------------------------------
-- Types

-- This inserts the Unique Unit reference into the primary Data Types table as a recognised trait. This is mandatory, if configuring a custom trait for your civilization. The string listed under 'Type' must be used throughout the mod when referring to the TraitType. In addition, we are inserting the Unit itself (UNIT_MC_WEREJAGUAR) and defining the UnitAbility (ABILITY_WEREJAGUAR), which is then tied to this unit (and no others).

-- The standard naming convention follows: TRAIT_CIVILIZATION_UNIQUEUNITNAME

-- Configuring a Unique Unit for your custom civilization is entirely optional, but it is typically considered appropriate for balance to configure at least one, such that your custom civilization matches those from the base games in terms of complexity, both for flavour and gameplay balance (in my opinion).
-----------------------------------------------	
	
INSERT INTO Types
		(Type,									Kind			)
VALUES	('TRAIT_CIVILIZATION_MC_WEREJAGUAR',	'KIND_TRAIT'	),
		('UNIT_MC_WEREJAGUAR',					'KIND_UNIT'		),
		('ABILITY_MC_WEREJAGUAR',				'KIND_ABILITY'	);

-----------------------------------------------
-- Tags

-- Certain game functions are aligned to groups of units (known as classes), rather than the individual unit-types themselves. For this reason, here we define the class (CLASS_MC_WEREJAGUAR) - we will later associate the unit to this class (as the only unit of that class) but also the UnitAbility to that same class. The below table INSERT paves the way for the special ability to be applied to our custom unit.
-----------------------------------------------	
	
INSERT INTO Tags
		(Tag,						Vocabulary		)
VALUES	('CLASS_MC_WEREJAGUAR',		'ABILITY_CLASS'	);

-----------------------------------------------
-- TypeTags

-- As mentioned above, we now link the Unit itself (UNIT_MC_WEREJAGUAR) to our newly-defined class (CLASS_MC_WEREJAGUAR). The second set of values associate the newly-defined Unit Ability (ABILITY_MC_WEREJAGUAR) to all objects within that same class (CLASS_MC_WEREJAGUAR).

-- The second INSERT function ensures our new Unit (UNIT_MC_WEREJAGUAR) inherits the classes that the UNIT_SPEARMAN already has configured. This ensures that groups to which the UNIT_SPEARMAN belongs, the UNIT_MC_WEREJAGUAR also belongs. This ensures integration with other Unit Abilities and identifications and allows for a cohesive replacement.
-----------------------------------------------		

INSERT INTO TypeTags
		(Type,						Tag						)
VALUES	('UNIT_MC_WEREJAGUAR',		'CLASS_MC_WEREJAGUAR'	),
		('ABILITY_MC_WEREJAGUAR',	'CLASS_MC_WEREJAGUAR'	);

INSERT INTO TypeTags (Type,		Tag)
SELECT 	'UNIT_MC_WEREJAGUAR',	Tag
FROM 	TypeTags
WHERE 	Type = 'UNIT_SPEARMAN';

-----------------------------------------------
-- Traits

-- With the TraitType defined (above), the below then inserts it into the overall Traits table. This allows it to exist in its own right, alongside other TraitType elements and ties it to the locally-referenced Name and Description text strings that name and describe the trait, respectively.
-----------------------------------------------
		
INSERT INTO Traits
		(TraitType,								Name,								Description								)
VALUES	('TRAIT_CIVILIZATION_MC_WEREJAGUAR',	'LOC_UNIT_MC_WEREJAGUAR_NAME',		'LOC_UNIT_MC_WEREJAGUAR_DESCRIPTION'	);

-----------------------------------------------
-- CivilizationTraits

-- This defines the civilization to which the TraitType is applied (i.e. which civilization gets the Unique Unit). This is a simple matter of referencing the custom CivilizationType defined in Civilization_Config.sql and using the TraitType defined in this document.
-----------------------------------------------
		
INSERT INTO CivilizationTraits
		(CivilizationType,				TraitType								)
VALUES	('CIVILIZATION_MC_OLMEC',		'TRAIT_CIVILIZATION_MC_WEREJAGUAR'		);

-----------------------------------------------
-- Units

-- The below defines the core behaviour/configuration of our custom Unit. This is where we instruct the game to ensure it is unique (by setting the TraitType value), as well as tie together the various locally-defined elements in this mod (UnitType, Name, Description).

-- You will note that the full set of values is populated via a hybrid of methods - some are taken from the UNIT_SPEARMAN that UNIT_MC_WEREJAGUAR replaces, whilst others are brand-new values that we've defined in this mod.

-- For integer values, it is possible to set a relative value by using simple mathematical operators - you'll note that we do this for the unit Cost and the Combat (Strength). What we're saying here is that the UNIT_MC_WEREJAGUAR has a Cost that is 15 higher than the UNIT_SPEARMAN, but it also has a Combat Strength of 5 more.

-- It is, of course, possible to explicitly define every value - in which case, the SELECT command would be replaced by VALUES; whilst the FROM and WHERE commands can be removed. As a syntax note: remember that if you use VALUES, you will need to use open ( and close ) parentheses to achieve valid code. The SELECT command does not require these, hence they are not present here.

-----------------------------------------------	
	
INSERT INTO Units	(
		UnitType,
		Name,
		Description,
		TraitType,
		BaseMoves,
		Cost,
		PurchaseYield,
		AdvisorType,
		Combat,
		RangedCombat,
		Range,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance,
		MandatoryObsoleteTech,
		PrereqTech,
		PrereqCivic
		)
SELECT	'UNIT_MC_WEREJAGUAR',	-- UnitType
		'LOC_UNIT_MC_WEREJAGUAR_NAME',	-- Name
		'LOC_UNIT_MC_WEREJAGUAR_DESCRIPTION', -- Description
		'TRAIT_CIVILIZATION_MC_WEREJAGUAR', -- TraitType
		BaseMoves,
		Cost + 15,
		PurchaseYield,
		AdvisorType,
		Combat + 5,
		RangedCombat,
		Range,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance,
		MandatoryObsoleteTech,
		PrereqTech,
		PrereqCivic
FROM	Units
WHERE	UnitType = 'UNIT_SPEARMAN';

-----------------------------------------------
-- UnitUpgrades

-- This section defines the position in the UnitUpgrades chain that the custom UNIT_MC_WEREJAGUAR fits into. For this mod, we are simply replacing the UNIT_SPEARMAN, so this ensures the continuity of the UNIT_SPEARMAN chain for the UNIT_MC_WEREJAGUAR.
-----------------------------------------------
		
INSERT INTO UnitUpgrades (Unit,	UpgradeUnit)
SELECT 	'UNIT_MC_WEREJAGUAR',	UpgradeUnit
FROM 	UnitUpgrades
WHERE	Unit = 'UNIT_SPEARMAN';

-----------------------------------------------
-- UnitAiInfos

-- UnitAiInfos are used to help mould the AI behaviour for Units. They essentially link each UnitType to one or more types of AI behaviour - such as exploration, melee combat or ranged combat.

-- In the below example, we are simply inheriting the UNIT_SPEARMAN behaviour for our UNIT_MC_WEREJAGUAR.

-- A full list of UnitAiType entries can be found in Units.xml. A search for the string 'UnitAiType' will find the full list.
-----------------------------------------------
		
INSERT INTO UnitAiInfos (UnitType,	AiType)
SELECT 	'UNIT_MC_WEREJAGUAR',		AiType
FROM 	UnitAiInfos
WHERE 	UnitType = 'UNIT_SPEARMAN';
		
-----------------------------------------------
-- UnitReplaces

-- This command tells the game about the replacement itself - this ensures that for any civilization to whom the UNIT_MC_WEREJAGUAR is available (which is only this custom civilization, thanks to the link to the TraitType), the UNIT_SPEARMAN will not be available; replaced instead by the UNIT_MC_WEREJAGUAR.
-----------------------------------------------
		
INSERT INTO UnitReplaces
		(CivUniqueUnitType,		ReplacesUnitType	)
VALUES	('UNIT_MC_WEREJAGUAR',	'UNIT_SPEARMAN'		);

-----------------------------------------------
-- UnitAbilities

-- Whilst we inserted the UnitAbilityType into the core data table earlier in this document, we need the below to allow it to exist in its own right, alongside other UnitAbilityType elements. This also ties it to the locally-referenced Name and Description text strings that name and describe the Unit Ability, respectively.

-- It is worth noting that applying an ability to the unit is optional - it's an extra layer on top of any 'standard' variables that are common to all units. This particular ability enables this template to showcase the way that a Modifier can be used to change the effectiveness of our custom unit in certain situations. These kind of unit abilities are granted to units by class in the base-game on many occasions - for example, granting Anti-Cavalry units a bonus versus Cavalry units. The logic is identical.
-----------------------------------------------

INSERT INTO UnitAbilities
		(UnitAbilityType,			Name,								Description						)
VALUES	('ABILITY_MC_WEREJAGUAR',	'LOC_UNIT_MC_WEREJAGUAR_NAME',		'LOC_ABILITY_MC_WEREJAGUAR'		);

-----------------------------------------------
-- Modifiers

-- If you've been following this in order, you may be well-versed in Modifiers by this point.

-- This particular Modifier is a little different - as it references an OwnerRequirementSetId. This instructs the game to implement this Modifier only when the requirements are met - but these requirements pertain to an OwnerRequirementSetId.

-- We are using this kind of requirement due to the nature of the ability. We are giving a particular unit a combat boost during a Golden Age. Golden Ages are granted to a civilization and the civilization is the owner of the unit in question. In this case, context is important. The use of OwnerRequirementSetId ensures it is only when the custom civilization, that has the UNIT_MC_WEREJAGUAR, is in a Golden Age will the effect apply. SubjectRequirementSetId would be used in cases where we want to check a variable is true in the context of the unit - for example, that it is in a certain terrain, or that it has a particular type of opponent in combat.

-- Compatibility note: Golden Ages were introduced in Rise & Fall. This particular unit ability requires that expansion to function. Specifically, the requirement creates the dependency on the expansion.
-----------------------------------------------
	
INSERT INTO Modifiers	
		(ModifierId,									ModifierType,									OwnerRequirementSetId		)
VALUES	('MODIFIER_WEREJAGUAR_GOLDEN_AGE_STRENGTH',		'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',			'PLAYER_HAS_GOLDEN_AGE'		);

-----------------------------------------------
-- ModifierArguments

-- This is fairly straightforward - it defines the values that change when the Modifier is applied. As with other Modifiers, these values are used in conjunction with the ModifierType (referenced above). In this case, we're instructing the Amount to increase 5. A negative value would reduce the Combat Strength. The fact that this is targeting the Combat Strength value at all is derived from the ModifierType.

-- The ModifierType governs the actual 'values' that are accepted within the Name column, which in turn governs the values that are accepted within the value column. I expect the below example data will make those connections clear.

-- More specifically, the EffectType that is used by the ModifierType directly dictates the values allowed.

-- This is what makes the ModifierType so important - this is one of the key parts of the game where the entries you configure are not all explicitly listed. In isolation, the below ModifierArgument could mean (or apply to) a number of things. However, the context of the ModifierType dictates that this Amount is, in fact, a Combat Strength increase.
-----------------------------------------------

INSERT INTO ModifierArguments		
		(ModifierId,										Name,						Value	)
VALUES	('MODIFIER_WEREJAGUAR_GOLDEN_AGE_STRENGTH',			'Amount',					5		);

-----------------------------------------------
-- UnitAbilityModifiers

-- In order to link the UnitAbility and the Modifier we have set up, we need to use the UnitAbilityModifiers table.

-- This simply ties the two elements together - it ensures that any unit that has the ABILITY_MC_WEREJAGUAR UnitAbilityType will receive the bonus granted by the MODIFIER_WEREJAGUAR_GOLDEN_AGE_STRENGTH Modifier.

-- We specified the CLASS_MC_WEREJAGUAR as being the only one linked to the ABILITY_MC_WEREJAGUAR earlier in this document (using the TypeTags table). This way, we ensure that the only unit to get this ability is, in fact, the Werejaguar.
-----------------------------------------------

INSERT INTO UnitAbilityModifiers
		(UnitAbilityType,				ModifierId									)
VALUES	('ABILITY_MC_WEREJAGUAR',		'MODIFIER_WEREJAGUAR_GOLDEN_AGE_STRENGTH'	);

-----------------------------------------------
-- ModifierStrings

-- The final element of the Unique Unit gameplay configuration simply adds the tooltip-style preview that describes this unit's special ability.

-- In this case, this also appears as part of the combat preview when you are deciding to attack an enemy unit.

-- We tie this to the Modifier, as the ability is triggered based on certain criteria being met. This is essentially what makes it an 'ability' rather than a staple part of that unit. Other ModifierStrings can be cross-referenced from UnitAbilities.xml.
-----------------------------------------------

INSERT INTO ModifierStrings
		(ModifierId,									Context,		Text							)
VALUES	('MODIFIER_WEREJAGUAR_GOLDEN_AGE_STRENGTH',		'Preview',		'LOC_ABILITY_MC_WEREJAGUAR'		);
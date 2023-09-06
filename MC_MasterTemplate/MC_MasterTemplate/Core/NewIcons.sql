/*
	Civilization Icons

	Authors: MC
*/

-----------------------------------------------
-- IconTextureAtlases

-- We use a single document to define all of our new ICON elements. This keeps things in one place and acts as a nice 'checklist' for every icon file we'll need to ensure exists.

-- Briefly, we'll explain what the IconTextureAtlases are. An 'atlas', in this context, is a series of graphics that all contain icons of a certain type, albeit in different sizes. In our example template, we have four different atlases: the CIVILIZATION, the LEADER, the UNIQUE UNIT and the UNIQUE INFRASTRUCTURE.

-- The definitions below illustrate how each is defined.

-- Name: This defines the name of the atlas. This is the element that is referenced in other parts of this document.
-- IconSize: Fairly self-explanatory, but this is the width (or height) of one icon (within the atlas) in pixels. All icons (game-wide) have square dimensions (1:1).
-- IconsPerRow: This defines the number of icons there are across the entire width of the atlas file. The total width of the DDS file should be equal to IconSize x IconsPerRow. If you are creating every icon as a separate file, the value here will always be 1.
-- IconsPerColumn: This defines the number of icons there are along the entire height of the atlas file. The total height of the DDS file should be equal to IconSize x IconsPerColumn. If you are creating every icon as a separate file, the value here will always be 1.
-- Filename: Again, fairly self-explanatory. This should be the complete, case-sensitive name of the DDS file that pertains to the graphic for that entry. All files referenced here must be located in the root of the Textures folder.

-- A quick note on the ICON_ATLAS_MC_WEREJAGUAR atlas. I've left this in here, configured in this way, to illustrate how to use multi-icon atlases. In this example, each WerejaguarAtlasXXX.dds file has two icons - the Unique Unit icon and Unique Unit portrait. We'll describe further down how we differentiate to the game which should be used for which function through the IconDefinitions section.

-- Please note: I have included a sample configuration for the ICON_ATLAS_COLOSSAL_HEAD but you may note that this is not referenced in the IconDefinitions. The ICON_COLOSSAL_HEAD exists in the base-game and therefore this is just to illustrate which icon-sizes are required for an Improvement.
-----------------------------------------------

INSERT INTO IconTextureAtlases	
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,		Filename					)
VALUES	('ICON_ATLAS_MC_OLMEC',					22,	 		1,				1,					'OlmecAtlas22.dds'			),
		('ICON_ATLAS_MC_OLMEC',					30,	 		1,				1,					'OlmecAtlas30.dds'			),
		('ICON_ATLAS_MC_OLMEC',					36,	 		1,				1,					'OlmecAtlas36.dds'			),
		('ICON_ATLAS_MC_OLMEC',					44,	 		1,				1,					'OlmecAtlas44.dds'			),
		('ICON_ATLAS_MC_OLMEC',					48,	 		1,				1,					'OlmecAtlas48.dds'			),
		('ICON_ATLAS_MC_OLMEC',					50,	 		1,				1,					'OlmecAtlas50.dds'			),
		('ICON_ATLAS_MC_OLMEC',					64,	 		1,				1,					'OlmecAtlas64.dds'			),
		('ICON_ATLAS_MC_OLMEC',					80,	 		1,				1,					'OlmecAtlas80.dds'			),
		('ICON_ATLAS_MC_OLMEC',					200, 		1,				1,					'OlmecAtlas200.dds'			),
		('ICON_ATLAS_MC_OLMEC',					256, 		1,				1,					'OlmecAtlas256.dds'			),

		('ICON_ATLAS_MC_PO_NGBE',				32,	 		1,				1,					'PoNgbeIcon32.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				45,	 		1,				1,					'PoNgbeIcon45.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				48,	 		1,				1,					'PoNgbeIcon48.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				50,	 		1,				1,					'PoNgbeIcon50.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				55,	 		1,				1,					'PoNgbeIcon55.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				64,			1,				1,					'PoNgbeIcon64.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				80,	 		1,				1,					'PoNgbeIcon80.dds'			),
		('ICON_ATLAS_MC_PO_NGBE',				256,	 	1,				1,					'PoNgbeIcon256.dds'			),
		
		('ICON_ATLAS_MC_WEREJAGUAR',			22,			2,				1,					'WerejaguarAtlas22.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			32,			2,				1,					'WerejaguarAtlas32.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			38,			2,				1,					'WerejaguarAtlas38.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			50,			2,				1,					'WerejaguarAtlas50.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			70,			2,				1,					'WerejaguarAtlas70.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			80,			2,				1,					'WerejaguarAtlas80.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			95,			2,				1,					'WerejaguarAtlas95.dds'		),
		('ICON_ATLAS_MC_WEREJAGUAR',			200,		2,				1,					'WerejaguarAtlas200.dds'	),
		('ICON_ATLAS_MC_WEREJAGUAR',			256,		2,				1,					'WerejaguarAtlas256.dds'	),
		
		('ICON_ATLAS_COLOSSAL_HEAD',			38,			1,				1,					'ColossalHead38.dds'		),
		('ICON_ATLAS_COLOSSAL_HEAD',			40,			1,				1,					'ColossalHead40.dds'		),
		('ICON_ATLAS_COLOSSAL_HEAD',			50,			1,				1,					'ColossalHead50.dds'		),
		('ICON_ATLAS_COLOSSAL_HEAD',			80,			1,				1,					'ColossalHead80.dds'		),
		('ICON_ATLAS_COLOSSAL_HEAD',			200,		1,				1,					'ColossalHead200.dds'		),
		('ICON_ATLAS_COLOSSAL_HEAD',			256,		1,				1,					'ColossalHead256.dds'		);

-----------------------------------------------
-- IconDefinitions

-- With the IconTextureAtlases defined, we now tie each Atlas to a specific icon-type.

-- The icon Name is defined in the table below and the Atlas tells the game where to pull the graphic from. The Index field directs the game to the right portion of the file, should there be more than one icon. The Index is an integer value in the form of an array - starting from 0, with icons numbered from left-to-right, row-by-row. In this way, we use the ICON_ATLAS_MC_WEREJAGUAR Atlas, which has two icons in a single file, to drive the display of two distinct in-game icons.
-----------------------------------------------

INSERT INTO IconDefinitions
		(Name,										Atlas,							'Index'				)
VALUES	('ICON_CIVILIZATION_MC_OLMEC',				'ICON_ATLAS_MC_OLMEC',			0					),
		('ICON_LEADER_MC_PO_NGBE',					'ICON_ATLAS_MC_PO_NGBE',		0					),
		('ICON_UNIT_MC_WEREJAGUAR_PORTRAIT',		'ICON_ATLAS_MC_WEREJAGUAR',		0					),
		('ICON_UNIT_MC_WEREJAGUAR',					'ICON_ATLAS_MC_WEREJAGUAR',		1					);
/*
	Civilization Historic Moments
	Authors: MC
*/

-----------------------------------------------
-- Moment Illustrations

-- This adds new Historic Moments to the custom civilization's timeline, triggered by the training of the Unique Unit and building of the Unique Improvement respectively.

-- MomentIllustrationType: these are game-referenced values that exist within the Rise & Fall (Expansion1) files.
-- MomentDataType: similarly, these classes are defined within the Rise & Fall (Expansion1) files.
-- GameDataType: these values will be defined locally (within this mod), unless you are using a Unique Unit or Unique Improvement that exists elsewhere (base game, or some other mod).
-- Texture: this references the 2D image that will appear when this Historic Moment is triggered. The DDS files should exist within this mod, included under the Textures folder.

-- Please note: For the below code to be used, Rise & Fall (Expansion1) is required.
-----------------------------------------------
INSERT INTO MomentIllustrations
		(MomentIllustrationType,					MomentDataType,					GameDataType,						Texture								)
VALUES	('MOMENT_ILLUSTRATION_UNIQUE_UNIT',			'MOMENT_DATA_UNIT',				'UNIT_MC_WEREJAGUAR',				'WerejaguarHistoricMoment.dds'		),
		('MOMENT_ILLUSTRATION_UNIQUE_IMPROVEMENT',	'MOMENT_DATA_IMPROVEMENT',		'IMPROVEMENT_COLOSSAL_HEAD',		'ColossalHeadHistoricMoment.dds'	);

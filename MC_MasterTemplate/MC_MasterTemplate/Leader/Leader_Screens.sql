/*
	Leader Screen Configuration
	Authors: MC
*/

-----------------------------------------------
-- LoadingInfo

-- A simple section of code that ties together the elements that appear on the Loading Screen - which is used both during new game creation and loading of existing save games.

-- The LeaderType is the locally-defined LeaderType for your custom civililaztion, whilst the ForegroundImage and BackgroundImage are self-explanatory.

-- The entry for the BackroundImage should match the filename (without the extension), but should also, specifically, be in the format: LEADER_PREFIX_LEADERNAME_BACKGROUND.

-- PlayDawnOfManAudio is a boolean value - with 0 disabling the audio speech and 1 enabling it.
-----------------------------------------------

INSERT INTO LoadingInfo
			(LeaderType,			ForegroundImage,					BackgroundImage,					PlayDawnOfManAudio	)
VALUES		('LEADER_MC_PO_NGBE',	'LEADER_MC_PO_NGBE_NEUTRAL',		'LEADER_MC_PO_NGBE_BACKGROUND',		0					);

--------------------------------------------------------------------------------------------------------------------------		
-- Background Art

-- The below section specifies the image to be used on the Diplomacy Screen, as a background. For flavour, this is typically a specific/unique image for your custom civilization, rather than the more generic LoadingInfo's BackgroundImage which is a tinted version of the 'world map' used by all civilizations in the base-game.

-- The entry for the BackroundImage should match the filename (without the extension).

-- Please note: the foreground image of the leader, on the Diplomacy Screen, is configured via an ArtDef file and does not require any associated code.
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO DiplomacyInfo			
			(Type,						BackgroundImage					)
VALUES		('LEADER_MC_PO_NGBE',		'LEADER_PO_NGBE_DIPLO_BG'		);
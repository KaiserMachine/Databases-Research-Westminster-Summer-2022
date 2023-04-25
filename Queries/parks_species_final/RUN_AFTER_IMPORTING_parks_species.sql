-- Add State Names SQL
SET SQL_SAFE_UPDATES=0;

UPDATE State SET stateName = "Maine" WHERE stateCode = "ME";
UPDATE State SET stateName = "Utah" WHERE stateCode = "UT";
UPDATE State SET stateName = "South Dakota" WHERE stateCode = "SD";
UPDATE State SET stateName = "Texas" WHERE stateCode = "TX";
UPDATE State SET stateName = "Florida" WHERE stateCode = "FL";
UPDATE State SET stateName = "Colorado" WHERE stateCode = "CO";
UPDATE State SET stateName = "California" WHERE stateCode = "CA";
UPDATE State SET stateName = "New Mexico" WHERE stateCode = "NM";
UPDATE State SET stateName = "Calfornia" WHERE stateCode = "CA";
UPDATE State SET stateName = "South Carolina" WHERE stateCode = "SC";
UPDATE State SET stateName = "Oregon" WHERE stateCode = "OR";
UPDATE State SET stateName = "Ohio" WHERE stateCode = "OH";
UPDATE State SET stateName = "Alaska" WHERE stateCode = 'AK';
UPDATE State SET stateName = "Montana" WHERE stateCode = 'MT';
UPDATE State SET stateName = "Nevada" WHERE stateCode = 'NV';
UPDATE State SET stateName = "Arizona" WHERE stateCode = 'AZ';
UPDATE State SET stateName = "Tennessee" WHERE stateCode = 'TN';
UPDATE State SET stateName = "North Carolina" WHERE stateCode = 'NC';
UPDATE State SET stateName = "Wyoming" WHERE stateCode = 'WY';
UPDATE State SET stateName = "Hawaii" WHERE stateCode = 'HI';
UPDATE State SET stateName = "Arkansas" WHERE stateCode = 'AR';
UPDATE State SET stateName = "Michigan" WHERE stateCode = 'MI';
UPDATE State SET stateName = "Kentucky" WHERE stateCode = 'KY';
UPDATE State SET stateName = "Washington" WHERE stateCode = 'WA';
UPDATE State SET stateName = "Virginia" WHERE stateCode = 'VA';
UPDATE State SET stateName = "North Dakota" WHERE stateCode = 'ND';
UPDATE State SET stateName = "Minnesota" WHERE stateCode = 'MN';
UPDATE State SET stateName = "Idaho" WHERE stateCode = 'ID';

SELECT * FROM State;

SET SQL_SAFE_UPDATES=1;


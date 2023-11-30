SELECT '[' + [C].[TABLE_SCHEMA] + '].[' + [C].[TABLE_NAME] + ']' TABLE_NAME
,	'[' + [C].[COLUMN_NAME]  + ']' [COLUMN_NAME]
,	[C].[DATA_TYPE] + CASE 
			WHEN [C].[NUMERIC_PRECISION] IS NOT NULL THEN 
				'(' + Convert(varchar,[C].[NUMERIC_PRECISION]) + ',' + Convert(varchar,[C].[NUMERIC_SCALE]) + ')'  
			WHEN [C].[CHARACTER_MAXIMUM_LENGTH] IS NOT NULL THEN 
				'(' + Convert(varchar,[C].[CHARACTER_MAXIMUM_LENGTH]) + ')'
			ELSE ''
			 END [DATA_TYPE]
--,	[C].[CHARACTER_MAXIMUM_LENGTH]
,	[C].[IS_NULLABLE]
,	[C].[COLUMN_DEFAULT]
FROM [INFORMATION_SCHEMA].[COLUMNS] C
WHERE LEFT([C].[TABLE_NAME],2) <> 'vw'
ORDER BY 
	[C].[TABLE_SCHEMA]
,	[C].[TABLE_NAME]
,	[C].[ORDINAL_POSITION]	
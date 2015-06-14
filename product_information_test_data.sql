USE product_information;

Insert into attr_type (attr_type_id, attr_type_description) values (1, 'Name and value (Short text)');
Insert into attr_type (attr_type_id, attr_type_description) values (2, 'Name and value (Long text)');
Insert into attr_type (attr_type_id, attr_type_description) values (3, 'Name and value (Boolean)');
Insert into attr_type (attr_type_id, attr_type_description) values (4, 'Name and value (Date)');
Insert into attr_type (attr_type_id, attr_type_description) values (5, 'Only value');

# Company - Coca-Cola Company
Insert into urn (urn_id, urn, urn_version)
values (1, 'urn:epc:class:sgtin:9577813.*.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 5, 'attr_name', null, 'The Coca-Cola Company', 	1);

# Item Coca-Cola
Insert into urn (urn_id, urn, urn_version)
values (2, 'urn:epc:class:sgtin:9577813.25093.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 5, 'attr_name', null, 'Coca-Cola', 	1);

# Batch Coca-Cola 1
Insert into urn (urn_id, urn, urn_version)
values (3, 'urn:epc:class:lgtin:9577813.25093.17685134', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, value_format,sort_order)
values(3, 4, 'attr_expiration_date', 'Expiration date', '2015-06-24', 'yyyy-MM-dd', 1);

# Unique Coca-Cola 1
Insert into urn (urn_id, urn, urn_version)
values (4, 'urn:epc:class:sgtin:9577813.25093.44849808', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(4, 1, 'attr_batch_no', 'Batch Number', '17685134', 	1);

# Unique Coca-Cola 2
Insert into urn (urn_id, urn, urn_version)
values (5, 'urn:epc:class:sgtin:9577813.25093.58349496', 0);

# Item Coca-Cola Zero
Insert into urn (urn_id, urn, urn_version)
values (6, 'urn:epc:class:sgtin:9577813.41700.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(6, 5, 'attr_name', null, 'Coca-Cola Zero', 	1);

# Unique Coca-Cola Zero
Insert into urn (urn_id, urn, urn_version)
values (7, 'urn:epc:class:sgtin:9577813.41700.2945072', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, value_format,sort_order)
values(7, 4, 'attr_expiration_date', 'Expiration date', '2015-06-28', 'yyyy-MM-dd', 1);

# Company Tulip
Insert into urn (urn_id, urn, urn_version)
values (8, 'urn:epc:class:sgtin:37525415.*.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(8, 5, 'attr_name', null, 'Tulip Food Company', 	1);

# Item Bacon
Insert into urn (urn_id, urn, urn_version)
values (9, 'urn:epc:class:sgtin:37525415.3175.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(9, 5, 'attr_name', null, 'Bacon - Diced', 	1);

# Unique Bacon
Insert into urn (urn_id, urn, urn_version)
values (10, 'urn:epc:class:sgtin:37525415.3175.90450', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, value_format,sort_order)
values(10, 4, 'attr_expiration_date', 'Expiration date', '2015-06-09', 'yyyy-MM-dd', 1);

# Company Arla 
Insert into urn (urn_id, urn, urn_version)
values (11, 'urn:epc:class:sgtin:59215977.*.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(11, 5, 'attr_name', null, 'Arla Foods', 	1);

# Item Milk
Insert into urn (urn_id, urn, urn_version)
values (12, 'urn:epc:class:sgtin:59215977.8215.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(12, 5, 'attr_name', null, 'Skim Milk', 	1);

# Unique Milk
Insert into urn (urn_id, urn, urn_version)
values (13, 'urn:epc:class:sgtin:59215977.8215.47052', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, value_format,sort_order)
values(13, 4, 'attr_expiration_date', 'Expiration date', '2015-06-06', 'yyyy-MM-dd', 1);

# Company Bread
Insert into urn (urn_id, urn, urn_version)
values (14, 'urn:epc:class:sgtin:390125.*.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(14, 5, 'attr_name', null, 'Schulstad', 	1);

# Item Bread
Insert into urn (urn_id, urn, urn_version)
values (15, 'urn:epc:class:sgtin:390125.160733.*', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(15, 5, 'attr_name', null, 'Rye bread - Multigrain', 	1);

# Unique Bread
Insert into urn (urn_id, urn, urn_version)
values (16, 'urn:epc:class:sgtin:390125.160733.72837', 0);
Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, value_format,sort_order)
values(16, 4, 'attr_expiration_date', 'Expiration date', '2015-06-03', 'yyyy-MM-dd', 1);

# Nutrition amount container

Insert into container (container_id, urn_id, name, sort_order)
values (1, 2, 'Nutrition Facts (Amount)', 50);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 5, 'attr_nutrition_def', 		null, 			'Per 250 mL', 	1);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_calories', 		'Calories', 	'110', 			10);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_fat', 			'Fat', 			'0 g', 			20);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_sodium', 		'Sodium', 		'30 mg', 		30);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_carbohydrate', 	'Carbohydrate', '30 g', 		40);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_sugars', 		'- Sugars', 	'30 g', 		50);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 1, 'attr_nutri_protein', 		'Protein', 		'0 g', 			60);

Insert into container_attr(container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(1, 5, 'attr_nutri_extra', 		null, 			'Not a significant source of saturated fat, trans fat, cholesterol, fibre, vitamin A, vitamin C, calcium or iron.', 			70);

# Nutrition daily value container

Insert into container (container_id, urn_id, name, sort_order)
values (2, 2, 'Nutrition Facts (Daily Value)', 60);

Insert into container_attr (container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 1, 'attr_nutri_fat', 			'Fat', 			'0 %', 			20);

Insert into container_attr (container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 1, 'attr_nutri_sodium', 		'Sodium', 		'1 %', 		30);

Insert into container_attr (container_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 1, 'attr_nutri_carbohydrate', 	'Carbohydrate', '10 %', 		40);

# Reaming attributes

Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 2, 'attr_ingredients', 		'Ingredients', 			'Carbonated water, sugar/glucose-fructose, caramel colour, phosphoric acid, natural flavour, caffeine', 			60);

Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 5, 'attr_trademark', 			null, 			'Trade marks of Coca-Cola LTD., Toronto, Ontario M4H 1B8, used under license', 			70);

Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 1, 'attr_consumer_info', 		'Consumer information', 	'1-800-438-2653', 			80);

Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 3, 'attr_recyclable', 		'Recyclable', 	'true', 		10);

Insert into attribute (urn_id, attr_type_id, attr_key, attr_name, attr_value, sort_order)
values(2, 1, 'attr_volume', 			'Volume', 			'250 mL', 		5);
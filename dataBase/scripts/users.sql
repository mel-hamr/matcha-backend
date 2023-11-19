INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'spiderman@example.com',
    'Parker',
    'Peter',
    'hashed_password', -- Replace with the actual hashed password
    'Spiderman',
    'Male',
    'Unknown',
    'Friendly neighborhood superhero.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Superhero', 'Friendly', 'Web-slinger'],
    ARRAY[4.5],
    '40.7128', -- Replace with the actual latitude
    '-74.0060', -- Replace with the actual longitude
    true,
    true
);

-- User Batman
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'batman@example.com',
    'Wayne',
    'Bruce',
    'hashed_password', -- Replace with the actual hashed password
    'Batman',
    'Male',
    'Unknown',
    'I am vengeance, I am the night.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Dark Knight', 'Gotham', 'Detective'],
    ARRAY[4.8],
    '40.7128', -- Replace with the actual latitude
    '-74.0060', -- Replace with the actual longitude
    true,
    true
);

-- User Wonder Woman
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'wonderwoman@example.com',
    'Prince',
    'Diana',
    'hashed_password', -- Replace with the actual hashed password
    'WonderWoman',
    'Female',
    'Unknown',
    'Amazonian warrior for truth and justice.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Amazon', 'Justice', 'Lasso of Truth'],
    ARRAY[4.7],
    '38.8951', -- Replace with the actual latitude
    '-77.0364', -- Replace with the actual longitude
    true,
    true
);

-- User Iron Man
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'ironman@example.com',
    'Stark',
    'Tony',
    'hashed_password', -- Replace with the actual hashed password
    'IronMan',
    'Male',
    'Unknown',
    'Genius, billionaire, playboy, philanthropist.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Genius', 'Billionaire', 'Playboy'],
    ARRAY[4.9],
    '34.0522', -- Replace with the actual latitude
    '-118.2437', -- Replace with the actual longitude
    true,
    true
);

INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'superman@example.com',
    'Kent',
    'Clark',
    'hashed_password', -- Replace with the actual hashed password
    'Superman',
    'Male',
    'Unknown',
    'Man of Steel dedicated to protecting Earth.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Man of Steel', 'Kryptonian', 'Truth and Justice'],
    ARRAY[4.9],
    '38.9072', -- Replace with the actual latitude
    '-77.0370', -- Replace with the actual longitude
    true,
    true
);

-- User Captain America
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'captainamerica@example.com',
    'Rogers',
    'Steve',
    'hashed_password', -- Replace with the actual hashed password
    'CaptainAmerica',
    'Male',
    'Unknown',
    'Super-soldier fighting for justice.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Shield', 'Avenger'],
    ARRAY[4.7],
    '40.7128', -- Replace with the actual latitude
    '-74.0060', -- Replace with the actual longitude
    true,
    true
);

-- User Black Widow
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'blackwidow@example.com',
    'Romanoff',
    'Natasha',
    'hashed_password', -- Replace with the actual hashed password
    'BlackWidow',
    'Female',
    'Unknown',
    'Espionage expert and skilled assassin.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Espionage', 'Assassin', 'Avenger'],
    ARRAY[4.6],
    '34.0522', -- Replace with the actual latitude
    '-118.2437', -- Replace with the actual longitude
    true,
    true
);

-- User Thor
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'thor@example.com',
    'Odinson',
    'Thor',
    'hashed_password', -- Replace with the actual hashed password
    'Thor',
    'Male',
    'Unknown',
    'God of Thunder wielding Mjolnir.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['God of Thunder', 'Mjolnir', 'Asgardian'],
    ARRAY[4.8],
    '40.7128', -- Replace with the actual latitude
    '-74.0060', -- Replace with the actual longitude
    true,
    true
);

-- User Wonder Woman
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'wonderwoman2@example.com',
    'Prince',
    'Diana',
    'hashed_password', -- Replace with the actual hashed password
    'WonderWoman2',
    'Female',
    'Unknown',
    'Amazonian warrior for truth and justice.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Amazon', 'Justice', 'Lasso of Truth'],
    ARRAY[4.7],
    '38.8951', -- Replace with the actual latitude
    '-77.0364', -- Replace with the actual longitude
    true,
    true
);

-- User Iron Man (alternate version)
INSERT INTO public.users (
    id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online
) VALUES (
    DEFAULT,
    'ironman2@example.com',
    'Stark',
    'Tony',
    'hashed_password', -- Replace with the actual hashed password
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9JSx2Sz0ZnjgNNnlWnKBcBIFB9hmVmoeZQ&usqp=CAU',
    'Male',
    'Unknown',
    'Genius, billionaire, playboy, philanthropist.',
    ARRAY['https://xsgames.co/randomusers/avatar.php?g=pixel'], -- Replace with the actual image path
    ARRAY['Genius', 'Billionaire', 'Playboy'],
    ARRAY[4.9],
    '34.0522', -- Replace with the actual latitude
    '-118.2437', -- Replace with the actual longitude
    true,
    true
);
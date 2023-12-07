INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    1, -- Conversation ID for Spiderman and Iron Man
    1, -- User ID for Spiderman
    'Hey, Iron Man! Just saved the day again. How s it going?',
    '2023-11-14 12:15:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    1,
    4, -- User ID for Iron Man
    'Not bad, Spidey! Just upgrading the suit. Need any tech help?',
    '2023-11-14 12:20:00'
);

-- Messages for Batman and Wonder Woman
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    2, -- Conversation ID for Batman and Wonder Woman
    2, -- User ID for Batman
    'Wonder Woman, any signs of trouble in Gotham?',
    '2023-11-14 12:35:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    2,
    5, -- User ID for Wonder Woman
    'Gotham looks calm, Batman. How about Metropolis?',
    '2023-11-14 12:40:00'
);

-- Messages for Wonder Woman and Superman
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    3, -- Conversation ID for Wonder Woman and Superman
    5, -- User ID for Wonder Woman
    'Superman, any global threats we need to address?',
    '2023-11-14 12:55:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    3,
    6, -- User ID for Superman
    'All clear for now, Wonder Woman. Keep an eye on Themyscira.',
    '2023-11-14 13:00:00'
);

-- Messages for Iron Man and Captain America
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    4, -- Conversation ID for Iron Man and Captain America
    4, -- User ID for Iron Man
    'Cap, need backup. There s a new villain in town.',
    '2023-11-14 13:15:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    4,
    7, -- User ID for Captain America
    'On my way, Iron Man! Avengers, assemble!',
    '2023-11-14 13:20:00'
);

-- Messages for Superman and Black Widow
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    5, -- Conversation ID for Superman and Black Widow
    6, -- User ID for Superman
    'Black Widow, any unusual activities in your sector?',
    '2023-11-14 13:35:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    5,
    8, -- User ID for Black Widow
    'Possible covert operation. Investigating now.',
    '2023-11-14 13:40:00'
);

-- Messages for Captain America and Thor
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    6, -- Conversation ID for Captain America and Thor
    7, -- User ID for Captain America
    'Thor, we need your lightning in this fight!',
    '2023-11-14 13:55:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    6,
    9, -- User ID for Thor
    'Fear not, Cap! Mjolnir is ready to strike.',
    '2023-11-14 14:00:00'
);

-- Messages for Black Widow and Spiderman
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    7, -- Conversation ID for Black Widow and Spiderman
    8, -- User ID for Black Widow
    'Spiderman, any intel on the mysterious figure?',
    '2023-11-14 14:15:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    7,
    1, -- User ID for Spiderman
    'Espionage mode activated. Keeping an eye on the shadows.',
    '2023-11-14 14:20:00'
);

-- Messages for Thor and Batman
INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    8, -- Conversation ID for Thor and Batman
    9, -- User ID for Thor
    'Batman, the storm in Gotham has subsided. All clear.',
    '2023-11-14 14:35:00'
);

INSERT INTO public.message (
    id, conversation_id, sender, text, date
) VALUES (
    DEFAULT,
    8,
    2, -- User ID for Batman
    'Thanks, Thor. Always good to have a god on our side.',
    '2023-11-14 14:40:00'
);
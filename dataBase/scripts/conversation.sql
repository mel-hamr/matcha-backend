INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    1, -- User ID for Spiderman
    4, -- User ID for Iron Man
    'Hey, crime doesn t take a break, and neither do I!',
    0
);

-- Conversation for Batman and Wonder Woman
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    2, -- User ID for Batman
    5, -- User ID for Wonder Woman
    'I am the night. Gotham City is secure.',
    0
);

-- Conversation for Wonder Woman and Superman
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    3, -- User ID for Wonder Woman
    6, -- User ID for Superman
    'In the name of truth and justice!',
    0
);

-- Conversation for Iron Man and Captain America
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    4, -- User ID for Iron Man
    7, -- User ID for Captain America
    'Genius, billionaire, playboy, philanthropist reporting in!',
    0
);

-- Conversation for Superman and Black Widow
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    6, -- User ID for Superman
    8, -- User ID for Black Widow
    'Up, up, and away! Metropolis is safe.',
    0
);

-- Conversation for Captain America and Thor
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    7, -- User ID for Captain America
    9, -- User ID for Thor
    'Avengers, assemble! We have a mission.',
    0
);

-- Conversation for Black Widow and Spiderman
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    8, -- User ID for Black Widow
    1, -- User ID for Spiderman
    'Espionage mode activated. Keeping an eye on the shadows.',
    0
);

-- Conversation for Thor and Batman
INSERT INTO public.conversation (
    id, participant_a, participant_b, last_message, is_read
) VALUES (
    DEFAULT,
    9, -- User ID for Thor
    2, -- User ID for Batman
    'By Odin’s beard! Lightning and thunder on the horizon.',
    0
);
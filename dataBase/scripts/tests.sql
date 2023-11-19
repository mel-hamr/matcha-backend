DELETE FROM public.message WHERE 1 = 1;
DELETE FROM public.conversation WHERE 1 = 1;
DELETE FROM public.users WHERE 1 = 1;

SELECT * FROM users;
SELECT * FROM conversation;
SELECT * FROM message;
SELECT public.conversation.id, last_message, is_read, username AS userName, images[1] as avatar;;
FROM conversation
RIGHT JOIN users ON
    CASE
        WHEN conversation.participant_b = 1 THEN users.id = conversation.participant_a
        WHEN conversation.participant_a = 1 THEN users.id = conversation.participant_b
    END
WHERE conversation.participant_a = 1 OR conversation.participant_b = 1;


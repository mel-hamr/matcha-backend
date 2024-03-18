const addNotificationQuery = `
INSERT INTO public.notifacation (user_id, type, text) VALUES ($1, $2, $3) `;

const delteNotificationsQuery = `
    DELETE FROM public.notifacation WHERE id = ANY($1)
`;

const deleteNotificatonQuery = `
DELETE FROM public.notifacation WHERE id = $1
`;

const getNotificationQuery = ` 
SELECT * FROM public.notifacation WHERE user_id = $1 ORDER BY created_at DESC
`;

const notificationCountQuery = `
SELECT COUNT(*)
	FROM public.notifacation WHERE user_id = $1 AND type = 'message' AND is_read = false
    `;

const notificationReadQuery = `
UPDATE public.notifacation SET is_read = true WHERE user_id = $1 AND public.notifacation.id = $2
`;

const notifiationAllReadedQuery = `
UPDATE public.notifacation SET is_read = true WHERE user_id = $1
`;

module.exports = {
    addNotificationQuery,
    notificationCountQuery,
    getNotificationQuery,
    notificationReadQuery,
    notifiationAllReadedQuery,
    deleteNotificatonQuery,
    delteNotificationsQuery
};

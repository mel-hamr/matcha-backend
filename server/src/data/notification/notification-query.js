const notificationCountQuery = `
SELECT COUNT(*)
	FROM public.notifacation WHERE user_id = $1 AND type = 'message' AND is_read = false
    `;

module.exports = { notificationCountQuery };

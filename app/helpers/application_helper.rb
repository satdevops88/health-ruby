module ApplicationHelper
	def humanize_date_time(dt, as: Time)
		# add timezone to user and let users specify their timezone
		return "" if dt.nil?
		tformat = as == Date ? "%b %d, %Y" : "%b %d, %Y %l:%M %p %Z"
		tz = "Pacific Time (US & Canada)"
		tz = current_user.timezone if current_user && current_user.timezone.present?
		return Time.at(dt).in_time_zone(tz).strftime(tformat)
	end
end
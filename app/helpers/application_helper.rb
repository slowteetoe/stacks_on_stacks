module ApplicationHelper
  OPEN_CODE_TAG = '<code class="code"><pre>'
  CLOSE_CODE_TAG = '</pre></code>'

  def fix_code_tags(s)
    html_escape(s).gsub(/\[\/code\]/, CLOSE_CODE_TAG).gsub(/\[code\]/,OPEN_CODE_TAG).html_safe
  end

	def user_link(username, profile)
		if !!profile.display_name
			link_to "#{profile.display_name} (#{username})", "/users/#{profile.user_id}"
		else
			link_to username, "/users/#{profile.user_id}"
		end
	end

	def author_link(username, profile)
		name = !!profile.display_name ? profile.display_name : username
		link_to name, "/users/#{profile.user_id}"
	end

	def logged_in_link(username, profile)
		name = !!profile.display_name ? profile.display_name : username
		link_to 'Hi ' + name + '!', "/users/#{profile.user_id}"
	end

	def profile_name(user)
		if user.profile.display_name.present?
			user.profile.display_name + ' (' + user.username + ') '
		else
			user.username
		end
	end

	def direction(col)
		params[:dir] && params[:dir] == 'desc' && params[:col] == col ? 'asc' : 'desc'
	end

end

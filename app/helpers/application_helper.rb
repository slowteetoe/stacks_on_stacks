module ApplicationHelper
  OPEN_CODE_TAG = '<code class="code"><pre>'
  CLOSE_CODE_TAG = '</pre></code>'

  def fix_code_tags(s)
    html_escape(s).gsub(/\[\/code\]/, CLOSE_CODE_TAG).gsub(/\[code\]/,OPEN_CODE_TAG).html_safe
  end

  def author_link(username, author)
  	name = !!author.display_name ? author.display_name : username
  	return link_to name, "/users/#{author.user_id}"
	end

	def profile_name(user)
		if user.profile.display_name.present?
			user.profile.display_name + ' (' + user.username + ') '
		else
			user.username
		end
	end

end

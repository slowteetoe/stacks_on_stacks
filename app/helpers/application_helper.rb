module ApplicationHelper
	
  def fix_code_tags(s)
    Albeano.generate(s).html_safe
  end

	def user_link(username, profile)
		link_to display_name_slug(profile.display_name, username), "/users/#{profile.user_id}"
	end

	def author_link(username, profile)
		link_to preferred_display_name(profile.display_name, username), "/users/#{profile.user_id}"
	end

	def logged_in_link(username, profile)
		name = preferred_display_name(profile.display_name, username)
		link_to "Hi #{name}!", "/users/#{profile.user_id}"
	end

	def profile_name(user)
		display_name_slug(user.profile.display_name, user.username)
	end

	def direction(col)
		params[:dir] && params[:dir] == 'desc' && params[:col] == col ? 'asc' : 'desc'
	end

	def already_answered?(username, question)
		authors = []
		question.answers.each { |a| authors << a.author }
		authors.include?(username)
	end

private

	def display_name_slug(display_name, username)
		return "#{display_name} (#{username})" unless display_name.nil? or display_name.blank?
		username
	end

	def preferred_display_name(display_name, username)
		return display_name unless display_name.nil? or display_name.blank?
		username
	end

end

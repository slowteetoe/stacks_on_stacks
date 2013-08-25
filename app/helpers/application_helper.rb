module ApplicationHelper
  OPEN_CODE_TAG = '<code class="code"><pre>'
  CLOSE_CODE_TAG = '</pre></code>'

  def fix_code_tags(s)
    s.gsub(/\[\/code\]/, CLOSE_CODE_TAG).gsub(/\[code\]/,OPEN_CODE_TAG).html_safe
  end
end

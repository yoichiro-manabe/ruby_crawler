require 'mechanize'

url = URI.parse('http://affiliate.amazon.co.jp')
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

page = agent.get(url)

next_page = page.form_with(name: 'sign_in') do |form|
  form.username = 'userid'
  form.password = 'passwd'
end.submit

p next_page.search('//*[@id="mini-report"]/div[5]/div[2]').text
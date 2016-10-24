When(/^I upload the file "(.*?)"$/) do |arg1|
	file_path = Rails.root + "spec/fixtures/" + arg1	
	attach_file('file', file_path)
	click_button "Import"
end

Then(/^I should see a presenter named "(.*?)"$/) do |arg1|
	posters = Poster.where(:presenter => arg1)
	posters.count.should equal(1)
end

Then(/^I should see the message "(.*?)"$/) do |arg1|
	expect(page).to have_css('div.alert.alert-success')
end

Given(/^I have poster \#(\d+) where the presenter is "(.*?)"$/) do |arg1, arg2|
	Poster.create!(:number => arg1, :title => "", :presenter => arg2, :advisors => "")
end

Then(/^I should see a poster titled "(.*?)"$/) do |arg1|
	posters = Poster.where(:title => arg1)
	#posters.count.should equal(1)
	expect(posters.count).to equal(1)
end

Given(/^I am on the (.*?) page$/) do |arg1|
	case arg1
		when "admin"
			visit admin_posters_path
        when "judge registration"
            visit register_judges #temporary	
        else
			raise "Could not find #{page}"
		end
end

When(/^I press "(.*?)"$/) do |arg1|
  	click_button arg1
end

Given(/^I logged in as admin/) do 
	visit new_session_path
	fill_in "session_password", :with => "admin"
	click_button "Sign in"
end

Given(/^I clicked on view poster/) do 
	click_button "View Posters"	
end
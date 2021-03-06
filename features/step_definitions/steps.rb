Given(/^I am on the (.*?) page$/) do |arg1|
	
	case arg1
	    when "login"
         	visit root_path
		when "admin"
			visit admin_root_path
	    when "reset"
	        visit admin_reset_path
	   when "judge add"
	       visit admin_judges_path
		when "poster add"
			visit admin_posters_path
        when "judge registration"
            visit register_judges #temporary	
        when "new poster"
        	visit new_poster_path
        when "view scores" 
            visit admin_scores_path
        else
			raise "Could not find #{page}"
	end
end

Then (/^(?:|I )should be on the (.*?) page$/) do |arg|
    current_path = URI.parse(current_url).path
    case arg
		when "admin"
          expect(current_path).to eq admin_root_path
		when "signin"
            expect(current_path).to eq signin_path
        when "poster add"
            expect(current_path).to eq admin_posters_path
        when "admin poster"
            expect(current_path).to eq admin_posters_path
        when "login"
            expect(current_path).to eq root_path
        else
            raise "Could not find #{arg}"
        
    end
end


Then (/^(?:|I )should be on the (.*?) page for "([^"]*)"$/) do |arg1, arg2|
    case arg1 
        when "judge"
            judge = Judge.find_by_name(arg2)
            expect(page).to have_current_path(judge_path(judge))
        when "register"
            judge = Judge.find_by_access_code(arg2)
            expect(page).to have_current_path(judge_register_path(judge))
        when "show scores"
            poster = Poster.find(arg2.to_i)
            expect(page).to have_current_path(admin_score_path(poster))
        when "admin_registeration"
            judge = Judge.find_by_access_code(arg2)
            expect(page).to have_current_path(admin_register_path(judge))
        when "accept-poster confirm"
            judge = Judge.find_by_access_code(arg2)
            expect(page).to have_content("You have successfully added another poster for 4 total posters!")
            expect(page).to have_current_path(judge_path(judge))
        else
            raise "Could not find page #{arg1}"
    end
end    


Given(/^I logged in as "([^"]*)"/) do |code|
    visit new_session_path
    fill_in "session[password]", :with => code
    click_button "Sign in"
end

Given (/the following users exist/) do |user_table|
    user_table.hashes.each do |user|
        judge = Judge.new(user)
        judge.save!(validate: false)
    end
end

Given (/the following events exist/) do |table|
    table.hashes.each do |event|
        e = Event.new(event)
        e.save!(validate: false)
    end
end

Given(/^the following posters exist:$/) do |table|
	table.hashes.each do |row|
	   poster = Poster.new(:number => Poster.count + 1, :email => row[:email], :title => row[:title], :presenter =>row[:presenter], :advisors =>  row[:advisors])
       poster.save!(validate: false)
    end
end
Given(/^the following judges exist:$/) do |table|
	table.hashes.each do |row|
        judge = Judge.new(:name =>row[:name],  'company_name' => row[:company_name],  :access_code => row[:access_code], :role => row[:role])
        judge.save!(validate: false)
    end
end
When %r{^I want to make a raid for "([^"]*)"$} do |date|
  date = Date.parse(date)
  visit("/raids/new?date=#{date.to_s(:default)}")
end

Then "I should not be able to add a raid" do
  page.should_not have_css(".add")
end

Given %r{^a raid exists for (tomorrow|yesterday) named "([^"]*)"$} do |date_method, location|
  get_guild("Exiled").raids.create(
    :date => Date.send(date_method),
    :invite_time => "7:45 am",
    :start_time => "8:00 am",
    :location => location
  )
end

Given %r{^I am queued to "([^"]*)" with "([^"]*)"$} do |raid_name, char_name|
  char = @current_user.characters.find_by_name(char_name)
  raid = @current_guild.raids.find_by_location(raid_name)
  raid.queued.add!(char, char.main_role)
end

Given %r{^"([^"]*)" is queued to "([^"]*)" with "([^"]*)"$} do |email, raid_name, char_name|
  char = User.find_by_email(email).characters.find_by_name(char_name)
  raid = @current_guild.raids.find_by_location(raid_name)
  raid.queued.add!(char, char.main_role)
end

Given %r{^"([^"]*)" is accepted to "([^"]*)"$} do |char_name, raid_name|
  char = Character.find_by_name(char_name)
  raid = @current_guild.raids.find_by_location(raid_name)
  raid.move_character(char.main_role, char, "queued", "accepted")
end

Then %r{^I should see "([^"]*)" is (accepted|queued|cancelled)$} do |name, queue|
  page.should have_css(".#{queue}", :text => /#{name}/)
end

Then "I should not see accept buttons" do
  page.should_not have_css("a.accept")
end

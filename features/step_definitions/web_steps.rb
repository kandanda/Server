module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end


When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link, match: :prefer_exact)
  end
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I visit the (?:root|home) page$/  do
  visit('/')
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

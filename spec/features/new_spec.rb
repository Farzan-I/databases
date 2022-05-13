feature "adding bookmarks to the page" do
  scenario 'add bookmark to bookmark manager' do
    visit '/bookmarks/new'

    fill_in "url", with: "http://www.bbc.co.uk"
    fill_in "title", with: "BBC"
    click_button "Submit"
    
    expect(page).to have_link('BBC', href: "http://www.bbc.co.uk")
  end
end

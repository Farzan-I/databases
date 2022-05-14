feature 'Updating a bookmark' do
  scenario 'user can update a bookmark' do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')

    first('.bookmark').click_button('Update')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/update"

    fill_in('url', with: "http://www.github.com")
    fill_in('title', with: "Github")
    click_button("Submit")

    expect(current_path).to eq "/bookmarks/"
    expect(page).not_to have_link("Google", href: "http://www.google.com")
    expect(page).to have_link("Github", href: "http://www.github.com")
  end
end
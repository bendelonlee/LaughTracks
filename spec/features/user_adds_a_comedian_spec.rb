RSpec.describe 'user adds a comedian' do
  context "user navigates to comedians/new, fill in, and submit" do
    it 'shows the comedian they added' do
      visit "/comedians/new"

      fill_in "comedian[firstname]", with:"John"
      fill_in "comedian[lastname]", with:"Oliver"
      fill_in "comedian[city]", with:"Los Angeles"
      fill_in "comedian[age]", with:"41"
      click_on "Create Comedian"

      expect(current_path).to eq("/comedians")
      within "#john-oliver-container" do
        expect(page).to have_content("John Oliver")
        expect(page).to have_content("City: Los Angeles")
        expect(page).to have_content("Age: 41")
      end

    end
  end
end

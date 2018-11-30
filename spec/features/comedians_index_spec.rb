RSpec.describe "User sees all comedians" do

  describe 'user visits /comedians page' do

    it 'displays all comedians' do
      Comedian.create!(firstname: "Bob", age:40, city:"New York")
      Comedian.create!(firstname: "Rob", age:42, city:"New York")
      Comedian.create!(firstname: "Shnob", age:42, city:"New York")
      Comedian.create!(firstname: "Blob", age:42, city:"New York")
      visit '/comedians'
      expect(page).to have_content("Bob")
      expect(page).to have_content("Shnob")
      expect(page).to have_content("Blob")
      expect(page).to have_content("Rob")
      expect(page).to have_content("Age: 40")
      expect(page).to have_content("Age: 42")
      expect(page).to have_content("City: New York")

    end

    it 'filters data based on query parameters' do
      comic_1 = Comedian.create!(firstname: "Bob", age:40, city:"New York")
      comic_2 = Comedian.create!(firstname: "Rob", age:42, city:"Philly")
      comic_3 = Comedian.create!(firstname: "Shnob", age:41, city:"Littleton")
      comic_4 = Comedian.create!(firstname: "Blob", age:42, city:"New York")


      comic_2.specials.create(title: "Life is Weird", runtime: 60)

      comic_3.specials.create(title: "What's going on?", runtime: 150)

      comic_4.specials.create(title: "ha", runtime: 100)
      comic_4.specials.create(title: "haha", runtime: 150)


      visit '/comedians?age=42'

      expect(page).to have_content(comic_2.name)
      expect(page).to have_content(comic_4.name)
      expect(page).to have_content("Cities: New York, Philly")
      expect(page).to have_content("Average Age: 42")
      expect(page).to have_content("Total Specials: 3")
      expect(page).to have_content("Average Runtime of Specials: 103")

      expect(page).not_to have_content(comic_1.name)
      expect(page).not_to have_content(comic_3.name)
    end
  end

end

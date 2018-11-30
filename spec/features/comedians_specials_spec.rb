RSpec.describe "specials are displayed on comedian index" do

  it "displays comedian's specials on comedian's page" do
    comedian_1 = Comedian.create!(firstname: "Bob", age:40, city:"New York")
    comedian_2 = Comedian.create!(firstname: "Rob", age:42, city:"New York")

    special_1 = Special.create!(title: "The Best Special", runtime: 100, image_path: "images/generic_special.jpeg")
    special_2 = Special.create!(title: "The Funny Special", runtime: 100, image_path: "images/generic_special.jpeg")
    comedian_1.specials << special_1
    comedian_1.specials << special_2

    special_3 = Special.create!(title: "Hot Dog!", runtime: 100, image_path: "images/generic_special.jpeg")
    special_4 = Special.create!(title: "Sex and other stuff is so funny!", runtime: 100, image_path: "images/generic_special.jpeg")
    comedian_2.specials << special_3
    comedian_2.specials << special_4

    visit '/comedians'

    expect(page).to have_content(special_1.title)
    expect(page).to have_css("img[src*='#{special_1.image_path}']")
    expect(page).to have_content(special_2.title)
    expect(page).to have_css("img[src*='#{special_2.image_path}']")
    expect(page).to have_content(special_3.title)
    expect(page).to have_css("img[src*='#{special_3.image_path}']")
    expect(page).to have_content(special_4.title)

    expect(page).to have_css("img[src*='#{special_4.image_path}']")

  end

  it "displays the number of specials a comedian has on comedian page" do
    comedian_1 = Comedian.create!(firstname: "Bob", lastname: "Mcgee", age:40, city:"New York")
    comedian_2 = Comedian.create!(firstname: "Rob", lastname: "Mcgoo", age:42, city:"New York")

    special_1 = Special.create!(title: "The Best Special", runtime: 100, image_path: "images/generic_special.jpeg")
    special_2 = Special.create!(title: "The Funny Special", runtime: 100, image_path: "images/generic_special.jpeg")
    comedian_1.specials << special_1
    comedian_1.specials << special_2

    special_3 = Special.create!(title: "Hot Dog!", runtime: 100, image_path: "images/generic_special.jpeg")
    comedian_2.specials << special_3

    visit '/comedians'

    within 'div#bob-mcgee-container' do
      expect(page).to have_content("2 Specials")
    end
    within 'div#rob-mcgoo-container' do
      expect(page).to have_content("1 Specials")
    end

  end
end

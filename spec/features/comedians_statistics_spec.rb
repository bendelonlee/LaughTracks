RSpec.describe "Comedian's index displays statistics" do
  it 'displays average_comedian age' do
    Comedian.create!(firstname: "Bob", age:40, city:"New York")
    Comedian.create!(firstname: "Rob", age:41, city:"New York")
    Comedian.create!(firstname: "Shnob", age:42, city:"New York")

    visit '/comedians'

    expect(page).to have_content("Average Age: 41")
  end
  it 'displays a unique list of city' do
    Comedian.create!(firstname: "Bob", age:40, city:"New York")
    Comedian.create!(firstname: "Rob", age:41, city:"New York")
    Comedian.create!(firstname: "Shnob", age:42, city:"New York")
    Comedian.create!(firstname: "Greg", age:42, city:"Denver")
    Comedian.create!(firstname: "Meg", age:42, city:"Denver")

    visit '/comedians'

    expect(page).to have_content("Cities: New York, Denver")
  end
  it 'displays the average run length of all specials' do
    comic = Comedian.create!(firstname: "Bob", age:40, city:"New York")
    comic.specials.create(
      [
        {title: "Hot Dog!", runtime: 100, image_path: "images/generic_special.jpeg"},
        {title: "Cold Dog!", runtime: 120, image_path: "images/generic_special.jpeg"},
        {title: "Lukewarm Dog!", runtime: 80, image_path: "images/generic_special.jpeg"}
      ]
    )

    visit '/comedians'

    expect(page).to have_content("Average Runtime of Specials: 100 minutes")
  end

  it "displays the total number of specials" do
    comic = Comedian.create!(firstname: "Bob", age:40, city:"New York")

    comic.specials.create(
      [
        {title: "Hot Dog!", runtime: 100, image_path: "images/generic_special.jpeg"},
        {title: "Cold Dog!", runtime: 120, image_path: "images/generic_special.jpeg"},
        {title: "Lukewarm Dog!", runtime: 80, image_path: "images/generic_special.jpeg"}
      ]
    )

    visit '/comedians'
    expect(page).to have_content("Total Specials: 3")

  end


end

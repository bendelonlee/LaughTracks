RSpec.describe 'user sees sorted comedians' do
  before(:each) do
    Comedian.create!(firstname: "Bob", age:40, city:"New York")
    Comedian.create!(firstname: "Rob", age:21, city:"New York")
    Comedian.create!(firstname: "Greg", age:23, city:"Denver")
    Comedian.create!(firstname: "Meg", age:19, city:"Denver")
    Comedian.create!(firstname: "Shnob", age:42, city:"New York")
  end

  it "displays comedian's sorted by age" do
    visit "/comedians"
    find('input[value="age"]', visible: false).click
    click_on "Submit"

    comic_1_position = page.body =~ /Meg/
    comic_2_position = page.body =~ /Rob/
    comic_3_position = page.body =~ /Greg/
    comic_4_position = page.body =~ /Bob/
    comic_5_position = page.body =~ /Shnob/
    expected = [comic_1_position, comic_2_position, comic_3_position, comic_4_position, comic_5_position]
    expect(expected.sort).to eq(expected)
  end

  it "displays comedian's sorted by name" do
    visit "/comedians"
    find('input[value="name"]', visible: false).click
    click_on "Submit"
    comic_1_position = page.body =~ /Bob/
    comic_2_position = page.body =~ /Greg/
    comic_3_position = page.body =~ /Meg/
    comic_4_position = page.body =~ /Rob/
    comic_5_position = page.body =~ /Shnob/
    expected = [comic_1_position, comic_2_position, comic_3_position, comic_4_position, comic_5_position]
    expect(expected.sort).to eq(expected)
  end

  it "displays comedian's sorted by city" do
    visit "/comedians"
    find('input[value="city"]', visible: false).click
    click_on "Submit"
    comic_1_position = page.body =~ /Greg/
    comic_2_position = page.body =~ /Meg/
    comic_3_position = page.body =~ /Bob/
    comic_4_position = page.body =~ /Rob/
    comic_5_position = page.body =~ /Shnob/
    expected = [comic_1_position, comic_2_position, comic_3_position, comic_4_position, comic_5_position]
    expect(expected.sort).to eq(expected)
  end
end

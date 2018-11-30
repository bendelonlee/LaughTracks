RSpec.describe Comedian do
  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a firstname' do
        comic = Comedian.create(age: 48)
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing an age' do
        comic = Comedian.create(firstname: 'Mitch', lastname: 'Hedberg')
        expect(comic).to_not be_valid
      end
    end
  end
  describe 'Instance Methods' do
    describe 'name returns correctly' do
      it 'returns an the right name' do

        comic = Comedian.create(age: 48, firstname: "Bozo", lastname: "Klein")
        expected_result = "Bozo Klein"
        expect(comic.name).to eq(expected_result)
      end
    end
    describe 'image_path returns correctly' do
      it 'returns an the right image path' do
        comic = Comedian.create(age: 48, firstname: "Bozo")
        expected_result = "images/comedians/bozo/profile_pic.jpg"
        expect(comic.image_path).to eq(expected_result)
        comic = Comedian.create(age: 48, firstname: "Bozo", lastname: "Klein")
        expected_result = "images/comedians/bozo_klein/profile_pic.jpg"
        expect(comic.image_path).to eq(expected_result)
      end
    end
  end
  describe 'Class Methods' do
    before(:each) do
      @comic_1 = Comedian.create(age: 48, firstname: "Bozo", city: 'Dublin')
      @comic_2 = Comedian.create(age: 49, firstname: "Bozohead", city: 'Dublin')
      @comic_3 = Comedian.create(age: 50, firstname: "Bozonose", city: 'Topeka')
      @comic_4 = Comedian.create(age: 51, firstname: "Bozotoes", city: 'Topeka')
      @comic_5 = Comedian.create(age: 52, firstname: "Bozofeet", city: 'Topeka')
      @comic_6 = Comedian.create(age: 52, firstname: "Bozohands", city: 'Topeka')
      @comic_7 = Comedian.create(age: 48, firstname: "Bozoface", city: 'Dublin')
    end
      it 'returns average_age correctly' do
        expect(Comedian.average_age).to eq(50)
      end
      it 'returns distinct cities correctly' do

        expect(Comedian.cities).to eq(%w(Topeka Dublin))
      end
      it 'fetches all data correctly with empty params' do
        params = {}
        expected = {
          comedians: Comedian.all,
          cities: %w(Topeka Dublin),
          average_age: 50
        }
        expect(Comedian.fetch_data(params)).to eq(expected)
      end
      it 'fetches all data correctly with given age' do
        params = {age: 48}
        expected = {
          comedians: [@comic_1, @comic_7],
          cities: %w(Dublin),
          average_age: 48
        }
        expect(Comedian.fetch_data(params)).to eq(expected)
      end
      it 'fetches comedians correctly when sorting by age' do
        params = {sort: "age"}
        expected = [@comic_7, @comic_1, @comic_2, @comic_3, @comic_4, @comic_6, @comic_5]
        result_comedians =  Comedian.fetch_data(params)[:comedians]
        expect(result_comedians).to eq(expected)
      end
      it 'fetches comedians correctly when sorting by name' do
        params = {sort: "name"}
        expected = [@comic_1, @comic_7, @comic_5, @comic_6, @comic_2, @comic_3, @comic_4]
        result_comedians =  Comedian.fetch_data(params)[:comedians]
        expect(result_comedians).to eq(expected)
      end
      it 'fetches comedians correctly when sorting by city' do
        params = {sort: "city"}
        expected = [@comic_2, @comic_1, @comic_7, @comic_6, @comic_4, @comic_3, @comic_5]
        result_comedians =  Comedian.fetch_data(params)[:comedians]
        expect(result_comedians).to eq(expected)
      end
    end
  end

RSpec.describe Special do
  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do

        special = Special.create(runtime: 30)
        expect(special).to_not be_valid
      end
    end
  end

  describe 'Class Methods' do
    it 'should return the average run time' do
      special = Special.create!(title: "Monkeytown", runtime: 40)
      special = Special.create!(title: "Monkeytown 2",runtime: 50)
      expect(Special.average_runtime).to eq(45)

    end
    describe 'it fetches data correctly' do
      before(:each) do
        @comic_1 = Comedian.create!(age: 48, firstname: "Bozo", city: 'Dublin')
        @comic_2 = Comedian.create!(age: 48, firstname: "Bozohead", city: 'Dublin')
        @comic_3 = Comedian.create!(age: 50, firstname: "Bozonose", city: 'Topeka')

        @special_1 = Special.create!(title: "Monkeytown", runtime: 40)
        @comic_1.specials << @special_1

        @special_2 = Special.create!(title: "I'm a clown", runtime: 50)
        @special_3 = Special.create!(title: "I'm a clown 2", runtime: 60)
        @comic_2.specials << @special_2
        @comic_2.specials << @special_3

        @special_4 = Special.create!(title: "Bignose!", runtime: 70)
        @special_5 = Special.create!(title: "Bignose 2!", runtime: 80)
        @special_6 = Special.create!(title: "Bignose 3!", runtime: 90)
        @comic_3.specials << @special_4
        @comic_3.specials << @special_5
        @comic_3.specials << @special_6
      end

      it 'fetches all data correctly with empty params' do
        params = {}
        expected = {
          average_runtime: 65,
          total_specials: 6
        }
        expect(Special.fetch_data(params)).to eq(expected)
      end
      it 'fetches all data correctly with empty params' do
        params = {age: 48}
        expected = {
          average_runtime: 50,
          total_specials: 3
        }
        expect(Special.fetch_data(params)).to eq(expected)
      end
    end
  end
end

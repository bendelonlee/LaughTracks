RSpec.describe Special do
  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do

        special = Special.create(runtime: 30)
        expect(special).to_not be_valid
      end
    end
  end
end

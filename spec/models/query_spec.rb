require 'rails_helper'

RSpec.describe Query, type: :model do
  subject do
    Query.new(body: 'Test query', user_id: 1)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a body' do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an user id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end

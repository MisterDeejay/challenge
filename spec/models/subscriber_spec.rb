require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  describe 'validations' do
    let(:subscriber) { build(:subscriber, :randomly_named) }
    let(:subscriber_no_name) { build(:subscriber) }
    let(:subscriber_no_email) { build(:subscriber, email: nil) }
    let(:subscriber_invalid_email) { build(:subscriber, :invalid_email) }
    let(:subscriber_no_sub_state) { build(:subscriber, subscribed: nil) }

    it 'is valid with valid attributes' do
      expect(subscriber).to be_valid
    end

    it 'is not valid without an email' do
      expect(subscriber_no_email).to_not be_valid
    end

    it 'is not valid without a valid email' do
      expect(subscriber_invalid_email).to_not be_valid
    end

    describe 'if a subscriber currently exists with the same email despite the case of the characters' do
      let!(:subscriber_with_existing_email) { create(:subscriber, email: subscriber.email.upcase) }

      it 'is not valid' do
        expect(subscriber).not_to be_valid
      end
    end

    it 'is not valid without a subscription state' do
      expect(subscriber_no_sub_state).to_not be_valid
    end

    it 'is valid without a name' do
      expect(subscriber_no_name).to be_valid
    end
  end
end

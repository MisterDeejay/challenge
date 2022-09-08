FactoryBot.define do
  factory :subscriber do
    email { Faker::Internet.free_email }
    subscribed { true }

    trait(:randomly_named) do
      name { Faker::Name.name }
    end

    trait(:invalid_email) do
      email { 'fake_email@gmailcom' }
    end
  end
end

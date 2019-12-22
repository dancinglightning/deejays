FactoryBot.define do
  factory :user do
    confirmed_at{ Time.now }
    full_name {"Test User"}
    sequence( :email) { |n| "test#{n}@test.com" }
    password {"please123"}
    city {"City"}
    country {"Country"}
    factory :given_user do
      given {Date.today}
      count {0}
    end
    factory :admin do
      sequence( :email) { |n| "admin#{n}@test.com" }
      admin {1}
      full_name {"Test Admin"}
    end
  end
end

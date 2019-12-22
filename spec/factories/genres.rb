FactoryBot.define do

  factory :genre do
    sequence :name do |n|
       "Rocks time #{n}"
     end
  end

end

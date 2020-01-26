describe User do

  before(:each) {
    @user = create :user
  }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'test.com'
  end

  it "creates an admin" do
    admin = create :admin
    expect(admin.admin).to be 1
  end

  it "scopes admin" do
      create :admin
      expect(User.admin.first.admin).to be 1
  end

  it "validates http" do
    user = build :user , full_name: "http://some"
    user.save
    expect(user.errors[:full_name].to_s).to include "know"
  end
  it "validates numbers" do
    user = build :user , full_name: "name 565"
    user.save
    expect(user.errors[:full_name].to_s).to include "digits"
  end
  it "validates minsk" do
    user = build :user , city: "Minsk" , country: "Haiti"
    user.save
    expect(user.errors[:city].to_s).to include "Belarus"
  end
  it "validates caps" do
    [:city, :country , :state].each do |attr|
      user = build :user , attr => "GroSS"
      user.save
      expect(user.errors[attr].to_s).to include "lock"
    end
  end
  it "USA ok" do
    user = build :user , state: "USA"
    expect(user.save).to be true
  end
  it "validates CAP name" do
    user = build :user , full_name: "Name Middle End"
    expect(user.save).to be true
  end
end

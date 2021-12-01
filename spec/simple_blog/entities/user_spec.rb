RSpec.describe User, type: :entity do
  it 'can be initialized with attributes' do
    user = User.new(login: 'test@mail.com')
    expect(user.login).to eq('test@mail.com')
  end
end

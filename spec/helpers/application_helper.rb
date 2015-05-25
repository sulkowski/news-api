module ApplicationHelper
  def sign_in
    current_user = User.create(id: 1, email: '007@mi6.co.uk', password: 'vesper')
    authorize '007@mi6.co.uk', 'vesper'
    current_user
  end
end

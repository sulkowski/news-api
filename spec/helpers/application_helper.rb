module ApplicationHelper
  def sign_in
    User.create(email: '007@mi6.co.uk', password: 'vesper')
    authorize '007@mi6.co.uk', 'vesper'
  end
end

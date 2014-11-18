require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "User not created if information is invalid" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
                              email: "user@invalid",
                              password:     "foo",
                              password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid sign up information" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name: "Elinor Gilbert",
                                           email: "user@example.com",
                                          password: "password",
                                          password_confirmation: "password"}
    end
    assert_template 'users/show'
  end
end

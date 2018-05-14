require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid params" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: {user: {name: "",
                                       date_of_birth: Date.today + 1,
                                       sex: "male",
                                       height: 1.7,
                                       weight: 100,
                                       strength: 2,
                                       password: "password",
                                       password_confirmation: "passport"}}
    end
    assert_template "users/new"
    assert_select "div#error_explanation", true
    assert_select "div.alert", true
    assert_select "li", count: 7
  end

  test "valid param" do
    get signup_path
    assert_difference "User.count" do
      post signup_path, params:  {user: {name: "Foo Bar",
                                       date_of_birth: Date.new(2000, 3, 31),
                                       sex: "female",
                                       height: 1.75,
                                       weight: 60,
                                       strength: 3,
                                       password: "password",
                                       password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template "users/show"
    assert_select "div.alert", "Let's get healthy!!"
    get user_path
    assert_select "div.alert", false
  end
end

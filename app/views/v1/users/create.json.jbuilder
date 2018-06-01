json.data do
  json.user do
    json.call(
      @user,
      :id,
      :email,
      :authentication_token,
      :confirmation_token,
      :confirmed_at
    )
  end
end

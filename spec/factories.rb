FactoryGirl.define do
  factory :user do
    first_name      "Chiara"
    last_name       "Di Pietro"
    nick_name       "cdp"
    email     "chiaradipietro84@gmail.com"
    password  "foobar"
    password_confirmation "foobar"
   # self.Credental.email     "chiaradipietro84@gmail.com"
   # self.Credental.password  "foobar"
   # self.Credental.password_confirmation "foobar"
  end
end

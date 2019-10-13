alias AdoptAFamily.{Accounts, Families, Repo}

{:ok, _user} = Accounts.create_user(%{
  username: "cgross",
  password: "password",
  password_confirmation: "password",
  email: "gross.chelsea2010@gmail.com",
  name: "Chelsea"
})

{:ok, family1} = Families.create_family(%{head_of_house: "Jane Smith", clinician: "Deb"})
{:ok, family2} = Families.create_family(%{head_of_house: "Suzy Sass", clinician: "Deb"})

{:ok, child1} = Families.add_child(family1, %{
  name: "Liz Smith",
  gender: "female",
  age: 10,
  interests: "Soccer"
})
{:ok, child2} = Families.add_child(family1, %{
  name: "John Smith",
  gender: "male",
  age: 6,
  interests: "Legos"
})
{:ok, child3} = Families.add_child(family2, %{
  name: "Joel Sass",
  gender: "male",
  age: 16,
  interests: "Music"
})

{:ok, _} = Families.add_gift(child1, %{item: "Soccer Ball"})
{:ok, _} = Families.add_gift(child1, %{item: "Soccer cleats", size: "Childs 9"})
{:ok, _} = Families.add_gift(child2, %{item: "Star Wars Legos"})
{:ok, _} = Families.add_gift(child3, %{item: "iTunes Gift Card"})
{:ok, _} = Families.add_gift(child3, %{item: "Music Posters"})
{:ok, _} = Families.add_gift(child3, %{item: "Sneakers", size: "Mens 10"})

# frozen_string_literal: true

ApiAdmin.create(email: 'admin@homie.mx', password: 'adminpass')

owners_data = 10.times.map do
  {
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.cell_phone
  }
end
owners = Owner.create(owners_data)

properties_data = 100.times.map do
  {
    name: "Departamento en #{Faker::Address.city}",
    description: Faker::Lorem.paragraphs(number: 2).join("\n\n"),
    rental_price: Faker::Commerce.price(range: 1_000..50_000),
    status: Property.statuses.keys.sample,
    owner_id: owners.sample.id
  }
end
Property.create(properties_data)

listing_accounts_data = [
  { name: 'Inmuebles24' },
  { name: 'Segundamano' }
]
ListingAccount.create(listing_accounts_data)

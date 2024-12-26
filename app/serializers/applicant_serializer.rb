class ApplicantSerializer < BaseSerializer
  attributes :id, :name, :document, :birth_date, :salary, :inss_discount, :addresses, :contacts

  attribute :addresses do |serializer|
    addresses = serializer.object.addresses

    addresses.map do |address|
      {
        address: address.address,
        number: address.number,
        neighborhood: address.neighborhood,
        city: address.city,
        state: address.state,
        zip_code: address.zip_code
      }
    end
  end

  attributes :contacts do |serializer|
    contacts = serializer.object.contacts

    contacts.map do |contact|
      {
        name: contact.name,
        phone: contact.phone,
        email: contact.email
      }
    end
  end
end

class ErrorSerializer < BaseSerializer
  attributes :error

  def read_attribute_for_serialization(attr)
    object[attr]
  end
end
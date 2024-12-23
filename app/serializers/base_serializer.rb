class BaseSerializer < ActiveModel::Serializer
  def attributes(*args)
    deep_transform_keys(super(*args)) { |key| key.to_s.camelize(:lower) }
  end

  private

  def deep_transform_keys(value, &block)
    case value
    when Array
      value.map { |v| deep_transform_keys(v, &block) }
    when Hash
      value.transform_keys(&block).transform_values { |v| deep_transform_keys(v, &block) }
    when ActiveModel::Errors
      value.messages.transform_keys(&block)
    else
      value
    end
  end
end

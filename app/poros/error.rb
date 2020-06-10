class Error
  attr_reader :description

  def initialize(errors)
    @description = construct_msg(errors)
  end

  def construct_msg(errors)
    if errors.kind_of?(Array)
      errors.uniq.to_sentence
    else
      errors
    end
  end
end

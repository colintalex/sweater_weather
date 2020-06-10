class Error
  attr_reader :description

  def initialize(errors)
    @description = errors.uniq.to_sentence
  end
end

module APIHelpers
  def parsed_body
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include APIHelpers, type: :request
end
